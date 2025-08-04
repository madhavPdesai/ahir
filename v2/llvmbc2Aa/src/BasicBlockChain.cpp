//
// Copyright (C) 2010-: Madhav P. Desai
// All Rights Reserved.
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal with the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimers.
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimers in the documentation and/or other materials provided
//    with the distribution.
//  * Neither the names of the AHIR Team, the Indian Institute of
//    Technology Bombay, nor the names of its contributors may be used
//    to endorse or promote products derived from this Software
//    without specific prior written permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
#include <llvm/Constants.h>
#include <llvm/Function.h>
//#include <llvm/Target/TargetData.h>
#include <llvm/User.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/Support/CFG.h>
#include <llvm/Type.h>

#include <iostream>
#include <deque>

#include "BasicBlockChain.hpp"
#include "AaWriter.hpp" 
#include "Utils.hpp"
#include "BGLWrap.hpp"


using namespace llvm;

namespace llvm {
	class AliasAnalysis;
}

namespace Aa {

	BasicBlockChainElement::BasicBlockChainElement(llvm::BasicBlock* elem)
	{
		_element = elem;
		_visit_count = 0;
		_invalidated = false;
	}

	void BasicBlockChainElement::addSuccessor(BasicBlockChainElement* s)
	{
	
		if(_successor_bb_set.find(s->_element) != _successor_bb_set.end())		
			return;

		_successors.push_back(s);
		_successor_bb_set.insert(s->_element);

	}

	void BasicBlockChainElement::addPredecessor(BasicBlockChainElement* s)
	{
		if(_predecessor_bb_set.find(s->_element) != _predecessor_bb_set.end())		
			return;

		_predecessors.push_back(s);
		_predecessor_bb_set.insert(s->_element);
		_visit_count += 1;
	}

	//
	// (disconnect it, mark it as invalid).
	//
	void BasicBlockChainElement::invalidate()
	{
		// 
		// dont delete it, but invalidate it.
		//
		this->_invalidated = true;

		for(int I =0, fI = this->_successors.size(); I < fI; I++)
		{
			BasicBlockChainElement* succ = this->_successors[I];
			succ->_visit_count -= 1;
		}
	}

	void BasicBlockChainElement::print(std::ostream& ofile)
	{
		int I, fI;
		ofile << " " << to_aa(_element->getNameStr()) << std::endl;
		ofile << "   -> ";
		for(I = 0, fI = _successors.size(); I < fI; I++)
		{
			if(I > 0)
				ofile << ",  ";
			ofile << to_aa(_successors[I]->_element->getNameStr());
		} 	
		ofile << std::endl;
		ofile << "   <- ";
		for(I = 0, fI = _predecessors.size(); I < fI; I++)
		{
			if(I > 0)
				ofile << ",  ";
			ofile << to_aa(_predecessors[I]->_element->getNameStr());
		} 	
		ofile << std::endl;
	}

	BasicBlockChainDAG::BasicBlockChainDAG(llvm::BasicBlock* header)
	{
		_header = header;
		BasicBlockChainElement* ne = new BasicBlockChainElement(header);
		_bb_element_map[header] = ne;
		_elements.push_back(ne);

		if(this->loops_back_to_header(header))
			_loopbacks.insert(header);
	}

	// return true if v is accepted as a legal element of this chain.
	bool BasicBlockChainDAG::addDependency(llvm::BasicBlock* u, llvm::BasicBlock* v, std::map<llvm::BasicBlock*, std::vector<llvm::BasicBlock*> >& bbmap, std::map<llvm::BasicBlock*,int>& dfs_map)
	{
		bool ret_val = false;

		// if u is a loopback, then skip... no further
		// additions from u.
		if(this->_loopbacks.find(u) != this->_loopbacks.end())
			return(false);

		// if v loops back to something other than the header then
		// we skip it.
		if(this->loops_back_to_non_header(v, dfs_map))
			return(false);

		BasicBlockChainElement* uc = NULL;
		BasicBlockChainElement* vc = NULL;
		if(_bb_element_map.find(u) != _bb_element_map.end())
		{
			uc = _bb_element_map[u];
		}
		else
		{
			uc = new BasicBlockChainElement(u);
			_elements.push_back(uc);
			_bb_element_map[u] = uc;
		}

		if(_bb_element_map.find(v) != _bb_element_map.end())
		{
			vc = _bb_element_map[v];
		}
		else
		{
			vc = new BasicBlockChainElement(v);
			_elements.push_back(vc);
			_bb_element_map[v] = vc;
		}

		// add links.
		uc->addSuccessor(vc);
		vc->addPredecessor(uc);

		if(this->loops_back_to_header(v))
		{
			_loopbacks.insert(v);
		}


		std::cerr << "Info: added chain-link "  << u->getNameStr() << " -> " << v->getNameStr() << std::endl;

		return(true);
	}

