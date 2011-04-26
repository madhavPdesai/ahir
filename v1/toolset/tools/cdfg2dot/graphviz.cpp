#include <CDFG/CDFGFactory.hpp>
#include <CDFG/CDFGParser.hpp>

#include <boost/program_options.hpp>
#include <string>
#include <iostream>

namespace po = boost::program_options;
using namespace cdfg;

void print_dot(hls::Program *program);

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
    ;

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

  print_dot(factory->program);
}
