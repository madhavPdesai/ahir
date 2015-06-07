../../../bin/Aa2C BranchBlock.aa
indent aa_c_model.c
indent aa_c_model.h
gcc -g -c -I$AHIR_RELEASE/include   -I./ aa_c_model.c
gcc -g -c -I$AHIR_RELEASE/include   -I./ driver.c
gcc -g -o driver driver.o aa_c_model.o -L$AHIR_RELEASE/lib   -lPipeHandler -lpthread -lBitVectors
rm *.o *~
