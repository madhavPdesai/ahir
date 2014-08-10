#ifndef __BBCHAIN_HPP__
#define __BBCHAIN_HPP__

#include <llvm/Support/InstVisitor.h>
#include <set>
#include <map>
#include <vector>
#include <string>
#include <iostream>

namespace llvm {
  class TargetData;
  class AliasAnalysis;
};


namespace Aa {
  // basic block DAG.
  struct BasicBlockChainElement { 
	BasicBlockChainElement(llvm::BasicBlock* elem);
	~BasicBlockChainElement() 
	{
		_successors.clear();
		_successor_bb_set.clear();
		_predecessors.clear();
		_predecessor_bb_set.clear();
	};
 
	llvm::BasicBlock* _element;
	std::vector<BasicBlockChainElement*> _successors;
	std::set<llvm::BasicBlock*> _successor_bb_set;

	std::vector<BasicBlockChainElement*> _predecessors;
	std::set<llvm::BasicBlock*> _predecessor_bb_set;
	

	void addSuccessor(BasicBlockChainElement* succ);
        void addPredecessor(BasicBlockChainElement* pred);

	void print(std::ostream& ofile);

	int _visit_count;

	bool _invalidated;
	void invalidate();

  };

  struct BasicBlockChainDAG {

    BasicBlockChainDAG(llvm::BasicBlock* header);

	// return true if v can point to _header.
	// in which case v will be inserted into _trailers.
	//
    bool addDependency(llvm::BasicBlock* u, llvm::BasicBlock* v, std::map<llvm::BasicBlock*, std::vector<llvm::BasicBlock*> >&,
				std::map<llvm::BasicBlock*,int>& );

    llvm::BasicBlock* _header;
    std::set<llvm::BasicBlock*> _loopbacks;
    std::set<llvm::BasicBlock*> _exitpoints;

    std::vector<BasicBlockChainElement*> _elements;
    std::map<llvm::BasicBlock*, BasicBlockChainElement* > _bb_element_map;

	//
	// return true of all predecessors of bb are
	// in DAG.
	//
    bool all_present_in_dag(std::vector<llvm::BasicBlock*>& vtr);

	//
	// return true if all successors of bb are
	// present in the DAG.
	//
    bool all_successors_in_dag(llvm::BasicBlock* bb);

	// 
	// return true if bb can point to non-header.
	// element in DAG.
	//
    bool loops_back_to_non_header(llvm::BasicBlock* bb, std::map<llvm::BasicBlock*,int>& dfs_map);

	// 
	// return true if bb can point back to header.
	//
    bool loops_back_to_header(llvm::BasicBlock* bb);

	// 
	// collect exit points.
	// 
    void collect_exit_points();

	// print
    void print(std::ostream& ofile);


	// eliminate dushta influences.
	// (dushta = not descending from the header).
    void eliminate_dushtatva(std::map<llvm::BasicBlock*,std::vector<llvm::BasicBlock*> >& predmap);

	// 
	// eliminate clutter  (get rid of invalidated stuff).
	//
    void garbage_collect();
   
    void precedence_order();

  };
    
};

#endif
