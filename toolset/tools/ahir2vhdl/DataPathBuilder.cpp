#include "DataPathBuilder.hpp"
#include "Utils.hpp"
#include "EntityBuilder.hpp"
#include "SimpleEntity.hpp"

#include <AHIR/AHIRModule.hpp>
#include <Base/Type.hpp>

#include <boost/lexical_cast.hpp>
#include <string>
#include <sstream>

using namespace vhdl;
using namespace hls;

namespace {

  struct Builder 
  {
    DataPath *dp;
    ahir::DataPath *adp;

    // typedef std::map<ahir::DPElement*, DPElement*> DPEMap;
    // DPEMap dpe_map;

    Builder() { reset(); }
    
    void reset()
    {
      dp = NULL;
      adp = NULL;
    }
    
    DataPath* create_dp(ahir::DataPath *ahir) 
    {
      adp = ahir;
      dp = new DataPath(adp->id, "" /* ahir::DataPath has no description. Yet. */);
    
      // create a vhdl::dpe for each ahir::dpe
      create_elements();
    
      // create wrappers and consume dpe's created in the previous function
      create_wrappers();
    
      // LC are created later in one bunch because we need to know the
      // total number of wrappers.
      create_lr_wrappers(dp, adp);

      for (DPEList::iterator di = dp->elements.begin(), de = dp->elements.end();
           di != de; ++di) {
        DPElement *dpe = (*di).second;
        dpe_add_generics(dpe);
      }

      dp_create_ports();
      dp_latch_call_tag();
  
      return dp;
    }

    /* ===== Elements ===== */

    void dpe_create_symbol_ports(PortList &plist, ahir::DPElement::SymbolMap &S
                                 , hls::IOType io_type, const std::string &sym
                                 , bool is_array)
    {
      for (ahir::DPElement::SymbolMap::iterator si = S.begin(), se = S.end();
           si != se; ++si) {
        Port *port = create_port(plist, (*si).first, io_type
                                 , vhdl::Type(is_array ? "BooleanArray" : "Boolean")
                                 , true /* control port */);
        port->mapping(SLICE, sym, Range(is_array ? DOWNTO : INDEX, (*si).second, (*si).second));
      }
    }

    void create_elements()
    {
      for (ahir::DPEList::iterator di = adp->elements.begin(), de = adp->elements.end();
           di != de; ++di) {
        ahir::DPElement *adpe = (*di).second;
        NodeType ntype = adpe->ntype;
        
        std::ostringstream id;
        id << "dpe_" << adpe->id;
        DPElement *dpe = new DPElement(id.str(), ntype
                                       , vhdl_component_name(adpe)
                                       , adpe->description
                                       , vhdl_configuration_name(adpe));
        
        bool array_ports = has_array_ports(ntype);
        
        for (ahir::PortList::iterator pi = adpe->ports.begin(), pe = adpe->ports.end();
             pi != pe; ++pi) {
          ahir::Port *p = (*pi).second;
        
          const bool is_mem_data = is_mem(ntype) && (p->id == "data");
          const bool output_port = is_output(p);
        
          const std::string wire_id = vhdl_wire_name(p->wire);
          const std::string slv_id = dpe->id + "_" + p->id;

          const std::string data_type = (array_ports ? vhdl_array_type_name(p->type)
                                         : str(p->type->type_id));

          Port *port = create_port(dpe->ports, p->id, p->io_type
                                   , vhdl::Type((is_mem_data ? "StdLogicArray2D"
                                                 : data_type)
                                                , (is_mem_data ? Range(DOWNTO, p->type->width())
                                                   : create_range(p->type))));
          if (array_ports)
            port->type.ranges.push_front(Range(DOWNTO, 1));
          
          port->mapping(WIRE, ((is_mem_data || (!array_ports)) ? slv_id : wire_id));

          if (is_mem_data || (!array_ports)) {
            if (output_port) {
              Wire *wire = new Wire(wire_id, vhdl::Type(vhdl_array_type_name(p->type)
                                                        , create_range(p->type)));
              dp->register_wire(wire);
              wire->type.ranges.push_front(Range(DOWNTO, 1));
            } else {
              dp->register_wire(new Wire(slv_id, port->type));
            }
            
            if (is_mem_data) {
              const std::string assign =
                (output_port
                 ? wire_id + " <= To_" + data_type + "(" + slv_id + ");"
                 : slv_id + " <= To_StdLogicArray2D(" + wire_id + ");");
              dpe->append_to_prelude(assign);
            } else {
              assert(!array_ports);
              const std::string assign =
                (output_port
                 ? wire_id + " <= to_" + vhdl_array_type_name(p->type)
                 + "(" + port->mapping.name + ");"
                 : port->mapping.name + " <= extract(" + wire_id + ", 0);");
              dpe->append_to_prelude(assign);
            }
          }
        }

        dpe_create_symbol_ports(dpe->ports, adpe->reqs, IN, "SigmaIn", array_ports);
        dpe_create_symbol_ports(dpe->ports, adpe->acks, OUT, "SigmaOut", array_ports);
      
        Port *rst = create_port(dpe->ports, "reset", IN, "std_logic", true);
        rst->mapping(SLICE, "reset");
      
        Port *clk = create_port(dpe->ports, "clk", IN, "std_logic", true);
        clk->mapping(SLICE, "clk");
      
        dpe_update_details(dpe, adpe);
      
        register_dpe(adpe, dpe);
      }
    }
    
