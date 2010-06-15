#include <llvm/Module.h>
#include <llvm/Bitcode/ReaderWriter.h>
#include <llvm/PassManager.h>
#include <llvm/Target/TargetData.h>
#include <llvm/Support/PassNameParser.h>
#include <llvm/System/Signals.h>
#include <llvm/Support/MemoryBuffer.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/Type.h>
#include <llvm/LinkAllPasses.h>
#include <llvm/LinkAllVMCore.h>
#include <llvm/Assembly/PrintModulePass.h>

#include <llvm/Transforms/Scalar.h>
#include <llvm/Transforms/Utils/UnifyFunctionExitNodes.h>

#include <fstream>
#include <sstream>
#include <iostream>

using namespace llvm;

namespace cdfg {
  FunctionPass* createLowerConstantExprPass();
  FunctionPass* createLowerGepPass();
  ModulePass* createModuleGenPass();
}

// The OptimizationList is automatically populated with registered
// Passes by the PassNameParser.
static cl::list<const PassInfo*, bool,PassNameParser>
OptimizationList(cl::desc("Optimizations available:"));

static cl::opt<std::string>
InputFilename(cl::Positional, cl::desc("<input bytecode>"));

// static cl::opt<bool>
// Force("f", cl::desc("Overwrite output files"));

int main(int argc, char **argv)
{
  try {
    cl::ParseCommandLineOptions(argc, argv,
                                " AHIR .bc -> .xml backend for LLVM\n");
    sys::PrintStackTraceOnErrorSignal();

    std::string ErrorMessage;

    std::auto_ptr<Module> Mp;
    if (MemoryBuffer *Buffer
          = MemoryBuffer::getFileOrSTDIN(InputFilename, &ErrorMessage)) {
      Mp.reset(ParseBitcodeFile(Buffer, getGlobalContext(), &ErrorMessage));
      delete Buffer;
    }

    if (!(Mp.get())) {
      std::cerr << argv[0] << ": ";
      if (ErrorMessage.size())
        std::cerr << ErrorMessage << "\n";
      else
        std::cerr << "bytecode didn't read correctly.\n";
      return 1;
    }

    Module &M = *Mp.get();
    const std::string &ModuleName = M.getModuleIdentifier();

    PassManager Passes;
    Passes.add(new TargetData("e-p:16:16"));

    std::string OrigFileName = ModuleName + ".txt";
    std::ofstream OrigFile(OrigFileName.c_str());
    raw_os_ostream RawOut(OrigFile);

    // Create a new optimization pass for each one specified on the command line
    for (unsigned i = 0; i < OptimizationList.size(); ++i) {
      const PassInfo *Opt = OptimizationList[i];
      
      if (Opt->getNormalCtor())
        Passes.add(Opt->getNormalCtor()());
      else
        std::cerr << argv[0] << ": cannot create pass: " << Opt->getPassName()
                  << "\n";
    }

    Passes.add(cdfg::createLowerConstantExprPass());
    Passes.add(cdfg::createLowerGepPass());
    Passes.add(createReassociatePass());
    Passes.add(createConstantPropagationPass());
    Passes.add(createDeadCodeEliminationPass());
    Passes.add(createCFGSimplificationPass());
    Passes.add(createUnifyFunctionExitNodesPass());
    Passes.add(createPrintModulePass(&RawOut));

    Passes.add(cdfg::createModuleGenPass());

    Passes.run(M);
    return 0;
  } catch (const std::string& msg) {
    std::cerr << argv[0] << ": " << msg << "\n";
  } catch (...) {
    std::cerr << argv[0] << ": Unexpected unknown exception occurred.\n";
  }

  return 1;
}

