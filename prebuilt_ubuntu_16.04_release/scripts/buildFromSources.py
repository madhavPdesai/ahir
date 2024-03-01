#!/usr/bin/env python 
#
# buildFromSources.py is a top-level script which 
# takes a description of C,Aa,vC source and
# produces VHDL...  This is meant to be a leaf-level
# script which is part of the processor assembly process.
#
# Borrows lots from IMAGE RC.
#  (Thanks to Powai Labs).
#
# Author: Madhav Desai
#
from __future__ import division, print_function

import os
import os.path
import shutil
import getopt
import sys
import glob
import subprocess
import threading 
import pdb
import time

# run system command.
def execSysCmd(sys_cmd):
    logCommand(sys_cmd)
    ret_val = os.system(sys_cmd)
    return ret_val

# clean the work-area, remove all the stuff produced by the script.
def cleanWorkArea(work_area):

    execSysCmd("rm -rf " + work_area + "./.objhw")
    execSysCmd("rm -rf " + work_area + "./.Aa")
    execSysCmd("rm -rf " + work_area + "./.vC")
    execSysCmd("rm -rf " + work_area + "./vhdl")

    return 0

    
# set global variables used in this script from environment
# variables.
def setGlobals(ahir_release_path):


    global AHIR_RELEASE
    global FUNCTIONLIB
    global XILINX_UNISIM
    global XILINX_SIMPRIM
    global AHIR_PTHREAD_UTILS_INCLUDE
    global AHIR_FUNCTIONLIB

    # Two versions of pipes, for software version, we
    # use pipeHandler, for ghdl simulation we use SocketLib.
    global SOCKETLIB_INCLUDE
    global SOCKETLIB_LIB
    global PIPEHANDLER_INCLUDE
    global PIPEHANDLER_LIB
    global AHIR_FUNCTIONLIB_INCLUDE

    # VHDL libraries from AHIR distro.
    global AHIR_VHDL_LIB
    global AHIR_VHDL_VHPI_LIB

    # VHDL, Aa results
    global VHDL
    global AA


    # SW version.
    global SW_INCLUDES
    global SW_LIB_PATHS
    global SW_LIBS

    # HW version..
    global HW_INCLUDES
        
    # CLANG includes
    global CLANG_INCLUDES
    
    # HW testbench for GHDL sim.
    global TB_INCLUDES
    global TB_LIB_PATHS
    global TB_LIBS

    # GHDL libraries to be linked to.
    global GHDL_LIB_OPTS

    # AHIR-related
    AHIR_RELEASE=ahir_release_path
    FUNCTIONLIB=AHIR_RELEASE + "/functionLibrary"
    XILINX_UNISIM=AHIR_RELEASE + "/vhdl"
    XILINX_SIMPRIM=AHIR_RELEASE + "/vhdl"
    SOCKETLIB_INCLUDE=AHIR_RELEASE + "/include"
    SOCKETLIB_LIB=AHIR_RELEASE + "/lib"
    PIPEHANDLER_INCLUDE=AHIR_RELEASE + "/include"
    PIPEHANDLER_LIB=AHIR_RELEASE + "/lib"
    AHIR_VHDL_LIB=AHIR_RELEASE + "/vhdl"
    AHIR_VHDL_VHPI_LIB=AHIR_RELEASE + "/vhdl"
    AHIR_PTHREAD_UTILS_INCLUDE=AHIR_RELEASE + "/include"
    AHIR_FUNCTIONLIB=AHIR_RELEASE + "/functionLibrary"
    AHIR_FUNCTIONLIB_INCLUDE=AHIR_FUNCTIONLIB + "/include"
    
    #GHDL_LIB_OPTS = "-Wl,-L" + SOCKETLIB_LIB + " -Wl,-L" + RC_LIB + " -Wl,-lVhpi" + " -Wl,-lrcApiWithoutPlx" + " -Wl,-lrt"


# logging.
def logCommand(sys_cmd):
    print (sys_cmd, file=command_log_file)

def logInfo(mesg):
    print ("Info: " + mesg)

def logError(mesg):
    print ("Error: " + mesg)

def logWarning(mesg):
    print ("Warning: " + mesg)

