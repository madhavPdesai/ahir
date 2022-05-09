#!/usr/bin/env python
#
# formatVhdlFiles.py
#   Walks the directory looking for file with extension .unformatted_vhdl.
#   Runs vhdlFormat on them and produces .vhdl files.  The unformatted
#   files are deleted.  
#
# Borrows lots from IMAGE RC.
#  (Thanks to Powai Labs).
#
# Brief Description:
#   The script walks the directory tree starting from the
#   specified directory.  All .unformatted_vhdl files are
#   converted to .vhdl files using vhdlFormat.  The .unformatted_vhdl
#   files are deleted.
#
#
# Author: Madhav Desai
#
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

    
# logging.
def logCommand(sys_cmd):
    print ("Info: executing " + sys_cmd)

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

    
# Author: Madhav Desai 
#
# Brief Description:
#   The script walks the directory tree starting from the
#   specified root-directory.  All .unformatted_vhdl files are
#   converted to .vhdl files using vhdlFormat.  The .unformatted_vhdl
#   files are deleted.
#
def printUsage():
    print (''' 
      formatVhdlFiles <root-directory>
          ''')
def main():

    if len(sys.argv) < 2:
       printUsage()
       return 1

    work_area = sys.argv[1]


    # as you walk, check if you see a .unformatted_vhdl file, and format it.
    for root, dirs, files in os.walk(work_area, topdown=False):
        for fname in files:
           full_name = os.path.join(root, fname)

           rootfname, extn = os.path.splitext(fname)
           if(extn == ".unformatted_vhdl"):
              logInfo("found unformatted vhdl file " + full_name)
              format_cmd = "vhdlFormat < " + full_name  + " > " + root + "/" + rootfname + ".vhdl"
              format_status = execSysCmd(format_cmd)
              if(format_status):
                  logError("vhdlFormat failed for " + full_name)
                  return 1
              rm_cmd = "rm -f " + full_name
              rm_status = execSysCmd(rm_cmd)
              if(rm_status):
                  logError("rm -f failed for " + full_name)
                  return 1
    return 0

if __name__ == '__main__':
    ret_val = main()
    sys.exit(ret_val)
