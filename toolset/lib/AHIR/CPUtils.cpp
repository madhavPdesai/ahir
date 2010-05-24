#include "CPUtils.hpp"

void ahir::initialise_dfs(ControlPath *cp)
{
  for (ControlPath::PList::iterator ei = cp->places.begin()
         , ee = cp->places.end();
       ei != ee; ei++) {
    (*ei).second->colour = hls::WHITE;
  }
    
  for (ControlPath::TList::iterator
         ei = cp->transitions.begin(), ee = cp->transitions.end();
       ei != ee; ei++) {
    (*ei).second->colour = hls::WHITE;
  }

  cp->init->colour = hls::BLACK;
}

void ahir::disconnect_initial_marking(ControlPath *cp)
{
  cp->init->srcs.clear();
  cp->fin->snks.clear();
}

void ahir::reconnect_initial_marking(ControlPath *cp)
{
  control_flow(cp->marked_place, cp->init);
  control_flow(cp->fin, cp->marked_place);
}

