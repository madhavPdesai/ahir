TOPMODULES=-T stage_2_daemon 
AA2CPREFIX=S2_
AA2C_C_FILE=$(AA2CPREFIX)aa_c_model.c

all: cmodel vhdlmodel

cmodel: pipes.aa stage2.aa
	rm -rf aa2c
	mkdir aa2c
	Aa2C -I dummy_mempool  -o aa2c -P $(AA2CPREFIX) $(TOPMODULES) pipes.aa stage2.aa
	indent aa2c/$(AA2C_C_FILE)
          
vhdlmodel: pipes.aa stage2.aa
	buildFromSources.py -a Stage2 -W S2 -E to_vhdl $(TOPMODULES) -A pipes.aa -A stage2.aa


clean:
	rm -rf vhdl/* aa2c/*


PHONY: all clean
