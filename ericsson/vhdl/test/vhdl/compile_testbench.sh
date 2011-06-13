gcc -c vhdlCStubs.c -I./ -I../../../../v2/CtestBench/include 
gcc -c testbench.c -I./ -I../../../../v2/CtestBench/include
gcc -o testbench testbench.o vhdlCStubs.o  -L../../../../v2/CtestBench/lib -lSocketLib -lpthread
