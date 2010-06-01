#include "AHIRBuilder.hpp"

#include <CDFG/CDFGVisitor.hpp>

#include <Base/Program.hpp>
#include <CDFG/CDFG.hpp>
#include <CDFG/Utils.hpp>

#include <AHIR/ControlPath.hpp>
#include <AHIR/CPUtils.hpp>
#include <AHIR/DataPath.hpp>
#include <AHIR/LinkLayer.hpp>
#include <AHIR/AHIRModule.hpp>

#include <boost/lexical_cast.hpp>
#include <sstream>
#include <assert.h>

using namespace cdfg;
using namespace ahir;

namespace {

  typedef std::map<std::string, Transition*> TList;

  class NodeFragment;
  typedef std::map<CDFGNode*, NodeFragment*> NodeFragmentMap;

  struct NodeFragment 
  {
    DPElement *dpe;

    TList transitions;
    Place *place;

    Transition* find_transition(const std::string &id)
    {
      if (transitions.find(id) != transitions.end())
        return transitions[id];
      return NULL;
    }
    
    void register_transition(const std::string &id, Transition *t)
    {
      assert(!find_transition(id));
      transitions[id] = t;
    }
  };
  
  struct AHIRBuilder : public cdfg::CDFGVisitor<AHIRBuilder> 
  {
    cdfg::CDFG *cdfg;
    Module *ahir;
    ControlPath *cp;
    DataPath *dp;
    LinkLayer *ln;
    
    AHIRBuilder()
    {
      clear();
    }

    void clear()
    {
      cdfg = NULL;
      ahir = NULL;
      cp = NULL;
      dp = NULL;
      ln = NULL;
      node_fragments.clear();
    }

    ahir::Module* cdfg2ahir(CDFG *cdfg)
    {
      ahir = new Module(cdfg->id);
      cp = ahir->cp = new ControlPath(ahir->id + "_cp");
      dp = ahir->dp = new DataPath(ahir->id + "_dp");
      ln = ahir->ln = new LinkLayer(ahir->id + "_ln");
  
      visit(cdfg);
  
      if (cdfg->retval)
        ahir->dp->retval = get_dpe(cdfg->retval);

      if (cdfg->acceptor)
        ahir->dp->acceptor = get_dpe(cdfg->acceptor);

      return ahir;
    }

    /* ===== Node Visitors ===== */

    void visit_node(CDFGNode *node)
    {
      NodeFragment* fragment = new NodeFragment();
      register_node_fragment(node, fragment);
      fragment->dpe = create_dpe(node);
      visit_ports(node, fragment);
      assign_node_details(node, fragment->dpe);
    }

    void visit_Fork(CDFGNode *node)
    {
      visit_Fork_or_Join(node);
    }

    void visit_Join(CDFGNode *node)
    {
      visit_Fork_or_Join(node);
    }

    void visit_Fork_or_Join(cdfg::CDFGNode *node)
    {
      NodeFragment *fragment = new NodeFragment();
      register_node_fragment(node, fragment);
      create_transition(HIDDEN, node, fragment, "main");
    }

    void visit_Merge(CDFGNode *node)
    {
      NodeFragment *fragment = new NodeFragment();
      register_node_fragment(node, fragment);
      fragment->place = create_place(node->description);

      assert(node->input_control_ports.size() > 1);
      assert(node->output_control_ports.size() == 1);
    }

    void visit_Start(CDFGNode *node)
    {
      NodeFragment *fragment = new NodeFragment();
      register_node_fragment(node, fragment);
      fragment->register_transition("main", cp->init);
    }

    void visit_Stop(CDFGNode *node)
    {
      NodeFragment *fragment = new NodeFragment();
      register_node_fragment(node, fragment);
      fragment->register_transition("main", cp->fin);
    }

    /* ===== Port Visitors ===== */
    
    void visit_ports(CDFGNode *node, NodeFragment *fragment) 
    {
      // First process all the data ports.
      visit_data_ports(node, fragment->dpe);
  
      // Constant nodes have no control flow
      if (is_constant(node))
        return;

      visit_control_ports(node, fragment);
    }

    void visit_data_ports(CDFGNode *node, DPElement *dpe)
    {
      for (CDFGNode::PortList::iterator pi = node->ports.begin()
             , pe = node->ports.end(); pi != pe; ++pi) {
        cdfg::Port *dport = (*pi).second;
        if (!is_data(dport))
          continue;
        create_port(dpe, dport);
      }
    }