# utility to make a directory or if exists, remove its contents.
def makeOrCleanDir(dest_dir):
    curr_path = os.getcwd()
    if(os.path.isdir(dest_dir) != 1):
        os.mkdir(dest_dir)
    else:
        execSysCmd("rm -rf " + curr_path + "/" + dest_dir + "/*")

    
# compile function
#  CC = compiler, SRC_DIRS = src-directory-list, OBJ = obj-dir, CFLAGS, list-of-includes, list-of-defines.
def  compileFiles(CC, SRC_DIRS, OBJ, CFLAGS, INCLUDE_LIST, DEFINES):
    err_flag = 0
    include_string = ""
    for incldir in INCLUDE_LIST:
       include_string += " -I" +   incldir + " "

    include_string += " -I" + AHIR_FUNCTIONLIB_INCLUDE +  " -I" + PIPEHANDLER_INCLUDE + " "

    define_string = ""
    for defs  in DEFINES:
        define_string += "-D" + defs

    # make object directory if needed.       
    if(os.path.isdir(OBJ) != 1): 
         os.mkdir(OBJ)

        
    cc_command = ""
    for src_dir in SRC_DIRS:
        for sfile in os.listdir(src_dir):
            name,extn = os.path.splitext(sfile)
            if(extn == ".c"):
               cc_command = CC + " -c " + CFLAGS  + " " + include_string + " " +  define_string + " " + src_dir + "/" + sfile  + " -o " + OBJ + "/" + name + ".o"
               logInfo("executing compile-command\n\t " + cc_command)
               ret_val = execSysCmd(cc_command)
               if(ret_val != 0):
                   logError("in compiling file " + sfile)
                   err_flag = 1
    return err_flag

    
# link-function
#   linker, bin-dir, exe-name, list-of-object-dirs, link-flags, list-of-shared-libs, list-of-static-libs
def linkAndBuildExecutable(LD, BIN, EXE, OBJDIRS, LDFLAGS, SHAREDLIBS, STATICLIBS):
    err_flag = 0
    ld_string = LDFLAGS
    for solib in SHAREDLIBS:
       ld_string += " -l" + solib
     
    static_libs = ""
    for stlib in STATICLIBS:
       static_libs += " " + stlib 

    ld_command = LD + " -o " + BIN + "/" + EXE + " " + ld_string
    for objdir in OBJDIRS:
        obj_files = os.listdir(objdir)
        for obj_file in obj_files:
            root,ext = os.path.splitext(obj_file)
            if(ext == ".o"):
               ld_command += " " + objdir + "/" +  obj_file
    
    ld_command += static_libs
    logInfo("executing link-command\n\t " + ld_command)
    err_flag = execSysCmd(ld_command)

    return(err_flag)


# C->llvm
def makeC2Llvm(c_src_dirs, c_include_dirs,define_list):
    logInfo("in makeC2Llvm ()")

    obj_dir = "./.objhw"
    makeOrCleanDir(obj_dir)
   
    clang_flags = "-std=gnu89 -emit-llvm -c " 
    ret_val = compileFiles("clang", c_src_dirs, obj_dir, clang_flags, c_include_dirs, define_list)
    
    if (ret_val): 
        logError("Error: in converting C to LLVM for")


    logInfo("optimizing LLVM object files")
    for objfile in os.listdir(obj_dir):
        objname,extn = os.path.splitext(objfile)
        if(extn == ".o"):
           opt_command = "opt -O3 --instnamer --lowerswitch " + obj_dir + "/" + objfile + " > " + obj_dir + "/" + objname + ".O"
           logInfo("running optimization:\n\t " + opt_command)
           opt_status = execSysCmd(opt_command)
           if(opt_status != 0):
              logError("opt-command failed:" + opt_command)
              ret_val = 1
           else:
              disassemble_cmd = "llvm-dis " + obj_dir + "/" + objname + ".O "  + " -o " + obj_dir + "/" + objname + ".txt"
              ret_val = execSysCmd(disassemble_cmd)
                   
                   
 
    return ret_val
    