    void create_wrappers()
    {
      for (ahir::WrapperList::iterator wi = adp->wrappers.begin()
             , we = adp->wrappers.end(); wi != we; ++wi) {
        ahir::Wrapper *aw = (*wi).second;

        ahir::MemberList::iterator mi = aw->members.begin();
        ahir::DPElement *first = adp->find_dpe(*mi);
        assert(first);

        DPElement *first_ve = find_dpe(first);
        assert(first_ve);
        DPElement *wrapper
          = create_wrapper("wrapper_" + boost::lexical_cast<std::string>(aw->id)
                           , aw->description, aw->members.size(), first_ve, dp);

        for (ahir::MemberList::iterator mi = aw->members.begin()
               , me = aw->members.end(); mi != me; ++mi) {
          ahir::DPElement *adpe = adp->find_dpe(*mi);
          assert(adpe);

          DPElement *dpe = find_dpe(adpe);
          assert(dpe);
          wrapper->register_member(dpe);
          dp->remove_dpe(dpe);
        }

        dpe_add_generics(wrapper);
      }
    }
  
    DPElement* create_wrapper(const std::string &id, const std::string &d
                              , unsigned num_members
                              , DPElement *dpe, DataPath *dp)
    {
      DPElement *w = new DPElement(id, dpe->ntype, dpe->cname, d
                                   , dpe->configuration);
      dp->register_wrapper(w);

      for (PortList::iterator pi = dpe->ports.begin(), pe = dpe->ports.end();
           pi != pe; ++pi) {
        Port *port = (*pi).second;
        
        if (port->id == "clk")
          continue;
        if (port->id == "reset")
          continue;

        Port *wport = create_port(w->ports, port->id, port->io_type
                                  , port->type.name, Range(DOWNTO, num_members));
        wport->mapping(WIRE, w->id + "_" + port->id);
      }

      Port *rst = create_port(w->ports, "reset", IN, "std_logic", true);
      rst->mapping(SLICE, "reset");
      
      Port *clk = create_port(w->ports, "clk", IN, "std_logic", true);
      clk->mapping(SLICE, "clk");

      return w;
    }

