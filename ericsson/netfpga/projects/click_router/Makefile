#
# Build the registers/software for the project
#


PROJECT = $(notdir $(CURDIR))
ifneq ($(wildcard include/project.xml),)
	TARGETS += regs
endif
ifneq ($(wildcard sw/Makefile),)
	TARGETS += sw
endif

all: $(TARGETS)

regs: include/registers.v

include/registers.v: include/project.xml
	$(NF_ROOT)/bin/nf_register_gen.pl --project $(PROJECT)

sw:
	$(MAKE) -C sw

clean:
	$(MAKE) clean -C sw
	$(MAKE) clean -C synth

.PHONY:	all sw regs clean
