# Pending binaries
# formatVhdlFiles.py
# ghdlSanitize.sh

# Pending libs (not sure if to be built)
# FLI Fli ModelsimFLI

# ILIBS are .a, not to be installed, consumed for build (to be confirmed)
# .so exist, but have to confirm whether they are to be installed

# Dependencies: boost, antlr2, llvm (once llvm2aa is merged)

OS  =   $(shell uname -s)
ifeq ($(OS),NetBSD)
PREFIX	?=	/usr/pkg
else
PREFIX	?=	/usr/local
endif

INSTALL	?=	install

INSTBINDIR	=	$(PREFIX)/bin
INSTLIBDIR	=	$(PREFIX)/lib
INSTINCDIR	=	$(PREFIX)/include
INSTSHRDIR	=	$(PREFIX)/share/ahir
INSTVHDDIR	=	$(PREFIX)/share/ahir/vhdl

CFLAGS	+=  -I$(PREFIX)/include -MMD -MP -fPIC -Werror=return-type -O3
CXXFLAGS+=	$(CFLAGS) --std=c++17
ANTLR	=	antlr
AR		=	ar
ARFLAGS	=	rcs
LDFLAGS	+=	-L$(PREFIX)/lib -lantlr -lboost_filesystem -Wl,-rpath,$(PREFIX)/lib
SOFLAGS	+=	-shared

INSTSHRFILES	=	../LICENSE ../CONTRIBUTORS

# LLVM2AA will be built from a separate git repo. Eventually it will be merged back here.
PROJECTS	=	AHIRASM HIERSYS LIBAHIR BITVECS VALUE FNLIB IOLIB VERSION #LLVM2AA
PROJECTS	+=	PIPEHANDLER RTL2AAMATCHER CTESTBENCH
PROJECTS	+=	BGLWRAP PTHREADUTILS

AHIRASM_DIR	=	Ahir-asm/devel
AHIRASM_BINS=	Aa2C Aa2VC AaLinkExtMem AaOpt AaPreprocess
AHIRASM_ILIBS=	Aa
AHIRASM_GRAM=	Aa

HIERSYS_DIR	=	HierSysBuild
HIERSYS_BINS=	hierSys2C hierSys2Vhdl hierSysCheck hierSysGenVhdlComponentsPackage hierSysPartition hierSysUniquify
HIERSYS_ILIBS=	HierSys
HIERSYS_GRAM=	hierSys

LIBAHIR_DIR	=	libAhirV2
LIBAHIR_BINS=	vc2vhdl vcAnalyze vcFormat vcParse vhdlFormat
LIBAHIR_ILIBS=	VC
LIBAHIR_GRAM=	vc
vcParse_SRCS=	$(LIBAHIR_DIR)/util/vcParseMain.cpp

#LLVM2AA_DIR	=	llvmbc2Aa
#LLVM2AA_BINS=	llvm2aa
#llvm2aa_SRCS=	$(wildcard $(LLVM2AA_DIR)/src/*.cpp)

BITVECS_DIR	=	BitVectors
BITVECS_ILIBS=	BitVectors

VALUE_DIR	=	Value
VALUE_ILIBS	=	Value

FNLIB_DIR	=	functionLibrary
FNLIB_ILIBS	=	fpu llvm_intrinsics timer

IOLIB_DIR	=	iolib
IOLIB_ILIBS	=	io

VERSION_DIR	=	version
VERSION_ILIBS=	AhirVersion

CTESTBENCH_DIR				=	CtestBench
CTESTBENCH_LIBS				=	SockPipes SocketLibPipeHandler Vhpi
CTESTBENCH_HDRS				=	SockPipes SocketLib Vhpi
SockPipes_SRCS				=	$(addprefix $(CTESTBENCH_DIR)/src/, $(addsuffix .c, SocketLib SockPipes))
SocketLibPipeHandler_SRCS	=	$(addprefix $(CTESTBENCH_DIR)/src/, $(addsuffix .c, SocketLib Pipes SockPipes pipeHandler))
Vhpi_SRCS					=	$(addprefix $(CTESTBENCH_DIR)/src/, $(addsuffix .c, Vhpi SocketLib))

PIPEHANDLER_DIR	=	pipeHandler
PIPEHANDLER_LIBS=	PipeHandler
PIPEHANDLER_HDRS=	*