	bool BasicBlockChainDAG::all_present_in_dag(std::vector<llvm::BasicBlock*>& bbv)
	{
		bool ret_val = true;
		for(int I = 0, fI = bbv.size(); I < fI; I++)
		{
			if(_bb_element_map.find(bbv[I]) == _bb_element_map.end())
			{
				ret_val = false;
				break;
			}
		}
		return(ret_val);
	}


	bool BasicBlockChainDAG::loops_back_to_non_header(llvm::BasicBlock* bb, std::map<llvm::BasicBlock*,int>& dfs_map)
	{
		bool ret_val = false;
		int I, fI;
		for(I = 0, fI = bb->getTerminator()->getNumSuccessors(); I < fI; I++)
		{
			llvm::BasicBlock* succ = bb->getTerminator()->getSuccessor(I);

			if((succ != _header) && ((succ == bb) || (dfs_map.find(succ) != dfs_map.end())) )
			{
				ret_val = true;
				break;
			}
		}
		return(ret_val);
	}

	bool BasicBlockChainDAG::loops_back_to_header(llvm::BasicBlock* bb)
	{
		bool ret_val = false;
		int I, fI;
		for(I = 0, fI = bb->getTerminator()->getNumSuccessors(); I < fI; I++)
		{
			llvm::BasicBlock* succ = bb->getTerminator()->getSuccessor(I);

			if(succ == _header)
			{
				ret_val = true;
				break;
			}
		}
		return(ret_val);
	}

    	bool BasicBlockChainDAG::all_successors_in_dag(llvm::BasicBlock* bb)
	{
		for(int I = 0, fI = bb->getTerminator()->getNumSuccessors(); I < fI; I++)
		{
			llvm::BasicBlock* sb = bb->getTerminator()->getSuccessor(I);
			if(_bb_element_map.find(sb) == _bb_element_map.end())
			{
				return(false);
			}
		}
		return(true);
	}

	//
	// collect all elements which point to something outside 
	// the DAG.
	//
	void BasicBlockChainDAG::collect_exit_points()
	{
		for(std::map<llvm::BasicBlock*,BasicBlockChainElement* >::iterator iter = _bb_element_map.begin(),
				fiter = _bb_element_map.end(); iter != fiter; iter++)
		{
			llvm::BasicBlock* bb = (*iter).first;
			if(!this->all_successors_in_dag(bb))
			{
				_exitpoints.insert(bb);
			}
		}
	}

	void BasicBlockChainDAG::print(std::ostream& ofile)
	{
		ofile << "Basic-block-chain-DAG with header = " << to_aa(_header->getNameStr()) << std::endl;
		for(int I = 0, fI = _elements.size(); I < fI; I++)
		{
			BasicBlockChainElement* e = _elements[I];
			e->print(ofile);
		}	

		ofile << "loop-backs " << std::endl;
		for(std::set<llvm::BasicBlock*>::iterator lbi = _loopbacks.begin(), flbi = _loopbacks.end();
				lbi != flbi; lbi++)
		{
			ofile << "  " << to_aa((*lbi)->getNameStr()) << std::endl;
		}

		ofile << "exit-points " << std::endl;
		for(std::set<llvm::BasicBlock*>::iterator epi = _exitpoints.begin(), fepi = _exitpoints.end();
				epi != fepi; epi++)
		{
			ofile << "  " << to_aa((*epi)->getNameStr()) << std::endl;
		}
	}



