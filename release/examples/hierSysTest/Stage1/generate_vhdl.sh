#!/bin/bash
TOPMODULES="-T stage_1_daemon"
AAFILES="-A stage1.aa"
buildProcessorHDL.py -a Stage1 -W S1 -E to_vhdl $TOPMODULES $AAFILES

