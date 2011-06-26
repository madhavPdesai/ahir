# build software version of testbench (to check the "desired behaviour")
# note: read/write functions will be found in ../../../iolib/
gcc -c -DRUN  -I/home/madhav/ahirgit/AHIR/v2/iolib prog.c
gcc -c -DRUN -I/home/madhav/ahirgit/AHIR/v2/iolib testbench.c
gcc -o testbench prog.o testbench.o -L/home/madhav/ahirgit/AHIR/v2/iolib -lio -lpthread