	//
	// reverse precedence order..
	//
	void BasicBlockChainDAG::precedence_order()
	{
		GraphBase dag_graph;	
		int I, fI, J, fJ;
	
		dag_graph.Add_Vertex(_bb_element_map[_header]);
		for(I = 0, fI = _elements.size(); I < fI; I++)
		{
			BasicBlockChainElement* ele = _elements[I];
			for(J = 0, fJ = ele->_successors.size(); J < fJ; J++)
			{
				BasicBlockChainElement* succ = ele->_successors[J];
				dag_graph.Add_Edge(ele,succ);	
			}
		}

		vector<void*> rprec_order;
		dag_graph.Topological_Sort(rprec_order);

		_elements.clear();
		for(I = rprec_order.size()-1, fI=0; I >= fI; I--)
		{
			_elements.push_back((BasicBlockChainElement*) rprec_order[I]);
		}
	}
	
	//
	// get rid of all blocks which are contaminated by influence
	// from the outside.
	//
	void BasicBlockChainDAG::eliminate_dushtatva(std::map<llvm::BasicBlock*,std::vector<llvm::BasicBlock*> >& predmap)
	{
		// assumed that the elements are in reverse precedence order.
		for(int I = 1, fI = _elements.size(); I < fI; I++)
		{
			BasicBlockChainElement* ele = _elements[I];
			if((ele->_element != _header) && (ele->_visit_count < predmap[ele->_element].size()))
			{
				std::cerr << "Info: invalidate chain-element "  << ele->_element->getNameStr() 
						<< std::endl;
				ele->invalidate();
			}
		}
		this->garbage_collect();
	}


	// remove all traces of invalid elements..
	void BasicBlockChainDAG::garbage_collect()
	{
		std::vector<BasicBlockChainElement*> valid_elements;
		std::vector<BasicBlockChainElement*> invalid_elements;


		valid_elements.clear();
		invalid_elements.clear();

		for(int I = 0, fI = _elements.size(); I < fI; I++)
		{
			BasicBlockChainElement* ele =_elements[I];
			if(ele->_invalidated)
			{
				//
				// erase it.
				// 
				_loopbacks.erase(ele->_element);	
				_exitpoints.erase(ele->_element);
				_bb_element_map.erase(ele->_element);

				//
				// free later.
				//
				invalid_elements.push_back(ele);
			}
			else
			{
				//
				// remove invalid elements from predecessors and successors
				//
				std::vector<BasicBlockChainElement*> preds;
				ele->_predecessor_bb_set.clear();
				for(int J = 0, fJ = ele->_predecessors.size(); J < fJ; J++)
				{
					if(!ele->_predecessors[J]->_invalidated)
					{
						preds.push_back(ele->_predecessors[J]);
						ele->_predecessor_bb_set.insert(ele->_predecessors[J]->_element);
					}
				}
				ele->_predecessors.clear();
				ele->_predecessors = preds;
				ele->_visit_count = preds.size();

				std::vector<BasicBlockChainElement*> succs;
				for(int J = 0, fJ = ele->_successors.size(); J < fJ; J++)
				{
					if(!ele->_successors[J]->_invalidated)
					{
						succs.push_back(ele->_successors[J]);
						ele->_successor_bb_set.insert(ele->_successors[J]->_element);
					}
				}
				ele->_successors.clear();
				ele->_successors = succs;

				//
				// for later repopulation
				//
				valid_elements.push_back(ele);
			}
		}

		// valid elements are used to repopulate _elements and
		// _bb_element_map.
		_elements.clear();
		_bb_element_map.clear();
		for(int I = 0, fI = valid_elements.size(); I < fI; I++)
		{
			_elements.push_back(valid_elements[I]);
			_bb_element_map[valid_elements[I]->_element] = valid_elements[I];
		}

		// invalid elements are deleted.
		for(int I = 0, fI = invalid_elements.size(); I < fI; I++)
			delete invalid_elements[I];
			
	}
		
