#include "Printer.hpp"

#include "../Base/Program.hpp"
#include "../Base/Addressable.hpp"
#include "CDFG.hpp"
#include "../Base/Values.hpp"

#include <fstream>

using namespace hls;
using namespace cdfg;

void cdfg::Printer::print_ports(CDFGNode *node, hls::ostream &out)
{
  for (CDFGNode::PortList::iterator pi = node->ports.begin()
	 , pe = node->ports.end();
       pi != pe; ++pi) {
    Port *port = (*pi).second;
      
    out << indent << "<port id=\"" << port->id
	<< "\" ptype=\"" << (is_control(port) ? "control" : "data")
	<< "\" iotype=\"" << (is_input(port) ? "in" : "out");
    if (is_data(port)) {
      out << "\" type=\"" << str(port->type);
    }
    out << "\" edge=\"" << port->edge->id
	<< "\"/>";
  }
}

void cdfg::Printer::print_node_details(CDFGNode *node, hls::ostream &out)
{
  switch (node->ntype) {
    case Constant:
      out << indent << "<value>" << node->value << "</value>";
      break;

    case Address:
      assert(node->addressable);
      out << indent << "<addressable id=\"" << node->addressable->id
	  << "\"/>";
      break;

    case Call:
      out << indent << "<callee>" << node->callee << "</callee>";
    case Response:
    case LoadRequest:
    case LoadComplete:
      assert(node->counterpart);
      out << indent << "<counterpart id=\"" << node->counterpart->id
	  << "\"/>";
      break;

    default:
      break;
  }
}
  
void cdfg::Printer::print_node(CDFGNode *node, hls::ostream &out)
{
  out << indent << "<node id=\"" << node->id
      << "\" ntype=\"" << str(node->ntype);
  if (node->description.size() != 0) {
    out << "\" description=\"" << node->description;
  }
  out << "\">";
    
  out << indent_in;
  print_node_details(node, out);
  print_ports(node, out);
  out << indent_out;
  out << indent << "</node>";
}
  
void cdfg::Printer::print_module_body(Module *myf, hls::ostream &out)
{
  assert(is_cdfg(myf));
  CDFG *cdfg = static_cast<CDFG*>(myf);
    
  out << "\n" << indent << "<cdfg>";
  out << indent_in;
    
  for (CDFG::NodeList::iterator ni = cdfg->nodes.begin(), ne = cdfg->nodes.end();
       ni != ne; ++ni) {
    CDFGNode *node = (*ni).second;
    print_node(node, out);
  }

  out << indent_out;
  out << indent << "</cdfg>";
}