    // Scan the DP for LoadComplete wrappers. The corresponding
    // LoadRequest wrappers are implicit and need to be created here.
    void create_lr_wrappers(DataPath *dp, ahir::DataPath *adp)
    {
      unsigned max_id = 0;	// used for creating new wrappers
      for (ahir::WrapperList::iterator wi = adp->wrappers.begin()
             , we = adp->wrappers.end(); wi != we; ++wi) {
        ahir::Wrapper *aw = (*wi).second;
        if (max_id < aw->id)
          max_id = aw->id;
      }

      std::vector<DPElement*> worklist;
      for (DPEList::iterator wi = dp->wrappers.begin(), we = dp->wrappers.end();
           wi != we; ++wi) {
        DPElement *lc = (*wi).second;
      
        if (lc->ntype != LoadComplete)
          continue;
      
        worklist.push_back(lc);
        assert(!lc->counterpart);
      }

      for (std::vector<DPElement*>::iterator i = worklist.begin(), e = worklist.end();
           i != e; ++i) {
        DPElement *lc = *i;

        DPEList::iterator mi = lc->members.begin();
        DPElement *first = (*mi).second->counterpart;
        assert(first);
        assert(first->ntype == LoadRequest);
      
        unsigned id = ++max_id;
        DPElement *lr = create_wrapper("wrapper_" + boost::lexical_cast<std::string>(id)
                                       , lc->description
                                       , lc->members.size(), first, dp);
        lr->counterpart = lc;
        lc->counterpart = lr;
      
        // Counterparts of the LoadComplete members get added to the
        // LoadRequest.
        for (DPEList::iterator mi = lc->members.begin(), me = lc->members.end();
             mi != me; ++mi) {
          DPElement *dpe = (*mi).second;
          DPElement *cpart = dpe->counterpart;
          assert(cpart);
          assert(cpart->ntype == LoadRequest);
          lr->register_member(cpart);
          dp->remove_dpe(cpart);
        }
        
        dpe_add_generics(lr);
      }
    }

    unsigned memory_get_num_lines(DPElement *dpe)
    {
      Port *data = NULL;
      switch (dpe->ntype) {
        default:
          assert(false && "expecting Load or Store");
          break;

        case LoadRequest:
          data = dpe->counterpart->find_port("data");
          assert(data);
          break;
          
        case LoadComplete:
        case Store:
          data = dpe->find_port("data");
          assert(data);
          break;
      }

      assert(data);
      return memory::get_num_addressable_units(data->width(2));
    }

    void dpe_add_mem_generics(DPElement *dpe)
    {
      assert(is_mem(dpe->ntype));
      
      std::ostringstream width_str;
      if (!is_wrapper(dpe)) 
        width_str << "(0 => " << memory_get_num_lines(dpe) << ")";
      else {
        width_str << "(";
        DPEList::iterator me = --dpe->members.end();
        for (DPEList::iterator mi = dpe->members.begin(); mi != me; ++mi) {
          width_str << memory_get_num_lines((*mi).second) << ", ";
        }
        width_str << memory_get_num_lines((*me).second);
        width_str << ")";
      }
      
      dpe->register_generic(new Generic("width", "NaturalArray", width_str.str()));

      if (dpe->ntype == LoadComplete)
        return;
      
      std::ostringstream flag_str;
      if (!is_wrapper(dpe))
        flag_str << "(0 => true)";
      else {
        flag_str << "(true";
        unsigned count = dpe->members.size() - 1;
        assert(count > 0);
        while (count-- > 0)
          flag_str << ", true";
        flag_str << ")";
      }

      dpe->register_generic(new Generic("suppress_immediate_ack"
                                        , "BooleanArray", flag_str.str()));
    }

    void dpe_add_generics(DPElement *dpe)
    {
      NodeType ntype = dpe->ntype;
      
      if (!is_data(ntype))
        return;

      unsigned members = (is_wrapper(dpe) ? dpe->members.size() : 1);
      assert(members > 0);
      
      if (is_shared(ntype) || is_mapped_to_io(ntype)) {
        switch (ntype) {
          case LoadRequest:
          case LoadComplete:
          case Store:
            break;
            
          default:
            dpe->register_generic(new Generic("colouring", "NaturalArray"
                                              , natural_array_all_same(0, members)));
            break;
        }
      }

      if (is_mem(ntype)) {
        dpe_add_mem_generics(dpe);
      }
    }

