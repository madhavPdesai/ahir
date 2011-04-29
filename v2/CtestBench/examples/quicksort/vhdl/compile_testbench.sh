gcc -g -c vhdlCStubs.c -I./ -I../../../include 
gcc -g -c testbench.c -I./ -I../../../include
gcc -g -o testbench testbench.o vhdlCStubs.o  -L../../../lib -lSocketLib -lpthread
