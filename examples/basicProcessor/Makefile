ENAME := basicProcessor
SRC := $(ENAME).c
RAWBC := $(ENAME).raw.bc
OPTBC := $(ENAME).bc
CDFG := $(OPTBC).cdfg.xml
AHIRDESC := $(OPTBC).ahir.xml
LINKEDAHIRDESC := $(OPTBC).linked_ahir.xml

all: vhdl

vhdl: linked_ahir
	ahir2vhdl $(LINKEDAHIRDESC) 

linked_ahir: ahir
	link-ahir $(AHIRDESC)

ahir: cdfg 
	cdfg2ahir $(CDFG)

cdfg: llvm
	llvm2cdfg $(OPTBC)

llvm : $(SRC)
	rm -f *.bc *.ll
	llvmc -emit-llvm -c $(SRC) -o $(RAWBC)
	opt -std-compile-opts -disable-inlining $(RAWBC) -o $(OPTBC)
	llvm-dis $(OPTBC)

clean :
	rm -f *.bc *.ll *.xml *.txt *.vhdl
