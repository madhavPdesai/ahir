#!/bin/bash
TOPMODULES="-T stage_2_daemon"
AAFILES="-A stage2.aa"
buildProcessorHDL.py -a Stage2 -W S2 -E to_vhdl $TOPMODULES $AAFILES

