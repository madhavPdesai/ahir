#!/bin/bash
rm -rf aa2c lib vhdl

mkdir aa2c
mkdir lib
mkdir vhdl

PARAMETERS=""
PIPES="pipes.aa"

# 
# -D means generate debug versions of the aa2c and vhdl
# -M execute all Makefiles in this directory and its subdirectories.
# -u uniquify all instances in the aa2c code (VHDL is always uniquified).
# -H hierarchically expand all the hsys files (go to the leaves!)
# -C generate aa2c model
# -s ghdl (simulator is ghdl)
#
# The final model uses shift_register_lib as a prefix..
#
buildHierarchicalModel.py -D -M -u -H -C -s ghdl  -a  shift_register_lib -I$AHIR_RELEASE/include $PARAMETERS $PIPES



