#ifndef __ELEMENTUTILS_HPP__
#define __ELEMENTUTILS_HPP__

#include "ControlPath.hpp"

#include <sstream>
#include <iostream>
#include <assert.h>

namespace ahir {
  
  inline bool is_place(CPElement *ele)
  {
    return ele->type == PLACE;
  }

  inline bool is_initially_marked(CPElement *ele)
  {
    if (!is_place(ele))
      return false;
    Place *p = static_cast<Place*>(ele);
    assert(p->marking < 2);
    return p->marking == 1;
  }

  inline bool is_merge(CPElement *ele)
  {
    return is_place(ele)
      && ele->srcs.size() > 1;
  }

  inline bool is_branch(CPElement *ele)
  {
    return is_place(ele)
      && ele->snks.size() > 1;
  }

  inline bool is_trans(CPElement *ele)
  {
    return ele->type > PLACE;
  }

  inline bool is_req(CPElement *ele)
  {
    return ele->type == REQ;
  }

  inline bool is_ack(CPElement *ele)
  {
    return ele->type == ACK;
  }

  inline bool is_hidden(CPElement *ele)
  {
    return ele->type == HIDDEN;
  }

  inline bool is_join(CPElement *ele)
  {
    return is_trans(ele)
      && ele->srcs.size() > 1;
  }

  inline bool is_fork(CPElement *ele)
  {
    return is_trans(ele)
      && ele->snks.size() > 1;
  }

  inline bool is_simple(CPElement *ele)
  {
    return ele->srcs.size() == 1
      && ele->snks.size() == 1;
  }
  
  inline bool is_simple_place(CPElement *ele)
  {
    return is_place(ele)
      && is_simple(ele);
  }

  inline bool is_simple_trans(CPElement *ele)
  {
    return is_trans(ele)
      && is_simple(ele);
  }

  inline bool is_fin(CPElement *ele)
  {
    return ele->id == fin_id;
  }

  inline void control_flow(CPElement *src, CPElement *snk)
  {
    assert((is_place(src) && is_trans(snk))
	   || (is_trans(src) && is_place(snk)));
    src->snks.insert(snk);
    snk->srcs.insert(src);
  }
  
  void initialise_dfs(ControlPath *cp);

  void disconnect_initial_marking(ControlPath *cp);
  void reconnect_initial_marking(ControlPath *cp);
};

#endif
