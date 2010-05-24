#include "VHDLBuilder.hpp"
#include <AHIR/AHIRFactory.hpp>
#include <AHIR/AHIRParser.hpp>

#include <boost/program_options.hpp>
namespace po = boost::program_options;

#include <iostream>

int main(int argc, char *argv[])
{
  po::positional_options_description pos;
  pos.add("ir", -1);
  
  po::options_description desc("Allowed Options");
  desc.add_options()
    ("help", "produce help message")
    ("ir", po::value<std::vector<std::string> >()->composing()
     , "input programs in IR form");

  po::variables_map vm;
  po::store(po::command_line_parser(argc, argv).options(desc)
	    .positional(pos).run(), vm);
  po::notify(vm);
  
  if (vm.count("help")) {
    std::cout << desc << "\n";
    return 1;
  }

  ahir::AHIRFactory *factory = new ahir::AHIRFactory();
  ahir::AHIRParser *ap = new ahir::AHIRParser(factory);
  hls::Parser *parser = new hls::Parser(ap);

  const std::vector<std::string>& irfiles = vm["ir"].as<std::vector<std::string> >();
  for (std::vector<std::string>::const_iterator i = irfiles.begin(), e = irfiles.end();
       i != e; ++i) {
    const std::string& fname = *i;
    parser->parse_file(fname);
  }

  vhdl::ahir2vhdl(factory->program);
  
  return 0;
}
