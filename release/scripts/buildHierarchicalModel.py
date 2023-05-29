#!/usr/bin/env python 
#
# buildHierarchicalModel.py is a top-level script which 
# searches for useful info in  a list of directories and builds a C
# model.
#
# Borrows lots from IMAGE RC.
#  (Thanks to Powai Labs).
#
# Brief Description:
#   The script walks the directory tree starting from the
#   working-directory = ./
#   If the -M option is specified
#      all makefiles in the directory tree rooted at working-dir
#      are executed.
#   If the -R option is specified
#      All makefiles encountered in the hierarchy will
#      be executed as 'make clean'
#   If the -H option is specified
#      all the hsys files in the directory tree rooted at working-dir
#      are assembled and a C model is created in  working-dir/aa2c/
#   If the -C option is specified.
#      all source files in aa2c subdirectories in the tree
#      rooted at working-dir are compiled into objsw/ and
#      an archive is created in lib/.
#                and
#      a top-level VHDL file is created in the vhdl/ directory.
#   If the -D option is specified
#      C files will be compiled with the " -gdwarf-2 -g3 " flags.
#      (to enable macro info in gdb).
#   If the -O option is specified
#      C files will be compiled with the " -O3 " flags.
#
#
#   Typically, one does 
#            -M
#            -H
#            -C
#
#   To clean, use 
#            -R
#
#
#
# Author: Madhav Desai

# Modification: 
#	added simulation choice <modelsim>|<ghdl>
#	change the default choice as preferred on line: 278
#	modified by: Ashfaque Ahammed
#	date: 23-Nov-2015
# 
from __future__ import division, print_function

import os
import os.path
import shutil
import getopt
import sys
import glob
import threading 
import subprocess
import pdb
import time


# run system command.
def execSysCmd(sys_cmd):
    logCommand(sys_cmd)
    ret_val = os.system(sys_cmd)
    return ret_val

# clean the work-area, remove all the stuff produced by the script.
def cleanWorkArea(work_area):

    execSysCmd("rm -rf " + work_area + "./objsw")
    execSysCmd("rm -f "  + work_area + "./lib")
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

    ccflag_string = CFLAGS

        
    cc_command = ""
    for src_dir in SRC_DIRS:
        for sfile in os.listdir(src_dir):
            name,extn = os.path.splitext(sfile)
            if(extn == ".c"):
               cc_command = CC + " -pthread -c " + ccflag_string  + " " + include_string + " " +  define_string + " " + src_dir + "/" + sfile  + " -o " + OBJ + "/" + name + ".o"
               logInfo("executing compile-command\n\t " + cc_command)
               ret_val = execSysCmd(cc_command)
               if(ret_val != 0):
                   #pdb.set_trace()
                   logError("in compiling file " + sfile)
                   err_flag = 1

    return err_flag

    
# build static library
def buildArchive(DEST_DIR, LIBNAME, OBJDIRS):
    err_flag = 0

    ar_cmd = "ar -rcs " + DEST_DIR + "/lib" + LIBNAME + ".a "
    for objdir in OBJDIRS:
        obj_files = os.listdir(objdir)
        for obj_file in obj_files:
            root,ext = os.path.splitext(obj_file)
            if(ext == ".o"):
               ar_cmd += " " + objdir + "/" +  obj_file
    
    logInfo("executing archive-command\n\t " + ar_cmd)
    err_flag = execSysCmd(ar_cmd)

    return(err_flag)


   

