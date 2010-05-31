#include "CDFGBuilder.hpp" 
#include "MemoryAccess.hpp"

#include "Utils.hpp"

#include <Base/Program.hpp>
#include <Base/Addressable.hpp>
#include <Base/Values.hpp>
#include <CDFG/Utils.hpp>

#include <llvm/Constants.h>
#include <llvm/Function.h>
#include <llvm/Target/TargetData.h>

#include <boost/lexical_cast.hpp>

#include <iostream>
#include <deque>

using namespace cdfg;
using namespace llvm;
using namespace hls;

namespace llvm {
  class AliasAnalysis;
}

namespace cdfg {

  CDFGBuilder::CDFGBuilder(llvm::TargetData *_TD, llvm::AliasAnalysis *_AA)
    : TD(_TD), AA(new AccessAnalysis(_AA, TD, this))
    , program(NULL)
  {}

  void CDFGBuilder::create_program(const std::string &id)
  {
    program = new Program(id);
  }

  void CDFGBuilder::create_addressable(llvm::GlobalVariable &G)
  {
    const llvm::Type *ptr = G.getType();
    const SequentialType *st = dyn_cast<SequentialType>(ptr);
    assert(st && "super class of array and pointer types");

    const llvm::Type *etype = st->getElementType();

    Addressable *addr = new Addressable(G.getNameStr()
                                        , getTypeName(etype)
                                        , getTypePaddedSize(TD, etype));

    if (G.hasInitializer()) {
      llvm::Constant *init = G.getInitializer();
      addr->value = getAddressableValue(init, program, TD);
    }

    program->register_addressable(addr);
  }

  void CDFGBuilder::visitInstruction(llvm::Instruction &I)
  {
    assert(!isa<llvm::GetElementPtrInst>(&I) && "GEP should not reach here");
    assert(false && "unsupported instruction");
  }
}

namespace {

  struct BBNode
  {
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
  
  struct CDFGBuilderImpl : public CDFGBuilder
  {

    CDFG *cdfg;
    llvm::BasicBlock *bb;
    BBNode *bbnode;

    unsigned constant_id;
    unsigned store_count;

    typedef std::map<llvm::BasicBlock*, BBNode*> BBMap;
    BBMap blocks;
    
    typedef std::map<llvm::Value*, CDFGNode*> NodeMap;
    NodeMap nodes;

    typedef std::map<CDFGNode*, CDFGNode*> ForkMap;
    ForkMap forks;
    
    typedef std::map<CDFGNode*, CDFGNode*> JoinMap;
    JoinMap joins;

    std::map<llvm::Value*, std::vector<Port*> > pendingUsers;
    std::map<std::string, CDFGNode*> io_history;
    
    /* ---- Initialisation ---- */
    
    CDFGBuilderImpl(llvm::TargetData *_TD, llvm::AliasAnalysis *_AA)
      : CDFGBuilder(_TD, _AA)
    {
      clear();
    };

    void clear()
    {
      cdfg = NULL;
      bb = NULL;
      bbnode = NULL;
      nodes.clear();
      forks.clear();
      joins.clear();
      constant_id = 0;
      store_count = 0;
    }

    CDFGNode* create_acceptor_node(llvm::Function &F)
    {
      CDFGNode *node = create_data_node(Accept, NULL, "incoming call");

      unsigned argno = 0;
      for (llvm::Function::arg_iterator ai = F.arg_begin(), ae = F.arg_end();
           ai != ae; ++ai) {
        Argument &arg = *ai;
        std::ostringstream id;
        id << "arg" << argno++;
        create_output_data_port(node, id.str(), arg.getType());
        register_node(arg, node);
      }

      return node;
    }

    void initialise_with_function(llvm::Function &F)
    {
      hls::Module *f = program->find_module(F.getName());
      assert(is_cdfg(f));
      cdfg = static_cast<CDFG*>(f);
  
      for (llvm::Function::iterator bi = F.begin(), be = F.end(); bi != be; ++bi) {
        BasicBlock &bb = *bi;
        create_bbnode(bb);
      }

      cdfg->start = create_node(Start, "cdfg_start");
      cdfg->stop = create_node(Stop, "cdfg_stop");
      cdfg->acceptor = create_acceptor_node(F);
  
      BBNode *start = blocks[&F.getEntryBlock()];
      control_flow(cdfg->start, "ack", cdfg->acceptor, "req");
      control_flow(cdfg->acceptor, "ack", start->entry, "req");
    }

