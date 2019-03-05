#include <stdint.h>

#define BYTE uint8_t
#define WORD uint32_t

/* Circular Shift by one Bit of Byte   ..Eg   1100 1100 => 1001 1001 */
#define ROTL(x) ( (((x)>>7)|((x)<<1)) & 0xFF)

/* Circular Shift by one Byte of Word  ..Eg   2 3 1 4 => 3 1 4 2  */
#define ROTL8(x) (((x)<<8)|((x)>>24))

/* Circular Shift by two Byte of Word  ..Eg   2 3 1 4 => 1 4 2 3  */
#define ROTL16(x) (((x)<<16)|((x)>>16))

/* Circular Shift by three Byte of Word..Eg   2 3 1 4 => 4 2 3 1  */
#define ROTL24(x) (((x)<<24)|((x)>>8))


#define nb 128			/* nb = block size in Bits */
#define nk 128			/* nk = Key Lenngth in Bits */
#define Nb (nb>>5)		/* Nb= Number of colomn in the STATE = block lengh/32 */
#define Nk (nk>>5)		/* Nk= Number of colomn in Cipher key= Keylength/32   */
#define Nr 10			/* Nr= Number of rounds as a function of block and key length */

void encrypt();
WORD SubByte(WORD);
/*
  WORD pack(BYTE *);
*/
void unpack(WORD, BYTE *);
WORD MixCol(WORD x);
void gkey();
BYTE product(WORD, WORD);
BYTE bmul(BYTE, BYTE);
BYTE mod(WORD, WORD);


/* Polynomial for encryption */
/* BYTE MxCo[4]={0x02, 0x03, 0x01, 0x01}; */
#define MxCo 0x1010302


#define bmul(x, y) (((x) && (y)) ? E[mod((L[(x)] + L[(y)]), 255)] : 0)

#define pack(b) (((WORD) (b)[3] << 24)		     \
		 | ((WORD) (b)[2] << 16)	     \
		 | ((WORD) (b)[1] << 8)		     \
		 | (b)[0])


