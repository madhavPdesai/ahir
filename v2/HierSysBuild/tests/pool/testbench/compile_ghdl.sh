gcc -g -o tb_ghdl -I../aa2c/ -I $AHIR_RELEASE/include main.c -L ../lib/ -lSYS_LIB -L $AHIR_RELEASE/lib -lSocketLibPipeHandler -lpthread -lBitVectors -lSockPipes
