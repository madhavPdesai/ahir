#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include "aes.h"

BYTE E[256];
BYTE L[256];
BYTE fbsub[256];
WORD Rcon[15];
BYTE key[16];
BYTE block[16];
WORD W[Nb * (Nr + 1)];

void initKey()
{
	int I;
	key[0] = 1;
	for(I=1 ;I < 16; I++)
		key[I] = 0;
}

void getConstants()
{
	int I;
	for(I = 0; I < 256; I++)
		E[I] = read_uint8("byte_constants_pipe");
	for(I = 0; I < 256; I++)
		L[I] = read_uint8("byte_constants_pipe");
	for(I = 0; I < 256; I++)
		fbsub[I] = read_uint8("byte_constants_pipe");
	for(I = 0; I < 15; I++)
		Rcon[I] = read_uint32("word_constants_pipe");
}

BYTE mod(WORD a, WORD b)
{
    if (b == 0)
	return (BYTE) 0;
    if (a < b)
	return (BYTE) a;
    while (a >= b) {
	a = a - b;
    }
    return (BYTE) a;
}

BYTE product(WORD x, WORD y)
{				/* dot product of two 4-byte arrays */
    BYTE xb[4], yb[4];
    unpack(x, xb);
    unpack(y, yb);
    return bmul(xb[0], yb[0])
	^ bmul(xb[1], yb[1])
	^ bmul(xb[2], yb[2])
	^ bmul(xb[3], yb[3]);
}

/* unpack bytes from a word */
void unpack(WORD a, BYTE * b)
{
    b[0] = (BYTE) a;
    b[1] = (BYTE) (a >> 8);
    b[2] = (BYTE) (a >> 16);
    b[3] = (BYTE) (a >> 24);
}

BYTE key[16] = {
    1, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0
};

BYTE block[16] = {
    0, 1, 2, 3,
    4, 5, 6, 7,
    8, 9, 10, 11,
    12, 13, 14, 15
};


/*============================================================================ */
/*                          Key-Expansion                                      */
/* =========================================================================== */

void gkey()
{
    BYTE i, j;
    WORD temp;

    if (Nk < 6) {
	for (i = 0, j = 0; i < Nk; i++, j += 4)
	    W[i] = pack(key + j);
	for (i = Nk; i < (Nb * (Nr + 1)); i++) {
	    temp = W[i - 1];
	    if (i % Nk == 0)
		temp = SubByte(ROTL8(temp)) ^ Rcon[(i >> 2) - 1];
	    W[i] = W[i - Nk] ^ temp;
	}
    } else {
	for (i = 0, j = 0; i < Nk; i++, j += 4)
	    W[i] = pack(key + j);
	for (i = Nk; i < (Nb * (Nr + 1)); i++) {
	    temp = W[i - 1];
	    if (i % Nk == 0)
		temp = SubByte(ROTL8(temp)) ^ Rcon[(i >> 2) - 1];
	    else if (i % Nk == 4)
		temp = SubByte(temp);
	    W[i] = W[i - Nk] ^ temp;
	}
    }

}

/*===================================================================================*/
/*                     Encryption of 128 bit Block plain Text                         */
/*====================================================================================*/

void encrypt()
{
    BYTE i, j, k, c1, c2, c3, c6;
    WORD a;

    for (k = 0; k < 10; k++) {

	/*Round Key Addition  */
	for (i = j = 0; i < Nb; i++, j += 4) {
	    a = pack(block + j);
	    a ^= W[i + (k * 4)];
	    unpack(a, (block + j));
	}

	block[0] = fbsub[block[0]];
	c1 = fbsub[block[5]];
	
	c2 = fbsub[block[10]];
	c3 = fbsub[block[15]];
	
	block[4] = fbsub[block[4]];
	block[5] = fbsub[block[9]];
	block[9] = fbsub[block[13]];
	block[13] = fbsub[block[1]];

	c6 = fbsub[block[14]];
	
	block[8] = fbsub[block[8]];
	block[10] = fbsub[block[2]];
	block[12] = fbsub[block[12]];
	block[14] = fbsub[block[6]];
	block[15] = fbsub[block[11]];
	block[11] = fbsub[block[7]];
	block[7] = fbsub[block[3]];
	

	block[1] = c1;
	block[2] = c2;
	block[3] = c3;
	block[6] = c6;
	   
	/* Mix Column Transformation : State is considered as a polynomial
	   over GF(2^8) and multiplied modulo x^4+1 with a fixed polynomial c(x)
	   given by '03'X^3 + '01'X^2 + '01'X + '02' which is coprime to 'x^4+1' */

	if (k != 9) {
	    for (i = j = 0; i < Nb; i++, j += 4) {
		a = pack(block + j);
		a = MixCol(a);
		unpack(a, (block + j));
	    }
	}

    }

    for (i = j = 0; i < Nb; i++, j += 4) {
	a = pack(block + j);
	a ^= W[i + (k * 4)];
	unpack(a, (block + j));
    }
}

/*====================================================================================*/
/*    Pre Calculated value of S-Box : during encryption each value
      of the state is replaced with the corresponding S-Box value 
      There is an obvious time/space trade-off possible here.      
      You could have calculated it onfly                                           */
/* ================================================================================*/

WORD SubByte(WORD a)
{
    BYTE b[4];
    unpack(a, b);
    b[0] = fbsub[b[0]];
    b[1] = fbsub[b[1]];
    b[2] = fbsub[b[2]];
    b[3] = fbsub[b[3]];
    return pack(b);
}

/*===============================================================================*/
/*                    matrix Multiplication over Galois Field                    */
/*===============================================================================*/

WORD MixCol(WORD x)
{
    WORD y, m;
    BYTE b[4];

    m = MxCo;
    b[0] = product(m, x);
    m = ROTL8(m);
    b[1] = product(m, x);
    m = ROTL8(m);
    b[2] = product(m, x);
    m = ROTL8(m);
    b[3] = product(m, x);
    y = pack(b);
    return y;
}


void Daemon(void)
{

    getConstants();
    initKey();

    int i;

    W[0] = 10;
    gkey();

    while(1)
    {
	for (i = 0; i < 16; i++) {
	    block[i] = read_uint8("input_block_pipe");
	}

	encrypt();

	for (i = 0; i < 16; i++) {
	     write_uint8("output_block_pipe",block[i]);
	}
    }
}

