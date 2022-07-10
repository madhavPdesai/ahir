#!/bin/bash
buildHierarchicalModel.py -D -M -u -H   -a SYS_LIB 
cd test_bench
. compile_ghdl.sh
cd ..
. ghdl.do
