#include <Base/ostream.hpp>
#include <Base/Program.hpp>
#include <CDFG/CDFG.hpp>

#include <fstream>

using namespace hls;
using namespace cdfg;

namespace {

  struct Printer
  {
    void print(hls::Program *program);
  };

  void Printer::print(hls::Program *program) 
  {
    for (Program::ModuleList::iterator mi = program->modules.begin(), me = program->modules.end();
	 mi != me; ++mi) {
      Module *module = (*mi).second;
      assert(is_cdfg(module));

      CDFG *cdfg = static_cast<CDFG*>(module);
      
      std::string filename = cdfg->id + ".dot";
      std::ofstream file(filename.c_str());
      hls::ostream out(file);
      
      out << indent << "digraph " << cdfg->id << " {";
      out << indent_in;

      for (CDFG::NodeList::iterator ni = cdfg->nodes.begin(), ne = cdfg->nodes.end();
	   ni != ne; ++ni) {
	CDFGNode *node = (*ni).second;
	out << indent << "n" << node->id
	    << " [label=\"" << node->id << ":" << str(node->ntype) << ":"
	    << "\\n" << node->description << "\"];";
      }
      out << "\n";

      for (CDFG::EdgeList::iterator ei = cdfg->edges.begin(), ee = cdfg->edges.end();
	   ei != ee; ++ei) {
	CDFGEdge *edge = (*ei).second;
	CDFGNode *src = edge->driver->parent;
        
	for (CDFGEdge::UserList::iterator ui = edge->users.begin(), ue = edge->users.end();
	     ui != ue; ++ui) {
	  CDFGNode *snk = (*ui)->parent;
	  out << indent << "n" << src->id << " -> n" << snk->id
	      << "[style=" << (is_control(edge->driver) ? "solid" : "dashed") << "];";
	}
	out << "\n";
      }
      
      out << indent_out;
      out << "}"
	"\n";
    }
  }
  
} // end anonymous namespace

void print_dot(hls::Program *program)
{
  static Printer printer;
  
  printer.print(program);
}
  
