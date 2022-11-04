CWD=$(pwd)
cd utils
echo "compiling generate utils"
./compile.sh
cd $CWD
cd scl180
echo "generate cut products for scl180"
./generateCutProducts.sh
cd $CWD
cd umc65
echo "generate cut products for umc65"
./generateCutProducts.sh
cd $CWD
cd sac
echo "generate cut products for sac"
./generateCutProducts.sh
cd $CWD
cd for_fpga_impl_of_asic_rtl
./build.sh
cd $CWD
