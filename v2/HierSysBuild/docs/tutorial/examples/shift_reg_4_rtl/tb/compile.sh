gcc -g -c  -I ./ -I ../aa2c -I $AHIR_RELEASE/include tb.c
gcc -g  tb.o -o tb_ghdl -L $AHIR_RELEASE/lib -L ../lib -lBitVectors -lSockPipes   -lpthread
rm *.o 