    void dpe_update_details(DPElement *dpe, ahir::DPElement *adpe)
    {
      NodeType ntype = dpe->ntype;
      
      switch (ntype) {
        default:
          break;
	
        case Constant: {
          dpe->type = adpe->find_port("z")->type;
          dpe->value = get_conversion_spec(adpe->value, dpe->type);
        }
          break;

        case Address:
          dpe->addressable = adpe->addressable;
          break;

        case Call:
          dpe->callee = adpe->callee;
          dp->calls[dpe->id] = dpe;
        case Response:
        case LoadRequest:
        case LoadComplete: {
          assert(adpe->counterpart);
          DPElement *cpart = find_dpe(adpe->counterpart);
          if (cpart) {
            assert(!cpart->counterpart);
            cpart->counterpart = dpe;
            dpe->counterpart = cpart;
          }
          break;
        }
      }
    }
    
    void register_dpe(ahir::DPElement *a, DPElement *d)
    {
      assert(!find_dpe(a));
      dp->register_dpe_ahir_id(a->id, d);
    }
    
    DPElement* find_dpe(ahir::DPElement *adpe)
    {
      if (!adpe)
        return NULL;
      return dp->find_dpe_from_ahir_id(adpe->id);
    }

    /* ===== Datapath Ports ===== */

    void dp_create_ports()
    {
      PortList &plist = dp->ports;

      create_port(plist, "SigmaIn", IN, "BooleanArray"
                  , Range(DOWNTO, adp->reqs.size(), 1));
      create_port(plist, "SigmaOut", OUT, "BooleanArray"
                  , Range(DOWNTO, adp->acks.size(), 1));
      create_port(plist, "reset", IN, "std_logic");
      create_port(plist, "clk", IN, "std_logic");
      
      dp_create_incoming_call_ports();
      dp_create_outgoing_call_ports();
      dp_create_memory_ports();
    }

    // Create the I/O data port on the DP with given port_id and
    // port_dir, using the list of ports registered on the DPE. In the
    // process, also generate the type-conversion statements that will
    // pack/unpack the data-port on the DP.
    void dp_create_forwarded_port(PortList &plist, DPElement *dpe
                                  , const std::string &port_id
                                  , IOType port_dir)
    {
      // Find the DPE ports that are to packed or unpacked at the DP
      // and also compute the total width of the resulting data port.
      std::vector<Port*> slices;
      unsigned width = 0;
      for (PortList::iterator pi = dpe->ports.begin()
             , pe = dpe->ports.end(); pi != pe; ++pi) {
        Port *port = (*pi).second;
        if (port->is_control)
          continue;
        assert(port->io_type != port_dir);
        
        assert(port->mapping.type == WIRE);
        RangeList &ranges = port->type.ranges;
        assert(ranges.size() == 2);
        Range &r = ranges.back();
        
        int rw = r.width();
        width += (unsigned)rw;
        slices.push_back(port);
      }

      // Increment width by one, since line 0 on the data port is
      // never used, so that the port does not have zero width when
      // there is no data at the current I/O operator.
      width++;

      // Create the port on the DP.
      Port *ext = create_port(plist, port_id, port_dir
                              , "std_logic_vector", Range(DOWNTO, width));
      // Create the port on the DPE, and map the two.
      Port *mdata = create_port(dpe->ports, "odata", port_dir, ext->type);
      mdata->mapping(SLICE, port_id);

      // The DPE port presented to other DPEs. The actual
      // packing/unpacking of wires reaching the I/O operator happens
      // at the wire connected to this port.
      IOType data_port_dir = (port_dir == IN ? OUT : IN);
      Port *data = create_port(dpe->ports, "data", data_port_dir
                               , vhdl::Type("StdLogicArray2D", ext->type.ranges));
      data->type.ranges.push_front(Range(DOWNTO, 0, 0));
      data->mapping(WIRE, dpe->id + "_data");
      Wire *member = new Wire(data->mapping.name + "_0", ext->type);
      dp->register_wire(member);

      unsigned low = 1;
      for (std::vector<Port*>::iterator pi = slices.begin(), pe = slices.end();
           pi != pe; ++pi) {
        Port *port = *pi;
        dpe->remove_port(port->id);
        
        unsigned high = low + port->type.ranges.back().width();
        assert(high <= width);

        if (is_output(port))
          dp->register_wire(new Wire(port->mapping.name, port->type));
        const std::string &wire_id = port->mapping.name;

        std::ostringstream slice;
        slice << member->id << "(" << Range(DOWNTO, high - 1, low) << ")";
        low = high; /* WARNING: don't use low beyond this point */

        if (data_port_dir == IN) {
          dpe->append_to_prelude(slice.str() + " <= to_slv(extract(" + wire_id + ", 0));");
        } else {
          dpe->append_to_prelude(wire_id + " <= to_" + port->type.name
                                 + "(To_StdLogicArray2D(" + slice.str() + "));");
        }
      }
      assert(low == width);
      if (data_port_dir == IN) {
        dp->register_wire(new Wire(data->mapping.name, data->type));
        dpe->append_to_prelude(data->mapping.name
                               + " <= to_stdlogicarray2d(" + member->id + ");");
      } else
        dpe->append_to_prelude(member->id + " <= extract(" + data->mapping.name + ", 0);");
    }