    void finalise_function()
    {
      check_wellformedness(cdfg);
      remove_redundant_nodes(cdfg);
      check_wellformedness(cdfg);
      clear();
    }


    void create_cdfg(llvm::Function &F)
    {
      assert(!F.isDeclaration() && "external functions not supported");
    
      const llvm::FunctionType *ftype = F.getFunctionType();
      assert(!ftype->isVarArg() && "variable arguments not supported");
    
      CDFG *cdfg = new CDFG(F.getName());
      program->modules[cdfg->id] = cdfg;

      if (cdfg->id == "start") {
        assert(!program->start && "start function already defined");
        program->start = cdfg;
      }
    }

    /* ----- Visitor functions ----- */

    void visitBasicBlock(BasicBlock &BB)
    {
      set_bb(BB);
      AA->clear();
      io_history.clear();

      TerminatorInst *term = BB.getTerminator();
      if (!isa<BranchInst>(term))
        return;

      BranchInst *br = cast<BranchInst>(term);

      unsigned default_index = (br->isConditional() ? 1 : 0);
      BasicBlock *default_target = br->getSuccessor(default_index);
      connect_to_block(bbnode->exit, default_target, "ack0");
  
      if (br->isConditional()) {
        BasicBlock *taken_target = br->getSuccessor(0);
        connect_to_block(bbnode->exit, taken_target, "ack1");
      }
    }

    void visitBinaryOperator(BinaryOperator &I)
    {
      NodeType ntype;
      unsigned opcode = I.getOpcode();

      switch (opcode) {

#define HANDLE_BINARY(op) case Instruction::op :        \
        ntype = op;                                     \
        break;
#define HANDLE_REL(name) 
#include <Base/NodeType.inc>
    
        default :
          assert(false && "instruction not supported");
          break;
      }
  
      CDFGNode *node = create_data_node(ntype, I.getType(), I.getNameStr());
      register_node(I, node);
  
      bool local_opnd = false;
      local_opnd |= handleOperand(node, I.getOperand(0), "x");
      local_opnd |= handleOperand(node, I.getOperand(1), "y");

      if (!local_opnd) {
        connect_entry_to_node(node);
      }

      AA->handleGenericInstruction(&I);

      connect_to_exit(node, I);
    }

    void visitReturnInst(ReturnInst &R)
    {
      CDFGNode *node = create_node(Return, R.getName());

      llvm::Value *retval = R.getReturnValue();
      if (retval)
        handleOperand(node, retval, "retval");
  
      handle_terminator_inst();
  
      assert(!cdfg->retval);
      cdfg->retval = node;

      control_flow(bbnode->join, "ack", node, "req");
      control_flow(node, "ack", bbnode->exit);
      control_flow(bbnode->exit, "ack", cdfg->stop);
    }
  
    void visitAllocaInst(AllocaInst &I)
    {
      Addressable *addr = create_addressable(I);
      CDFGNode *an = create_data_node(Address
                                      , llvm::IntegerType::get(I.getContext()
                                                               , TD->getPointerSizeInBits())
                                      , I.getNameStr());
      register_node(I, an);
      addr->register_address(cdfg->id, an->id);
      an->addressable = addr;
    }

    void phi_connect_input(CDFGNode *mux
                           , const std::string &phi_name
                           , llvm::Value *inval
                           , const std::string& data_port_id
                           , BasicBlock *inbb
                           , const std::string& control_port_id)
    {
      Port *input = create_input_data_port(mux, data_port_id, inval->getType());
      Port *select = create_input_control_port(mux, control_port_id);
    
      CDFGNode *indpe = get_node(inval);
      BBNode *innode = get_bbnode(inbb);
  
      if (!indpe) {
        register_pending_user(inval, input);
      } else {
        Port *value = get_output_data_port(indpe, inval);
        connect_ports(value, input);
      }
    
      // Create control-flow from the BB that contains the current
      // incoming value
      CDFGNode *infork;
      if (innode->phi_forks.find(bb) != innode->phi_forks.end())
        infork = innode->phi_forks[bb];
      else {
        infork = create_node(Fork, innode->id + ": phi_fork for " + phi_name);
        innode->phi_forks[bb] = infork;
      }
      control_flow(infork, phi_name, select);
    }

