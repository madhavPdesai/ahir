Aa2C -T stage_0 -T stage_1 -T stage_2 -T stage_3 ShiftRegister.aa
indent aa_c_model.c
indent aa_c_model.h
gcc -gdwarf-2 -g3  -c -I$AHIR_RELEASE/include -I./ aa_c_model.c
gcc -gdwarf-2 -g3  -c -I$AHIR_RELEASE/include -I./ driver.c
gcc -gdwarf-2 -g3  -o driver driver.o aa_c_model.o -L$AHIR_RELEASE/lib -lPipeHandler -lpthread -lBitVectors -lSockPipes
rm *.o *~