# llvm -> Aa
def makeLlvm2Aa(aa_files,ahir_fn_libs, balance_flag):
    logInfo("in makeLlvm2Aa ()")
    ret_val = 0


    obj_dir = "./.objhw/"
    aa_dir  = "./.Aa/"

    makeOrCleanDir(aa_dir)

    llvm2aa_opts="-extract_do_while=true"

    files_to_link = []
 
    for aafile in aa_files:
        files_to_link.append(aafile)

    for obj_file in os.listdir(obj_dir):
        #pdb.set_trace()
        root,ext = os.path.splitext(obj_file) 
        if(ext == ".O"):
            llvm2aa_cmd = "llvm2aa " + llvm2aa_opts + " " + obj_dir + "/" + obj_file + " > " + aa_dir  + "/." + root + ".uaa " 
            logInfo("executing llvm2aa\n\t " + llvm2aa_cmd)
            cmd_stat = execSysCmd(llvm2aa_cmd)
            if(cmd_stat != 0):
               logError("command failed " + llvm2aa_cmd)
               ret_val = 1
            else:
               fmt_file = "." + root + ".aa"
               format_cmd = "vcFormat < " + aa_dir +  "/." + root + ".uaa " + " > " + aa_dir + "/" + fmt_file
               execSysCmd(format_cmd)
               files_to_link.append(aa_dir + "/" + fmt_file)
                


    if (ret_val): 
        logError("Error: in converting LLVM to Aa")
        return 1

    #if (len(ahir_fn_libs) > 0):
         #for ahir_lib in ahir_fn_libs:
         #files_to_link.append(AHIR_FUNCTIONLIB + "/Aa/" + ahir_lib + ".aa")

    ret_val = makeAaLink(files_to_link, balance_flag)

    return ret_val

# Aa -> Aa
def makeAaLink(files_to_link, balance_flag):

    logInfo("in makeAaLink ()")
    ret_val = 0
    aa_dir = "./.Aa/"

    aa_link_cmd = "AaLinkExtMem -I 1 -E default_mem_pool " 
    for aa_file in files_to_link:
       aa_link_cmd +=  " " + aa_file + " "

     
    aa_link_cmd += " > " + aa_dir +  "/.linked.uaa"
    logInfo("running link command\n\t " + aa_link_cmd)

    cmd_status = execSysCmd(aa_link_cmd)
    if(cmd_status != 0):
       logError("Aa-link command failed: " + aa_link_cmd)
       ret_val = 1

    if(ret_val != 0):
       return 1

    fmt_cmd = "vcFormat < " + aa_dir + "/.linked.uaa > " + aa_dir + "/linked.aa"
    execSysCmd(fmt_cmd)

    # todo: AaOpt.
    b_string = " "
    if balance_flag:
       b_string = " -B "
    aa_opt_cmd = "AaOpt -I mempool " + b_string + aa_dir + "/linked.aa > " + aa_dir + "/.linked.opt.uaa"
    cmd_status = execSysCmd(aa_opt_cmd)
    if(cmd_status != 0):
       logError("AaOpt command failed: " + aa_opt_cmd)
       ret_val = 1

    if(ret_val != 0):
       return 1

    fmt_cmd = "vcFormat < " + aa_dir + "/.linked.opt.uaa > " + aa_dir + "/linked.opt.aa"
    execSysCmd(fmt_cmd)
    
    return 0

# Aa -> C
def makeAa2C(system_name, aa_source_prefix, top_daemon_modules, use_gnu_pth):
    ret_val = 0

    aa2c_dir = "./aa2c"
    aa_dir = "./.Aa/"

    makeOrCleanDir(aa2c_dir)

    aa2c_cmd = "Aa2C -o aa2c -P " + aa_source_prefix + "_ " 
    if(use_gnu_pth):
       aa2c_cmd += " -G "
    for tdm in top_daemon_modules:
       aa2c_cmd  += " -T " + tdm 
    
    aa2c_cmd += " " +  aa_dir + "/linked.opt.aa"
    cmd_status = execSysCmd(aa2c_cmd)
    if(cmd_status != 0):
        logError("Aa2C command failed: " + aa2c_cmd)
        ret_val = 1

    indent_h_cmd = "indent -orig aa2c/*.h"
    cmd_status = execSysCmd(indent_h_cmd)
    if(cmd_status != 0):
        logError("indent header command failed: " + indent_h_cmd)
        ret_val = 1

    indent_c_cmd = "indent -orig aa2c/*.c"
    cmd_status = execSysCmd(indent_c_cmd)
    if(cmd_status != 0):
        logError("indent source command failed: " + indent_c_cmd)
        ret_val = 1

    return(ret_val)


