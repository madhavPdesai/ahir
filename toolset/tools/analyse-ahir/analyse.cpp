#include <AHIR/Type2Verify.hpp>
#include <AHIR/AHIRParser.hpp>
#include <AHIR/AHIRFactory.hpp>
#include <AHIR/Label.hpp>

#include <Base/Program.hpp>

#include <iostream>
#include <boost/program_options.hpp>
namespace po = boost::program_options;

namespace ahir {

  void reuse_operators(hls::Program *program);
  
}

void test_cps();

using namespace ahir;

int main(int argc, char *argv[]) 
{
  po::positional_options_description pos;
  pos.add("ir", -1);
  
  po::options_description desc("Allowed Options");
  desc.add_options()
    ("help", "produce help message")
    ("ir"
     , po::value<std::vector<std::string> >()->composing()
     , "input programs in IR form")
    ("verify-type2", "verify whether each ControlPath is a Type-2 Petri-net")
    ("create-labels", "create an LRG for each ControlPath and validate it")
    ("reuse", "mark data-path operators for arbiter-less reuse")
    ("test-cps", "create test CPs and run various analyses on them")
    ;

  po::variables_map vm;
  po::store(po::command_line_parser(argc, argv).options(desc)
	    .positional(pos).run(), vm);
  po::notify(vm);
  
  if (vm.count("help")) {
    std::cout << desc << "\n";
    return 0;
  }

  if (vm.count("test-cps")) {
    test_cps();
    return 0;
  }

  AHIRFactory *factory = new AHIRFactory();
  AHIRParser *ap = new AHIRParser(factory);
  hls::Parser *parser = new hls::Parser(ap);
  
  const std::vector<std::string>& irfiles = vm["ir"].as<std::vector<std::string> >();
  for (std::vector<std::string>::const_iterator i = irfiles.begin(), e = irfiles.end();
       i != e; ++i) {
    const std::string& fname = *i;
    parser->parse_file(fname);
  }

  hls::Program *program = factory->program;
  if (vm.count("verify-type2")) {
    std::cerr << "\nVerifying Type-2 control paths in program \""
              << program->id << "\"... ";
    if (verify_type2(factory->program))
      std::cerr << "done.";
    else
      std::cerr << "failed.";
  }

  if (vm.count("create-labels"))
    create_labels(program);

  if (vm.count("reuse"))
    reuse_operators(program);

  return 0;
}
