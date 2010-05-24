#include "ControlPath.hpp"
#include "CPUtils.hpp"
#include "Label.hpp"

#include <assert.h>

using namespace ahir;

ControlPath::ControlPath(const std::string& _id)
  : id(_id), parent(NULL), init(NULL), fin(NULL), marked_place(NULL)
  , labels(NULL)
{
  // max_req = max_ack = 0;
  marked_place = new Place(marked_place_id, "marked_place", 1);
  register_place(marked_place);
  
  init = new Transition(init_id, HIDDEN, "init");
  // init->symbol = 1;
  register_transition(init);
  
  fin = new Transition(fin_id, HIDDEN, "fin");
  // fin->symbol = 1;
  register_transition(fin);

  control_flow(fin, marked_place);
  control_flow(marked_place, init);
};


ControlPath::~ControlPath()
{
  for (PList::iterator pi = places.begin(), pe = places.end();
       pi != pe; ++pi)
    delete (*pi).second;
  for (TList::iterator pi = transitions.begin(), pe = transitions.end();
	   pi != pe; ++pi)
    delete (*pi).second;
  places.clear();
  transitions.clear();
  mux_regions.clear();
  if (!labels)
    delete labels;
}

void ControlPath::register_transition(Transition *t)
{
  register_element(t);
  assert(is_hidden(t) || t->symbol);
  transitions[t->id] = t;

  if (is_req(t)) {
    assert(reqs.find(t->symbol) == reqs.end());
    reqs[t->symbol] = t;
    // max_req = max_req < t->symbol ? t->symbol : max_req;
  } else if (is_ack(t)) {
    assert(acks.find(t->symbol) == acks.end());
    acks[t->symbol] = t;
    // max_ack = max_ack < t->symbol ? t->symbol : max_ack;
  }
}

Transition* ControlPath::find_transition(unsigned id)
{
  if (transitions.find(id) != transitions.end())
    return transitions[id];
  else
    return NULL;
}

void ControlPath::register_place(Place *p)
{
  register_element(p);
  places[p->id] = p;
}

Place* ControlPath::find_place(unsigned id)
{
  if (places.find(id) != places.end())
    return places[id];
  else
    return NULL;
}

void ControlPath::register_element(CPElement *cpe)
{
  assert(!find_element(cpe->id));
  elements[cpe->id] = cpe;
}

CPElement* ControlPath::find_element(unsigned id)
{
  if (elements.find(id) != elements.end())
    return elements[id];
  return NULL;
}
