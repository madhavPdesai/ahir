#include "MemoryAccess.hpp"
#include "CDFGBuilder.hpp"

#include <llvm/Instructions.h>
#include <llvm/Pass.h>
#include <llvm/Analysis/AliasAnalysis.h>
#include <llvm/Target/TargetData.h>

#include <iostream>
#include <deque>

/*
  Purpose: Given a basic block, enforce external dependences by
  introducting appropriate control edges. Function calls and
  terminator statements are termed as "barrier" instructions, that
  define the range within we each analyse load/store instructions. The
  control edges introduced by this procedure guarantee that a store
  instruction is executed only after the completion of all previous
  loads and stores that may alias with it.

  range: Maximal sequence of instructions bounded by barriers.
  
  closure: Transitive closure over external dependences between loads
  and stores. An edge (u,v) in the closure represents an external
  dependence where ``u'' depends on ``v''.

  roots: closure is a DAG. This set contains its roots ---
  instructions on which no other instruction in the closure depends.
  
*/

using namespace llvm;
using namespace cdfg;

AccessAnalysis::AccessAnalysis(llvm::AliasAnalysis *_AA
			       , llvm::TargetData *_TD
			       , CDFGBuilder *_CB)
{
  AA = _AA;
  TD = _TD;
  cbuilder = _CB;
}

void AccessAnalysis::clear(void)
{
  closure.clear();
  roots.clear();
  range.clear();
  previous_call = NULL;
}

void AccessAnalysis::insert_edge(Instruction *pred, Instruction *succ)
{
  assert(pred != succ && "sanity check");
  assert(pred && succ && "sanity check");
  closure[pred].insert(succ);
  roots.erase(succ);

  for (SI::iterator si = closure[succ].begin(), se = closure[succ].end();
       si != se; ++si) {
    Instruction *s = *si;
    closure[pred].insert(s);
  }
}

bool AccessAnalysis::aliases(Instruction *a, Instruction *b)
{
  assert((isa<LoadInst>(a) || isa<StoreInst>(a)) && "sanity check");
  assert((isa<LoadInst>(b) || isa<StoreInst>(b)) && "sanity check");
    
  if (isa<LoadInst>(a) && isa<LoadInst>(b))
    return false;

  llvm::Value *val1 = NULL;
  unsigned size1 = 0;
  llvm::Value *val2 = NULL;
  unsigned size2 = 0;

  switch (a->getOpcode()) {
  case Instruction::Load:
    val1 = a->getOperand(0);
    size1 = TD->getTypeStoreSize(a->getType());
    break;

  case Instruction::Store:
    val1 = a->getOperand(1);
    size1 = TD->getTypeStoreSize(a->getOperand(0)->getType());
    break;
  }

  switch (b->getOpcode()) {
  case Instruction::Load:
    val2 = b->getOperand(0);
    size2 = TD->getTypeStoreSize(b->getType());
    break;

  case Instruction::Store:
    val2 = b->getOperand(1);
    size2 = TD->getTypeStoreSize(b->getOperand(0)->getType());
    break;
  }

  return AA->alias(val1, size1, val2, size2);
}

/*
  return a list of instructions with the following properties:
  * each instruction is a load operation
  * it is reachable from the the given instruction
  * it is in the current range of instructions being examined
 */
void AccessAnalysis::get_dependences(Instruction *inst, SI &deps)
{
  assert(inst && "unhandled condition");
    
  for (User::op_iterator i = inst->op_begin(), e = inst->op_end();
       i != e; ++i) {
    llvm::Value *opnd = *i;

    if (!isa<Instruction>(opnd))
      continue;

    Instruction *op = cast<Instruction>(opnd);

    if (range.count(op) == 0)
      continue;

    if (isa<LoadInst>(op))
      deps.insert(op);

    get_dependences(op, deps);
  }
}

// remove nodes that are reachable from the current node

void AccessAnalysis::remove_deps(Instruction *inst, SI &candidates)
{
  assert(inst && "unhandled condition");

  for (SI::iterator si = closure[inst].begin(), se = closure[inst].end();
       si != se; ++si) {
    Instruction *s = *si;

    assert(s != inst && "sanity check");
    candidates.erase(s);
  }
}

// the boundary is the set of nodes that are not reachable from the
// current node

