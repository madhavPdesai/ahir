#!/bin/bash
export AHIR_RELEASE=$(pwd)/release
export BOOST_VERSION=boost_1_58_0
export LD_LIBRARY_PATH=/opt/glibc-2.14/lib:$LD_LIBRARY_PATH
echo "setting boost version" to $BOOST_VERSION
echo "Making vhdl release."
cd vhdl/release
. cat.sh
. catForAsic.sh
. catForAsicFpga.sh
cd -
echo "Running scons to build tools."
cd v2
source build_bashrc
scons
cd -
echo "Copying files to release area."
make -f ReleaseMakefile
echo "Setting version"
echo "----------------------------------------------------------------------------" >> $AHIR_RELEASE/VERSION
echo $(date) >> $AHIR_RELEASE/VERSION
git log -n 1 >> $AHIR_RELEASE/VERSION
echo "----------------------------------------------------------------------------" >> $AHIR_RELEASE/VERSION
