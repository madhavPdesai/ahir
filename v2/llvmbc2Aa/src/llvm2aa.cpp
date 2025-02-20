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
//
// authors: Madhav Desai, Sameer Sahasrabudhe
// copyright:  Indian Institute of Technology, Bombay
//
#include <llvm/Module.h>
#include <llvm/Bitcode/ReaderWriter.h>
#include <llvm/PassManager.h>
#include <llvm/Target/TargetData.h>
#include <llvm/Support/PassNameParser.h>
#include <llvm/System/Signals.h>
#include <llvm/Support/MemoryBuffer.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/Support/raw_os_ostream.h>
#include <llvm/Type.h>
#include <llvm/LinkAllPasses.h>
#include <llvm/LinkAllVMCore.h>
#include <llvm/Assembly/PrintModulePass.h>

#include <llvm/Transforms/Scalar.h>
#include <llvm/Transforms/Utils/UnifyFunctionExitNodes.h>

#include <fstream>
#include <sstream>
#include <iostream>

bool _global_error_flag;

using namespace llvm;

namespace Aa {
  FunctionPass* createLowerConstantExprPass();
  ModulePass* createModuleGenPass(const std::string &mlist_file, bool create_initializers, const std::string &pipe_depth_file,
				  const std::string& hw_target, bool extract_do_while);
}

#include <signal.h>
void Handle_Segfault(int signal)
{
  std::cerr << "Error: in llvm2aa: segmentation fault! giving up!!" << std::endl;
  exit(-1);
}

// The OptimizationList is automatically populated with registered
// Passes by the PassNameParser.
static cl::list<const PassInfo*, bool,PassNameParser>
OptimizationList(cl::desc("Optimizations available:"));

static cl::opt<std::string>
InputFilename(cl::Positional, cl::desc("<input bytecode>"));

static cl::opt<std::string>
ModuleListFile("modules", cl::desc("A file containing a list of modules to be translated")
               , cl::value_desc("filename"));

static cl::opt<std::string>
PipeDepthFile("pipedepths", cl::desc("A file containing pipe-name pipe-depth pairs")
               , cl::value_desc("filename"));

static cl::opt<bool>
  WriteStorageInitializers("storageinit", cl::desc("set to true if you want storage initializers to be generated"));

static cl::opt<std::string>
HardwareTargetDescription("hw_target", cl::desc("the hardware target: choose one of xilinx/asic, default is xilinx")
               , cl::value_desc("hardware_target"));

static cl::opt<bool>
ExtractDoWhile("extract_do_while", cl::desc("detect do-while loops and print in generated Aa file.")
               , cl::value_desc("extract_do_while: set to true if you want do-while loops to be extracted."));

int main(int argc, char **argv)
{

  signal(SIGSEGV, Handle_Segfault);


  _global_error_flag = false;

  std::cout << "// Aa code produced by llvm2aa (version 1.0)" << std::endl;
  cl::ParseCommandLineOptions(argc, argv,
                                "llvm-to-aa .o -> .aa front-end\n");
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
    Passes.add(new TargetData("e-p:32:132-n1:2:4:8:16:32:64"));

    std::string OrigFileName = ModuleName + ".txt";
    std::ofstream OrigFile(OrigFileName.c_str());
    llvm::raw_os_ostream RawOut(OrigFile);

    // Create a new optimization pass for each one specified on the command line
    for (unsigned i = 0; i < OptimizationList.size(); ++i) {
      const PassInfo *Opt = OptimizationList[i];
      
      if (Opt->getNormalCtor())
        Passes.add(Opt->getNormalCtor()());
      else
        std::cerr << argv[0] << ": cannot create pass: " << Opt->getPassName()
                  << "\n";
    }

    // this is an important pass.. constant expressions are
    // lower to instructions.
    Passes.add(Aa::createLowerConstantExprPass());

    // not critical, but useful.
    Passes.add(createDeadCodeEliminationPass());

    // not critical, but useful.. but broken.
    // this pass is broken in llvm-2.8.  intermediate
    // basic blocks are optimized away, but their
    // dependent phi statements are incorrectly 
    // handled.
    //Passes.add(createCFGSimplificationPass());

    // not critical, useful.
    Passes.add(createUnifyFunctionExitNodesPass());

    // this produces a txt file of the transformed
    // llvm byte code (post transformations)
    Passes.add(createPrintModulePass(&RawOut));

    // the Aa generation pass.
    Pass *P = Aa::createModuleGenPass(ModuleListFile,WriteStorageInitializers,PipeDepthFile,HardwareTargetDescription,ExtractDoWhile);
    if(P != NULL)
      Passes.add(P);
    else
      {
	std::cerr << argv[0] << ": cannot create module-gen pass"<< std::endl;
	return(1);
      }

      
    if(WriteStorageInitializers)
      {
	std::cerr << "Info: -storageinit=true: storage initializers will be generated" << std::endl;
      }
    else
      {
	std::cerr << "Info: -storageinit=false: storage initializers will not be generated" << std::endl;
      }

    if(ExtractDoWhile)
      {
	std::cerr << "Info: -extract_do_while=true: storage initializers will be generated" << std::endl;
      }
    
    Passes.run(M);

    if(_global_error_flag)
	return(1);

    return 0;
}

