../../../bin/Aa2C Concats.aa
indent aa_c_model.c
indent aa_c_model.h
gcc -g -c -I$AHIR_RELEASE/BitVectors/include  -I$AHIR_RELEASE/pipeHandler/include  -I$AHIR_RELEASE/pthreadUtils/include -I./ aa_c_model.c
gcc -g -c -I$AHIR_RELEASE/BitVectors/include  -I$AHIR_RELEASE/pipeHandler/include  -I$AHIR_RELEASE/pthreadUtils/include  -I./ driver.c
gcc -g -o driver driver.o aa_c_model.o -L$AHIR_RELEASE/BitVectors/lib/ -lBitVectors -L$AHIR_RELEASE/pipeHandler/lib  -lPipeHandler -lpthread
rm *.o *~