    void visitPHINode(PHINode &P)
    {
      std::string phi_name = P.getName();
    
      CDFGNode *retval = NULL;
    
      // we build the tree of multilexers from the last to first, so that
      // the final multiplexer has the first two phi arguments as inputs. 

      // mux created for the (i-1)th value.
      CDFGNode *prev_mux = NULL;
    
      for (unsigned i = P.getNumIncomingValues() - 1; i > 0; --i) {
        llvm::Value *inval = P.getIncomingValue(i);
        BasicBlock *inbb = P.getIncomingBlock(i);
      
        CDFGNode *mux = create_data_node(Multiplexer, P.getType(), phi_name
                                         + ": mux " + boost::lexical_cast<std::string>(i));

        phi_connect_input(mux, phi_name, inval, "x", inbb, "reqx");
      
        if (prev_mux) {
          // connect output to the input1 of the previous multiplexer
          Port *input1 = create_input_data_port(prev_mux, "y", P.getType());
          Port *select1 = create_input_control_port(prev_mux, "reqy");

          Port *value = get_output_data_port(mux, NULL);
          connect_ports(value, input1);
          control_flow(mux, "ack", select1);
        } else {
          // Current mux is the "output" mux that provides the value of
          // the entire PHI instruction. This is the first to be created
          // in the mux tree

          register_node(P, mux);
          retval = mux;

          control_flow(mux, "ack", bbnode->entry);
        }
      
        prev_mux = mux;
      }
    
      // The first incoming value. No new mux is created.
      llvm::Value *fval = P.getIncomingValue(0);
      BasicBlock *fbb = P.getIncomingBlock(0);

      phi_connect_input(prev_mux, phi_name, fval, "y", fbb, "reqy");
    }

    void handle_io_port(CallInst &C, IOCode ioc)
    {
      const llvm::Type *type = NULL;
      NodeType ntype = hls::Constant; // sentinel

      switch (ioc) {
        case READ_FLOAT32:
          type = llvm::Type::getFloatTy(C.getContext());
          ntype = Input;
          break;

        case READ_UINT32:
          type = llvm::Type::getInt32Ty(C.getContext());
          ntype = Input;
          break;

        case WRITE_FLOAT32:
          type = llvm::Type::getFloatTy(C.getContext());
          ntype = Output;
          break;

        case WRITE_UINT32:
          type = llvm::Type::getInt32Ty(C.getContext());
          ntype = Output;
          break;

        default:
          assert(false);
          break;
      }

      assert(type && ntype != hls::Constant);

      llvm::ConstantArray *konst = cast<ConstantArray>(C.getOperand(1));
      CDFGNode *node = create_data_node(ntype, type
                                        , C.getCalledFunction()->getNameStr()
                                        + ":" + konst->getAsString());
      node->portname = konst->getAsString();

      if (ntype == Output) {
        if (!handleOperand(node, C.getOperand(2), "data"))
          connect_entry_to_node(node);
      } else {
        connect_entry_to_node(node);
      }

      register_node(C, node);
      connect_to_exit(node, C);

      if (io_history.find(node->portname) != io_history.end()) {
        CDFGNode *prev = io_history[node->portname];
        assert(prev->ntype == node->ntype);
        control_flow(prev, node);
      }
      io_history[node->portname] = node;
    }

