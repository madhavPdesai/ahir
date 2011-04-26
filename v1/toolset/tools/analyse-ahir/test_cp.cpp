#include <AHIR/ControlPath.hpp>
#include <AHIR/CPUtils.hpp>
#include <AHIR/Printer.hpp>
#include <AHIR/Type2Verify.hpp>
#include <AHIR/Label.hpp>

#include <iostream>

#include <boost/program_options.hpp>
namespace po = boost::program_options;

using namespace ahir;

namespace {

  void generate_cover_with_all_ones(LabelGraph *lgraph)
  {
    lgraph->reset_weights(1);
    generate_cover(lgraph, true);
  }

  Transition* create_transition(ControlPath *cp
                                , const std::string& d
                                , CPEType type = HIDDEN)
  {
    Transition *ret = new Transition(cp->elements.size(), type, d);
    cp->register_transition(ret);
    return ret;
  }

  Place* create_place(ControlPath *cp
                      , const std::string &d
                      , unsigned marking = 0)
  {
    Place *ret = new Place(cp->elements.size(), d, marking);
    cp->register_place(ret);
    return ret;
  }

  void control_flow(ControlPath *cp
                    , Transition *src, Transition *snk
                    , const std::string &id)
  {
    Place *p = create_place(cp, id);
    control_flow(src, p);
    control_flow(p, snk);
  }

  void control_flow(ControlPath *cp
                    , Place *src, Place *snk
                    , const std::string &id)
  {
    Transition *p = create_transition(cp, id);
    control_flow(src, p);
    control_flow(p, snk);
  }

  ControlPath* straight_cp()
  {
    ControlPath *cp = new ControlPath("straight");
    control_flow(cp, cp->init, cp->fin, "place");

    return cp;
  }

  ControlPath* branchy()
  {
    ControlPath *cp = new ControlPath("branchy");

    Place *b1 = create_place(cp, "b1");
    Place *m1 = create_place(cp, "m1");
    
    Place *b2 = create_place(cp, "b2");
    // there is no m2

    Place *b3 = create_place(cp, "b3");
    // there is no m3
    
    Place *b4 = create_place(cp, "b4");
    Place *m4 = create_place(cp, "m4");
    
    Place *b5 = create_place(cp, "b5");
    Place *m5 = create_place(cp, "m5");

    Place *b6 = create_place(cp, "b6");
    Place *m6 = create_place(cp, "m6");

    // connect b1 and m1 to init and fin respectively
    control_flow(cp->init, b1);
    control_flow(m1, cp->fin);

    // branch on the left at b1
    control_flow(cp, b1, b2, "b1x");

    // simple branch b4-m4 from b2
    control_flow(cp, b2, b4, "b2x");
    control_flow(cp, b4, m4, "b4x");
    control_flow(cp, b4, m4, "b4y");
    control_flow(cp, m4, m1, "m4out");

    // another branch b3 at b2, that merges at m1 and m4
    control_flow(cp, b2, b3, "b2y");
    control_flow(cp, b3, m1, "b3x");
    control_flow(cp, b3, m4, "b3y");

    // loop on the right at b1, with entry m6 and exit b6
    control_flow(cp, b1, m6, "b1y");
    control_flow(cp, m6, b6, "m6out");
    control_flow(cp, b6, m1, "b6x");

    control_flow(cp, b6, b5, "b6y");
    control_flow(cp, b5, m5, "b5x");
    control_flow(cp, b5, m5, "b5y");
    control_flow(cp, m5, m6, "m5out");

    return cp;
  }

  ControlPath* merger()
  {
    ControlPath *cp = new ControlPath("merger");

    Place *b1 = create_place(cp, "b1");
    control_flow(cp->init, b1);
    
    Transition *f1 = create_transition(cp, "f1");
    Transition *f2 = create_transition(cp, "f2");
    control_flow(b1, f1);
    control_flow(b1, f2);

    Place *b1x = create_place(cp, "b1x");
    Place *b1y = create_place(cp, "b1y");
    control_flow(f1, b1x);
    control_flow(f1, b1y);
    control_flow(f2, b1x);
    control_flow(f2, b1y);

    Transition *j1 = create_transition(cp, "j1");
    control_flow(b1x, j1);
    control_flow(b1y, j1);

    control_flow(cp, j1, cp->fin, "j1out");

    return cp;
  }