void AccessAnalysis::locate_boundary(SI &candidates)
{
  for (SI::iterator ci = candidates.begin(); ci != candidates.end(); ++ci) {
    Instruction *c = *ci;

    remove_deps(c, candidates);
  }
}

bool AccessAnalysis::check_control_flow(Instruction *pred, Instruction *succ)
{
  if (!pred || !succ)
    return false;
  
  std::deque<Instruction*> queue;
  queue.push_back(succ);

  while (!queue.empty()) {
    Instruction *c = queue.front();
    queue.pop_front();
    
    for (Instruction::op_iterator i = c->op_begin(), e = c->op_end();
	 i != e; ++i) {
      
      llvm::Value *opnd = *i;

      if (!isa<Instruction>(opnd))
	continue;

      Instruction *op = cast<Instruction>(opnd);

      if (opnd == pred)
	return true;
      
      if (range.count(op) == 0)
	continue;

      queue.push_back(op);
    }
  }

  return false;
}

void AccessAnalysis::control_flow(Instruction *pred, Instruction *succ)
{
  if (!check_control_flow(pred, succ))
    cbuilder->control_flow(pred, succ);
}

void AccessAnalysis::handleGenericInstruction(llvm::Instruction *inst)
{
  range.insert(inst);
}

/*
  Called when a load/store is encountered. This function implements
  the control-edges that enforces correct sequencing to prevent
  hazards.
  
  We first identify a set of candidates with the following properties:
  * subset of the current range
  * not reachable from the current instruction
  * may alias with the current instruction

  This set is reduced to the subset of candidates that are not
  reachable from other candidates.
 */

void AccessAnalysis::handleLoadStore(llvm::Instruction *node)
{
  SI candidates;
  SI deps;
  get_dependences(node, deps);

  SI workset = roots;
  VI queue;
  queue.insert(queue.end(), roots.begin(), roots.end());
	
  while (!queue.empty()) {
    Instruction *c = queue.front();
    queue.erase(queue.begin());
	  
    if (deps.count(c)) {
      continue;
    }
	  
    if (aliases(c, node)) {
      candidates.insert(c);
      
    } else {
      for (SI::iterator si = closure[c].begin(), se = closure[c].end();
	   si != se; ++si) {
	Instruction *s = *si;
	    
	if (!workset.count(s)) {
	  queue.push_back(s);
	  workset.insert(s);
	}
      }
    }
  }
      
  locate_boundary(candidates);
  
  for (SI::iterator ci = candidates.begin(); ci != candidates.end(); ++ci) {
    Instruction *c = *ci;

    insert_edge(node, c);
    control_flow(c, node);
  }

  for (SI::iterator di = deps.begin(), de = deps.end();
       di != de; ++di) {
    Instruction *d = *di;
    insert_edge(node, d);
  }

  if (candidates.size() == 0 && deps.size() == 0) {
    if (!check_control_flow(previous_call, node))
      control_flow(previous_call, node);
  }
    
  roots.insert(node);
  range.insert(node);
}
  
void AccessAnalysis::handleCallInst(llvm::Instruction *node
				    , bool connect_entry)
{
  if (roots.size() == 0) {
    if (previous_call)
      control_flow(previous_call, node);
    else if (connect_entry)
      control_flow(NULL, node);
  } else {
    SI deps;
    get_dependences(node, deps);

    for (SI::iterator di = deps.begin(), de = deps.end();
	 di != de; ++di) {
      roots.erase(*di);
    }
    
    for (SI::iterator ri = roots.begin(), re = roots.end();
	 ri != re; ++ri) {
      Instruction *root = *ri;

      control_flow(root, node);
    }
  }

  clear();
  previous_call = cast<CallInst>(node);
}

void AccessAnalysis::handleTerminatorInst()
{
  for (SI::iterator ri = roots.begin(), re = roots.end();
       ri != re; ++ri) {
    Instruction *root = *ri;

    if (isa<LoadInst>(root))
      continue;
    
    cbuilder->connect_to_exit(root);
  }

  // Connect the previous CallInst to the exit only if both the
  // following conditions are true:
  //
  // 1) there are no uses in the current block, as indicatd by
  // path_to_exit.
  //
  // 2) there are no roots pending. If there are, then there is
  // already a path from the previous call to the roots, which will
  // eventually reach the exit.
  if (roots.size() == 0)
    if (previous_call)
      if (!path_to_exit)
	control_flow(previous_call, NULL);
}
