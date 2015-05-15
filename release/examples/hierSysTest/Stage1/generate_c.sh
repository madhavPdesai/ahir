#!/bin/bash
TOPMODULES="-T stage_1_daemon  " 
AAFILES=" stage1.aa"
PREFIX="S1_"
C_FILE=$PREFIX"aa_c_model.c"
Aa2C -I dummy_mempool  -P $PREFIX $TOPMODULES $AAFILES 
indent $C_FILE
          
