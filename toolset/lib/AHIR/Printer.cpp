#include "Printer.hpp"

#include "AHIRModule.hpp"
#include "ControlPath.hpp"
#include "CPUtils.hpp"
#include "DataPath.hpp"
#include "LinkLayer.hpp"
#include "Symbol.hpp"
#include "Arbiter.hpp"

#include <Base/Program.hpp>
#include <Base/Addressable.hpp>
#include <Base/Module.hpp>
#include <Base/Values.hpp>
#include <Base/Type.hpp>

#include <fstream>
#include <iostream>

using namespace hls;
using namespace ahir;

namespace ahir {

  void ahir::Printer::print_ln(LinkLayer *ln, hls::ostream &out)
  {
    out << "\n" << indent << "<ln id=\"" << ln->id << "\">";
    out << indent_in;
    
    for (LinkLayer::IfaceMap::iterator ii = ln->maps.begin()
	   , ie = ln->maps.end(); ii != ie; ++ii) {
      const std::string &from_iface = (*ii).first;
      LinkLayer::Interface &iface = (*ii).second;

      for (LinkLayer::Interface::iterator si = iface.begin()
	     , se = iface.end(); si != se; ++si) {
	Symbol from_sym = (*si).first;
	LinkLayer::Literal &lit = (*si).second;
	const std::string &to_iface = lit.iface;
	Symbol to_sym = lit.sym;

	out << indent << "<map src=\"" << from_iface
	    << "\" src_sym=\"" << from_sym
	    << "\" snk=\"" << to_iface
	    << "\" snk_sym=\"" << to_sym
	    << "\"/>";
      }
    }
    
    out << indent_out;
    out << indent << "</ln>";
  }
  
  void ahir::Printer::print_dpe(DPElement *dpe, hls::ostream &out)
  {
    out << indent << "<dpe id=\"" << dpe->id
	<< "\" ntype=\"" << str(dpe->ntype);
    if (dpe->description.size() > 0) {
      out << "\" description=\"" << dpe->description;
    }
    out << "\">";

    out << indent_in;

    switch (dpe->ntype) {
      case Constant:
	out << indent << "<value>" << dpe->value << "</value>";
	break;

      case Address:
	assert(dpe->addressable);
	out << indent << "<addressable>" << dpe->addressable->id << "</addressable>";
	break;

      case Call:
	out << indent << "<callee>" << dpe->callee << "</callee>";
      case Response:
      case LoadRequest:
      case LoadComplete:
	out << indent << "<counterpart>" << dpe->counterpart->id << "</counterpart>";
	break;
	
      default:
	break;
    }

    for (PortList::iterator pi = dpe->ports.begin(), pe = dpe->ports.end();
	 pi != pe; ++pi) {
      Port *port = (*pi).second;
      assert(port->id == (*pi).first);

      out << indent << "<port id=\"" << port->id
	  << "\" iotype=\"" << (is_input(port) ? "in" : "out")
	  << "\" type=\"" << str(port->type)
	  << "\" wire=\"" << port->wire->id
	  << "\"/>";
    }

    for (DPElement::SymbolMap::iterator si = dpe->reqs.begin()
	   , se = dpe->reqs.end(); si != se; ++si) {
      out << indent << "<req id=\"" << (*si).first << "\">"
	  << (*si).second << "</req>";
    }
    
    for (DPElement::SymbolMap::iterator si = dpe->acks.begin()
	   , se = dpe->acks.end(); si != se; ++si) {
      out << indent << "<ack id=\"" << (*si).first << "\">"
	  << (*si).second << "</ack>";
    }
    
    out << indent_out;
    out << indent << "</dpe>"
	<< "\n";
  }
  
  void ahir::Printer::print_dp(DataPath *dp, hls::ostream &out)
  {
    out << indent << "<dp id=\"" << dp->id << "\">"
	<< "\n";
    out << indent_in;

    for (WrapperList::iterator wi = dp->wrappers.begin(), we = dp->wrappers.end();
	 wi != we; ++wi) {
      Wrapper *wrapper = (*wi).second;
      out << indent << "<wrapper id=\"" << wrapper->id;
      if (wrapper->description.size() > 0)
	out << "\" description=\"" << wrapper->description;
      out << "\">";
      
      out << indent_in;
      for (std::set<unsigned>::iterator mi = wrapper->members.begin()
	     , me = wrapper->members.end(); mi != me; ++mi) {
	out << indent << "<member id=\"" << (*mi) << "\"/>";
      }
      out << indent_out;
      out << indent << "</wrapper>"
	  << "\n";
    }

    for (DPEList::iterator di = dp->elements.begin(), de = dp->elements.end();
	 di != de; ++di) {
      DPElement *dpe = (*di).second;
      print_dpe(dpe, out);
    }
    
    out << indent_out;
    out << indent << "</dp>";
  }
  
