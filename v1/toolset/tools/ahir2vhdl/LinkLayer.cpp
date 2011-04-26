#include "LinkLayer.hpp"
#include "EntityBuilder.hpp"
#include "EntityPrinter.hpp"

#include <AHIR/LinkLayer.hpp>

#include <fstream>

using namespace vhdl;
using namespace hls;

std::string LinkLayer::instance_name()
{
  return id + "_inst";
}

std::string LinkLayer::component_name()
{
  return id;
}

LinkLayer::LinkLayer(const std::string _id, ahir::LinkLayer *_aln)
  : Entity(_id, LN, ""), aln(_aln)
{}
  
vhdl::LinkLayer* vhdl::create_ln(ahir::LinkLayer *aln)
{
  LinkLayer *ln = new LinkLayer(aln->id, aln);

  PortList &plist = ln->ports;

  entity_create_clk_ports(ln);
  
  for (ahir::LinkLayer::IfaceMap::iterator lni = aln->maps.begin()
         , lne = aln->maps.end(); lni != lne; ++lni) {
    entity_create_port_with_map_name(ln, (*lni).first, IN
                                     , Type("BooleanArray"
                                            , Range(DOWNTO, (*lni).second.size(), 1))
                                     , SLICE, (*lni).first);
  }
  
  for (ahir::LinkLayer::IfaceMap::iterator lni = aln->rmaps.begin()
         , lne = aln->rmaps.end(); lni != lne; ++lni) {
    entity_create_port_with_map_name(ln, (*lni).first, OUT
                                     , Type("BooleanArray"
                                            , Range(DOWNTO, (*lni).second.size(), 1))
                                     , SLICE, (*lni).first);
  }
  
  return ln;
}

namespace {

  void print_ln_mappings(LinkLayer *ln, bool clocked, hls::ostream &out)
  {
    ahir::LinkLayer *aln = ln->aln;
    
    for (ahir::LinkLayer::IfaceMap::iterator mi = aln->rmaps.begin()
           , me = aln->rmaps.end(); mi != me; ++mi) {
      const std::string &snk_id = (*mi).first;
      ahir::LinkLayer::Interface &iface = (*mi).second;

      for (ahir::LinkLayer::Interface::iterator ii = iface.begin()
             , ie = iface.end(); ii != ie; ++ii) {
        Symbol snk_sym = (*ii).first;
        const ahir::LinkLayer::Literal &lit = (*ii).second;

        out << indent << snk_id << "(" << snk_sym << ") <= "
            << lit.iface << "(" << lit.sym << ")"
            << (clocked ? " when reset = '0' else false;" : ";");
      }
      out << "\n";
    }
  }
  
  void print_ln_architecture(LinkLayer *ln, bool clocked, hls::ostream &out)
  {
    out << indent << "architecture default_arch of " << ln->id << " is";
    out << indent_in;
    out << indent_out;
    out << indent << "begin";
    out << indent_in;

    if (clocked) {
      out << indent << "process (clk)"
          << indent << "begin" << indent_in
          << indent << "if clk'event and clk = '1' then" << indent_in;
    }
    
    print_ln_mappings(ln, clocked, out);
    out << indent_out;

    if (clocked) {
      out << indent << "end if;" << indent_out
          << indent << "end process;" << indent_out;
    }

    out << indent << "end default_arch;";
  }

} // end anonymous namespace

void vhdl::print_ln(LinkLayer *ln, bool clocked)
{
  std::ofstream file;
  const std::string& filename = ln->id + ".vhdl";
  
  file.open(filename.c_str());
  file <<
    "\nlibrary ieee;"
    "\nuse ieee.std_logic_1164.all;"
    "\n"
    "\nlibrary ahir;"
    "\nuse ahir.types.all;"
    "\n";

  hls::ostream out(file);
  
  print_object_declaration(ln, "entity", out);
  print_ln_architecture(ln, clocked, out);
}
