#include "LLVM.hpp"
#include "typedefs.hpp"
#include "Utils.hpp"
#include "Exception.hpp"

#include <Base/NodeType.hpp>

#include <boost/program_options.hpp>
namespace po = boost::program_options;

#include <fstream>
#include <iostream>

llvm::LLVMContext LC;

// provided by APInt.cpp
void generate_apint_tests(std::ostream &ofs
                          , unsigned num_cases
                          , const std::string &opcode_fraction
                          , const std::string &input_details
                          , const std::string &output_details);

// provided by APFloat.cpp
void generate_apfloat_tests(std::ostream &ofs
                            , unsigned num_cases
                            , const std::string &opcode_fraction
                            , const std::string &input_details
                            , const std::string &output_details);

void generate_testcases(std::ostream &ofs
                        , const std::string &opcode
                        , const std::string &input_details
                        , const std::string &output_details
                        , unsigned num_cases)
{
  std::string fname = opcode;
  
  if (boost::istarts_with(fname, "apint")) {
    boost::ierase_first(fname, "apint");
    generate_apint_tests(ofs, num_cases, fname, input_details, output_details);
  } else if (boost::istarts_with(fname, "apfloat")) {
    boost::ierase_first(fname, "apfloat");
    generate_apfloat_tests(ofs, num_cases, fname, input_details, output_details);
  } else
    throw TGE("unknown type prefix");
}

void parse_line(std::string &buffer
                , std::string &filename
                , std::string &opcode
                , std::string &input_details
                , std::string &output_details
                , unsigned &num_cases)
{
  typedef boost::split_iterator<std::string::iterator> s_iter;
  SV parts;
  
  for (s_iter si = boost::make_split_iterator
         (buffer, boost::first_finder("--", boost::is_equal()));
       !si.eof(); ++si) {
    parts.push_back(boost::copy_range<std::string>(*si));
  }
  
  SV part0;
  boost::split(part0, parts[0], boost::is_any_of(" "));
  filename = part0[0];

  opcode = part0[1];
  boost::trim(opcode);
  
  input_details = parts[1];
  if (!boost::istarts_with(input_details, "input-sizes"))
    throw TGE("expecting input details here: " + input_details);
  boost::ierase_first(input_details, "input-sizes");
  boost::trim(input_details);

  output_details = parts[2];
  if (!boost::istarts_with(output_details, "output-sizes"))
    throw TGE("expecting output details here: " + output_details);
  boost::ierase_first(output_details, "output-sizes");
  boost::trim(output_details);

  std::string num_tests_str = parts[3];
  if (!boost::istarts_with(num_tests_str, "num-tests"))
    throw TGE("expecting number of tests here: " + num_tests_str);
  boost::ierase_first(num_tests_str, "num-tests");
  boost::trim(num_tests_str);
  num_cases = boost::lexical_cast<unsigned>(num_tests_str);
}

void parse_file(std::istream &ifs)
{
  std::string filename;
  std::string opcode;
  std::string input_details;
  std::string output_details;
  unsigned num_cases;

  while (!ifs.eof()) {
    std::string buffer;
    getline(ifs, buffer);
    
    if (buffer.size() == 0)
      continue;

    if (boost::istarts_with(buffer, "#"))
      continue;

    // std::cerr << "\ninspecting " << buffer;
    
    try {
      parse_line(buffer, filename, opcode
                 , input_details, output_details, num_cases);
      std::ofstream ofs(filename.c_str());
      generate_testcases(ofs, opcode, input_details, output_details, num_cases);
    } catch (TGE &e) {
      std::cerr << "\n***** Exception: " << e.what()
                << "\n  at: " << buffer
                << "\n";
      
      continue;
    }

    // std::cerr << "\n##### Success!\n";
  }
}

int main (int argc, char *argv[])
{
  po::options_description desc("Available options");
  po::positional_options_description p;
  p.add("template", -1);

  desc.add_options()
    ("help", "produce this help message")
    ("template", po::value<std::string>(), "template for the testcases");

  po::variables_map vm;
  po::store(po::command_line_parser(argc, argv).
            options(desc).positional(p).run(), vm);
  po::notify(vm);

  if (vm.count("help") > 0) {
    std::cout << desc << "\n";
    return 1;
  }

  std::string tfile = vm["template"].as<std::string>();
  std::ifstream ifs(tfile.c_str());
  // ifs.exceptions(std::ifstream::failbit | std::ifstream::badbit);

  try {
    parse_file(ifs);
  } catch (std::exception &e) {
    std::cerr << "\n===== Unhandled exception: " << e.what()
              << "\n";
    return 1;
  }
  
  return 0;
}