	void AaWriter::Build_Basic_Block_Chain_DAGs(llvm::Function& F)
	{
		_bb_chain_dag_vector.clear();

		std::set<llvm::BasicBlock*> unchained_blocks;
		std::vector<llvm::BasicBlock*> block_vector;

		// list of blocks.
		for(llvm::Function::iterator iter = F.begin(); iter != F.end(); ++iter)
		{
			bb_name_map[to_aa((*iter).getNameStr())] = &(*iter);
			unchained_blocks.insert(&(*iter));
			block_vector.push_back(&(*iter));
		}

		for(int J=0, fJ = block_vector.size(); J < fJ; J++)
		{
			llvm::BasicBlock* curr_block = block_vector[J];

			if(unchained_blocks.find(curr_block) != unchained_blocks.end())
			{
				//
				// build chain starting with curr_block.
				//
				BasicBlockChainDAG* new_dag = new BasicBlockChainDAG(curr_block);
				std::cerr << "Info: starting new BB-chain-dag with header " << curr_block->getNameStr()
						<< std::endl;

				_bb_chain_dag_vector.push_back(new_dag);

				int pD, buffRing; bool fRflag; // sacrificial :(
				bool leader_is_do_while_loop = is_marked_as_a_do_while_loop(*curr_block, pD,buffRing,fRflag);


				if(leader_is_do_while_loop) // if not a do-while, dont try to chain.
				{

					//
					// do a DFS and find the maximal acyclic component
					// rooted at the leader (curr_block).  The DFS will
					// stop when it encounters a vertex with a back
					// edge which is not to the header of the DAG.
					// 
					//
					std::deque<llvm::BasicBlock*> dfs_queue;
					dfs_queue.push_front(curr_block);
				

					//
					//  for each block on the stack, count
					//  the last index of the neighbour which
					//  was visited.
					// 
					map<llvm::BasicBlock*,int> dfs_map;
					dfs_map[curr_block] = 0;

					while(!dfs_queue.empty())
					{

						llvm::BasicBlock* tblock = dfs_queue.front();

			
						int fI = tblock->getTerminator()->getNumSuccessors(); 
						if((dfs_map.find(tblock) != dfs_map.end()) &&
							(dfs_map[tblock] == fI))
						{
							dfs_queue.pop_front();
							dfs_map.erase(tblock);
						}
						else
						{
							if(dfs_map.find(tblock) == dfs_map.end())
							{
								dfs_map[tblock] = 0;
							}

						
							int I = dfs_map[tblock];
							llvm::BasicBlock* succ = tblock->getTerminator()->getSuccessor(I);
							dfs_map[tblock] = (I+1);

							// only continue to unchained-blocks.
							if(unchained_blocks.find(succ) == unchained_blocks.end())
								continue;


							// skip if succ is not appropriately terminated.
							llvm::TerminatorInst* succT = succ->getTerminator();
							if(isa<llvm::ReturnInst>(succT) ||
								isa<llvm::SwitchInst>(succT) ||
									(succT->getNumSuccessors() == 0))
								continue;

							if(new_dag->addDependency(tblock, succ, basic_block_predecessor_map, dfs_map))
							{
								dfs_queue.push_front(succ);
								dfs_map[succ] = 0;
							}
						}
					}

					// precedence ordering of the elements.
					new_dag->precedence_order();

					//
					// get rid of 5th columnists :-).. Those which
					// are influenced by dushta influence.. ie
					// those which have predecessors outside the DAG.
					//
					new_dag->eliminate_dushtatva(basic_block_predecessor_map);
				}
				new_dag->collect_exit_points();

				// remove dag elements from unchained blocks.
				for(int I = 0, fI = new_dag->_elements.size(); I < fI; I++)
					unchained_blocks.erase(new_dag->_elements[I]->_element);
			}
		}


		// print the chains.. for debug purposes..
		std::cerr << "Basic Block Chain DAGS." << std::endl;
		for(int J = 0, fJ = _bb_chain_dag_vector.size(); J < fJ; J++)
		{
			_bb_chain_dag_vector[J]->print(std::cerr);
		}
	}