    void visitCallInst(CallInst &C)
    {
      IOCode ioc = get_io_code(C);
      if (ioc != NOT_IO) {
        handle_io_port(C, ioc);
        return;
      }

      llvm::Function *f = C.getCalledFunction();
      assert(f && "function pointers are not currently supported");

      CDFGNode *call = create_data_node(Call, NULL, C.getName());
      call->callee = f->getName();

      CDFGNode *response = create_data_node(Response, C.getType(), C.getName());
      call->counterpart = response;
      response->counterpart = call;
  
      register_node(C, response);
    
      bool internalFlow = false;
      for (unsigned i = 0, e = C.getNumOperands() - 1; i != e; ++i) {
        llvm::Value *val = C.getOperand(i + 1);
        std::ostringstream port_id;
        port_id << "arg" << i;
        internalFlow |= handleOperand(call, val, port_id.str());
      }

      CDFGNode *fork = forks[call];
      CDFGNode *join = joins[response];
      assert(fork && join);
      control_flow(fork, join);
  
      connect_to_exit(NULL, C); // the NULL indicates that this is not an I/O operation.

      AA->handleCallInst(&C, !internalFlow);
    }

    NodeType getAppropriateCast(CastInst &C)
    {
      const llvm::Type *dest = C.getDestTy();
      llvm::Value *val = C.getOperand(0);
      Instruction::CastOps op = C.getOpcode();
      NodeType ntype;
      const IntegerType *ptr_type = TD->getIntPtrType(C.getContext());
  
      // replace typed pointers with the generic int address
      switch (op) {
        case Instruction::IntToPtr:
          op = CastInst::getCastOpcode(val, false, ptr_type, false);
          break;
        case Instruction::PtrToInt: {
          llvm::Constant *cst = ConstantInt::get(ptr_type, 0, false);
          op = CastInst::getCastOpcode(cst, false, dest, false);
          break;
        }
        default:
          break;
      }

      assert(op != Instruction::BitCast);

      switch (op) {
#define HANDLE_CAST(name) case Instruction::name:       \
        ntype = name;                                   \
        break; 
#include <Base/NodeType.inc>

        default:
          assert(false);
          break;
      }

      return ntype;
    }

    void visitCastInst(CastInst& C)
    {
      const llvm::Type *dest = C.getDestTy();
      llvm::Value *val = C.getOperand(0);

      CDFGNode *node = NULL;
      if (C.isNoopCast(TD->getIntPtrType(C.getContext()))) {
        node = get_node(val);
        register_node(C, node);
      } else {
        NodeType ntype = getAppropriateCast(C);
        node = create_data_node(ntype, dest, C.getNameStr());
        register_node(C, node);

        if (!handleOperand(node, val, "x"))
          connect_entry_to_node(node);
    
        connect_to_exit(node, C);
      }

      AA->handleGenericInstruction(&C);
    }


    // Note that we do not connect a load or a store to the entry or exit. 
    // This is handled by a later pass that uses AliasAnalysis to
    // determine external dependences.

    void visitLoadInst(LoadInst &L)
    {
      CDFGNode *lr = create_data_node(LoadRequest, NULL, L.getNameStr());
      CDFGNode *lc = create_data_node(LoadComplete, L.getType(), L.getNameStr());
      lr->counterpart = lc;
      lc->counterpart = lr;

      CDFGNode *fork = forks[lr];
      CDFGNode *join = joins[lc];
      assert(fork && join);
      control_flow(fork, join);

      register_node(L, lc);
      connect_to_exit(lc, L);

      handleOperand(lr, L.getPointerOperand(), "addr");

      AA->handleLoadStore(&L);
    }

    void visitStoreInst(StoreInst &S)
    {
      CDFGNode *node = create_data_node(Store, NULL, "store "
                                        + boost::lexical_cast<std::string>(store_count++));
      register_node(S, node);

      handleOperand(node, S.getOperand(0), "data");
      handleOperand(node, S.getOperand(1), "addr");

      AA->handleLoadStore(&S);
    }

    void visitCmpInst(CmpInst &C)
    {
      AA->handleGenericInstruction(&C);

      NodeType ntype;
  
      switch (C.getPredicate()) {
#define HANDLE_REL(name)  case CmpInst::name:	\
        ntype = name;				\
        break;
#include <Base/NodeType.inc>
    
        default :
          assert(false && "unsupported comparison");
          break;
      }
  
      CDFGNode *node = create_data_node(ntype, C.getType(), C.getNameStr());
      register_node(C, node);
      connect_to_exit(node, C);

      bool local_opnd = false;
      local_opnd |= handleOperand(node, C.getOperand(0), "x");
      local_opnd |= handleOperand(node, C.getOperand(1), "y");

      if (!local_opnd) {
        connect_entry_to_node(node);
      }
    }