    void visit_control_ports(CDFGNode *node, NodeFragment *fragment)
    {
      if (is_pipelined(node->ntype)) {
    
        assert(node->input_control_ports.size() == 1);
        assert(node->output_control_ports.size() == 1);

        Transition *reqR = create_transition(REQ, node, fragment, "reqR");
        Transition *ackR = create_transition(ACK, node, fragment, "ackR");
        Transition *reqC = create_transition(REQ, node, fragment, "reqC");
        Transition *ackC = create_transition(ACK, node, fragment, "ackC");

        control_flow(reqR, ackR);
        control_flow(ackR, reqC);
        control_flow(reqC, ackC);
    
      } else {
        fragment->place = create_place(node->description);
        for (CDFGNode::PortList::iterator pi = node->ports.begin()
               , pe = node->ports.end(); pi != pe; ++pi) {
          cdfg::Port *cport = (*pi).second;
          if (is_data(cport))
            continue;
          Transition *t = create_transition((is_input(cport) ? REQ : ACK)
                                            , node, fragment, cport->id);
          if (is_input(cport))
            ahir::control_flow(t, fragment->place);
          else
            ahir::control_flow(fragment->place, t);
        }
      }
    }

    /* ===== Edge Visitors ===== */

    void visit_data_edge(CDFGEdge *edge) 
    {
      cdfg::Port *driver = edge->driver;
      CDFGNode *dnode = driver->parent;
      assert(dnode);

      DPElement *de = get_dpe(dnode);

      ahir::Port *d = de->find_port(driver->id);
      assert(d);
      create_wire(d);

      // assert(edge->users.size() > 0);
      for (CDFGEdge::UserList::iterator ui = edge->users.begin()
             , ue = edge->users.end(); ui != ue; ++ui) {
        cdfg::Port *user = *ui;

        CDFGNode *unode = user->parent;
        assert(unode);

        DPElement *du = get_dpe(unode);

        ahir::Port *u = du->find_port(user->id);
        assert(u);

        d->wire->add_user(u);
      }
    }

    void visit_control_edge(CDFGEdge *edge)
    {
      cdfg::Port *driver = edge->driver;
      CDFGNode *cnode = driver->parent;
      assert(cnode);
  
      assert(edge->users.size() == 1);
      cdfg::Port *user = *edge->users.begin();
      CDFGNode *unode = user->parent;
      assert(unode);
  
      CPElement *src = (cnode->ntype == hls::Merge
                        ? (CPElement*)get_place(cnode)
                        : (CPElement*)get_exit_transition(cnode, driver->id));
      CPElement *dst = (unode->ntype == hls::Merge
                        ? (CPElement*)get_place(unode)
                        : (CPElement*)get_entry_transition(unode, user->id));
      control_flow(src, dst);
    }

    /* ===== Fragments ===== */

    NodeFragmentMap node_fragments;
    
    void register_node_fragment(CDFGNode *node, NodeFragment *frag)
    {
      assert(!find_node_fragment(node));
      node_fragments[node] = frag;
    }
    
    NodeFragment* find_node_fragment(CDFGNode *node)
    {
      if (node_fragments.find(node) != node_fragments.end())
        return node_fragments[node];
      return NULL;
    }

    DPElement* get_dpe(CDFGNode *node)
    {
      DPElement *ret = find_dpe(node);
      assert(ret);
      return ret;
    }

    DPElement* find_dpe(CDFGNode *node) 
    {
      NodeFragment *fragment = find_node_fragment(node);
      if (!fragment)
        return NULL;
      
      assert(fragment->dpe);
  
      return fragment->dpe;
    }

    DPElement* get_dpe_from_node_id(unsigned id)
    {
      CDFGNode *node = cdfg->find_node(id);
      assert(node);
      return get_dpe(node);
    }

    Transition* get_exit_transition(CDFGNode *node, const std::string &id)
    {
      if (hls::is_pipelined(node->ntype))
        return get_transition(node, "ackC");

      return get_transition(node, id);
    }

    Transition* get_entry_transition(CDFGNode *node, const std::string &id)
    {
      if (hls::is_pipelined(node->ntype))
        return get_transition(node, "reqR");

      return get_transition(node, id);
    }

    Transition* get_transition(CDFGNode *node, const std::string &id)
    {
      NodeFragment *fragment = find_node_fragment(node);
      assert(fragment);
  
      Transition *ret = NULL;

      switch (node->ntype) {
        case hls::Fork:
        case hls::Join:
        case hls::Start:
        case hls::Stop:
          ret = fragment->find_transition("main");
          break;

        default:
          ret = fragment->find_transition(id);
          break;
      }
  
      assert(ret);
      return ret;
    }

