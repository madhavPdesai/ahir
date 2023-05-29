#!/bin/bash
# clean up
buildHierarchicalModel.py -R -a shift_reg_lib_shift_reg_4
rm -rf objsw/*
rm -rf lib/*
rm -f __UFQ.TXT
rm -f *.log
rm -f aa2c/*
rm -f executed_command*
