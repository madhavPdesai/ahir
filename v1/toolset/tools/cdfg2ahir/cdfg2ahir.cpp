#include "AHIRBuilder.hpp"

#include <AHIR/Printer.hpp>
#include <CDFG/Printer.hpp>
#include <CDFG/CDFGParser.hpp>

#include <Base/Parser.hpp>
#include <Base/Program.hpp>

#include <string>
#include <iostream>

#include <boost/program_options.hpp>
namespace po = boost::program_options;

using namespace cdfg;

namespace hls
{
  class Program;
}

namespace ahir
{
  void print(hls::Program *program);
}

int main(int argc, char *argv[])
{
  po::positional_options_description pos;
  pos.add("ir", -1);
  
  po::options_description desc("Allowed Options");

  desc.add_options()
    ("help", "produce help message")
    ("ir", po::value<std::vector<Glib::ustring> >()->composing()
     , "XML files with function bodies as CDFGs");

  po::variables_map vm;
  po::store(po::command_line_parser(argc, argv).options(desc)
	    .positional(pos).run(), vm);
  po::notify(vm);
  
  if (vm.count("help")) {
    std::cout << desc << "\n";
    return 1;
  }

  CDFGFactory *factory = new CDFGFactory();
  CDFGParser *cp = new CDFGParser(factory);
  hls::Parser *parser = new hls::Parser(cp);
  
  const std::vector<Glib::ustring>& irfiles = vm["ir"].as<std::vector<Glib::ustring> >();
  for (std::vector<Glib::ustring>::const_iterator i = irfiles.begin(), e = irfiles.end();
       i != e; ++i) {
    const Glib::ustring& fname = *i;
    parser->parse_file(fname);
  }

  ahir::cdfg2ahir(factory->program);
  ahir::Printer printer;
  printer.print(factory->program, ".ahir.xml");
  
  return 0;
}