# Aa -> vC
def makeAa2Vc(system_name, opaque_flag):

    logInfo("in makeAa2Vc ()")
    ret_val = 0

    aa_dir = "./.Aa/"
    vc_dir = "./.vC/"
    makeOrCleanDir(vc_dir)

    # treat all modules as opaque (-P)
    aa2vc_cmd = "Aa2VC -I mempool -O -C "
    if opaque_flag:
       aa2vc_cmd += " -P " 
    aa2vc_cmd += aa_dir + "/linked.opt.aa  > " + vc_dir + "/." + system_name + ".uvc"
    logInfo("executing command\n\t " + aa2vc_cmd)
    cmd_status = execSysCmd(aa2vc_cmd)
    if (cmd_status != 0): 
        logError("Error: in converting Aa to vC")
        ret_val = 1
 
    fmt_cmd = "vcFormat < " + vc_dir + "/." + system_name + ".uvc > " + vc_dir + "/" + system_name + ".vc"
    logInfo("executing command\n\t " + fmt_cmd)
  
    execSysCmd(fmt_cmd)

    # get rid of some junk.
    # execSysCmd("rm -rf vhdlCStubs.*")

    return ret_val

# vC -> VHDL
def makeVc2Vhdl(system_name, top_modules, top_daemon_modules, ahir_fn_libs, sim_type, vhdl_library_name, debug_flag, suppress_io_pipes):
    logInfo("in makeVc2Vhdl (" + system_name +  ")")
    vhdl_dir = "./vhdl"

    cwd_dir = os.getcwd()
    makeOrCleanDir(vhdl_dir)
    os.chdir(vhdl_dir)
    makeOrCleanDir(vhdl_library_name)

    ret_val = 0
   
    vc_dir = "../.vC"

    vc2vhdl_cmd = "vc2vhdl -H -a -C -O -e " + system_name + " -w -s " + sim_type + " -W " + vhdl_library_name 
    if debug_flag:
       vc2vhdl_cmd += " -D "
    if suppress_io_pipes:
       vc2vhdl_cmd += " -U "

    for ahir_lib in ahir_fn_libs:
       vc2vhdl_cmd += " -L " +  ahir_lib + ".list "

    top_module_string = ""
    for tm in top_modules:
       vc2vhdl_cmd += " -t " + tm
    for tdm in top_daemon_modules:
       vc2vhdl_cmd  += " -T " + tdm 

    vc2vhdl_cmd += " -f " + vc_dir + "/" + system_name + ".vc"
    logInfo("executing vc->vhdl\n\t " + vc2vhdl_cmd)
    cmd_status = execSysCmd(vc2vhdl_cmd)

    if(cmd_status != 0):
        logError("vc2vhdl failed for " + system_name)
        os.chdir(cwd_dir)
        return 1

    # put package and system entity/arch in one design file.
    pkg_file = system_name + "_global_package.unformatted_vhdl"
    fmt_command = "vhdlFormat < " + pkg_file + " > " + vhdl_library_name + "/" + system_name + ".vhdl"
    execSysCmd(fmt_command)
    execSysCmd("rm -f " + pkg_file)

    sys_file = system_name + ".unformatted_vhdl"
    fmt_command = "vhdlFormat < " + sys_file + " >> " + vhdl_library_name + "/" + system_name + ".vhdl"
    execSysCmd(fmt_command)
    execSysCmd("rm -f " + sys_file)

    # put testbench file in testbench/ directory.
    makeOrCleanDir("testbench")
    tb_file = system_name + "_test_bench.unformatted_vhdl"
    fmt_command = "vhdlFormat < " + tb_file + " >> testbench/" + system_name + "_test_bench.vhdl"
    execSysCmd(fmt_command)
    execSysCmd("rm -f " + tb_file)


    os.chdir(cwd_dir)
    return ret_val


