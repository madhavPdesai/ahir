TOPMODULES=-T controller_daemon
AA2CPREFIX=controller_
AA2C_C_FILE=$(AA2CPREFIX)aa_c_model.c
AA2CFILES= ../pipes.aa  controller.aa
AA2VHDLFILES=-A ../pipes.aa -A controller.aa

all: $(AA2CFILES)
	buildFromSources.py -U -a controller  -W SYS_LIB  -E to_vhdl  $(TOPMODULES) $(AA2VHDLFILES)


clean:
	rm -rf vhdl/* aa2c/* *.c *.h *.txt .Aa .vC  .objhw

PHONY: all clean