#
# Author: Madhav Desai 
#
# Brief Description:
#   The script walks the directory tree starting from the
#   working-directory = ./
#   If the -M option is specified
#      all makefiles in the directory tree rooted at working-dir
#      are executed.
#   If the -H option is specified
#      all the hsys files in the directory tree rooted at working-dir
#      are assembled and a C model is created in  working-dir/aa2c/
#   If the -C option is specified.
#      all source files in aa2c subdirectories in the tree
#      rooted at working-dir are compiled into objsw/ and
#      an archive is created in lib/.
#
#   Typically, one does 
#            -M
#            -H
#            -C
#
#
#
def printUsage():
    print (''' 
     -a <app-name> 
     -u (if uniquification needed)
     -M (if all makefiles needs to be exexcuted)
     -H (if  hsys needs to be expanded)
     [-J <hsys-file>]*  hsys files to be read before starting walk.
     -C (if  C model needs to be created).
     -D (cc-flags set -gdwarf-2 -g3).
     -O (cc-flags set -O3).
     -R (to clean)
     (-s ghdl/modelsim)?  (default is ghdl)
     (-I  (c-include-dir))*
     src-dir-1 src-dir-2 ... src-dir-n.
          ''')

def buildUniquifyMaps (uniquification_file):
    #pdb.set_trace()
    logInfo ("entered buildUniquifyMaps (" + uniquification_file + ")")
    ret_prefix_rename_map = {}
    ret_rpipe_rename_map = {}
    ret_wpipe_rename_map = {}
    ret_register_pipe_rename_map = {}

    uf = open (uniquification_file, 'r')

    for line in uf:
       if line[0] != '!':
          split_line = line.split ()
          sys_prefix = split_line[1] + "_" + split_line[2] + "_"
          add_link = []
          if split_line[0] == "prefix_rename":
             if (len(split_line) != 4):
                logError ("incomplete line in uniquify file " + uniquification_file + ":" + line)     
             else:
                add_link.append(split_line[1] + "_" + split_line[3] + "_")
                if sys_prefix in ret_prefix_rename_map:
                   ret_prefix_rename_map[sys_prefix] += add_link
                else:
                   ret_prefix_rename_map[sys_prefix] = add_link
                logInfo ("buildUniquifyMaps: prefix_rename_map[" + sys_prefix + "]  += " + add_link[0])
          elif split_line[0] == "register_pipe_rename":
             if (len(split_line) != 6):
                logError ("incomplete line in uniquify file " + uniquification_file + ":" + line)     
             else:
                add_link.append(split_line[1] + "_" + split_line[3] + "_ " + split_line[4] + " " + split_line[5])
                if sys_prefix in ret_register_pipe_rename_map:
                   ret_register_pipe_rename_map[sys_prefix] += add_link
                else:
                   ret_register_pipe_rename_map[sys_prefix] = add_link
                logInfo ("buildUniquifyMaps: register_pipe_rename_map[" + sys_prefix + "]  += " + add_link[0])
          elif split_line[0] == "rpipe_rename":
             if (len(split_line) != 6):
                logError ("incomplete line in uniquify file " + uniquification_file + ":" + line)     
             else:
                add_link.append(split_line[1] + "_" + split_line[3] + "_ " + split_line[4] + " " + split_line[5])
                if sys_prefix in ret_rpipe_rename_map:
                   ret_rpipe_rename_map[sys_prefix] += add_link
                else:
                   ret_rpipe_rename_map[sys_prefix] = add_link
                logInfo ("buildUniquifyMaps: rpipe_rename_map[" + sys_prefix + "]  += " + add_link[0])
          elif split_line[0] == "wpipe_rename":
             if (len(split_line) != 6):
                logError ("incomplete line in uniquify file " + uniquification_file + ":" + line)     
             else:
                add_link.append(split_line[1] + "_" + split_line[3] + "_ " + split_line[4] + " " + split_line[5])
                if sys_prefix in ret_wpipe_rename_map:
                   ret_wpipe_rename_map[sys_prefix] += add_link
                else:
                   ret_wpipe_rename_map[sys_prefix] = add_link

                logInfo ("buildUniquifyMaps: wpipe_rename_map[" + sys_prefix + "]  += " + add_link[0])
          else:
             logError ("Junk line in uniquify file " + uniquification_file + ", ignored")


    return ret_prefix_rename_map, ret_rpipe_rename_map, ret_wpipe_rename_map, ret_register_pipe_rename_map
                 