# VHDL -> simulation.
def makeVhdlSim(app_name, sim_type, vhdl_library_name):
     if(sim_type != "ghdl"):
         logError("only ghdl supported as simulator-type for now.")
         return 1
    
     execSysCmd("ghdl --clean")
     execSysCmd("ghdl --remove")

     ghdl_cmd = "ghdl -i --work=GhdlLink " + AHIR_VHDL_LIB + "/GhdlLink.vhdl"  
     ret_status = execSysCmd( ghdl_cmd)
     if(ret_status):
         logError("command failed " + ghdl_cmd)
         return 1

     ghdl_cmd = "ghdl -i --work=aHiR_ieee_proposed " + AHIR_VHDL_LIB + "/aHiR_ieee_proposed.vhdl"  
     ret_status = execSysCmd( ghdl_cmd)
     if(ret_status):
         logError("command failed " + ghdl_cmd)
         return 1

     ghdl_cmd = "ghdl -i --work=ahir " + AHIR_VHDL_LIB + "/ahir.vhdl"  
     ret_status = execSysCmd( ghdl_cmd)
     if(ret_status):
         logError("command failed " + ghdl_cmd)
         return 1

     ghdl_cmd = "ghdl -i --work=work vhdl/" + vhdl_library_name + "/" + app_name + ".vhdl"  
     ret_status = execSysCmd( ghdl_cmd)
     if(ret_status):
         logError("command failed " + ghdl_cmd)
         return 1

     ghdl_cmd = "ghdl -i --work=work vhdl/testbench/" + app_name + "_test_bench.vhdl"  
     ret_status = execSysCmd( ghdl_cmd)
     if(ret_status):
         logError("command failed " + ghdl_cmd)
         return 1

     ghdl_cmd = "ghdl -m --work=work -Wl,-L" + SOCKETLIB_LIB + " -Wl,-lVhpi " + app_name + "_test_bench"  
     ret_status = execSysCmd( ghdl_cmd)
     if(ret_status):
         logError("command failed " + ghdl_cmd)
         return 1

     return 0

#     -a <ahir-system-name> 
#     -w <work-area>
#     (-t (<top-module>)*  (note: multiple top-modules can be specified)
#     (-T (<top-daemon-module>)*  (note: multiple top-modules can be specified)
#     (-F  <full-path-of-function-library-to-include>)*
#     -S  <start-point> ({ "", to_llvm, to_aa, to_aa2c, to_vc, to_vhdl, to_sim} ) 
#     -E  <end-point> (one of {to_llvm, to_aa, to_aa2c, to_vc, to_vhdl, to_sim} ) 
#     -s  <simulator-type>
#     -h  (print help message)
#     (-B)  to balance paths in Aa pipeline.
#     (-N)? do not treat all modules as opaque.
#     (-C  (c-source-dir))*
#     (-I  (c-include-dir))*
#     (-A  (aa-source-file))*
#     (-P  (aa-source-prefix)?
#     (-W <vhdl-library-name)?
#     (-R)?  remove everything that was built
#
def parseOptions(opts):
    app_name = ""
    work_area = "./"
    ahir_fn_libs = []
    top_modules = []
    top_daemon_modules = []
    debug_flag = 0
    use_gnu_pth = False
    suppress_io_pipes = False
    balance_flag = False
    opaque_flag = True

    c_src_dirs = []
    c_include_dirs = []

    aa_src_files = []

    start_point = ""
    end_point = ""
    help_flag = 0
    err_flag  = 0
    clean_flag = 0

    sim_type = "ghdl"
    vhdl_library_name = "work"
    aa_source_prefix = None

    for option, parameter in opts:
        if option ==  '-a':
           app_name = parameter
           logInfo("application-name  = " + parameter + ".")
        elif option ==  '-w':
           work_area = parameter
           logInfo("set project work-area = " + parameter + ".")
        elif option ==  '-B':
           balance_flag = True
           logInfo("set balance-flag = True ")
        elif option ==  '-N':
           opaque_flag = False
           logInfo("set opaque flag = False ")
        elif option ==  '-t':
           top_modules.append(parameter)
           logInfo("added top-module = " + parameter + ".")
        elif option ==  '-T':
           top_daemon_modules.append(parameter)
           logInfo("added top-daemon-module = " + parameter + ".")
        elif option == '-F':
           ahir_fn_libs.append(parameter)
           logInfo("added full-path-of-function-lib  " + parameter + ".")
        elif option ==  '-C':
           c_src_dirs.append(parameter)
           logInfo("added c-source-directory = " + parameter + ".")
        elif option ==  '-I':
           c_include_dirs.append(parameter)
           logInfo("added c-include_directory = " + parameter + ".")
        elif option ==  '-A':
           aa_src_files.append(parameter)
           logInfo("added aa-source-file = " + parameter + ".")
        elif option == '-S':
           start_point = parameter
           logInfo("start-point = " + parameter + ".")
        elif option == '-E':
           end_point = parameter
           logInfo("end-point = " + parameter + ".")
        elif option == '-s':
           sim_type = parameter
           logInfo("simulator-type = " + sim_type + ".")
        elif option == '-W':
           vhdl_library_name = parameter
           logInfo("vhdl-library-name = " + vhdl_library_name + ".")
        elif option == '-P':
           aa_source_prefix = parameter
           logInfo("aa-source-prefix = " + parameter + ".")
        elif option ==  '-D':
           debug_flag = 1
           logInfo("set debug-flag = 1.")
        elif option ==  '-G':
           use_gnu_pth = True
           logInfo("set use-gnu-pth = True.")
        elif option ==  '-U':
           suppress_io_pipes = True
           logInfo("set suppress-io-pipes = True.")
        elif option == '-h':
           help_flag = 1
        elif option == '-R':
           clean_flag = 1

    if (aa_source_prefix == None):
       aa_source_prefix = vhdl_library_name + "_" + app_name 
    
    return app_name, work_area, top_modules, top_daemon_modules, c_src_dirs, c_include_dirs, aa_src_files, start_point, end_point, help_flag, clean_flag, err_flag, ahir_fn_libs, sim_type, vhdl_library_name, aa_source_prefix, debug_flag, use_gnu_pth, suppress_io_pipes, balance_flag, opaque_flag


