#include "ControlPath.hpp"
#include "EntityBuilder.hpp"
#include "EntityPrinter.hpp"

#include <AHIR/ControlPath.hpp>
#include <AHIR/CPUtils.hpp>

#include <Base/ostream.hpp>
#include <fstream>

using namespace vhdl;
using namespace hls;

std::string ControlPath::instance_name()
{
  return id + "_inst";
}

std::string ControlPath::component_name()
{
  return id;
}

ControlPath::ControlPath(const std::string _id, ahir::ControlPath *_acp)
  : Entity(_id, CP, ""), acp(_acp)
{}
  
vhdl::ControlPath* vhdl::create_cp(ahir::ControlPath *acp)
{
  ControlPath *cp = new ControlPath(acp->id, acp);

  PortList &plist = cp->ports;

  create_port(plist, "clk", IN, "std_logic");
  create_port(plist, "reset", IN, "std_logic");
  
  create_port(plist, "LambdaIn", IN, "BooleanArray", Range(DOWNTO, acp->acks.size(), 1));
  create_port(plist, "LambdaOut", OUT, "BooleanArray", Range(DOWNTO, acp->reqs.size(), 1));
  
  return cp;
}

namespace {

  void print_signal_declarations(ControlPath *cp, hls::ostream &out)
  {
    ahir::ControlPath *acp = cp->acp;
    
    for (ahir::ControlPath::PList::iterator pi = acp->places.begin(), pe = acp->places.end();
	 pi != pe; ++pi) {
      ahir::Place *p = (*pi).second;
      out << indent << "signal place_" << p->id << "_preds : BooleanArray"
	  << "(" << p->srcs.size() - 1 << " downto 0);";
      out << indent << "signal place_" << p->id << "_succs : BooleanArray"
	  << "(" << p->snks.size() - 1 << " downto 0);";
      out << indent << "signal place_" << p->id << "_token : boolean;";
    }
    out << "\n";

    for (ahir::ControlPath::TList::iterator pi = acp->transitions.begin()
	   , pe = acp->transitions.end(); pi != pe; ++pi) {
      ahir::Transition *p = (*pi).second;
      out << indent << "signal transition_" << p->id << "_symbol_out : boolean;";
      out << indent << "signal transition_" << p->id << "_preds : BooleanArray"
	  << "(" << p->srcs.size() - 1 << " downto 0);";
    }
    out << "\n";
  }

  void print_places(ControlPath *cp, hls::ostream &out)
  {
    ahir::ControlPath *acp = cp->acp;
    
    for (ahir::ControlPath::PList::iterator pi = acp->places.begin(), pe = acp->places.end();
	 pi != pe; ++pi) {
      ahir::Place *p = (*pi).second;

      unsigned count = 0;
      for (ahir::CPEList::iterator si = p->srcs.begin(), se = p->srcs.end();
	   si != se; ++si) {
	ahir::CPElement *src = *si;
	out << indent << "place_" << p->id << "_preds(" << count << ")"
	    << " <= " << "transition_" << src->id << "_symbol_out;";
	++count;
      }

      count = 0;
      for (ahir::CPEList::iterator si = p->snks.begin(), se = p->snks.end();
	   si != se; ++si) {
	ahir::CPElement *src = *si;
	out << indent << "place_" << p->id << "_succs(" << count << ")"
	    << " <= " << "transition_" << src->id << "_symbol_out;";
	++count;
      }

      out << indent << "place_" << p->id << " : place";
      out << indent_in;
      out << indent << "generic map(marking => " << (p->marking == 0 ? "false" : "true") << ")";
      out << indent << "port map(";
      out << indent_in;
      out << indent << "preds => place_" << p->id << "_preds,";
      out << indent << "succs => place_" << p->id << "_succs,";
      out << indent << "token => place_" << p->id << "_token,";
      out << indent << "clk   => clk,";
      out << indent << "reset => reset);";
      out << indent_out;
      out << indent_out;
      out << "\n";
    }
  }

  void print_transitions(ControlPath *cp, hls::ostream &out)
  {
    ahir::ControlPath *acp = cp->acp;
    
    for (ahir::ControlPath::TList::iterator pi = acp->transitions.begin()
	   , pe = acp->transitions.end(); pi != pe; ++pi) {
      ahir::Transition *p = (*pi).second;

      unsigned count = 0;
      for (ahir::CPEList::iterator si = p->srcs.begin(), se = p->srcs.end();
	   si != se; ++si) {
	ahir::CPElement *src = *si;
	out << indent << "transition_" << p->id << "_preds(" << count << ")"
	    << " <= " << "place_" << src->id << "_token;";
	++count;
      }
      if (is_req(p))
	out << indent << "LambdaOut(" << p->symbol << ") <= transition_"
	    << p->id << "_symbol_out;";
      
      out << indent << "transition_" << p->id << " : transition";
      out << indent_in;
      out << indent << "port map(";
      out << indent_in;
      out << indent << "preds      => transition_" << p->id << "_preds,";
      out << indent << "symbol_out => transition_" << p->id << "_symbol_out,";
      out << indent << "symbol_in  => ";
      if (is_ack(p))
	out << "LambdaIn(" << p->symbol << "));";
      else
	out << "true);";
      out << indent_out;
      out << indent_out;
      out << "\n";
    }
  }
  
  void print_cp_architecture(ControlPath *cp, hls::ostream &out)
  {
    out << indent << "architecture default_arch of " << cp->component_name() << " is";
    out << indent_in;
    print_signal_declarations(cp, out);
    out << indent_out;
    out << indent << "begin";
    out << indent_in;
    print_places(cp, out);
    print_transitions(cp, out);
    out << indent_out;
    out << indent << "end architecture default_arch;";
  }
  
} // end anonymous namespace

void vhdl::print_cp(ControlPath *cp)
{
  std::ofstream file;
  const std::string& filename = cp->id + ".vhdl";
  
  file.open(filename.c_str());
  file <<
    "\nlibrary ieee;"
    "\nuse ieee.std_logic_1164.all;"
    "\n"
    "\nlibrary ahir;"
    "\nuse ahir.types.all;"
    "\nuse ahir.components.all;"
    "\n";

  hls::ostream out(file);
  
  print_object_declaration(cp, "entity", out);
  print_cp_architecture(cp, out);
}

