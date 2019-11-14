gcc -g -o tb -DSW  -I../aa2c/ main.c -I $AHIR_RELEASE/include -L ../lib/ -lSYS_LIB -L $AHIR_RELEASE/lib -lPipeHandlerDebugPthreads -lpthread -lBitVectors -lSockPipes