    Place* get_place(CDFGNode *node)
    {
      NodeFragment *fragment = find_node_fragment(node);
      assert(fragment);
      assert(fragment->place);
      return fragment->place;
    }

    /* ===== Construction Kit ===== */

    DPElement* create_dpe(CDFGNode *node)
    {
      DPElement *dpe = new DPElement(dp->elements.size() + 1, node->ntype, node->description);
      dp->register_dpe(dpe);
      return dpe;
    }

    void assign_node_details(CDFGNode *node, DPElement *dpe) 
    {
      switch (node->ntype) {
        case hls::Constant:
          dpe->value = node->value;
          break;

        case hls::Address:
          dpe->addressable = node->addressable;
          break;

        case hls::Call:
          dpe->callee = node->callee;
        case hls::Response:
        case hls::LoadRequest:
        case hls::LoadComplete: {
          CDFGNode *cnode = node->counterpart;
          assert(cnode);
          DPElement *cpart = find_dpe(cnode);
          if (cpart) {
            assert(!cpart->counterpart);
            cpart->counterpart = dpe;
            dpe->counterpart = cpart;
          }
          break;
        }

        case hls::Input:
        case hls::Output:
          dpe->portname = node->portname;
          break;

        default:
          break;
      }
    }

    ahir::Port* create_port(DPElement *dpe, cdfg::Port *dport)
    {
      // Important: The port ID should be the same, else it breaks an
      // assumption in the function visit_Call().
      assert(is_data(dport));
      ahir::Port *aport = new ahir::Port(dport->id, dport->dir, dport->type);
      dpe->register_port(aport);
      return aport;
    }

    void create_wire(ahir::Port *port)
    {
      assert(port);
      assert(!port->wire);
      assert(is_output(port));
      port->wire = new Wire(dp->wires.size() + 1);
      port->wire->driver = port;
      dp->register_wire(port->wire);
    }

    Transition* create_transition(CPEType _t, CDFGNode *node
                                  , NodeFragment *fragment
                                  , const std::string &id)
    {
      Transition *t = new Transition(cp->elements.size(), _t
                                     , node->description + ":" + id);

      if (fragment->dpe) {
      
        switch (_t) {
          case REQ:
            t->symbol = cp->reqs.size() + 1;
            dp->register_req(fragment->dpe, id, lambda_to_sigma(t));
            break;
          case ACK:
            t->symbol = cp->acks.size() + 1;
            dp->register_ack(fragment->dpe, id, sigma_to_lambda(t));
            break;
          default:
            break;
        }
      }
      
      fragment->register_transition(id, t);
      cp->register_transition(t);

      return t;
    }

    Place* create_place(const std::string &description)
    {
      Place *p = new Place(cp->elements.size(), description);
      cp->register_place(p);

      return p;
    }

    Symbol lambda_to_sigma(Transition *t)
    {
      assert(is_req(t));
      Symbol req = dp->reqs.size() + 1;

      ln->map(cp->id + "_LambdaOut", t->symbol, dp->id + "_SigmaIn", req);
      return req;
    }

    Symbol sigma_to_lambda(Transition *t)
    {
      assert(is_ack(t));
      Symbol ack = dp->acks.size() + 1;
  
      ln->map(dp->id + "_SigmaOut", ack, cp->id + "_LambdaIn", t->symbol);
      return ack;
    }

    void control_flow(CPElement *src, CPElement *snk) 
    {
      if (is_trans(src) && is_trans(snk))
        return control_flow(static_cast<Transition*>(src), static_cast<Transition*>(snk));

      return ahir::control_flow(src, snk);
    }
    
    void control_flow(Transition *src, Transition *snk)
    {
      Place *p = create_place("from " + src->description + " to " + snk->description);
      ahir::control_flow(src, p);
      ahir::control_flow(p, snk);
    }
  
  };
  
} // end anonymous namespace    

void ahir::cdfg2ahir(hls::Program *program)
{
  const std::string start_id = program->start->id;

  AHIRBuilder builder;
  
  for (hls::Program::ModuleList::iterator fi = program->modules.begin()
         , fe = program->modules.end(); fi != fe; ++fi) {
    hls::Module *func = (*fi).second;
    assert(is_cdfg(func));
    CDFG *cdfg = static_cast<CDFG*>(func);

    builder.clear();
    ahir::Module *ahir = builder.cdfg2ahir(cdfg);
    delete cdfg;
    (*fi).second = ahir;
  }

  program->start = program->find_module(start_id);
}