def uniquifyAa2cDirectory (aa2c_dir, prefix_rename_map, rpipe_rename_map, wpipe_rename_map, register_pipe_rename_map):

    #pdb.set_trace()
    logInfo ("entered uniquifyAa2cDirectory " + aa2c_dir)

    # read prefix file, if file not found, report error and quit
    prefix_file = aa2c_dir + "/PREFIX"
    if not os.path.isfile(prefix_file):
       logInfo ("no prefix file, skipping aa2c directory " + aa2c_dir)
       return 0

    pf = open (aa2c_dir + "/PREFIX", 'r')
    sys_prefix = ""
    if (pf != None):
       pline = pf.readline ()
       split_pline = pline.split ()
       if (len(split_pline) != 1):
          logError ("malformed line in prefix file in aa2c-directory " + aa2c_dir + ":" + pline)
          return 1
 
       sys_prefix = split_pline[0]
       logInfo ("found prefix " + sys_prefix)
    else:
       logError ("prefix file not found in aa2c-directory " + aa2c_dir)
       return 1

    # we have the prefix.
    logInfo ("uniquifying in " + aa2c_dir + ", prefix=" + sys_prefix)
    for cfile in os.listdir(aa2c_dir):
       suffix = ""
       if (cfile == (sys_prefix + "aa_c_model.h")):
          suffix = "aa_c_model.h"
       elif (cfile == (sys_prefix + "aa_c_model_internal.h")):
          suffix = "aa_c_model_internal.h"
       elif (cfile == (sys_prefix + "aa_c_model.c")):
          suffix = "aa_c_model.c"
       if suffix != "": 
           createRenamedFiles (sys_prefix, suffix,  aa2c_dir, cfile, prefix_rename_map, rpipe_rename_map, wpipe_rename_map, register_pipe_rename_map)

    return 0

           
