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

  create_port(plist, "clk", IN, "std_logic");
  create_port(plist, "reset", IN, "std_logic");

  for (ahir::LinkLayer::IfaceMap::iterator lni = aln->maps.begin()
         , lne = aln->maps.end(); lni != lne; ++lni) {
    create_port(plist, (*lni).first, IN
                , Type("BooleanArray", Range(DOWNTO, (*lni).second.size(), 1)));
  }
  
  for (ahir::LinkLayer::IfaceMap::iterator lni = aln->rmaps.begin()
         , lne = aln->rmaps.end(); lni != lne; ++lni) {
    create_port(plist, (*lni).first, OUT
                , Type("BooleanArray", Range(DOWNTO, (*lni).second.size(), 1)));
  }
  
  return ln;
}

namespace {

  void print_ln_mappings(LinkLayer *ln, hls::ostream &out)
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
            << lit.iface << "(" << lit.sym << ");";
      }
      out << "\n";
    }
  }
  
  void print_ln_architecture(LinkLayer *ln, hls::ostream &out)
  {
    out << indent << "architecture default_arch of " << ln->id << " is";
    out << indent_in;
    out << indent_out;
    out << indent << "begin";
    out << indent_in;
    print_ln_mappings(ln, out);
    out << indent_out;
    out << "end default_arch;";
  }

} // end anonymous namespace

void vhdl::print_ln(LinkLayer *ln)
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
  print_ln_architecture(ln, out);
}