RTL2AAMATCHER_DIR	=	rtl2AaMatcher
RTL2AAMATCHER_LIBS	=	Rtl2AaMatcher
RTL2AAMATCHER_HDRS	=	*

BGLWRAP_DIR	=	BGLWrap

PTHREADUTILS_DIR=	pthreadUtils
PTHREADUTILS_HDRS=	*

# # # # # # # ---- VHDL Packaging --- # # # # # # # # #
VHDLRELEASEDIR	=	../vhdl/release
VHDLRELFILES	=	ahirForImage GhdlLink ModelsimLink aHiR_ieee_proposed ahir ahirXilinx

INSTVHDFILES	=	$(call f_prefsuf,$(VHDLRELEASEDIR),.vhdl,$(VHDLRELFILES))

VHDLHOME		=	../vhdl
VHDLAHIRHOME	=	$(VHDLHOME)/ahir
PKGSV2DIR		=	$(VHDLAHIRHOME)/packagesV2
CPATHDIR		=	$(VHDLAHIRHOME)/control-path
V2VHDLDIR		=	$(VHDLAHIRHOME)/operatorsV2
MEMSUBSYSDIR	=	$(VHDLAHIRHOME)/memory_subsystem
OPERATORSDIR	=	$(VHDLAHIRHOME)/operatorsV2
CLKGATINGDIR	=	$(VHDLAHIRHOME)/clock_gating
VHPIDIR			=	$(VHDLHOME)/Vhpi
AHIRIEEEDIR		=	$(VHDLHOME)/aHiR_ieee_proposed/trimmed