def createRenamedFiles (sys_prefix, suffix, aa2c_dir, cfile, prefix_rename_map, rpipe_rename_map, wpipe_rename_map, register_pipe_rename_map):
    #pdb.set_trace()
    logInfo ("createRenamedFiles for prefix= " + sys_prefix + ", aa2c_dir= " + aa2c_dir)
    tmp_dir = aa2c_dir +  "/uniquify_tmp" 

    if(os.path.isdir(tmp_dir) != 1):
        os.mkdir(tmp_dir)
    else:
        execSysCmd("rm -rf " + tmp_dir + "/*")

    execSysCmd ("mv " + aa2c_dir  + "/" + cfile + " " + tmp_dir)

    # rename prefixes
    #pdb.set_trace()
    if sys_prefix in prefix_rename_map:
        lprefix_cmds = prefix_rename_map[sys_prefix]
        base_cfile = tmp_dir + "/" + cfile
        for prefix_cmd in lprefix_cmds:
            prefix_cmd_fields = prefix_cmd.split()
            if len(prefix_cmd_fields) == 1 :
                f = prefix_cmd_fields[0]
                dest_file = aa2c_dir + "/" + f + suffix
                sed_cmd = "sed " + '"' + "s/" + sys_prefix + "/" + f + "/g" + '"' +  " " + base_cfile + " > " + dest_file
                logInfo ("apply sed: " + sed_cmd)
                execSysCmd(sed_cmd)
            else:
               logError ("incorrect prefix_rename command: " + prefix_cmd)
               return 1
    else:
       #pdb.set_trace()
       logError("missing sys prefix " + sys_prefix + " did you include the library-name in the aa2c prefix")
       return 1

    # register pipe rename commands
    if sys_prefix in register_pipe_rename_map :
        register_pipe_rename_cmds = register_pipe_rename_map[sys_prefix]
        for register_pipe_rename_cmd in register_pipe_rename_cmds:
            register_pipe_rename_cmd_fields = register_pipe_rename_cmd.split()
            if(len(register_pipe_rename_cmd_fields) != 3):
               logError ("incorrect register_pipe_rename command: " + register_pipe_rename_cmd)
               return 1
            dest_file = aa2c_dir + "/" + register_pipe_rename_cmd_fields[0] + suffix
            rfn_name = "register_pipe"
            orig_string = rfn_name + "(\\\"" +  register_pipe_rename_cmd_fields[1] + "\\\""
            repl_string = rfn_name + "(\\\"" +  register_pipe_rename_cmd_fields[2] + "\\\""
            sed_cmd = "sed -i  " + '"' + "s/" + orig_string  + "/" + repl_string + "/g" +  '"' + " " + dest_file
            logInfo ("apply sed: " + sed_cmd)
            execSysCmd(sed_cmd)
            rfn_name = "register_signal"
            orig_string = rfn_name + "(\\\"" +  register_pipe_rename_cmd_fields[1] + "\\\""
            repl_string = rfn_name + "(\\\"" +  register_pipe_rename_cmd_fields[2] + "\\\""
            sed_cmd = "sed -i  " + '"' + "s/" + orig_string  + "/" + repl_string + "/g" +  '"' + " " + dest_file
            logInfo ("apply sed: " + sed_cmd)
            execSysCmd(sed_cmd)

    # rename read-pipe commands
    if sys_prefix in rpipe_rename_map :
        rpipe_rename_cmds = rpipe_rename_map[sys_prefix]
        for rpipe_rename_cmd in rpipe_rename_cmds:
            rpipe_rename_cmd_fields = rpipe_rename_cmd.split()
            if(len(rpipe_rename_cmd_fields) != 3):
               logError ("incorrect rpipe_rename command: " + rpipe_rename_cmd)
               return 1
            dest_file = aa2c_dir + "/" + rpipe_rename_cmd_fields[0] + suffix
            rfn_name = "read_bit_vector_from_pipe"
            orig_string = rfn_name + "(\\\"" +  rpipe_rename_cmd_fields[1] + "\\\""
            repl_string = rfn_name + "(\\\"" +  rpipe_rename_cmd_fields[2] + "\\\""
            sed_cmd = "sed -i  " + '"' + "s/" + orig_string  + "/" + repl_string + "/g" +  '"' + " " + dest_file
            logInfo ("apply sed: " + sed_cmd)
            execSysCmd(sed_cmd)

    # rename write-pipe commands
    if sys_prefix in wpipe_rename_map:
        wpipe_rename_cmds = wpipe_rename_map[sys_prefix]
        for wpipe_rename_cmd in wpipe_rename_cmds:
            wpipe_rename_cmd_fields = wpipe_rename_cmd.split()
            if(len(wpipe_rename_cmd_fields) != 3):
               logError ("incorrect wpipe_rename command: " + wpipe_rename_cmd)
               return 1
            dest_file = aa2c_dir + "/" + wpipe_rename_cmd_fields[0] + suffix
            wfn_name = "write_bit_vector_to_pipe"
            orig_string = wfn_name + "(\\\"" +  wpipe_rename_cmd_fields[1] + "\\\""
            repl_string = wfn_name + "(\\\"" +  wpipe_rename_cmd_fields[2] + "\\\""
            sed_cmd = "sed -i  " + '"' + "s/" + orig_string  + "/" + repl_string + "/g" +  '"' + " " + dest_file
            logInfo ("apply sed: " + sed_cmd)
            execSysCmd(sed_cmd)

    return 0


