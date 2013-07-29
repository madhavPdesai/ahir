#include <llvm/Target/TargetData.h>
#include <llvm/Support/InstIterator.h>
#include <llvm/Instructions.h>
#include <llvm/Constants.h>
#include <llvm/DerivedTypes.h>
#include <llvm/Module.h>
#include <llvm/GlobalVariable.h>
#include <llvm/Analysis/AliasAnalysis.h>
#include <llvm/TypeSymbolTable.h>

#include <sstream>
#include <list>
#include <set>
#include <iostream>
#include <fstream>
#include "AaWriter.hpp"
#include "Utils.hpp"

namespace llvm {
  class AliasAnalysis;
}


using namespace llvm;
using namespace Aa;


namespace {

  struct ModuleGenPass : public ModulePass {

    static char ID;
    std::set<std::string> module_names;
    std::map<std::string, int> _pipe_depths;
    std::set<std::string> _lifo_pipe_set;
    bool _consider_all_functions;
    bool _create_initializers;
    bool _skip_zero_initializers;
    bool _extract_do_while;
    int _pointer_width;

    ModuleGenPass() : ModulePass(ID) 
    {
      _pointer_width = 32;
      _consider_all_functions = true;
      _create_initializers = true;
      _skip_zero_initializers = true;
      _extract_do_while = true;
    }

    ModuleGenPass(const std::string& mlist_file, 
		  bool create_initializers, 
		  const std::string& pipe_depth_file,
		  const std::string& hw_target,
		  bool extract_do_while
		  ) : ModulePass(ID) 
    {
      _pointer_width = 32;
      _consider_all_functions = true;
      _create_initializers = create_initializers;
      _skip_zero_initializers = true;
      _extract_do_while = extract_do_while;

      if(hw_target != "")
	{
	  _skip_zero_initializers = (hw_target == "xilinx");
	}

      if(mlist_file != "")
	{
	  std::ifstream mlist(mlist_file.c_str());
	  if (mlist.is_open()) {
	    
	    while (mlist.good()) {
	      std::string line;
	      std::getline(mlist, line);
              if(line[0] != '#')
	      {
	      	std::cerr << "Info: module to be translated: " << line << std::endl;
	      	module_names.insert(line);
	      	_consider_all_functions = false;
	      }
	    }
	    mlist.close();
	  }
	}

      if(_consider_all_functions)
	std::cerr << "Warning: no modules specified.. will translate all functions" << std::endl;

      if(pipe_depth_file != "")
	{
	  std::ifstream plist(pipe_depth_file.c_str());
	  if (plist.is_open()) {
	    
	    while (plist.good()) {
	      std::string line;
	      std::string pipe_name;
	      int pipe_depth = 1;
              bool lifo_flag = false;

	      std::getline(plist, line);
	      if(parse_pipe_depth_spec(line,pipe_name, pipe_depth, lifo_flag))
		{
		  std::cerr << "Info: pipe " << pipe_name << " max-depth set to " << pipe_depth << std::endl;	      
		  _pipe_depths[pipe_name] = pipe_depth;
                  if(lifo_flag)
			_lifo_pipe_set.insert(pipe_name);
		}
	    }
	    plist.close();
	  }
	}
    };
    


    virtual void getAnalysisUsage(AnalysisUsage &AU) const {
      AU.addRequired<AliasAnalysis>();
      AU.addRequired<TargetData>();
    }

    TargetData *TD;
    AliasAnalysis *AA;
    BasicBlock *curr_block;
    AaWriter *aa_writer;

    bool isConstantUsed(const Constant *konst) const
    {
      for (llvm::Value::const_use_iterator UI = konst->use_begin(), E = konst->use_end();
           UI != E; ++UI) {
        const Constant *UC = dyn_cast<Constant>(*UI);
        if (UC == 0 || isa<GlobalValue>(UC))
          return true;
        
        if (isConstantUsed(UC))
          return true;
      }
      return false;
    }

    bool is_ioport_identifier(GlobalVariable &G)
    {
      bool is_ioport = true;
      std::string gname = G.getName();

      if(aa_writer->Is_Pipe(gname))
	return(true);
      
      for (llvm::Value::use_iterator ui = G.use_begin(), ue = G.use_end();
           ui != ue; ++ui) {
        User *user = *ui;
	
        if (BitCastInst *inst = dyn_cast<BitCastInst>(user)) {
          if (inst->getNumUses() > 1) {
            is_ioport = false;
            break;
          }
          
          IOCode ioc = get_io_code(*(inst->use_begin()));
          if (ioc == NOT_IO) {
            is_ioport = false;
            break;
          }
        } else {
          if (Constant *konst = dyn_cast<Constant>(user)) {
            if (!isConstantUsed(konst))
              continue;
          }
          
          is_ioport = false;
          break;
        }
      }
      return is_ioport;
    }

