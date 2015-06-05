#!/bin/bash
echo "Making vhdl release."
cd vhdl/release
. cat.sh
cd -
echo "Running scons to build tools."
cd v2
source build_bashrc
scons
cd -
echo "Copying files to release area."
make -f ReleaseMakefile