def main():

    #pdb.set_trace()

    ahir_release = os.environ.get('AHIR_RELEASE')
    if(ahir_release == None):
       logError (" environment variable AHIR_RELEASE is not defined." )
       return 1

    if len(sys.argv) < 2:
       printUsage()
       return 1

    arg_list = sys.argv[1:]
    hiersys2c_flag = False
    compile_aa2c_files = False
    make_flag = False
    clean_flag = False
    debug_flag = False
    use_gnu_pth = False

    hsys_list = []

    uniquify_flag = False

    simulator_choice = "ghdl"

    opts,args = getopt.getopt(arg_list,'a:I:s:tHCMRDOuJ:')
    #pdb.set_trace()
    app_name = ""
    c_include_dirs = []
    cc_flags =  " "
    for option, parameter in opts:
        if option ==  '-a':
           app_name = parameter
           logInfo("application-name  = " + parameter + ".")
        elif option ==  '-u':
           uniquify_flag = True
           logInfo("uniquification mode set to true")
        elif option ==  '-I':
           c_include_dirs.append(parameter)
           logInfo("added c-include_directory = " + parameter + ".")
        elif option ==  '-D':
           debug_flag = True
           cc_flags = " -gdwarf-2 -g3 "
           logInfo("debug mode selected cc-flags = " + cc_flags + ".")
        elif option ==  '-O':
           cc_flags = " -O3 "
           logInfo("optimize mode selected cc-flags = " + cc_flags + ".")
        elif option ==  '-G':
           use_gnu_pth = True
           logInfo("link to gnu-pth = True.")
        elif option ==  '-H':
           hiersys2c_flag = True
           logInfo("only hsys files will be expanded")
	elif option == '-J':
           hsys_list.append(parameter)
           logInfo("added hsys file " + parameter)
        elif option ==  '-C':
           compile_aa2c_files = True
           logInfo("all aa2c files will be compiled into library")
        elif option ==  '-M':
           make_flag = True
           logInfo("all make files in the hierarchy will be executed. ")
        elif option ==  '-R':
           make_flag = True
           clean_flag = True
           logInfo("all secondary products in the hierarchy will be removed. ")
        elif option == "-s":
           simulator_choice = parameter
           logInfo("simulator-choice = " + simulator_choice + ".")
        else:
           logError("unknown-option " + option)
           return 1

    work_area = "./"
    global command_log_file
    command_log_file = open(work_area + "/executed_command_log.txt","a")


    if(app_name == ""):
        logError("specify an application name ")
        printUsage()
        command_log_file.close()
        return 1

    #default compilation and simulation [ghdl | modelsim]
    if ((not clean_flag) and (simulator_choice == None)):
       logError("unspecified simulator-type (ghdl/modelsim), set simulator (-s) to ghdl or modelsim")
       return 1

    # set all the global constants (include-paths, libraries etc. etc.)
    setGlobals(ahir_release)

    prefix_rename_map = { }
    rpipe_rename_map = { }
    wpipe_rename_map = { }
    register_pipe_rename_map = { }

    # 0 = success.
    ret_status  = 0

    # walk this directory.. note bottom up..
    src_list = []

    # as you walk, execute the makefiles that you
    # see.  This will produce aa2c directories 
    # and also hsys files.
    for root, dirs, files in os.walk(work_area, topdown=False, followlinks=True):

        for fname in files:
           full_name = os.path.join(root, fname)
           rootfname, extn = os.path.splitext(fname)
           if(make_flag and (fname == "Makefile")):
              #
              # existing makefiles will be executed in reverse
              # order (leaves first)
              #
              logInfo("found Makefile in " + root)
              cwd = os.getcwd()
              make_cmd = "make -C " + root
              if(debug_flag):
                 make_cmd += " DEBUG=-D "
              if(clean_flag):
                 make_cmd += " clean"

              if (simulator_choice != None):
                 make_cmd += " SIMULATOR=-s\ "
                 make_cmd += simulator_choice

              if(use_gnu_pth):
                  make_cmd += " GNUPTH=-G "

              #pdb.set_trace()
              make_status = execSysCmd(make_cmd)
              if(make_status):
                 logError("make failed in " + root)
                 return 1

    
    # as you walk, collect the hsys files that you see.
    for root, dirs, files in os.walk(work_area, topdown=False, followlinks=True):
        for fname in files:
           full_name = os.path.join(root, fname)

           rootfname, extn = os.path.splitext(fname)
           if(hiersys2c_flag and (extn == ".hsys")):
              logInfo("found hsys file " + full_name)
              hsys_list.append(full_name)

    #
    # construct the hierarchical model from lower level constructs.
    #
    if((len(hsys_list) > 0) and compile_aa2c_files):
        hiersys2c_cmd = "hierSys2C -n " + app_name  + " -o aa2c "
        if uniquify_flag:
           hiersys2c_cmd += " -u " 
        if(use_gnu_pth): 
            hiersys2c_cmd += " -G "
        for aafile in args:
            hiersys2c_cmd += aafile + " "
        for hsys_file in hsys_list:
            hiersys2c_cmd += hsys_file + " " 
        #pdb.set_trace()
        hsys2c_status = execSysCmd(hiersys2c_cmd)
        if(hsys2c_status):
            logError("hierSys2C failed in " + work_area)
            return 1

        if uniquify_flag:
           hiersysuqf_cmd = "hierSysUniquify "
           for aafile in args:
              hiersysuqf_cmd += aafile + " "
           for hsys_file in hsys_list:
              hiersysuqf_cmd += hsys_file + " " 
           hsysuqf_status = execSysCmd(hiersysuqf_cmd)
           if(hsysuqf_status):
              logError("hierSysPartition (uniquify) failed in " + work_area)
              return 1

           uniquification_file = "__UFQ.TXT"
           prefix_rename_map,  rpipe_rename_map, wpipe_rename_map, register_pipe_rename_map  = buildUniquifyMaps (uniquification_file)
    elif (hiersys2c_flag and (len(hsys_list) == 0)):
        logError("no hsys files found under " + work_area)
        return 1

    # C files..  collect them.  Note that they will be uniquified if
    # -u option has been used.
    for root, dirs, files in os.walk(work_area, topdown=False, followlinks=True):
        for name in dirs:
           full_name = os.path.join(root, name)
           if uniquify_flag:
              logInfo("uniquifying aa2c directory " + full_name)
              uniquifyAa2cDirectory (full_name, prefix_rename_map, rpipe_rename_map, wpipe_rename_map, register_pipe_rename_map)
           if(compile_aa2c_files and (name == "aa2c")):
              logInfo("found aa2c directory " + full_name)
              src_list.append(full_name)
              c_include_dirs.append(full_name)

    # C files... compile them
    if((len(src_list) > 0) and compile_aa2c_files):
        ret_status = compileFiles("gcc", src_list, "./objsw", cc_flags, c_include_dirs,"") 
        if(ret_status):
           #pdb.set_trace()
           logError("compilation failed.") 
           return 1
    elif (compile_aa2c_files):
        logError("no aa2c subdirectories found under " + root)
        return 1


    if (compile_aa2c_files):
        obj_dirs = []
        obj_dirs.append("./objsw")
        ret_status = buildArchive("./lib", app_name, obj_dirs)


    # create a top-level VHDL file.
    if(len(hsys_list) > 0):
        hiersys2vhdl_cmd = "hierSys2Vhdl -s " + simulator_choice +  " -o vhdl " 
        for aafile in args:
            hiersys2vhdl_cmd += aafile + " "
        for hsys_file in hsys_list:
            hiersys2vhdl_cmd += hsys_file + " " 
        hsys2vhdl_status = execSysCmd(hiersys2vhdl_cmd)
        if(hsys2vhdl_status):
            logError("hierSys2Vhdl failed in " + root)
            return 1
        format_cmd = "formatVhdlFiles.py vhdl"
        ret_status = execSysCmd(format_cmd)

    return ret_status

if __name__ == '__main__':
    ret_val = main()
    sys.exit(ret_val)