# The top-level script which builds VHDL from source.
#
# Author: Madhav Desai 
#
# Brief Description:
#   Specify C source-files, Aa source-files and AHIR function libraries.
#   Also the top-level modules.
#   The script then generates the corresponding VHDL.
#
#
#     -a <app-name> 
#     -w <work-area>
#     (-t (<top-module>)*  (note: multiple top-modules can be specified)
#     (-T (<top-daemon-module>)*  (note: multiple top-modules can be specified)
#     (-F  <ahir-function-library-to-include>)*
#     (-W <vhdl-library-name)?
#     -S  <start-point> ({ "", to_llvm, to_aa, to_aa2c, to_vc, to_vhdl, to_sim} ) 
#     -E  <end-point> (one of {to_llvm, to_aa, to_aa2c, to_vc, to_vhdl, to_sim} ) 
#     -h  (print help message)
#     -s  <simulator-type> (modelsim/ghdl)
#     (-C  (c-source-dir))*
#     (-I  (c-include-dir))*
#     (-A  (aa-source-dir))*
#     (-B)?  to balance paths inside pipelined loops.
#     (-U)?  I/O pipes in top-module will have depth=0
#     (-D)?  if debug info to be available in generated code.
#     (-G)?   to link generated code to Gnu-pth instead of pthreads.
#     (-R)?  remove everything that was built
def printUsage():
    print (''' 
     -a <app-name> 
     -w <work-area>
     (-t (<top-module>)*  (note: multiple top-modules can be specified)
     (-T (<top-daemon-module>)*  (note: multiple top-modules can be specified)
     (-F  <ahir-function-library-to-include>)*
     (-W  <vhdl-library-name>)?  (default is work.)
     -S  <start-point> ({ "", to_llvm, to_aa, to_aa2c,  to_vc, to_vhdl, to_sim} ) 
     -E  <end-point> (one of {to_llvm, to_aa, to_aa2c, to_vc, to_vhdl, to_sim} ) 
     -h  (print help message)
     -s  <simulator-type> (modelsim/ghdl)
     (-C  (c-source-dir))*
     (-I  (c-include-dir))*
     (-A  (aa-source-dir))*
     (-B)?  to balance paths inside pipelined loops.
     (-N)?  if specified, respect pipe and load-store dependencies through calls.
     (-D)?  to add debug info to generated VHDL
     (-U)?  I/O pipes in top-module will have depth=0
     (-G)?  to link generated code to Gnu-pth instead of pthreads (deprecated)..
     (-R)?  remove everything that was built
          ''')
