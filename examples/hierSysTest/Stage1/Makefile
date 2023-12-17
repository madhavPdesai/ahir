TOPMODULES=-T stage_1_daemon 
AA2CPREFIX=S1_
AA2C_C_FILE=$(AA2CPREFIX)aa_c_model.c

all: cmodel vhdlmodel

cmodel: stage1.aa pipes.aa
	rm -rf aa2c
	mkdir aa2c
	Aa2C -I dummy_mempool  -o aa2c -P $(AA2CPREFIX) $(TOPMODULES) pipes.aa stage1.aa
	indent aa2c/$(AA2C_C_FILE)
          
vhdlmodel: stage1.aa pipes.aa
	buildFromSources.py -a Stage1 -W S1 -E to_vhdl $(TOPMODULES) -A pipes.aa -A stage1.aa


clean:
	rm -rf vhdl/* aa2c/*


PHONY: all clean
