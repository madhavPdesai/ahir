# build software version of testbench (to check the "desired behaviour")
# note: read/write functions will be found in ../../../iolib/
gcc -g -c -I../../../iolib insertionsort.c
gcc  -g -c -I../../../iolib testbench.c
gcc -g -o testbench insertionsort.o testbench.o -L../../../iolib -lio -lpthread
#
# run testbench (it will need a random seed)
#
