#!/bin/bash
TOPMODULES="-T stage_2_daemon  " 
AAFILES=" stage2.aa"
PREFIX="S2_"
C_FILE=$PREFIX"aa_c_model.c"
Aa2C -I dummy_mempool  -P $PREFIX $TOPMODULES $AAFILES 
indent $C_FILE
          
