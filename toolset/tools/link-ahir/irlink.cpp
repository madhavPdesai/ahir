#include "Linker.hpp"

#include <Base/Program.hpp>

#include <AHIR/AHIRParser.hpp>
#include <AHIR/AHIRFactory.hpp>
#include <AHIR/Printer.hpp>

#include <iostream>
#include <vector>

#include <boost/program_options.hpp>
namespace po = boost::program_options;

using namespace ahir;
using namespace hls;

int main(int argc, char *argv[])
{
  po::positional_options_description pos;
  pos.add("ir", -1);
  
  po::options_description desc("Allowed Options");
  desc.add_options()
    ("help", "produce help message")
    ("ir"
     , po::value<std::vector<Glib::ustring> >()->composing()
     , "input programs in IR form")
    //    ("map"
    //     , po::value<Glib::ustring>()->default_value("map.xml")
    //     , "location map for variables")
    ;

  po::variables_map vm;
  po::store(po::command_line_parser(argc, argv).options(desc)
	    .positional(pos).run(), vm);
  //  po::store(po::parse_command_line(argc, argv, desc), vm);
  po::notify(vm);
  
  if (vm.count("help")) {
    std::cout << desc << "\n";
    return 1;
  }

  AHIRFactory *factory = new AHIRFactory();
  AHIRParser *ap = new AHIRParser(factory);
  hls::Parser *parser = new hls::Parser(ap);

  const std::vector<Glib::ustring>& irfiles = vm["ir"].as<std::vector<Glib::ustring> >();
  for (std::vector<Glib::ustring>::const_iterator i = irfiles.begin(), e = irfiles.end();
       i != e; ++i) {
    const Glib::ustring& fname = *i;
    parser->parse_file(fname);
  }

  Linker linker;
  linker.link(factory->program);

  ahir::Printer printer;
  printer.print(factory->program, ".linked_ahir.xml");

  return 0;
}