V2VHDFILES		=	Types Utilities Subprograms BaseComponents Components FloatOperatorPackage OperatorPackage mem_component_pack mem_function_pack memory_subsystem_package merge_functions functionLibraryComponents
MEMSUBSYSCOMPS_FORIMG	=	common base_bank_image strictly_ordered unordered
OPERATORCOMPS_FORIMG	=	base ieee754 experimental functionLibrary
AHIRFORIMAGESRCS		= $(f_prefsuf $(PKGSV2DIR),.vhd,$(V2VHDFILES)) \
	$(foreach c,$(MEMSUBSYSCOMPS_FORIMG),$(wildcard $(MEMSUBSYSDIR)/$(c)/*.vhd)) \
	$(wildcard $(CPATHDIR)/*.vhdl) \
	$(foreach c,$(OPERATORCOMPS_FORIMG),$(wildcard $(OPERATORSDIR)/$(c)/*.vhd))

GHDLLINKFILES	=	Utility_Package Vhpi_Package LogUtilitiesGhdl
GHDLLINKSRCS	=	$(call f_prefsuf,$(VHPIDIR),.vhdl,$(GHDLLINKFILES))

MODELSIMLINKFILES	=	Utility_Package Modelsim_FLI_Foreign LogUtilitiesModelsim
MODELSIMLINKSRCS	=	$(call f_prefsuf,$(VHPIDIR),.vhdl,$(MODELSIMLINKFILES))

AHIRIEEEFILES	=	math_utility_pkg.vhd fixed_float_types_c.vhdl fixed_pkg_c.vhd float_pkg_c.vhd
AHIRIEEESRCS	=	$(addprefix $(AHIRIEEEDIR)/,$(AHIRIEEEFILES))

AHIR_XL_PKGV2FILES		=	GlobalConstants Types Utilities Subprograms BaseComponents Components FloatOperatorPackage OperatorPackage mem_component_pack mem_function_pack memory_subsystem_package merge_functions functionLibraryComponents ApIntComponents
MEMSUBSYSCOMPS_FORAHIR	=	common base_bank strictly_ordered unordered
OPERATORCOMPS_FORAHIR	=	base ieee754 experimental glue level_core functionLibrary ap_int
AHIR_XL_COMMONSRCS		=	$(f_prefsuf,$(PKGSV2DIR),.vhd,$(AHIR_XL_PKGV2FILES)) \
	$(foreach c,$(MEMSUBSYSCOMPS_FORAHIR),$(wildcard $(MEMSUBSYSDIR)/$(c)/*.vhd)) \
	$(wildcard $(CPATHDIR)/*.vhdl) \
	$(foreach c,$(OPERATORCOMPS_FORAHIR),$(wildcard $(OPERATORSDIR)/$(c)/*.vhd)) \
	$(wildcard $(CLKGATINGDIR)/*__clock_gate.vhdl)

AHIRSRCS	=	$(AHIR_XL_COMMONSRCS) $(CLKGATINGDIR)/clock_gater.vhdl

AHIRXLSRCS	=	$(AHIR_XL_COMMONSRCS) $(CLKGATINGDIR)/clock_gater_xilinx.vhdl
# # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # # Usually no change should be required below this point # # # # #

define f_prefsuf
	$(addprefix $(1)/,$(addsuffix $(2),$(3)))
endef

# Convention:
# For BINS, binary name has a corresponding utils/<bin>.cpp program, unless <BIN>_SRCS is defined
# If a project has a single LIB, build from src/*.cpp
# If a project has multiple ILIBS, for each source there is corresponding src/<lib>.c
# If a project has no ILIBS, use all sources for the BIN
# We use all include directories for compilation and all libs for linking, to keep it simple


BINS	=	$(foreach p,$(PROJECTS), $(addprefix $($(p)_DIR)/bin/, $($(p)_BINS)))
LIBS	=	$(foreach p,$(PROJECTS), $(addsuffix .so,$(addprefix $($(p)_DIR)/lib/lib, $($(p)_LIBS))))
ILIBS	=	$(foreach p,$(PROJECTS), $(addsuffix .a,$(addprefix $($(p)_DIR)/lib/lib, $($(p)_ILIBS))))
INCDIRS	+=	$(foreach p,$(PROJECTS), $($(p)_DIR)/include)
INCDIRS	+=	$(foreach p,$(PROJECTS),$(foreach g,$($(p)_GRAM),$($(p)_DIR)/src))
CFLAGS	+=	$(addprefix -I,$(INCDIRS))


%.o:	%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

%.o:	%.c
	$(CC) $(CFLAGS) -c $< -o $@

define f_ANTLROPS
$(addprefix $($(1)_DIR)/src/, $(foreach g,$($(1)_GRAM), $(foreach suf,Lexer Parser, $(foreach ext,.hpp .cpp, $(g)$(suf)$(ext)))))
endef

define f_ANTLRINP
$(foreach g,$($(1)_GRAM),$($(1)_DIR)/grammar/$(g).g)
endef

define f_ILIBSRCS
$(if $(filter-out 1,$(words $($(1)_ILIBS))),\
	$($(1)_DIR)/src/$(2).c,\
	$(sort $(wildcard $($(1)_DIR)/src/*.cpp) $(filter %.cpp,$(call f_ANTLROPS,$(1)))))
endef

define f_LIBSRCS
$(if $($(2)_SRCS),\
	$($(2)_SRCS),\
	$(wildcard $($(1)_DIR)/src/*.c))
endef

define f_BINSRCS
$(if $($(2)_SRCS),\
	$($(2)_SRCS),\
	$($(1)_DIR)/util/$(2).cpp)
endef

define f_SRC2O
$(subst .c,.o,$(subst .cpp,.o,$(1)))
endef

define ILIBRULES
$($(1)_DIR)/lib/lib$(2).a: $(call f_SRC2O, $(call f_ILIBSRCS,$(1),$(2)))
	mkdir -p $($(1)_DIR)/lib && \
	$(AR) $(ARFLAGS) $($(1)_DIR)/lib/lib$(2).a $(call f_SRC2O, $(call f_ILIBSRCS,$(1),$(2)))

endef

define LIBRULES
$($(1)_DIR)/lib/lib$(2).so: $(call f_SRC2O, $(call f_LIBSRCS,$(1),$(2)))
	mkdir -p $($(1)_DIR)/lib && \
	$(CXX) $(SOFLAGS) $(LDFLAGS) $(call f_SRC2O, $(call f_LIBSRCS,$(1),$(2))) -o $($(1)_DIR)/lib/lib$(2).so

endef

define BINRULES
$($(1)_DIR)/bin/$(2): $(call f_SRC2O, $(call f_BINSRCS,$(1),$(2))) $(ILIBS)
	mkdir -p $($(1)_DIR)/bin && \
	$(CXX) $(call f_SRC2O, $(call f_BINSRCS,$(1),$(2))) $(ILIBS) $(LDFLAGS) -o $($(1)_DIR)/bin/$(2)

endef

define PROJRULES

$(call f_ANTLROPS,$(1)) &: $(call f_ANTLRINP,$(1))
	$(ANTLR) -o $($(1)_DIR)/src $(call f_ANTLRINP,$(1))

$(foreach l,$($(1)_ILIBS),$(call ILIBRULES,$(1),$(l)))

$(foreach l,$($(1)_LIBS),$(call LIBRULES,$(1),$(l)))

$(foreach b,$($(1)_BINS),$(call BINRULES,$(1),$(b)))

endef

define GENSRCDEPRULE
$(1)	:	$(GENSRCS)

endef


all: $(BINS) $(LIBS) $(INSTVHDFILES)

GENSRCS=	$(foreach p,$(PROJECTS),$(call f_ANTLROPS,$(p)))
BINOBJS=	$(foreach p,$(PROJECTS),$(foreach b,$($(p)_BINS),$(call f_SRC2O,$(call f_BINSRCS,$(p),$(b)))))
ILIBOBJS=	$(foreach p,$(PROJECTS),$(foreach l,$($(p)_ILIBS),$(call f_SRC2O,$(call f_ILIBSRCS,$(p),$(l)))))
LIBOBJS=	$(foreach p,$(PROJECTS),$(foreach l,$($(p)_LIBS),$(call f_SRC2O,$(call f_LIBSRCS,$(p),$(l)))))
OBJS=		$(BINOBJS) $(ILIBOBJS) $(LIBOBJS)
DFILES=		$(OBJS:.o=.d)
-include $(DFILES)

define f_INSTHDRS
$(foreach h,$($(1)_HDRS), $(if $(filter-out *,$(h)), $($(1)_DIR)/include/$(h).h, $(wildcard $($(1)_DIR)/include/*.h)))
endef

INSTHDRS=	$(foreach p,$(PROJECTS),$(call f_INSTHDRS,$(p)))

install: all
	$(INSTALL) -d -m 755 $(DESTDIR)$(INSTBINDIR) $(DESTDIR)$(INSTLIBDIR) $(DESTDIR)$(INSTINCDIR) $(DESTDIR)$(INSTSHRDIR) $(DESTDIR)$(INSTVHDDIR)
	$(INSTALL) -m 755 $(BINS) $(DESTDIR)$(INSTBINDIR)
	$(INSTALL) -m 755 $(LIBS) $(DESTDIR)$(INSTLIBDIR)
	$(INSTALL) -m 644 $(INSTHDRS) $(DESTDIR)$(INSTINCDIR)
	$(INSTALL) -m 644 $(INSTSHRFILES) $(DESTDIR)$(INSTSHRDIR)
	$(INSTALL) -m 644 $(INSTVHDFILES) $(DESTDIR)$(INSTVHDDIR)

clean: clean-bins clean-libs clean-objs clean-gensrcs clean-vhdl

clean-bins:
	rm -f $(BINS)
clean-libs:
	rm -f $(ILIBS) $(LIBS)
clean-gensrcs:
	rm -f $(GENSRCS)
clean-objs:
	rm -f $(OBJS) $(DFILES)
clean-vhdl:
	rm -f $(INSTVHDFILES)

$(foreach p, $(PROJECTS), $(eval $(call PROJRULES,$(p))))

$(foreach o, $(OBJS), $(eval $(call GENSRCDEPRULE,$(o))))

$(VHDLRELEASEDIR)/ahirForImage.vhdl: $(AHIRFORIMAGESRCS)
	cat $^ > $@

$(VHDLRELEASEDIR)/GhdlLink.vhdl:	$(GHDLLINKSRCS)
	cat $^ > $@

$(VHDLRELEASEDIR)/ModelsimLink.vhdl:	$(MODELSIMLINKSRCS)
	cat $^ > $@

$(VHDLRELEASEDIR)/aHiR_ieee_proposed.vhdl:	$(AHIRIEEESRCS)
	cat $^ > $@

$(VHDLRELEASEDIR)/ahir.vhdl:	$(AHIRSRCS)
	cat $^ > $@

$(VHDLRELEASEDIR)/ahirXilinx.vhdl:	$(AHIRXLSRCS)
	cat $^ > $@

