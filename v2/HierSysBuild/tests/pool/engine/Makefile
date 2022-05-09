TOPMODULES=-T engine_daemon
AA2CPREFIX=engine_
AA2C_C_FILE=$(AA2CPREFIX)aa_c_model.c
AA2CFILES= engine.aa
AA2VHDLFILES=-A engine.aa

all: $(AA2CFILES)
	buildFromSources.py -U -a engine  -W SYS_LIB  -E to_vhdl  $(TOPMODULES) $(AA2VHDLFILES)


clean:
	rm -rf vhdl/* aa2c/* *.c *.h *.txt .Aa .vC  .objhw

PHONY: all clean
