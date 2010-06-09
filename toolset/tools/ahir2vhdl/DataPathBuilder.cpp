#include "DataPathBuilder.hpp"
#include "Utils.hpp"
#include "EntityBuilder.hpp"
#include "SimpleEntity.hpp"
#include "typedefs.hpp"

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

    typedef std::map<ahir::DPElement*, DPElement*> DPEMap;
    DPEMap dpe_map;

    Builder() { reset(); }
    
    void reset()
    {
      dp = NULL;
      adp = NULL;
      dpe_map.clear();
    }
    
    void map_adpe_to_dpe(ahir::DPElement *a, DPElement *d)
    {
      assert(!find_dpe_for_adpe(a));
      dpe_map[a] = d;
    }
    
    DPElement* find_dpe_for_adpe(ahir::DPElement *adpe)
    {
      if (!adpe)
        return NULL;
      if (dpe_map.find(adpe) == dpe_map.end())
        return NULL;
      return dpe_map[adpe];
    }

    DataPath* create_dp(ahir::DataPath *ahir) 
    {
      adp = ahir;
      dp = new DataPath(adp->id, "" /* ahir::DataPath has no description. Yet. */);
    
      // create a vhdl::dpe for each ahir::dpe
      create_elements();

      // create a single element to represent each I/O port, removing
      // all the individual DPEs from DP.
      collect_io_elements();
    
      // create wrappers and remove members from the DP.
      wrap_shared_elements();
    
      // LR are created later in one bunch because we need to know the
      // total number of wrappers when generating IDs for new members.
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

    void create_dpe_ports(ahir::DPElement *adpe, DPElement *dpe, bool has_1D_ports)
    {
      hls::NodeType ntype = dpe->ntype;
      
      for (ahir::PortList::iterator pi = adpe->ports.begin(), pe = adpe->ports.end();
           pi != pe; ++pi) {
        ahir::Port *p = (*pi).second;
        
        const bool has_slv_proxy = (is_io(ntype) || is_mem(ntype)) && (p->id == "data");
        const bool needs_proxy = has_slv_proxy || has_1D_ports;
        const bool output_port = is_output(p);
        
        const std::string wire_id = vhdl_wire_name(p->wire);
        const std::string proxy_id = dpe->id + "_" + p->id;

        const std::string data_type = (has_1D_ports
                                       ? str(p->type->type_id)
                                       : vhdl_array_type_name(p->type));

        // Use std_logic when creating a port that needs an SLV proxy,
        // else use the actual data-type
        Port *port = create_port(dpe->ports, p->id, p->io_type
                                 , vhdl::Type((has_slv_proxy ? "StdLogicArray2D"
                                               : data_type)
                                              , (has_slv_proxy ? Range(DOWNTO, p->type->width())
                                                 : create_range(p->type))));
          
        // Promote the port type to a two-dimensional array if appropriate.
        if (!has_1D_ports)
          port->type.ranges.push_front(Range(DOWNTO, 1));

        // The port declares the wire if it is a proxy, or it is an
        // output port.
        port->mapping(((needs_proxy || port->io_type == OUT) ? WIRE : SLICE)
                      , (needs_proxy ? proxy_id : wire_id));

        // Normally, every output port also declares the attached
        // wire; but in case of an output port with a proxy, the
        // actual wire remains undeclared. Such wires need to be
        // registered with the DP.
        if (needs_proxy) {
          if (output_port) {
            Wire *wire = new Wire(wire_id, vhdl::Type(vhdl_array_type_name(p->type)
                                                      , create_range(p->type)));
            dp->register_wire(wire);
            wire->type.ranges.push_front(Range(DOWNTO, 1));
          }
        }

        // Connect the proxies by inserting assignment statements in
        // the prelude.
        if (has_slv_proxy) {
          const std::string assign =
            (output_port
             ? wire_id + " <= To_" + data_type + "(" + proxy_id + ");"
             : proxy_id + " <= To_StdLogicArray2D(" + wire_id + ");");
          dpe->append_to_prelude(assign);
          continue; // ensures mutual exclusion with the next
                    // if-block.
        }

        if (has_1D_ports) {
          const std::string assign =
            (output_port
             ? wire_id + " <= to_" + vhdl_array_type_name(p->type)
             + "(" + port->mapping.name + ");"
             : port->mapping.name + " <= extract(" + wire_id + ", 0);");
          dpe->append_to_prelude(assign);
        }
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

        // A few elemnts like multiplexers are never shared, and hence
        // they do not have two-dimensional array ports.
        bool has_1D_ports = !has_2D_ports(ntype);

        create_dpe_ports(adpe, dpe, has_1D_ports);
        
        dpe_create_symbol_ports(dpe->ports, adpe->reqs, IN, "SigmaIn", !has_1D_ports);
        dpe_create_symbol_ports(dpe->ports, adpe->acks, OUT, "SigmaOut", !has_1D_ports);
        entity_create_clk_ports(dpe);
        dpe_update_details(dpe, adpe);

        dp->register_dpe(dpe);
        map_adpe_to_dpe(adpe, dpe);
      }
    }

    /* ===== Wrappers ===== */

    std::string wrapper_id(unsigned id)
    {
      return "wrapper_" + boost::lexical_cast<std::string>(id);
    }

    void collect_io_elements()
    {
      for (ahir::DataPath::IOPortList::iterator pi = adp->io_ports.begin()
             , pe = adp->io_ports.end(); pi != pe; ++pi) {
        ahir::DPEVector &dl = (*pi).second;
        assert(dl.size() > 0);
        if (dl.size() == 1)
          continue;

        ahir::DPElement *first_dpe = dl.front();
        NodeType ntype = first_dpe->ntype;
        assert(is_io(ntype));
        assert((*pi).first == first_dpe->portname);
        
        create_wrapper("io_" + first_dpe->portname
                       , (first_dpe->ntype == Input
                          ? "InputPort" : "OutputPort")
                       , dl, dp);
      }
    }
    
    void wrap_shared_elements()
    {
      for (ahir::WrapperList::iterator wi = adp->wrappers.begin()
             , we = adp->wrappers.end(); wi != we; ++wi) {
        ahir::Wrapper *aw = (*wi).second;

        ahir::DPEVector members;
        
        for (ahir::MemberList::iterator mi = aw->members.begin()
               , me = aw->members.end(); mi != me; ++mi) {
          ahir::DPElement *adpe = adp->find_dpe(*mi);
          assert(adpe);
          members.push_back(adpe);
        }
      
        create_wrapper(wrapper_id(aw->id), aw->description, members, dp);
      }
    }
  
    DPElement* create_wrapper(const std::string &id, const std::string &d
                              , ahir::DPEVector &dv, DataPath *dp)
    {
      ahir::DPElement *adpe = dv.front();
      DPElement *vdpe = find_dpe_for_adpe(adpe);
      assert(vdpe);
      
      unsigned num_members = dv.size();
      
      DPElement *w = new DPElement(id, vdpe->ntype, vdpe->cname, d
                                   , vdpe->configuration);
      dp->register_wrapper(w);
      
      if (is_io(w->ntype)) {
        w->portname = vdpe->portname;
      }

      for (PortList::iterator pi = vdpe->ports.begin(), pe = vdpe->ports.end();
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

      entity_create_clk_ports(w);

      for (ahir::DPEVector::iterator di = dv.begin(), de = dv.end();
           di != de; ++di) {
        ahir::DPElement *adpe = *di;
        DPElement *vdpe = find_dpe_for_adpe(adpe);
        assert(vdpe);
        w->register_member(vdpe);
        dp->remove_dpe(vdpe);
      }

      dpe_add_generics(w);
      
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

      for (ahir::WrapperList::iterator wi = adp->wrappers.begin()
             , we = adp->wrappers.end(); wi != we; ++wi) {
        ahir::Wrapper *aw = (*wi).second;

        DPElement *lc = dp->find_wrapper(wrapper_id(aw->id));
        if (lc->ntype != LoadComplete)
          continue;

        assert(!lc->counterpart);
        
        ahir::DPEVector members;
        for (ahir::MemberList::iterator mi = aw->members.begin()
               , me = aw->members.end(); mi != me; ++mi) {
          ahir::DPElement *adpe = adp->find_dpe(*mi);
          assert(adpe);
          assert(adpe->counterpart);
          members.push_back(adpe->counterpart);
        }

        unsigned id = ++max_id;
        DPElement *lr = create_wrapper(wrapper_id(id)
                                       , lc->description
                                       , members, dp);
        lr->counterpart = lc;
        lc->counterpart = lr;
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
          DPElement *cpart = find_dpe_for_adpe(adpe->counterpart);
          if (cpart) {
            assert(!cpart->counterpart);
            cpart->counterpart = dpe;
            dpe->counterpart = cpart;
          }
          break;
        }

        case Input:
        case Output:
          dpe->portname = adpe->portname;
          break;
      }
    }
    
    /* ===== Datapath Ports ===== */

    void dp_create_ports()
    {
      entity_create_port_with_map(dp, "SigmaIn", IN
                                  , vhdl::Type("BooleanArray"
                                               , Range(DOWNTO, adp->reqs.size(), 1))
                                  , WIRE);
      entity_create_port_with_map(dp, "SigmaOut", OUT
                                  , vhdl::Type("BooleanArray"
                                               , Range(DOWNTO, adp->acks.size(), 1))
                                  , WIRE);
      entity_create_clk_ports(dp);
      dp_create_incoming_call_ports();
      dp_create_outgoing_call_ports();
      dp_create_memory_ports();
      dp_create_io_ports(dp);
    }

    // Create the I/O data port on the DP with given port_id and
    // port_dir, using the list of ports registered on the DPE. In the
    // process, also generate the type-conversion statements that will
    // pack/unpack the data-port on the DP.
    void dp_create_forwarded_port(DPElement *dpe
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
      Port *ext = entity_create_port_with_map(dp, port_id, port_dir
                                              , vhdl::Type("std_logic_vector"
                                                           , Range(DOWNTO, width))
                                              , WIRE);
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
        dpe->append_to_prelude(data->mapping.name
                               + " <= to_stdlogicarray2d(" + member->id + ");");
      } else
        dpe->append_to_prelude(member->id + " <= extract(" + data->mapping.name + ", 0);");
    }

    void dp_create_incoming_call_ports()
    {
      ahir::DPElement *adpe = adp->acceptor;
      assert(adpe);
      DPElement *acc = find_dpe_for_adpe(adpe);
      assert(acc);
      dp->acceptor = acc;

      // Note the req/ack inversion here.
      entity_create_port_with_map(dp, "call_ack", OUT, vhdl::Type("std_logic"), WIRE);
      Port *oack = create_port(acc->ports, "oreq", OUT, "std_logic", true);
      oack->mapping(WIRE, "call_ack_sig");
      
      entity_create_port_with_map(dp, "call_req", IN, vhdl::Type("std_logic"), WIRE);
      Port *oreq = create_port(acc->ports, "oack", IN, "std_logic", true);
      oreq->mapping(SLICE, "call_req");

      // Note that the accept data port is not mapped to the DPE port.
      // Instead, the printer must generate a set of convertor
      // functions from SLV to the relevant data-type.
      dp_create_forwarded_port(acc, "call_data", IN);

      entity_create_port_with_map(dp, "call_tag", IN, vhdl::Type("std_logic_vector"), WIRE);
      
      assert(adp->retval);
      DPElement *retval = find_dpe_for_adpe(adp->retval);
      assert(retval);
      dp->retval = retval;

      entity_create_port_with_map(dp, "return_ack", IN, vhdl::Type("std_logic"), WIRE);
      oack = create_port(retval->ports, "oack", IN, "std_logic", true);
      oack->mapping(SLICE, "return_ack");
      
      entity_create_port_with_map(dp, "return_req", OUT, vhdl::Type("std_logic"), WIRE);
      oreq = create_port(retval->ports, "oreq", OUT, "std_logic", true);
      oreq->mapping(SLICE, "return_req");
      
      // Note that the return data port is not mapped to the DPE port.
      // Instead, the printer must generate a set of convertor
      // functions from SLV to the relevant data-type.
      dp_create_forwarded_port(retval, "return_data", OUT);

      entity_create_port_with_map(dp, "return_tag", OUT, vhdl::Type("std_logic_vector"), WIRE);
    }

    void dp_create_outgoing_call_ports()
    {
      for (DPEList::iterator ci = dp->calls.begin(), ce = dp->calls.end();
           ci != ce; ++ci) {
        DPElement *call = (*ci).second;
        DPElement *resp = call->counterpart;

        std::ostringstream cid_str;
        cid_str << "call_" << call->id;
        std::string cid = cid_str.str();
        
        entity_create_port_with_map(dp, cid + "_req", OUT, vhdl::Type("std_logic"), WIRE);
        Port *oreq = create_port(call->ports, "oreq", OUT, "std_logic", true);
        oreq->mapping(SLICE, cid + "_req");
        
        entity_create_port_with_map(dp, cid + "_ack", IN, vhdl::Type("std_logic"), WIRE);
        Port *oack = create_port(call->ports, "oack", IN, "std_logic", true);
        oack->mapping(SLICE, cid + "_ack");
        
        // Note that the call data port is not mapped to the DPE port.
        // Instead, the printer must generate a set of convertor
        // functions from SLV to the relevant data-type.
        dp_create_forwarded_port(call, cid + "_data", OUT);

        std::ostringstream rid_str;
        rid_str << "return_" << call->id; // note that we do NOT use resp->id here.
        std::string rid = rid_str.str();
        
        entity_create_port_with_map(dp, rid + "_req", OUT, vhdl::Type("std_logic"), WIRE);
        oreq = create_port(resp->ports, "oreq", OUT, "std_logic", true);
        oreq->mapping(SLICE, rid + "_req");
        
        entity_create_port_with_map(dp, rid + "_ack", IN, vhdl::Type("std_logic"), WIRE);
        oack = create_port(resp->ports, "oack", IN, "std_logic", true);
        oack->mapping(SLICE, rid + "_ack");
        
        // Note that the response data port is not mapped to the DPE
        // port. Instead, the printer must generate a set of convertor
        // functions from SLV to the relevant data-type.
        dp_create_forwarded_port(resp, rid + "_data", IN);
      }
    }

    void dp_latch_call_tag()
    {
      Entity *latch = new SimpleEntity("call_tag_latch", "TagLatch");
      dp->register_instance(latch);

      entity_create_clk_ports(latch);
      
      entity_create_port_with_map_name(latch, "r", IN, vhdl::Type("std_logic")
                                       , SLICE, "call_req");
      
      latch->append_to_prelude("call_ack <= call_ack_sig;");
      entity_create_port_with_map_name(latch, "a", IN, vhdl::Type("std_logic")
                                       , WIRE, "call_ack_sig");
      
      entity_create_port_with_map_name(latch, "tag_in", IN, vhdl::Type("std_logic_vector")
                                       , SLICE, "call_tag");
      
      entity_create_port_with_map_name(latch, "tag_out", OUT, vhdl::Type("std_logic_vector")
                                       , SLICE, "return_tag");

    }

    /* ===== I/O interface ===== */

    void dp_create_io_ports(DataPath *dp)
    {
      dp_io_ports_helper(dp->elements, dp);
      dp_io_ports_helper(dp->wrappers, dp);
    }
    
    void dp_io_ports_helper(DPEList& elements, DataPath *dp)
    {
      for (DPEList::iterator pi = elements.begin(), pe = elements.end();
           pi != pe; ++pi) {
        DPElement *dpe = (*pi).second;

        switch (dpe->ntype) {
          default:
            continue;
            break;

          case Input:
          case Output:
            assert(dpe->portname.size() > 0);
            create_io_ports(dp, dpe);
            break;
        }
      }
    }

    void create_io_ports(DataPath *dp, DPElement *dpe)
    {
      assert(dp->io_elements.find(dpe->portname) == dp->io_elements.end()
             && "A DPE already exists for this I/O port");
      dp->io_elements[dpe->portname] = dpe;
      
      Port *data = dpe->find_port("data");
      entity_create_forwarded_io_port(dp, dpe, dpe->portname, "data"
                                      , (dpe->ntype == Input ? IN : OUT)
                                      , vhdl::Type("std_logic_vector", data->get_range(1)));
      entity_create_forwarded_io_port(dp, dpe, dpe->portname, "req", OUT
                                      , vhdl::Type("std_logic"));
      entity_create_forwarded_io_port(dp, dpe, dpe->portname, "ack", IN
                                      , vhdl::Type("std_logic"));
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