def main():

    ahir_release = os.environ.get('AHIR_RELEASE')
    if(ahir_release == None):
       logError (" environment variable AHIR_RELEASE is not defined." )
       return 1

    if len(sys.argv) < 2:
       printUsage()
       return 1

    arg_list = sys.argv[1:]
   
    opts,args = getopt.getopt(arg_list,'a:w:t:T:S:E:C:A:I:F:hs:RW:DGUBN')
    app_name, work_area, top_modules, top_daemon_modules, c_src_dirs, c_include_dirs, aa_src_files, start_point, stop_point, help_flag, clean_flag, err_flag, ahir_fn_libs, sim_type, vhdl_library_name, aa_source_prefix, debug_flag, use_gnu_pth, suppress_io_pipes, balance_flag, opaque_flag  = parseOptions(opts)



    global command_log_file
    command_log_file = open(work_area + "/executed_command_log.txt","a")


    if(clean_flag):
        cleanWorkArea(work_area)
        command_log_file.close()
        return 0

    if(app_name == ""):
       logError("specify an application name ")
       printUsage()
       command_log_file.close()
       return 1

    if((len(top_modules) == 0) and (len(top_daemon_modules) == 0) and (start_point != "to_sim")):
       logError("top-module and top-daemon-module sets cannot both be empty. ")
       command_log_file.close()
       return 1

    if sim_type == None:
       logError("simulator-choice not specified: set simulator to modelsim or ghdl.")
       return 1

    saved_cwd = os.getcwd()
    if(os.path.isdir(work_area) != 1):
       logError("project-directory " + work_area + " not found")
       logError("project directory " + work_area + " not found")
       command_log_file.close()
       return 1
   
    if(err_flag == 1):
        command_log_file.close()
        return 1

    if(help_flag == 1):
        printUsage()
        command_log_file.close()
        return 0

    #     set all the global constants (include-paths, libraries etc. etc.)
    setGlobals(ahir_release)

    # change to work-area.
    os.chdir(work_area)


    make_llvm = ((start_point == "") or  (start_point == "to_llvm"))

    if(make_llvm):
       
        define_list = []
        ret_val = makeC2Llvm(c_src_dirs, c_include_dirs, define_list)
        if(ret_val):
           os.chdir(saved_cwd)
           command_log_file.close()
           return 1
    
    if(stop_point == "to_llvm"):
        os.chdir(saved_cwd)
        command_log_file.close()
        return 0

    make_aa = (make_llvm or (start_point == "to_aa"))
    if(make_aa):
         ret_val = makeLlvm2Aa(aa_src_files, ahir_fn_libs, balance_flag)
         if(ret_val):
           os.chdir(saved_cwd)
           command_log_file.close()
           return 1
 
    
    if(stop_point == "to_aa"):
        os.chdir(saved_cwd)
        command_log_file.close()
        return 0

    make_aa2c = (make_aa  or (start_point == "to_aa2c"))
    if(make_aa2c):
        ret_val = makeAa2C(app_name, aa_source_prefix, top_daemon_modules, use_gnu_pth)
        if(ret_val):
           os.chdir(saved_cwd)
           command_log_file.close()
           return 1

    if(stop_point == "to_aa2c"):
        os.chdir(saved_cwd)
        command_log_file.close()
        return 0

    make_vc = (make_aa2c or (start_point == "to_vc"))
    if(make_vc):
       ret_val = makeAa2Vc(app_name, opaque_flag)
       if(ret_val):
           os.chdir(saved_cwd)
           command_log_file.close()
           return 1
    
    if(stop_point == "to_vc"):
        os.chdir(saved_cwd)
        command_log_file.close()
        return 0

    make_vhdl = (make_vc or (start_point == "to_vhdl"))
    if(make_vhdl):
       ret_val = makeVc2Vhdl(app_name, top_modules, top_daemon_modules, ahir_fn_libs, sim_type, vhdl_library_name, debug_flag, suppress_io_pipes)
       if(ret_val):
          os.chdir(saved_cwd)
          command_log_file.close()
          return 1

    
    if(stop_point == "to_vhdl"):
        os.chdir(saved_cwd)
        command_log_file.close()
        return 0
    
    make_vhdlsim = (make_vhdl or (start_point == "to_vhdl"))
    if(make_vhdlsim):
       ret_val = makeVhdlSim(app_name, sim_type, vhdl_library_name)
       if(ret_val):
         os.chdir(saved_cwd)
         command_log_file.close()
         return 1

    
    os.chdir(saved_cwd)
    command_log_file.close()
    return 0

if __name__ == '__main__':
    ret_val = main()
    sys.exit(ret_val)
