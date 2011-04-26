gcc -c vhdlCStubs.c -I./ -I../../../include 
gcc -c testbench.c -I./ -I../../../include
gcc -o testbench testbench.o vhdlCStubs.o  -L../../../lib -lSocketLib -lpthread