    void visitSelectInst(SelectInst &S)
    {
      CDFGNode *node = create_data_node(Select, S.getType(), S.getNameStr());
      register_node(S, node);
      connect_to_exit(node, S);

      bool local_opnd = false;
      local_opnd |= handleOperand(node, S.getCondition(), "sel");
      local_opnd |= handleOperand(node, S.getTrueValue(), "x");
      local_opnd |= handleOperand(node, S.getFalseValue(), "y");

      if (!local_opnd)
        connect_entry_to_node(node);

      AA->handleGenericInstruction(&S);
    }

    void handle_terminator_inst()
    {
      if (bbnode->fork->output_control_ports.size() == 0) {
        assert(bbnode->join->input_control_ports.size() == 0);
        control_flow(bbnode->fork, bbnode->join);
      }
  
      AA->handleTerminatorInst();
    }

    void visitBranchInst(BranchInst &br)
    {
      CDFGNode *node = bbnode->exit;

      if (br.isConditional()) {
        llvm::Value *condition = br.getCondition();

        handleOperand(node, condition, "condition");
      }

      handle_terminator_inst();
    }

    // basic blocks

    BBNode* create_bbnode(BasicBlock &bb)
    {
      const std::string id = bb.getName();

      BBNode *bbnode = new BBNode(id);
      bbnode->bb = &bb;

      const std::string exit_name = bbnode->id + ": entry";
      if (!isa<PHINode>(bb.begin())) {
        bbnode->entry = create_node(Merge, exit_name);
      } else {
        bbnode->entry = create_node(Join, exit_name);
      }

      bbnode->fork = create_node(Fork, bbnode->id + ": fork");
      control_flow(bbnode->entry, "ack", bbnode->fork, "req");
      forks[bbnode->entry] = bbnode->fork;
  
      bbnode->join = create_node(Join, bbnode->id + ": join");
      bbnode->exit = create_node(Branch, bbnode->id + ": exit");

      TerminatorInst *term = bb.getTerminator();
      if (!isa<ReturnInst>(term))
        control_flow(bbnode->join, "ack", bbnode->exit, "req");
      joins[bbnode->exit] = bbnode->join;
  
      register_bbnode(bb, bbnode);
      return bbnode;
    }

    void set_bb(BasicBlock &BB)
    {
      bb = &BB;
      bbnode = get_bbnode(BB);
    }

    void register_bbnode(BasicBlock &BB, BBNode *bbnode)
    {
      assert(blocks.find(&BB) == blocks.end()
             && "BBNode already exists");
      blocks[&BB] = bbnode;
    }

    BBNode* get_bbnode(BasicBlock &BB) 
    {
      return get_bbnode(&BB);
    } 

    BBNode* get_bbnode(BasicBlock *BB)
    {
      assert(blocks.find(BB) != blocks.end()
             && "BBNode does not exist");
      return blocks[BB];
    }

    // generic nodes

    void register_node(llvm::Value *val
                       , CDFGNode *node)
    {
      register_node(*val, node);
    }

    void register_node(llvm::Value &val
                       , CDFGNode *node)
    {
      assert(nodes.find(&val) == nodes.end()
             && "node already present");
      nodes[&val] = node;

      if (isa<StoreInst>(val)
          || isa<AllocaInst>(val)
          || isa<Argument>(val)
          || val.getType()->getTypeID() == llvm::Type::VoidTyID) {
        assert(pendingUsers.find(&val) == pendingUsers.end() && "uh oh!");
      } else 
        clear_pending_users(val, node);
    }

    CDFGNode* get_node(llvm::Value &val)
    {
      return get_node(&val);
    }

    CDFGNode* get_node(llvm::Value *val)
    {
      if (!val)
        return NULL;
  
      if (nodes.find(val) != nodes.end())
        return nodes[val];

      llvm::Constant *konst = dyn_cast<llvm::Constant>(val);
      if (!konst)
        return NULL;

      std::ostringstream id;

      if (llvm::GlobalVariable *G = dyn_cast<llvm::GlobalVariable>(konst)) {
        CDFGNode *an = create_data_node(Address
                                        , llvm::IntegerType::get(G->getContext()
                                                                 , TD->getPointerSizeInBits())
                                        , G->getNameStr());
        register_node(G, an);
        Addressable *g = program->find_addressable(G->getNameStr());
        assert(g);
        g->register_address(cdfg->id, an->id);
        an->addressable = g;

        return an;
      } else {
        CDFGNode *node = create_data_node(hls::Constant, konst->getType(), ""); 
  
        node->value = getValue(konst);
        register_node(konst, node);
        return node;
      }
    }