    bool runOnModule(llvm::Module &M)
    {
      TD = &getAnalysis<TargetData>();
      AA = &getAnalysis<AliasAnalysis>();
    
      aa_writer = AaWriter_New(TD, AA, module_names,_consider_all_functions);  
      aa_writer->Set_Module(&M);
      aa_writer->Set_Pointer_Width(_pointer_width);

	// first the global named types 
	// (note: only structures need to be declared).
      llvm::TypeSymbolTable& tst = M.getTypeSymbolTable();
      for(std::map<const std::string, const Type*>::iterator ti = tst.begin(), tf = tst.end();
	ti != tf;
	ti++)
      {
		llvm::Type* t = (llvm::Type*) (*ti).second;
		if(t->isStructTy())
		{
			write_type_declaration(t,M);
		}
      }

	// collect all the pipes declared in the module..
	// you will need to scan every instruction in every
	// function to find the calls to io write/read functions.
      for (llvm::Module::iterator fi = M.begin(), fe = M.end();
           fi != fe; ++fi) {
	std::string fname = (*fi).getNameStr();
	if((module_names.count(fname) > 0) || _consider_all_functions)
	  {
	    aa_writer->Collect_Pipes(*fi);
	  }
      }
	// declare the pipes.
      aa_writer->Print_Pipe_Declarations(std::cout,_pipe_depths,_lifo_pipe_set);

      std::vector<std::string> objects_to_be_initialized;
      for (llvm::Module::global_iterator gi = M.global_begin(), ge = M.global_end();
           gi != ge; ++gi) {
        if (!is_ioport_identifier(*gi))
	  {
	    // not if it is a pointer to a function
	    if(!(*gi).getType()->isFunctionTy())
	    {
	      std::string obj_name = to_aa(aa_writer->get_name(&(*gi)));
	      if((*gi).getNumUses() > 0)
		{
		  if(is_used_in_module(*gi,module_names,_consider_all_functions))
		    {
		      //if(!aa_writer->Is_Pipe(obj_name))
		      //{
		      aa_writer->write_storage_object(&(*gi),
						      objects_to_be_initialized, 
						      _create_initializers,
						      _skip_zero_initializers);
		      //}
		    }
		}
	    }
	  }
      }

      if(_create_initializers)
	{
	  std::string init_module_name = to_aa(M.getModuleIdentifier() + "_storage_initializer_");
	  std::cerr << "Info: generating storage initialization module which calls all initializers in parallel" << std::endl;
	  std::cout << "$module [" << init_module_name << "] $in () $out () $is {" << std::endl;
	  if(objects_to_be_initialized.size() > 0)
	    {
	      std::cout << "$parallelblock [pb] { " << std::endl;
	      for(int idx = 0, fidx = objects_to_be_initialized.size(); idx < fidx; idx++)
		{
		  std::cout << "$call " << objects_to_be_initialized[idx] << " () () " << std::endl;
		}
	      std::cout << "}" << std::endl;
	    }
	  else
	    std::cout << "$null" << std::endl;

	  std::cout << "$attribute initializer" << std::endl;

	  std::cout << "}" << std::endl;
	}


      for (llvm::Module::iterator fi = M.begin(), fe = M.end();
           fi != fe; ++fi) 
	{
	  std::string fname = (*fi).getNameStr();
	  if((module_names.count(fname) > 0) || _consider_all_functions)
	    {
	      runOnFunction(*fi);
	    }
	  else
	    {
	      std::cerr << "Info: skipping function " 
			<< fname 
			<< " not specified in -modules" 
			<< std::endl;
	    }
	}

      return false; // we didn't touch anything
    }

