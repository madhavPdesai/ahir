#!/bin/bash
CWD=$(pwd)
cd scl180
echo "generate reverse wrappers for scl180"
./generateVhdl.sh
cd $CWD
cd umc65
echo "generate reverse wrappers for umc65"
./generateVhdl.sh
cd $CWD
cd sac
echo "generate reverse wrappers for sac"
./generateVhdl.sh
cd $CWD