    void dp_create_incoming_call_ports()
    {
      PortList &plist = dp->ports;

      ahir::DPElement *adpe = adp->acceptor;
      assert(adpe);
      DPElement *acc = find_dpe(adpe);
      assert(acc);
      dp->acceptor = acc;

      // Note the req/ack inversion here.
      create_port(plist, "call_ack", OUT, "std_logic");
      Port *oack = create_port(acc->ports, "oreq", OUT, "std_logic", true);
      oack->mapping(WIRE, "call_ack_sig");
      
      create_port(plist, "call_req", IN, "std_logic");
      Port *oreq = create_port(acc->ports, "oack", IN, "std_logic", true);
      oreq->mapping(SLICE, "call_req");

      // Note that the accept data port is not mapped to the DPE port.
      // Instead, the printer must generate a set of convertor
      // functions from SLV to the relevant data-type.
      dp_create_forwarded_port(plist, acc, "call_data", IN);

      create_port(plist, "call_tag", IN, "std_logic_vector");
      
      assert(adp->retval);
      DPElement *retval = find_dpe(adp->retval);
      assert(retval);
      dp->retval = retval;

      create_port(plist, "return_ack", IN, "std_logic");
      oack = create_port(retval->ports, "oack", IN, "std_logic", true);
      oack->mapping(SLICE, "return_ack");
      
      create_port(plist, "return_req", OUT, "std_logic");
      oreq = create_port(retval->ports, "oreq", OUT, "std_logic", true);
      oreq->mapping(SLICE, "return_req");
      
      // Note that the return data port is not mapped to the DPE port.
      // Instead, the printer must generate a set of convertor
      // functions from SLV to the relevant data-type.
      dp_create_forwarded_port(plist, retval, "return_data", OUT);

      create_port(plist, "return_tag", OUT, "std_logic_vector");
    }

