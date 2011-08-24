# build software version of testbench (to check the "desired behaviour")
# note: read/write functions will be found in ../../../iolib/
gcc -c -I../../../iolib prog.c
gcc -c -I../../../iolib testbench.c
gcc -o testbench prog.o testbench.o -L../../../iolib -lio -lpthread
#
# run testbench (it will need a random seed)
#
