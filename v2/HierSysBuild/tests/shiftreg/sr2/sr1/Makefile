TOPMODULES=-T sr1_daemon
AA2CPREFIX=sr1_
AA2C_C_FILE=$(AA2CPREFIX)aa_c_model.c
AA2CFILES=   sr1.aa
AA2VHDLFILES=-A sr1.aa

all: aa2c/cpu_ccu_aa_c_model.c

aa2c/cpu_ccu_aa_c_model.c: $(AA2CFILES)
	buildFromSources.py -B $(SIMULATOR) $(DEBUG) $(GNUPTH) -U -a sr1  -W SR1_LIB  -E to_vhdl  $(TOPMODULES) $(AA2VHDLFILES)


clean:
	rm -rf vhdl/* aa2c/* *.c *.h *.txt .Aa .vC  .objhw

PHONY: all clean
