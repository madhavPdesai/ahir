#!/bin/bash
CWD=$(pwd)
export AHIR_RELEASE=$(pwd)/release
export BOOST_VERSION=boost_1_74_0
#export BOOST_VERSION=boost_1_58_0
#export LD_LIBRARY_PATH=/opt/glibc-2.14/lib:$LD_LIBRARY_PATH
echo "setting boost version" to $BOOST_VERSION
echo "Making vhdl release."
cd vhdl/ahir/memory_subsystem/base_bank_asic/
./build.sh
cd $CWD
cd vhdl/release
. cat.sh
. catForAsic.scl180.sh
. catForAsicFpga.scl180.sh
. catForAsic.umc65.sh
. catForAsicFpga.umc65.sh
. catForAsic.sac.sh
. catForAsicFpga.sac.sh
cd $CWD
echo "Running scons to build tools."
cd v2
source build_bashrc
scons
cd $CWD
echo "Copying files to release area."
make -f ReleaseMakefile
echo "Setting version"
echo "----------------------------------------------------------------------------" >> $AHIR_RELEASE/VERSION
echo $(date) >> $AHIR_RELEASE/VERSION
git log -n 1 >> $AHIR_RELEASE/VERSION
echo "----------------------------------------------------------------------------" >> $AHIR_RELEASE/VERSION