    void dp_create_outgoing_call_ports()
    {
      PortList &plist = dp->ports;
      for (DPEList::iterator ci = dp->calls.begin(), ce = dp->calls.end();
           ci != ce; ++ci) {
        DPElement *call = (*ci).second;
        DPElement *resp = call->counterpart;

        std::ostringstream cid_str;
        cid_str << "call_" << call->id;
        std::string cid = cid_str.str();
        
        create_port(plist, cid + "_req", OUT, "std_logic");
        Port *oreq = create_port(call->ports, "oreq", OUT, "std_logic", true);
        oreq->mapping(SLICE, cid + "_req");
        
        create_port(plist, cid + "_ack", IN, "std_logic");
        Port *oack = create_port(call->ports, "oack", IN, "std_logic", true);
        oack->mapping(SLICE, cid + "_ack");
        
        // Note that the call data port is not mapped to the DPE port.
        // Instead, the printer must generate a set of convertor
        // functions from SLV to the relevant data-type.
        dp_create_forwarded_port(plist, call, cid + "_data", OUT);

        std::ostringstream rid_str;
        rid_str << "return_" << call->id; // note that we do NOT use resp->id here.
        std::string rid = rid_str.str();
        
        create_port(plist, rid + "_req", OUT, "std_logic");
        oreq = create_port(resp->ports, "oreq", OUT, "std_logic", true);
        oreq->mapping(SLICE, rid + "_req");
        
        create_port(plist, rid + "_ack", IN, "std_logic");
        oack = create_port(resp->ports, "oack", IN, "std_logic", true);
        oack->mapping(SLICE, rid + "_ack");
        
        // Note that the response data port is not mapped to the DPE
        // port. Instead, the printer must generate a set of convertor
        // functions from SLV to the relevant data-type.
        dp_create_forwarded_port(plist, resp, rid + "_data", IN);
      }
    }

    void dp_latch_call_tag()
    {
      Entity *latch = new SimpleEntity("call_tag_latch", "TagLatch");
      dp->register_instance(latch);

      // dp->register_wire(new Wire("call_ack_sig", vhdl::Type("std_logic")));

      Port *port = create_port(latch->ports, "clk", IN, "std_logic");
      port->mapping(SLICE, "clk");
      
      port = create_port(latch->ports, "reset", IN, "std_logic");
      port->mapping(SLICE, "reset");
      
      port = create_port(latch->ports, "r", IN, "std_logic");
      port->mapping(SLICE, "call_req");
      
      port = create_port(latch->ports, "a", IN, "std_logic");
      port->mapping(WIRE, "call_ack_sig");
      
      port = create_port(latch->ports, "tag_in", IN, "std_logic_vector");
      port->mapping(SLICE, "call_tag");
      
      port = create_port(latch->ports, "tag_out", OUT, "std_logic_vector");
      port->mapping(SLICE, "return_tag");

      latch->append_to_prelude("call_ack <= call_ack_sig;");
    }

    /* ===== DPE external ports ===== */
    
    void dpe_create_memory_ports()
    {
      for (DPEList::iterator di = dp->elements.begin(), de = dp->elements.end();
           di != de; ++di) {
        DPElement *dpe = (*di).second;

        switch (dpe->ntype) {
          case Store:
            dpe_create_store_mports(dpe);
            break;

          case LoadRequest:
            dpe_create_load_mports(dpe);
            break;

          default:
            break;
        }
      }

      for (DPEList::iterator di = dp->wrappers.begin(), de = dp->wrappers.end();
           di != de; ++di) {
        DPElement *dpe = (*di).second;

        switch (dpe->ntype) {
          case Store:
            dpe_create_store_mports(dpe);
            break;
            
          case LoadRequest:
            dpe_create_load_mports(dpe);
            break;

          case Input:
          case Output:
            assert(false);
            break;

          default:
            break;
        }
      }
    }
    

    /* ===== Datapath memory interface ===== */

    void dp_create_memory_ports()
    {
      dpe_create_memory_ports();
      dp_create_load_ports();
      dp_create_store_ports();
    }

    void dp_create_load_ports()
    {
      if (dp->load_lines == 0)
        return;
      
      PortList &plist = dp->ports;

      create_port(plist, "lr_addr", OUT, "std_logic_vector"
                  , Range(DOWNTO, memory::address_width * dp->load_lines));
      create_port(plist, "lr_req", OUT, "std_logic_vector"
                  , Range(DOWNTO, dp->load_lines));
      create_port(plist, "lr_ack", IN, "std_logic_vector"
                  , Range(DOWNTO, dp->load_lines));
      create_port(plist, "lr_tag", OUT, "std_logic_vector"
                  , Range(DOWNTO, memory::tag_width * dp->load_lines));
    
      create_port(plist, "lc_data", IN, "std_logic_vector"
                  , Range(DOWNTO, memory::data_width * dp->load_lines));
      create_port(plist, "lc_req", OUT, "std_logic_vector"
                  , Range(DOWNTO, dp->load_lines));
      create_port(plist, "lc_ack", IN, "std_logic_vector"
                  , Range(DOWNTO, dp->load_lines));
      create_port(plist, "lc_tag", IN, "std_logic_vector"
                  , Range(DOWNTO, memory::tag_width * dp->load_lines));
    }

