#
# Makefile for click2llvm/Modelsim testing (c) Oy L M Ericsson Ab 2011.
# modified to illustrate revised wrapper usage
#

# LLVM
LLVM_INSTALL_DIR  ?= /usr/local/
LLVM_INCL_DIR     = $(LLVM_INSTALL_DIR)/include
LLVM_LIB_DIR      = $(LLVM_INSTALL_DIR)/lib
LLVMCONFIG        = $(LLVM_INSTALL_DIR)/bin/llvm-config
CLANG             = $(LLVM_INSTALL_DIR)/bin/clang
LLC               = $(LLVM_INSTALL_DIR)/bin/llc
LLVMC             = $(LLVM_INSTALL_DIR)/bin/llvmc
LLVMAS            = $(LLVM_INSTALL_DIR)/bin/llvm-as
LLVMDIS           = $(LLVM_INSTALL_DIR)/bin/llvm-dis
LLVMLINK          = $(LLVM_INSTALL_DIR)/bin/llvm-link
LLVMGCC_INST_DIR  ?= /usr/local/llvm-gcc-hlsynth
LLVMCXX           = $(LLVMGCC_INST_DIR)/bin/llvm-g++
OPT               = $(LLVM_INSTALL_DIR)/bin/opt

# AHIRv2
AHIR2_INSTALL_DIR = $(HOME)/ahirgit/AHIR/v2
LLVM2AA           = $(AHIR2_INSTALL_DIR)/llvmbc2Aa/bin/llvm2aa
AALINKEXTMEM      = $(AHIR2_INSTALL_DIR)/Ahir-asm/devel/bin/AaLinkExtMem
AA2VC             = $(AHIR2_INSTALL_DIR)/Ahir-asm/devel/bin/Aa2VC
VC2VHDL           = $(AHIR2_INSTALL_DIR)/libAhirV2/bin/vc2vhdl
VCFORMAT          = $(AHIR2_INSTALL_DIR)/libAhirV2/bin/vcFormat
VHDLFORMAT        = $(AHIR2_INSTALL_DIR)/libAhirV2/bin/vhdlFormat

INCLUDES          = -I. -I$(AHIR2_INSTALL_DIR)/iolib -I../
INCLUDES         += -I$(AHIR2_INSTALL_DIR)/CtestBench/include 
LIBS              = -L$(AHIR2_INSTALL_DIR)/lib
LIBS             += -L$(AHIR2_INSTALL_DIR)/CtestBench/lib

CFLAGS            = -m32 -O2 -g

# note: receive_packet_pipeline and send_packet_pipeline must be marked as -T modules.
TOPMODULES  = -T wrapper_input -T wrapper_output -T receive_packet_pipeline -T send_packet_pipeline
# additional top modules.. (in this example round_robin)
TOPMODULES +=  -T round_robin

# PORTS will be of the form "-DPORT1 -DPORT3" 
PORTS = -DPORT0 -DPORT1 -DPORT2 -DPORT3

TARGETS = ahir_system.vhdl 

all: $(TARGETS)

clean:
	rm -f $(TARGETS) *_aa *_vc *_bc *.txt *.ll *.vhdl

wrapper_revised_bc: ../wrapper_revised_pipelined.c
	$(CLANG) -Werror -m32 -std=gnu89 $(INCLUDES) \
            $(PORTS) -emit-llvm -o wrapper_revised_pipelined.o -c ../wrapper_revised_pipelined.c
	$(OPT) -O3 wrapper_revised_pipelined.o > wrapper_revised_bc
	$(LLVMDIS) wrapper_revised_bc

round_robin_aa : round_robin.c
	$(CLANG) -Werror -m32 -std=gnu89 $(INCLUDES) \
            $(PORTS) -emit-llvm -o round_robin_bc -c round_robin.c
	$(LLVMDIS) round_robin_bc
	$(LLVM2AA) -storageinit=true -modules=modules.txt round_robin_bc \
            | $(VCFORMAT) > round_robin_aa

wrapper_revised_aa: wrapper_revised_bc
	$(LLVM2AA) -modules=modules.txt -pipedepths=pipedepthfile \
            wrapper_revised_bc | $(VCFORMAT) > wrapper_revised_aa

ahir_system.vhdl: round_robin_aa wrapper_revised_aa ../wrapper_lib_pipelined.aa
	$(AALINKEXTMEM) -I 1 -E mempool round_robin_aa wrapper_revised_aa ../wrapper_lib_pipelined.aa  \
            | $(VCFORMAT) > ahir_system_aa
	$(AA2VC) -I mempool -O ahir_system_aa \
            | $(VCFORMAT) > ahir_system_vc
	$(VC2VHDL) -a $(TOPMODULES) \
            -q -e ahir_system -f ahir_system_vc | $(VHDLFORMAT) > ahir_system.vhdl 