    void runOnFunction(llvm::Function &F)
    {
      aa_writer->initialise_with_function(F);

      std::string fname = F.getNameStr();

      std::cerr<<"Info: visiting function " << fname << std::endl;

      aa_writer->clear();

      if (F.isDeclaration())
      {
	std::cerr<<"Info: ignoring external function " << fname << std::endl;
        return;
      }

      // scan the list of basic blocks and name them 
      // if they were not already named..
      int idx = 0;
      for(llvm::Function::iterator iter = F.begin(); iter != F.end(); ++iter)
	{
	  if((*iter).getNameStr() == "")
	    {
	      std::string bbname = "bb_" + int_to_str(idx);
	      (*iter).setName(bbname);
	    }

	  idx++;
	}

    

      // BFS to figure out predecessors of a block, since there
      // appears to be (?) no way of getting them from llvm.
      std::set<BasicBlock*> blocks_queued;
      std::list<BasicBlock*> queue;
    

      queue.push_back(&(F.getEntryBlock()));
      blocks_queued.insert(&(F.getEntryBlock()));
      int iidx = 0;

      aa_writer->_num_ret_instructions = 0;
      aa_writer->_unique_return_value  = NULL;

      while (!queue.empty()) 
	{
	  BasicBlock *bb = queue.front();
	  queue.pop_front();
	  
	  curr_block = bb;

	  aa_writer->name_all_instructions(*bb,iidx);
	  
	  TerminatorInst *T = bb->getTerminator();
	  if(T->getNumSuccessors() == 0)
	    {
	    }

	  if(isa<llvm::ReturnInst>(T))
	    {
	      aa_writer->_num_ret_instructions++;
	      if(aa_writer->_num_ret_instructions == 1)
		{
		  llvm::ReturnInst* R = dyn_cast<llvm::ReturnInst>(T);
		  aa_writer->_unique_return_value = R->getReturnValue();
		}
	      else
		aa_writer->_unique_return_value = NULL;
	    }

	  for (unsigned i = 0, e = T->getNumSuccessors(); i != e; ++i) 
	    {
	      BasicBlock *S = T->getSuccessor(i);
	      aa_writer->add_bb_predecessor_map_entry(to_aa(S->getNameStr()),to_aa(bb->getNameStr()));

	      if (blocks_queued.count(S) != 0)
		continue;

	      queue.push_back(S);
	      blocks_queued.insert(S);
	    }
	}


      if(aa_writer->_unique_return_value != NULL)
	{
	  std::string iname = "ret_val__";
	  aa_writer->_unique_return_value->setName(iname);
	}


      std::cout << "$module [" << to_aa(fname) << "] " << std::endl;
      

      std::cout << " $in (";
      for(Function::arg_iterator args = F.arg_begin(), Eargs = F.arg_end();
	  args != Eargs;
	  ++args)
	{
	  
	  std::cout << to_aa((*args).getNameStr()) << " : "
		    << get_aa_type_name((*args).getType(), aa_writer->Get_Module()) << " ";
	}

	std::cout << ")" << std::endl;
	std::cout << " $out (";
	const llvm::Type* ret_type = F.getReturnType();
	bool has_ret_val = true;
	if(ret_type->isVoidTy())
	  has_ret_val = false;

	if(has_ret_val)
	   std::cout << "ret_val__ : " << get_aa_type_name(ret_type, aa_writer->Get_Module());
	std::cout << ")" << std::endl;

	std::cout << " $is " << std::endl<< "{" << std::endl;

	if(has_ret_val && (aa_writer->_num_ret_instructions > 1))
		std::cout << "$storage stored_ret_val__ : " << get_aa_type_name(ret_type, aa_writer->Get_Module()) << std::endl;

	
	std::cout << "$branchblock [body] {"  << std::endl;

	// visit the basic blocks.. this time all instructions
	// have been named ..
	for(llvm::Function::iterator iter = F.begin(); iter != F.end(); ++iter)
	  {
	    bool v = false;
	    int pipelining_depth = 1;
	    int buffering_depth = 1;
            bool full_rate_flag = false;
	    if(_extract_do_while)
	    	v = is_do_while_loop(*iter, pipelining_depth, buffering_depth, full_rate_flag);
	    aa_writer->Set_Do_While_Flag(v);
            aa_writer->Set_Do_While_Full_Rate_Flag(full_rate_flag);
            aa_writer->Set_Do_While_Pipelining_Depth(pipelining_depth);
            aa_writer->Set_Do_While_Buffering_Depth(buffering_depth);
	    aa_writer->visit(*iter);
	    aa_writer->Set_Do_While_Flag(false);
	  }
	
	if(aa_writer->Get_Return_Flag())
	  {
	    std::cout << "$merge return__ $endmerge" << std::endl;
	    if(has_ret_val && (aa_writer->_num_ret_instructions > 1))
	      std::cout << "ret_val__ := stored_ret_val__ "  << std::endl;
	  }
	
	std::cout << "}" << std::endl;
	
	std::cout << "}" << std::endl;
	
	aa_writer->finalise_function();
    }
    
  };

  char ModuleGenPass::ID = 0;
  RegisterPass<ModuleGenPass> X("modulegen", "generates Aa description");

} // end anonymous namespace

namespace Aa {

  ModulePass* createModuleGenPass(const std::string& module_list, bool create_initializers, const std::string& pipe_depth_file,
				  const std::string& hw_target, bool extract_do_while) 
  { 
    return new ModuleGenPass(module_list, create_initializers,pipe_depth_file, hw_target, extract_do_while); 
  }
}

