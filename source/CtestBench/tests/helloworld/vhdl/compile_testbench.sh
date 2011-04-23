gcc -c vhdlCStubs.c -I./ -I../../../include 
gcc -c testbench.c -I./ -I../../../include
gcc -o testbench testbench.o ahirPlug.o  -L../../../lib -lSocketLib -lpthread