    // ports

    void create_edge(Port *port)
    {
      std::ostringstream eid;
      eid << "edge_" << cdfg->edges.size();
      assert(is_output(port));
      assert(!port->edge);
      port->edge = new CDFGEdge(eid.str());
      port->edge->driver = port;
      cdfg->register_edge(port->edge);
    }

    Port* create_output_data_port(CDFGNode *node
                                  , const std::string &id
                                  , const llvm::Type *type)
    {
      Port *port = new Port(id, OUT, Port::Data);
      port->type = get_type(program, TD, type);
    
      node->register_output_data_port(port);
      create_edge(port);
      return port;
    }
  
    Port* create_input_data_port(CDFGNode *node
                                 , const std::string &id
                                 , const llvm::Type *type)
    {
      Port *port = new Port(id, IN, Port::Data);
      port->type = get_type(program, TD, type);
    
      node->register_input_data_port(port);
      return port;
    }
  
    Port* create_output_control_port(CDFGNode *node
                                     , const std::string &id)
    {
      Port *port = new Port(id, OUT, Port::Control);

      node->register_output_control_port(port);
      create_edge(port);
      return port;
    }
  
    Port* create_input_control_port(CDFGNode *node
                                    , const std::string &id)
    {
      Port *port = new Port(id, IN, Port::Control);

      node->register_input_control_port(port);
      return port;
    }

    // specific nodes

    CDFGNode* create_node(NodeType t, const std::string &d)
    {
      CDFGNode *retval = new CDFGNode(cdfg->nodes.size() + 1, t, d);
      cdfg->register_node(retval);

      if (retval->description.size() == 0)
        retval->description = hls::str(t) + "_"
          + boost::lexical_cast<std::string>(retval->id);
      return retval;
    }

    CDFGNode* create_data_node(NodeType t
                               , const llvm::Type *type
                               , const std::string &d)
    {
      CDFGNode *node = create_node(t, d);
      initialise_control_flow(node);

      const std::string outd = (t == LoadComplete ? "data" : "z");

      if (type && type->getTypeID() != llvm::Type::VoidTyID)
        create_output_data_port(node, outd, type);

      return node;
    }

    Addressable* create_addressable(AllocaInst &I)
    {
      // An Alloca always allocates an array, which may be of size 1 for
      // a single element.

      std::ostringstream id;
      id << cdfg->id << "_" << I.getNameStr();
  
      assert(isa<llvm::Constant>(I.getArraySize())
             && "expecting only constants for size in alloca");
  
      llvm::Value *konst = I.getArraySize();
      uint64_t size = cast<ConstantInt>(konst)->getValue().getZExtValue();
  
      const llvm::Type *etype = I.getAllocatedType();
      size *= getTypePaddedSize(TD, etype);
  
      Addressable *addr = new Addressable(id.str(), getTypeName(etype), size);
      program->register_addressable(addr);
  
      return addr;
    }

    Port* get_output_data_port(CDFGNode *vnode, llvm::Value *val)
    {
      Port *vport = NULL;
      switch (vnode->ntype) {
        case Accept: {
          assert(val);
          while (isa<CastInst>(val)) {
            Instruction *I = cast<CastInst>(val);
            val = I->getOperand(0);
          }
  
          Argument *arg = cast<Argument>(val);
          unsigned id = arg->getArgNo();
          std::ostringstream pid;
          pid << "arg" << id;
          vport = vnode->find_output_data_port(pid.str());
          break;
        }

        case LoadComplete:
          vport = vnode->find_output_data_port("data");
          break;

        default:
          vport = vnode->find_output_data_port("z");
          break;
      }
  
      assert(vport);
      return vport;
    }

