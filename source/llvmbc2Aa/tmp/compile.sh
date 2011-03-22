clang -std=gnu89 -emit-llvm -c main.c
llvm-dis main.o
opt -O3 main.o > main.opt.o
llvm-dis main.opt.o
llvm-ld main.opt.o
