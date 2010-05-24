#ifndef __CDFGBUILDER_HPP__
#define __CDFGBUILDER_HPP__

#include <CDFG/CDFG.hpp>

#include <llvm/Support/InstVisitor.h>
#include <llvm/Argument.h>
#include <llvm/Instructions.h>

#include <map>
#include <vector>
#include <string>

namespace llvm {
  class Value;
  class BasicBlock;
  class Argument;
  class TargetData;
  class AliasAnalysis;
};

namespace hls {
  class Value;
  class Program;
  class Addressable;
  class Module;
};

namespace cdfg {

  class BBNode;
  class AccessAnalysis;
  
  struct BBNode {
    llvm::BasicBlock *bb;
    std::string id;
    
    CDFGNode *entry; // merge or join; phi-node
    CDFGNode *fork;
    CDFGNode *join;
    CDFGNode *exit; // branch

    std::map<llvm::BasicBlock*, CDFGNode*> phi_forks;

    BBNode(const std::string &_id)
    {
      id = _id;
    }

  };
  
  struct CDFGBuilder : public llvm::InstVisitor<CDFGBuilder> {

    CDFG *cdfg;
    llvm::BasicBlock *bb;
    BBNode *bbnode;
    llvm::TargetData *TD;
    AccessAnalysis *AA;
    hls::Program *program;

    unsigned constant_id;
    unsigned store_count;

    CDFGBuilder(llvm::TargetData *_TD, llvm::AliasAnalysis *_AA);

    void create_program(const std::string &id);
    
    void initialise_with_function(llvm::Function &F);
    void finalise_function();
    void clear();

    void create_cdfg(llvm::Function &F);
    void create_addressable(llvm::GlobalVariable &G);

    typedef std::map<llvm::BasicBlock*, BBNode*> BBMap;
    BBMap blocks;
    BBNode* create_bbnode(llvm::BasicBlock &bb);
    void register_bbnode(llvm::BasicBlock &BB, BBNode *bbnode);
    BBNode* get_bbnode(llvm::BasicBlock &BB) { return get_bbnode(&BB); };
    BBNode* get_bbnode(llvm::BasicBlock *BB);

    void visitBasicBlock(llvm::BasicBlock &BB);
    void set_bb(llvm::BasicBlock &_bb);

    void visitInstruction(llvm::Instruction &I);

    void visitBinaryOperator(llvm::BinaryOperator &I);

    void visitAllocaInst(llvm::AllocaInst &I);
    void visitArgument(llvm::Argument &A);

    void visitBranchInst(llvm::BranchInst &br);
    void visitPHINode(llvm::PHINode &phi);
    void phi_connect_input(CDFGNode *mux
			   , const std::string &phi_name
			   , llvm::Value *inval
			   , const std::string& data_port_id
			   , llvm::BasicBlock *inbb
			   , const std::string& control_port_id);

    void visitCallInst(llvm::CallInst &call);
    void visitReturnInst(llvm::ReturnInst &R);

    hls::NodeType getAppropriateCast(llvm::CastInst &C);
    void visitCastInst(llvm::CastInst& C);

    hls::NodeType getAppropriateCmp(llvm::CmpInst::Predicate P);
    void visitCmpInst(llvm::CmpInst &C);

    void visitSelectInst(llvm::SelectInst &S);
    
    void visitLoadInst(llvm::LoadInst& L);
    void visitStoreInst(llvm::StoreInst& S);
    
    bool handleOperand(CDFGNode *node
		       , llvm::Value *val
		       , const std::string &port_id);
    void connect_to_exit(llvm::Instruction *I);
    void connect_to_exit(CDFGNode *node, llvm::Instruction &I);
    void handle_terminator_inst();

    CDFGNode* create_acceptor_node(llvm::Function &F);
    Port* get_output_data_port(CDFGNode *vnode, llvm::Value *val);
      
    typedef std::map<llvm::Value*, CDFGNode*> NodeMap;
    NodeMap nodes;

    typedef std::map<CDFGNode*, CDFGNode*> ForkMap;
    ForkMap forks;
    
    typedef std::map<CDFGNode*, CDFGNode*> JoinMap;
    JoinMap joins;
    
    CDFGNode* get_node(llvm::Value &val);
    CDFGNode* get_node(llvm::Value *val);
    void register_node(llvm::Value &val, CDFGNode *node);
    void register_node(llvm::Value *val, CDFGNode *node);

    std::map<llvm::Value*, std::vector<Port*> > pendingUsers;
    void register_pending_user(llvm::Value *val, Port *port);
    void clear_pending_users(llvm::Value &val, CDFGNode *node);
    
    CDFGNode* create_data_node(hls::NodeType t
                               , const llvm::Type *type, const std::string &d);
    CDFGNode* create_node(hls::NodeType t, const std::string &d);

    void create_edge(Port *port);
    Port* create_output_data_port(CDFGNode *node
                                  , const std::string &id, const llvm::Type *type);
    Port* create_input_data_port(CDFGNode *node
                                 , const std::string &id, const llvm::Type *type);
    Port* get_data_port(CDFGNode *node, const std::string &id);
    
    Port* create_output_control_port(CDFGNode *node, const std::string &id);
    Port* create_input_control_port(CDFGNode *node, const std::string &id);
    Port* get_control_port(CDFGNode *node, const std::string &id);

    void initialise_control_flow(CDFGNode *node);    
    void create_pred_join(CDFGNode *node); 
    void create_succ_fork(CDFGNode *node);
    void connect_entry_to_node(CDFGNode *node);

    void control_flow(llvm::Instruction *pred, llvm::Instruction *succ);
    void control_flow(CDFGNode *src
		      , const std::string &port_at_src
		      , CDFGNode *dst
		      , const std::string &port_at_dst);
    void control_flow(CDFGNode *src, CDFGNode *dst);
    void control_flow(CDFGNode *src
		      , const std::string &port_at_src
		      , CDFGNode *dst);
    void control_flow(CDFGNode *src
		      , CDFGNode *dst
		      , const std::string &port_at_dst);
    void control_flow(CDFGNode *src
		      , const std::string &port_at_src
		      , Port *dst);
    void control_flow(Port *src
		      , CDFGNode *dst
		      , const std::string &port_at_dst);
    
    void connect_ports(Port *src, Port *dst);

    void connect_to_block(CDFGNode *node, llvm::BasicBlock *dest, const std::string &dest_id);
    
    hls::Addressable* create_addressable(llvm::AllocaInst &I);
    CDFGNode* create_address_node(llvm::AllocaInst &I, hls::Addressable *addr);
  };
};

#endif