    void dp_create_store_ports()
    {
      if (dp->store_lines == 0)
        return;
      
      PortList &plist = dp->ports;

      create_port(plist, "sr_addr", OUT, "std_logic_vector"
                  , Range(DOWNTO, memory::address_width * dp->store_lines));
      create_port(plist, "sr_data", OUT, "std_logic_vector"
                  , Range(DOWNTO, memory::data_width * dp->store_lines));
      create_port(plist, "sr_req", OUT, "std_logic_vector"
                  , Range(DOWNTO, dp->store_lines));
      create_port(plist, "sr_ack", IN, "std_logic_vector"
                  , Range(DOWNTO, dp->store_lines));
      create_port(plist, "sr_tag", OUT, "std_logic_vector"
                  , Range(DOWNTO, memory::tag_width * dp->store_lines));
    }

    /* ===== DPE memory interface ===== */

    void dpe_create_store_mports(DPElement *store)
    {
      // Create the memory ports on the store DPE
      Port *data = store->find_port("data");
      unsigned num_lines = memory::get_num_addressable_units(data->width(2));
      unsigned low = dp->store_lines;
      unsigned high = low + num_lines; // this is the next index
	
      dpe_create_mport(store, "addr", OUT, high, low, memory::address_width);
      dpe_create_mport(store, "data", OUT, high, low, memory::data_width);
      dpe_create_mport(store, "req", OUT, high, low);
      dpe_create_mport(store, "ack", IN, high, low);
      dpe_create_mport(store, "tag", OUT, high, low, memory::tag_width);
    
      dp->store_lines = high;
    }

    void dpe_create_load_mports(DPElement *lr)
    {
      DPElement *lc = lr->counterpart;
      assert(lc && lc->counterpart == lr);
      
      // Create the memory interface on the LR.
      Port *data = lc->find_port("data");
      assert(data);
      unsigned num_lines = memory::get_num_addressable_units(data->width(2));
      
      unsigned low = dp->load_lines;
      unsigned high = low + num_lines; // this is the next index
	
      dpe_create_mport(lr, "addr", OUT, high, low, memory::address_width);
      dpe_create_mport(lr, "req", OUT, high, low);
      dpe_create_mport(lr, "ack", IN, high, low);
      dpe_create_mport(lr, "tag", OUT, high, low, memory::tag_width);
    
      dpe_create_mport(lc, "data", IN, high, low, memory::data_width);
      dpe_create_mport(lc, "req", OUT, high, low);
      dpe_create_mport(lc, "ack", IN, high, low);
      dpe_create_mport(lc, "tag", IN, high, low, memory::tag_width);

      dp->load_lines = high;
    }

    Port* dpe_create_mport(DPElement *dpe
                           , const std::string &id, hls::IOType io_type
                           , unsigned high, unsigned low, unsigned width = 1)
    {
      assert(high >= low);
      assert(dpe->ntype == LoadComplete || dpe->ntype == LoadRequest
             || dpe->ntype == Store);
      Port *p = create_port(dpe->ports, "m" + id, io_type, "std_logic_vector"
                            , Range(DOWNTO, width));
    
      const std::string prefix = (dpe->ntype == LoadComplete
                                  ? "lc_" : (dpe->ntype == LoadRequest
                                             ? "lr_" : "sr_"));
      p->mapping(SLICE, prefix + id, Range(DOWNTO, high * width - 1, low * width));
      return p;
    }
  };
  
} // end anonymous namespace

DataPath* vhdl::create_dp(ahir::DataPath *dp)
{
  static Builder builder;

  builder.reset();

  return builder.create_dp(dp);
}

