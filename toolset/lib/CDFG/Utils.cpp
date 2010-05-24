#include "Utils.hpp"

#include <deque>
#include <iostream>

#include <assert.h>

using namespace cdfg;
using namespace hls;

void cdfg::check_wellformedness(CDFG *cdfg)
{
  if (!cdfg)
    return;

  for (CDFG::NodeList::iterator ni = cdfg->nodes.begin(), ne = cdfg->nodes.end();
       ni != ne; ++ni) {
    CDFGNode *node = (*ni).second;

    node->colour = WHITE;
  }

  std::deque<CDFGNode*> queue;
  queue.push_back(cdfg->start);
  cdfg->start->colour = BLACK;

  while (!queue.empty()) {
    CDFGNode *node = queue.front();
    queue.pop_front();
    
    assert(node->ports.size()
	   == node->input_data_ports.size()
	   + node->output_data_ports.size()
	   + node->output_control_ports.size()
	   + node->input_control_ports.size());

    if (is_control(node)) {
      if (node->ntype != Stop)
	assert(node->output_control_ports.size() > 0);
      if (node->ntype != Start)
	assert(node->input_control_ports.size() > 0);
    }

    for (CDFGNode::PortList::iterator pi = node->ports.begin(), pe = node->ports.end();
	 pi != pe; ++pi) {
      Port *port = (*pi).second;
      
      assert(port->edge);

      assert(port->edge->driver);
      // if (port->edge->users.size() == 0)
	// assert(cdfg->retval == port->parent);

      if (is_output(port))
	assert(port->edge->driver == port);
      else
	assert(port->edge->users.find(port) != port->edge->users.end());
      
      if (is_control(port))
	assert(port->edge->users.size() == 1);
    }

    for (CDFGNode::PortList::iterator ci = node->output_control_ports.begin()
	   , ce = node->output_control_ports.end();
	 ci != ce; ++ci) {
      
      Port *port = (*ci).second;
      CDFGEdge *edge = port->edge;
      Port *user = (*(edge->users.begin()));
      assert(user);
      assert(user->parent);
      
      if (user->parent->colour != BLACK) {
	user->parent->colour = BLACK;
	queue.push_back(user->parent);
      }
    }
  }

  for (CDFG::NodeList::iterator ni = cdfg->nodes.begin(), ne = cdfg->nodes.end();
       ni != ne; ++ni) {
    CDFGNode *node = (*ni).second;

    if (is_constant(node))
      assert(node->colour == WHITE);
    else
      assert(node->colour == BLACK);
  }
}

bool cdfg::is_redundant(CDFGNode *node)
{
  switch (node->ntype) {
  case Fork:
  case Branch:
    assert(node->input_control_ports.size() == 1
	   && "a fork/branch has exactly one input");
    
    switch (node->output_control_ports.size()) {
    case 0:
      assert (false && "unexpected dangling node");
      break;
    case 1:
      return true;
      break;
    default:
      break;
    }

    break;

  case Join:
  case Merge:
    assert(node->output_control_ports.size() == 1
	   && "a join/merge has exactly one output");
    
    switch (node->input_control_ports.size()) {
    case 0:
      assert (false && "unexpected dangling node");
      break;
    case 1:
      return true;
      break;
    default:
      break;
    }
      
    break;
    
  default:
    break;
  }
  
  return false;
}

void cdfg::remove_redundant_nodes(CDFG *cdfg)
{
  if (!cdfg)
    return;

  for (CDFG::NodeList::iterator ni = cdfg->nodes.begin(), ne = cdfg->nodes.end();
       ni != ne; ++ni) {
    CDFGNode *node = (*ni).second;

    node->colour = WHITE;
  }

  std::deque<CDFGNode*> queue;
  queue.push_back(cdfg->start);
  cdfg->start->colour = BLACK;

  while (!queue.empty()) {
    CDFGNode *node = queue.front();
    queue.pop_front();

    for (CDFGNode::PortList::iterator ci = node->output_control_ports.begin()
	   , ce = node->output_control_ports.end();
	 ci != ce; ++ci) {
      
      Port *port = (*ci).second;
      CDFGEdge *edge = port->edge;
      assert(edge);
      assert(edge->users.size() == 1);
      Port *user = (*(edge->users.begin()));
      assert(user);
      assert(user->parent);
      
      if (user->parent->colour != BLACK) {
	  user->parent->colour = BLACK;
	  queue.push_back(user->parent);
      }
    }
    
    if (is_redundant(node)) {
      Port *input = (*(node->input_control_ports.begin())).second;
      CDFGEdge *edge = input->edge;
      
      Port *output = (*(node->output_control_ports.begin())).second;
      assert(output->edge->users.size() == 1
	     && "expecting a single port on the predecessor here");
      Port *user = (*(output->edge->users.begin()));
      assert(user && "invalid pointer to user");

      edge->users.clear();
      assert(edge->users.find(user) == edge->users.end());
      edge->users.insert(user);
      user->edge = edge;

      output->edge->users.clear();
      input->edge = NULL;
      
      assert(cdfg->nodes[node->id] == node);
      cdfg->nodes.erase(node->id);
      delete node;
    }
  }
}