  ControlPath* forky()
  {
    ControlPath *cp = new ControlPath("forky");

    Transition *f1 = create_transition(cp, "f1");
    control_flow(cp, cp->init, f1, "init_out");

    Transition *f2 = create_transition(cp, "f2");
    Transition *f3 = create_transition(cp, "f3");
    control_flow(cp, f1, f2, "f1x");
    control_flow(cp, f1, f3, "f1y");

    Transition *f3x = create_transition(cp, "f3x");
    control_flow(cp, f3, f3x, "f3xp");

    Transition *j3 = create_transition(cp, "j3");
    control_flow(cp, f3x, j3, "f3xy");

    Transition *f3y = create_transition(cp, "f3y");
    control_flow(cp, f3, f3y, "f3yp");
    control_flow(cp, f3y, j3, "f3yx");
    control_flow(cp, f3y, j3, "f3yy");

    Transition *j2 = create_transition(cp, "j2");
    control_flow(cp, f3x, j2, "f3xx");
    control_flow(cp, j3, j2, "j3out");
    control_flow(cp, f2, j2, "f2x");
    
    control_flow(cp, f2, cp->fin, "f2y");
    control_flow(cp, j2, cp->fin, "j2out");

    return cp;
  }
  
  ControlPath* failure()
  {
    ControlPath *cp = new ControlPath("failure");

    Place *b1 = create_place(cp, "b1");
    control_flow(cp->init, b1);

    Place *p1 = create_place(cp, "p1");
    Place *p2 = create_place(cp, "p2");
    control_flow(cp, b1, p1, "b1x");
    control_flow(cp, b1, p2, "b1y");
    
    Transition *j1 = create_transition(cp, "j1");
    control_flow(p1, j1);
    control_flow(p2, j1);
    control_flow(cp, j1, cp->fin, "j1out");

    return cp;
  }
  
} // end anonymous namespace


void test_cps()
{
  ahir::Printer printer;

  std::vector<ControlPath*> cps;

  cps.push_back(straight_cp());
  cps.push_back(branchy());
  cps.push_back(merger());
  cps.push_back(forky());
  cps.push_back(failure());

  for (std::vector<ControlPath*>::iterator ci = cps.begin(), ce = cps.end();
       ci != ce; ++ci) {
    ControlPath *cp = *ci;

    std::cerr << "\nControlPath: " << cp->id;
    
    printer.print_cp(cp);
    
    std::cerr << "\n  verifying type-2 structure... ";
    bool verified_type2 = false;
    bool verified_lrg = false;

    if ((verified_type2 = verify_type2(cp))) {
      std::cerr << "done.";
      std::cerr << "\n  generating and validating LRG... ";
      LabelGraph *lrg = create_labels(cp);
      if ((verified_lrg = validate_lrg(lrg))) {
        std::cerr << "done.";
        std::cerr << "  \n  generating cover for LRG... ";
        generate_cover(lrg, lrg->cover, false);
        if (verify_cover(lrg, lrg->cover, false))
          std::cerr << "done.";
      }
    } else {
      std::cerr << "\n  skipping LRG.";
    }

    if (cp->id == "forky") {
      save_lrg(cp->labels, "forky.xml");
      LabelGraph *lrg = create_empty_lrg();
      std::cerr << "\n  Loading LRG... ";
      load_lrg(lrg, "forky.xml");
      std::cerr << "done.\n  Verifying LRG... ";
      if (validate_lrg(lrg)) {
        std::cerr << "done.";
        std::cerr << "  \n  generating cover for LRG... ";
        generate_cover(lrg, lrg->cover, false);
        if (verify_cover(lrg, lrg->cover, false))
          std::cerr << "done.";
      }
      
      save_lrg(lrg, "new_forky.xml");

      generate_cover_with_all_ones(lrg);
      verify_cover(lrg, lrg->cover, true);
    }
    
    std::cerr << "\n";
  }
}