    bool handleOperand(CDFGNode *node
                       , llvm::Value *val
                       , const std::string &port_id)
    {
      Port *port = create_input_data_port(node, port_id, val->getType());
  
      CDFGNode *vnode = get_node(val);

      if (!vnode) {
        register_pending_user(val, port);
        return false;
      }

      Port *vport = get_output_data_port(vnode, val);
      connect_ports(vport, port);

      if (node->ntype == Return)
        return false;

      if (has_no_local_control(vnode))
        return false;
  
      Instruction *inst = dyn_cast<Instruction>(val);
      assert(inst);
      if (inst->getParent() != bb)
        return false;

      CDFGNode *join = joins[node];
      CDFGNode *fork = forks[vnode];
      assert(join && fork && "missing control nodes");
      control_flow(fork, join, port_id);

      return true;
    }

    void connect_to_exit(Instruction *I)
    {
      CDFGNode *node = get_node(I);
      connect_to_exit(node, *I);
    }

    void connect_to_exit(CDFGNode *node, Instruction &I)
    {
      bool connect_exit = true;
      std::deque<Instruction*> queue;
  
      for (llvm::Value::use_iterator ui = I.use_begin(), ue = I.use_end();
           ui != ue; ++ui) {
        User *user = *ui;
        Instruction *u = cast<Instruction>(user);
        queue.push_back(u);
      }

      while (!queue.empty()) {
        Instruction *u = queue.front();
        queue.pop_front();

        if (u->getParent() != bb)
          continue;

        if (isa<ReturnInst>(u))
          continue;
    
        if (CastInst *C = dyn_cast<CastInst>(u)) {
          if (C->isNoopCast(TD->getIntPtrType(I.getContext()))) {
            for (llvm::Value::use_iterator ui = C->use_begin(), ue = C->use_end();
                 ui != ue; ++ui) {
              User *user = *ui;
              Instruction *u = cast<Instruction>(user);
              queue.push_back(u);
            }
	
            continue;
          }
        }

        if (!isa<PHINode>(u)) {
          connect_exit = false;
          break;
        }
      }

      if (isa<CallInst>(I) && !node) {
        AA->path_to_exit = !connect_exit;
      } else if (connect_exit) {
        assert(forks.find(node) != forks.end()
               && "control node missing");
        control_flow(forks[node], bbnode->join);
      }
    }

    void register_pending_user(llvm::Value *val, Port *port)
    {
      assert(!isa<AllocaInst>(val) && "uh oh!");
      assert(!isa<llvm::GlobalVariable>(val));
      assert(!isa<Argument>(val));
      pendingUsers[val].push_back(port);
    }

    void clear_pending_users(llvm::Value &val, CDFGNode *node)
    {
      Port *driver = get_output_data_port(node, &val);
  
      typedef std::vector<Port*> PList;
      PList &users = pendingUsers[&val];

      for (PList::iterator ui = users.begin(), ue = users.end();
           ui != ue; ++ui) {
        Port *user = *ui;

        connect_ports(driver, user);
      }

      pendingUsers.erase(&val);
    }

    void create_pred_join(CDFGNode *node)
    {
      Port *inc = create_input_control_port(node, "req");
      std::ostringstream jd;
      jd << "join for " << node->description;
      CDFGNode *pred = create_node(Join, jd.str());
      control_flow(pred, "ack", inc);
      joins[node] = pred;
    }

    void initialise_control_flow(CDFGNode *node)
    {
      if (has_no_local_control(node)) {
        return;
      }

      create_pred_join(node);
      create_succ_fork(node);
    }

    void create_succ_fork(CDFGNode *node)
    {
      Port *outc = create_output_control_port(node, "ack");
      std::ostringstream fd;
      fd << "fork for " << node->id << "(" << str(node->ntype)
         << ": " << node->description << ")";
      CDFGNode *succ = create_node(Fork, fd.str());
      control_flow(outc, succ, "req");
      forks[node] = succ;
    }

    void connect_entry_to_node(CDFGNode *node)
    {
      CDFGNode *join = joins[node];
      control_flow(bbnode->fork, boost::lexical_cast<std::string>(join->id), join);
    }

