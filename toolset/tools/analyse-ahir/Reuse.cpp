#include "Reuse.hpp"

#include <AHIR/Label.hpp>
#include <AHIR/Printer.hpp>
#include <AHIR/AHIRModule.hpp>
#include <AHIR/ControlPath.hpp>
#include <AHIR/DataPath.hpp>

#include <Base/Program.hpp>
#include <Base/NodeType.hpp>
#include <Base/Type.hpp>

#include <sstream>

using namespace hls;
using namespace ahir;

namespace {

  typedef std::set<DPElement*> DPESet;
  typedef std::map<unsigned, DPESet> LabelDPEMap;
  typedef std::map<std::string, DPESet> WorkSet;

  void insert_wrappers(ControlPath *cp, DataPath *dp, LabelDPEMap &members
                       , const std::string &d)
  {
    CliqueSet &cover = cp->labels->cover;

    for (CliqueSet::iterator ci = cover.begin(), ce = cover.end();
         ci != ce; ++ci) {
      const Clique &cliq = *ci;
      assert(!cliq.empty());

      DPESet herd;
      for (Clique::iterator ei = cliq.begin(), ee = cliq.end();
           ei != ee; ++ei) {
        unsigned label = *ei;
        assert(members.find(label) != members.end());
        DPESet &dpes = members[label];
        assert(dpes.size() != 0);
        herd.insert(dpes.begin(), dpes.end());
        members.erase(label);
      }

      assert(!herd.empty());
      if (herd.size() == 1)
        continue;
      
      Wrapper *wrapper = new Wrapper(dp->wrappers.size(), d);
      dp->register_wrapper(wrapper);
      
      for (DPESet::iterator di = herd.begin(), de = herd.end();
           di != de; ++di) {
        DPElement *dpe = *di;
        wrapper->register_member(dpe->id);
      }
    }
  }

  void assign_weights(LabelGraph *lrg, ahir::Module *module
                      , DPESet &candidates, LabelDPEMap &members)
  {
    lrg->reset_weights();

    for (LabelCPEMap::iterator li = lrg->elements.begin()
           , le = lrg->elements.end(); li != le; ++li) {
      unsigned label = (*li).first;
      std::set<unsigned> &elements = (*li).second;

      for (std::set<unsigned>::iterator ei = elements.begin()
             , ee = elements.end(); ei != ee; ++ei) {
        DPElement *dpe = module->locate_dpe_from_cpe_id(*ei);
        if (!dpe)
          continue;

        if (candidates.count(dpe) != 0) {
          lrg->weight(label)++;
          members[label].insert(dpe);
          candidates.erase(dpe);
        }
      }
    }
  }

  void reuse_operators(ahir::Module *module, DPESet &candidates
                       , const std::string &description)
  {
    ControlPath *cp = module->cp;
    LabelDPEMap members;
    
    assign_weights(cp->labels, module, candidates, members);
    assert(candidates.size() == 0);
    generate_cover(cp->labels, true);
    
    insert_wrappers(cp, module->dp, members
                    , description);
    assert(members.size() == 0);
  }

  void reuse_operators(ahir::Module *module)
  {
    DataPath *dp = module->dp;
    create_labels(module->cp);

    typedef std::map<hls::NodeType, DPESet> OpcodeMap;
    OpcodeMap opcodes;

    // Sort all shareable operators by NodeType
    for (DPEList::iterator ii = dp->elements.begin()
           , ie = dp->elements.end(); ii != ie; ++ii) {
      DPElement *dpe = (*ii).second;

      if (!is_shared(dpe->ntype))
        continue;
      
      opcodes[dpe->ntype].insert(dpe);
    }
    
    for (OpcodeMap::iterator oi = opcodes.begin(), oe = opcodes.end();
         oi != oe; ++oi) {
      hls::NodeType ntype = (*oi).first;
      const std::string str_ntype = hls::str(ntype);
      
      DPESet &dpes = (*oi).second;

      switch (ntype) {
        case LoadComplete:
        case Store:
          // Some operators are independent of type, so we share them
          // with no further processing.
          reuse_operators(module, dpes, str_ntype);
          break;

        case LoadRequest:
          // Some operators are shared only through their counterparts.
          break;
          
        default:
          // For others, we classify them by output types, and then
          // share only within the subsets.
          WorkSet wset;
          for (DPESet::iterator di = dpes.begin(), de = dpes.end();
               di != de; ++di) {
            DPElement *dpe = *di;
            Port *port = dpe->find_port(get_output_port(ntype));
            const hls::Type *type = port->type;
            wset[str(type)].insert(dpe);
          }
          
          for (WorkSet::iterator wi = wset.begin(), we = wset.end();
               wi != we; ++wi) {
            DPESet &candidates = (*wi).second;
            assert(candidates.size() > 0);
            if (candidates.size() == 1)
              continue;
            reuse_operators(module, candidates, (*wi).first + " " + str_ntype);
          }

          break;
      }
    }
  }

} // end anonymous namespace

void ahir::reuse_operators(hls::Program *program)
{
  for (Program::ModuleList::iterator mi = program->modules.begin()
         , me = program->modules.end(); mi != me; ++mi) {
    const std::string &id = (*mi).first;
    ahir::Module *module = get_ahir_module(program, id);

    ::reuse_operators(module);
  }

  ahir::Printer printer;
  printer.print(program, ".ahir_shared.xml");
}