  void ahir::Printer::print_place(Place *p, hls::ostream &out)
  {
    out << indent << "<place id=\"" << p->id
	<< "\" marking=\"" << p->marking;
    if (p->description.size() > 0) {
      out << "\" description=\"" << p->description;
    }
    out << "\"/>";
  }

  void ahir::Printer::print_transition(Transition *t, hls::ostream &out)
  {
    out << indent << "<transition id=\"" << t->id << "\" type=\"";

    switch (t->type) {
      case REQ:
	out << "req";
	break;

      case ACK:
	out << "ack";
	break;

      case HIDDEN:
	out << "hidden";
	break;

      case PLACE:
	out << "place";
	break;
    }

    if (t->description.size() > 0) {
      out << "\" description=\"" << t->description;
    }
    out << "\" symbol=\"" << t->symbol << "\">";
    out << indent_in;

    for (CPEList::iterator si = t->srcs.begin(), se = t->srcs.end();
	 si != se; ++si) {
      CPElement *s = *si;
      assert(is_place(s));
      out << indent << "<src id=\"" << s->id << "\" />";
    }
        
    for (CPEList::iterator si = t->snks.begin(), se = t->snks.end();
	 si != se; ++si) {
      CPElement *s = *si;
      assert(is_place(s));
      out << indent << "<snk id=\"" << s->id << "\" />";
    }

    out << indent_out;
    out << indent << "</transition>";
  }

  void ahir::Printer::print_cp(ControlPath *cp)
  {
    const std::string filename = cp->id + ".xml";
    std::ofstream file(filename.c_str());
    hls::ostream out(file);
    print_cp(cp, out);
  }
  
  void ahir::Printer::print_cp(ControlPath *cp, hls::ostream &out)
  {
    out << "\n" << indent << "<cp id=\"" << cp->id
	<< "\" init=\"" << cp->init->id
	<< "\" fin=\"" << cp->fin->id
	<< "\">";

    out << indent_in;

    out << "\n";
    for (ControlPath::PList::iterator pi = cp->places.begin()
	   , pe = cp->places.end(); pi != pe; ++pi) {
      CPElement *p = (*pi).second;
      assert(p->id == (*pi).first);
      assert(is_place(p));
      print_place(static_cast<Place*>(p), out);
    }
        
    out << "\n";
    for (ControlPath::TList::iterator ti = cp->transitions.begin()
	   , te = cp->transitions.end(); ti != te; ++ti) {
      CPElement *t = (*ti).second;
      assert(t->id == (*ti).first);
      assert(is_trans(t));
      print_transition(static_cast<Transition*>(t), out);
    }

    out << indent_out;
        
    out << "\n" << indent << "</cp>";
  }

  void ahir::Printer::print_ahir(ahir::Module *ahir, hls::ostream &out)
  {
    print_cp(ahir->cp, out);
    print_dp(ahir->dp, out);
    print_ln(ahir->ln, out);
    if (ahir->arbiter)
      print_arbiter(ahir->arbiter, out);
  }
    
  void ahir::Printer::print_module_body(hls::Module *myf, hls::ostream &out)
  {
    assert(is_ahir(myf));
    ahir::Module *ahir = static_cast<ahir::Module*>(myf);
    print_ahir(ahir, out);
  }

  void ahir::Printer::print_arbiter(Arbiter *arbiter, hls::ostream &out) 
  {
    out << "\n" << indent << "<arbiter id=\"" << arbiter->id
	<< "\">";
    out << indent_in;

    for (ClientList::iterator ci = arbiter->clients.begin()
	   , ce = arbiter->clients.end(); ci != ce; ++ci) {
      Client *client = (*ci).second;
      assert(client->id == (*ci).first);

      out << indent << "<client id=\"" << client->id
	  << "\" module=\"" << client->module
	  << "\" callsite=\"" << client->callsite
	  << "\" />";
    }
      
    out << indent_out;
    out << indent << "</arbiter>";
  }
}
