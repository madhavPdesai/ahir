#!/bin/bash
buildHierarchicalModel.py -D -M -u -H -C  -a SYS_LIB pipes.aa
cd testbench
. compile.sh
cd ..
