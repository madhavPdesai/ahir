
SRC := alu.c
BC := $(SRC:.c=.bc)

vhdl:  opt.bc.ahir_shared.xml
	rm -f *.vhdl
	~/AHIR/toolset/tools/ahir2vhdl/ahir2vhdl $<

reuse:	opt.bc.ahir_shared.xml

opt.bc.ahir_shared.xml : opt.bc.linked_ahir.xml
	~/AHIR/toolset/tools/analyse-ahir/analyse-ahir --reuse $<

link : opt.bc.linked_ahir.xml

opt.bc.linked_ahir.xml : opt.bc.ahir.xml
	rm -f opt.bc.linked_ahir.xml
	~/AHIR/toolset/tools/link-ahir/link-ahir $<

ahir : opt.bc.ahir.xml

opt.bc.ahir.xml : opt.bc.cdfg.xml
	rm -f opt.bc.ahir.xml
	~/AHIR/toolset/tools/cdfg2ahir/cdfg2ahir $<

cdfg : opt.bc.cdfg.xml

opt.bc.cdfg.xml : opt.bc
	rm -f opt.bc.cdfg.xml
	~/AHIR/toolset/tools/llvm2cdfg/llvm2cdfg $<

llvm : opt.bc

opt.bc : $(SRC)
	rm -f $(BC)
	llvmc -emit-llvm -c $(SRC) -o $(BC)
	rm -f opt.bc
	opt -std-compile-opts -lowerswitch -disable-inlining $(BC) -o opt.bc
