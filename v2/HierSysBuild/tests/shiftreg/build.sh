#!/bin/bash
buildHierarchicalModel.py -D -M -u -H -C  -a SR4 pipes.aa
cd testbench
. compile.sh
cd ..