    // warning: This function is only meant for connecting Load/Store
    // instructions using AliasAnalysis. Note the special treatment of
    // counterparts --- we are only interested in the correct sequencing
    // of Load/Store requests, and not their completion.
    void control_flow(llvm::Instruction *pred, llvm::Instruction *succ)
    {
      CDFGNode *pnode = get_node(pred);
      CDFGNode *snode = get_node(succ);

      // Since this function is used only by AliasAnalysis to enforce
      // control flow accross Load/Stores, any control flow on the Load
      // instruction should be connected to the LR.
      // 
      // When a CallInst is passed as the succ, we use the corresponding
      // Call node and not the Response node returned by get_node().
  
      if (pnode && pnode->ntype == LoadComplete)
        pnode = pnode->counterpart;
  
      if (snode)
        switch (snode->ntype) {
          case LoadComplete:
          case Response:
            snode = snode->counterpart;
            break;

          default:
            break;
        }
  
      if (!pnode && snode) {
        // There is no predecessor, hence we connect the snode to the
        // entry of the block.
        connect_entry_to_node(snode);
        return;
      }

      if (pnode && !snode) {
        // There is no successor, hence we connect the pnode to the exit
        // of the block.
        control_flow(forks[pnode], bbnode->join);
        return;
      }

      assert(pnode && snode && "expecting both nodes here");

      CDFGNode *join = joins[snode];
      CDFGNode *fork = forks[pnode];
      assert(join && fork && "missing control nodes");
      control_flow(fork, join);
    }

    void control_flow(CDFGNode *src
                      , const std::string &port_at_src
                      , CDFGNode *dst
                      , const std::string &port_at_dst)
    {
      Port *src_port = create_output_control_port(src, port_at_src);
      Port *dst_port = create_input_control_port(dst, port_at_dst);
      connect_ports(src_port, dst_port);
    }

    void control_flow(CDFGNode *src, CDFGNode *dst)
    {
      control_flow(src, boost::lexical_cast<std::string>(dst->id)
                   , dst, boost::lexical_cast<std::string>(src->id));
    }

    void control_flow(CDFGNode *src
                      , const std::string &port_at_src
                      , CDFGNode *dst)
    {
      control_flow(src, port_at_src, dst, boost::lexical_cast<std::string>(src->id));
    }

    void control_flow(CDFGNode *src
                      , CDFGNode *dst
                      , const std::string &port_at_dst)
    {
      control_flow(src, boost::lexical_cast<std::string>(dst->id), dst, port_at_dst);
    }

    void control_flow(CDFGNode *src
                      , const std::string &port_at_src
                      , Port *dst)
    {
      Port *outc = create_output_control_port(src, port_at_src);
      connect_ports(outc, dst);
    }

    void control_flow(Port *src
                      , CDFGNode *dst
                      , const std::string &port_at_dst)
    {
      Port *inc = create_input_control_port(dst, port_at_dst);
      connect_ports(src, inc);
    }

    void connect_ports(Port *src, Port *dst)
    {
      assert(src->port_type == dst->port_type);
      CDFGEdge *edge = src->edge;
      assert(edge);
      if (is_control(src)) {
        assert(edge->users.size() == 0 && "a control edge has only one load");
      }
  
      edge->users.insert(dst);
      assert(!dst->edge && "this port is already connected to a driver");
      dst->edge = edge;
    }
  
    void connect_to_block(CDFGNode *node, BasicBlock *dest, const std::string &dest_id)
    {
      CDFGNode *dest_entry = get_bbnode(dest)->entry;

      if (PHINode *phi = dyn_cast<PHINode>(dest->begin())) {
        CDFGNode *fork;
        if (bbnode->phi_forks.find(dest) != bbnode->phi_forks.end())
          fork = bbnode->phi_forks[dest];
        else {
          fork = create_node(Fork, bbnode->id
                             + ": phi_fork for " + phi->getNameStr());
          bbnode->phi_forks[dest] = fork;
        }
        control_flow(node, dest_id, fork);
      } else {
        control_flow(node, dest_id, dest_entry);
      }
    }
  };
}

CDFGBuilder* cdfg_builder_new(llvm::TargetData *TD, llvm::AliasAnalysis *AA)
{
  return new CDFGBuilderImpl(TD, AA);
}