	// write Aa code for the chain-dag.
	void AaWriter::Write_Aa_Code(BasicBlockChainDAG* chain_dag, bool extract_do_while_flag)
	{

		std::string header_name = get_name(chain_dag->_header);

		_active_dag = chain_dag;

		bool v = false;
		int pipelining_depth = 1;
		int buffering_depth = 1;
		bool full_rate_flag = false;


		if(extract_do_while_flag)
			v = is_marked_as_a_do_while_loop(*(chain_dag->_header),
					pipelining_depth, 
					buffering_depth, 
					full_rate_flag);


		v = v && (chain_dag->_loopbacks.size() > 0);

		if(v)
		{
			std::cerr << "Info: found pipelined-loop: Basic-block-chain-DAG with header = " 
				<< to_aa(chain_dag->_header->getNameStr()) << std::endl;
		}

		this->Set_Do_While_Flag(v);
		this->Set_Do_While_Full_Rate_Flag(full_rate_flag);
		this->Set_Do_While_Pipelining_Depth(pipelining_depth);
		this->Set_Do_While_Buffering_Depth(buffering_depth);

		//
		// if it is not a do-while loop, then print it
		// in the normal manner.
		//
		if(!v)
		{
			_suppress_leading_merge = false;
			_suppress_terminator = false;

			for(int idx = 0, fidx = chain_dag->_elements.size(); idx < fidx; idx++)
			{
				llvm::BasicBlock* curr_block = chain_dag->_elements[idx]->_element;
				this->visit(*curr_block);
			}
			return;
		}


		// going forward.. you are in a do-while loop.
		// visit the blocks from beginning to end.. 
		// turn on leading merge printing only for the lead-block.
		// terminators for all blocks will be suppressed.
		_suppress_leading_merge = false;
		_suppress_terminator = true;

		// the common situation: there is a single exit-point
		// which is also the loopback BB.. or there is a single loopback
		// but there is no exit.
		bool common_case = (chain_dag->_loopbacks.size() == 1) &&
			( ((chain_dag->_exitpoints.size() == 1) &&
				(*(chain_dag->_loopbacks.begin()) == 
			 		*(chain_dag->_exitpoints.begin())) ) || 
				(chain_dag->_exitpoints.size() == 0)) ;



		for(int idx = 0, fidx = chain_dag->_elements.size(); idx < fidx; idx++)
		{
			llvm::BasicBlock* curr_block = chain_dag->_elements[idx]->_element;
			std::string curr_block_name = to_aa(curr_block->getNameStr());
			std::string guard_name = curr_block_name + "_exec_guard";

			std::vector<std::string> preds;
			this->get_predecessors(curr_block_name, preds);

			bool header_flag = (curr_block == chain_dag->_header);
			bool common_case_loopback = (common_case && 
					(chain_dag->_loopbacks.find(curr_block) != chain_dag->_loopbacks.end()));

			// there are several distinct cases.
			// if curr-block is the header, then the leading 
			// merge and phi statements will be preserved.  Else, the
			// leading phi-statement will be converted to 
			// a multiplexor.
			if(header_flag)
			{
				// no guard for the header.
				this->Set_Guard_Flag(false);
				_suppress_leading_merge = false;
			}
			else
			{

				_suppress_leading_merge = true;

				if(common_case_loopback)
				{
					this->Set_Guard_Flag(false);
				}
				else
				{

					// generate guard for this basic-block.
					this->Set_Guard_Flag(true);
					this->Set_Guard_Variable(guard_name);

					int lp_count = 1;

					std::cout << guard_name << " := " ;
					std::vector<std::string> names;
					for(int J=0, fJ = preds.size(); J < fJ; J++)
					{
						names.push_back(preds[J] + "_" + curr_block_name + "_taken");
					}
					write_reduction_expression(names, "|", std::cout);
					std::cout << std::endl;
				}
			}

			// visit the current block.
			this->visit(*curr_block);

			// now the terminator.
			llvm::TerminatorInst* T = curr_block->getTerminator();
			if(isa<llvm::BranchInst>(T))
			{
				llvm::BranchInst* B = dyn_cast<llvm::BranchInst>(T);
				if(B->isUnconditional())
				{

				
					llvm::BasicBlock* to_bb = B->getSuccessor(0);
					if(!common_case_loopback || (to_bb != chain_dag->_header))
					{
						std::cout << curr_block_name << "_" << to_aa(to_bb->getNameStr()) << "_taken := ";
						if(header_flag || !this->Get_Guard_Flag())
							std::cout << "($bitcast($uint<1>) _b1)" << std::endl;
						else 
							std::cout << guard_name << std::endl;
					}
				}
				else
				{
					BasicBlock* dest0 = B->getSuccessor(0);
					BasicBlock* dest1 = B->getSuccessor(1);
					std::string cond_name = prepare_operand(B->getCondition());

					if(!common_case_loopback || (dest0 != chain_dag->_header))
					{
						std::cout << curr_block_name << "_" << to_aa(dest0->getNameStr()) << "_taken := ";
						if(header_flag || !this->Get_Guard_Flag())
							std::cout << cond_name << std::endl;
						else
							std::cout << "(" << guard_name << " & " << cond_name << ")" << std::endl;
					}

					if(!common_case_loopback || (dest1 != chain_dag->_header))
					{
						std::cout << curr_block_name << "_" << to_aa(dest1->getNameStr()) << "_taken := ";
						if(header_flag || !this->Get_Guard_Flag())
							std::cout << "( ~" << cond_name << ")" << std::endl;
						else
							std::cout << "(" << guard_name << " & (~" << cond_name << "))" << std::endl;
					}
				}
			}
			else
			{
				std::cerr << "Error: unsupported terminator in do-while loop." << std::endl;
				std::cout << "ERROR: UNSUPPORTED TERMINATOR IN DO-WHILE LOOP" << std::endl;
			}

		}


		//
		// OK. now the while_loop_back conditon variable.  from the loopbacks
		// to the header... this is an OR of  all the loopback conditions..
		//
		// 
		if(!common_case)
		{
			std::vector<std::string> loopback_names;
			for(std::set<llvm::BasicBlock*>::iterator iter = chain_dag->_loopbacks.begin(), fiter = 
					chain_dag->_loopbacks.end(); iter != fiter; iter++)
			{
				loopback_names.push_back(get_name(*iter) + "_" + get_name(chain_dag->_header)
						+ "_taken");	
			}
			std::cout << header_name << "_loopback := ";
			write_reduction_expression(loopback_names,"|", std::cout);
			std::cout << std::endl;	
			std::cout << "$while " << header_name << "_loopback" << std::endl;
		}
		else
		{
			// in the common case, we infer that the loopback block
			// will always be visited (because there are no other
			// exit points), and so the loopback condition is locally
			// determined (this cuts the loopback condition evaluation
			// delay).
			llvm::BasicBlock* lbb = *(chain_dag->_loopbacks.begin());			
			llvm::TerminatorInst* T = lbb->getTerminator();
			if(isa<llvm::BranchInst>(T))
			{
				llvm::BranchInst* B = dyn_cast<llvm::BranchInst>(T);
				if(B->isUnconditional())
				{
					llvm::BasicBlock* to_bb = B->getSuccessor(0);
					if(to_bb != chain_dag->_header)
					{
						std::cerr << "Error: common-case loopback not to header?" << std::endl;
						std::cout << "ERROR: COMMON-CASE LOOPBACK NOT TO HEADER?" << std::endl;
					}
					else
					{
						std::cout << "$while 1" << std::endl;
					}
				}
				else
				{
					BasicBlock* dest0 = B->getSuccessor(0);
					BasicBlock* dest1 = B->getSuccessor(1);


					std::string cond_name = prepare_operand(B->getCondition());
					if(dest0 == chain_dag->_header)
					{
						std::cout << "$while " << cond_name << std::endl;
					}
					else if(dest1 == chain_dag->_header)
					{
						std::cout << "$while (~" << cond_name << ")" <<  std::endl;

					}
					else
					{
						std::cerr << "Error: common-case loopback not to header?" << std::endl;
						std::cout << "ERROR: COMMON-CASE LOOPBACK NOT TO HEADER?" << std::endl;
					}
				}
			}
		}

		// finally, the exit points..
		//
		// for each exit point, check a condition and generate a place
		// statement based on the condition.
		//
		for(std::set<llvm::BasicBlock*>::iterator iter = chain_dag->_exitpoints.begin(), fiter = 
				chain_dag->_exitpoints.end(); iter != fiter; iter++)
		{
			llvm::BasicBlock* exit_bb = *iter;

			llvm::TerminatorInst* T = exit_bb->getTerminator();
			if(isa<llvm::BranchInst>(T))
			{
				for(int I = 0, fI = T->getNumSuccessors(); I < fI; I++)
				{
					llvm::BasicBlock* tgt = T->getSuccessor(I);
					if(tgt != chain_dag->_header)
					{
						std::string cond_name = get_name(exit_bb) + "_" + get_name(tgt) + "_taken";
						std::cout << "$if " << cond_name << " $then " << std::endl;
						std::cout << "  $place [" << get_name(exit_bb) + "_" + get_name(tgt) << "]" << std::endl;
						std::cout << "$endif" << std::endl;	
					}
				}
			}
		}


		_active_dag = NULL;
		_suppress_leading_merge = false;
		_suppress_terminator = false;
		this->Set_Do_While_Flag(false);
		this->Set_Guard_Flag(false);
	}
}
