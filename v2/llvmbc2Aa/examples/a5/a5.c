//
// Copyright (C) 2010-: Madhav P. Desai
// All Rights Reserved.
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal with the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimers.
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimers in the documentation and/or other materials provided
//    with the distribution.
//  * Neither the names of the AHIR Team, the Indian Institute of
//    Technology Bombay, nor the names of its contributors may be used
//    to endorse or promote products derived from this Software
//    without specific prior written permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.

/*  A5/1 Stream Cipher implementation
    Implemnted by : Prakalp Somawanshi
    DATE:   10/01/2008
    M.Tech : Electrical- Control & Computing   */



/* Masks for the three shift registers */
#define R1MASK	0x07FFFF	/* 19 bits, numbered 0..18 */
#define R2MASK	0x3FFFFF	/* 22 bits, numbered 0..21 */
#define R3MASK	0x7FFFFF	/* 23 bits, numbered 0..22 */

/* Middle bit of each of the three shift registers, for clock control*/
#define R1MID	0x000100	/* bit 8 */
#define R2MID	0x000400	/* bit 10 */
#define R3MID	0x000400	/* bit 10 */

/* Feedback taps, for clocking the shift registers.
 * These correspond to the primitive polynomials
 * x^19 + x^5 + x^2 + x + 1, x^22 + x + 1,
 * and x^23 + x^15 + x^2 + x + 1. */

#define R11TAPS	0x040000	/* bits 18 */
#define R12TAPS	0x020000	/* bits 17 */
#define R13TAPS	0x010000	/* bits 16 */
#define R14TAPS	0x002000	/* bits 13 */

#define R21TAPS	0x200000	/* bits 21 */
#define R22TAPS	0x100000	/* bits 20 */

#define R31TAPS	0x400000	/* bits 22 */
#define R32TAPS	0x200000	/* bits 21 */
#define R33TAPS	0x100000	/* bits 20 */
#define R34TAPS	0x000080	/* bits 7  */


/* Output taps, for output generation */
#define R1OUT	0x040000	/* bit 18 (the high bit) */
#define R2OUT	0x200000	/* bit 21 (the high bit) */
#define R3OUT	0x400000	/* bit 22 (the high bit) */

#ifdef RUN
#include <stdio.h>
#endif

void a5init(void);
unsigned int a5reg(void);
void initreg(void);
unsigned int key[2];
unsigned int AtoB[4];
unsigned int BtoA[4];

unsigned int frame;


unsigned int R1;
unsigned int R2;
unsigned int R3;

unsigned int a5reg()
{

  unsigned int i, out = 0, t1, t2, t3, t4;

  unsigned int tempR1 = R1;
  unsigned int tempR2 = R2;
  unsigned int tempR3 = R3;

  unsigned int tempRR1 = tempR1;
  unsigned int tempRR2 = tempR2;
  unsigned int tempRR3 = tempR3;

  /* Look at the middle bits of R1,R2,R3. */

  unsigned shr1 = tempR1 >> 8;
  unsigned shr2 = tempR2 >> 10;
  unsigned shr3 = tempR3 >> 10;

  int ctap1 = 0 - (shr1 & 1);
  int ctap2 = 0 - (shr2 & 1);
  int ctap3 = 0 - (shr3 & 1);

  /* Majority value of tapped middle bits of R1,R2,R3 will decide
     condition for clockin R1,R2,R3 */

  // condition for clockin reg2 
  int condition2
      = (~ctap2 & ~ctap3)
      | (~ctap1 & ctap3)
      | (ctap1 & ctap2);

  // condition for clockin reg3
  int condition3
      = (~ctap2 & ~ctap3)
      | (~ctap1 & ctap2)
      | (ctap1 & ctap3);

  // condition for clockin reg1
  int condition1
      = (~ctap1 & ~ctap3)
      | (~ctap2 & ctap3)
      | (ctap1 & ctap2);

  /* Tapped 18,17,16,13th bit of R1 will decide LSB of R1 after
     clockin */

  t1 = tempR1 >> 18;
  t2 = tempR1 >> 17;
  t3 = tempR1 >> 16;
  t4 = tempR1 >> 13;
  t1 = t1 ^ t2;
  t3 = t3 ^ t4;
  t1 = t1 ^ t3;
  t1 = t1 & 1;
  tempR1 = (tempR1 << 1) & R1MASK;
  tempR1 |= t1;


  /* Tapped 21,20th bit of R2 will decide LSB of R2 after clockin */

  t1 = tempR2 >> 21;
  t2 = tempR2 >> 20;
  t1 = t1 ^ t2;
  t1 = t1 & 1;
  tempR2 = (tempR2 << 1) & R2MASK;
  tempR2 |= t1;


  /* Tapped 22,21,7th bit of R3 will decide LSB of R3 after clockin */


  t1 = tempR3 >> 22;
  t2 = tempR3 >> 21;
  t3 = tempR3 >> 20;
  t4 = tempR3 >> 7;
  t1 = t1 ^ t2;
  t3 = t3 ^ t4;
  t1 = t1 ^ t3;
  t1 = t1 & 1;
  tempR3 = (tempR3 << 1) & R3MASK;
  tempR3 |= t1;

  tempRR1 = tempR1 & condition1 | tempRR1 & ~condition1;
  tempRR2 = tempR2 & condition2 | tempRR2 & ~condition2;
  tempRR3 = tempR3 & condition3 | tempRR3 & ~condition3;
  
  /* Generation of Keystream bit after X-or ing MSB of all LFSR's */

  t1 = tempRR1 >> 18;
  t2 = tempRR2 >> 21;
  t3 = tempRR3 >> 22;

  t1 = t1 ^ t2;
  t1 = t1 ^ t3;
  t1 = t1 & 1;

  R1 = tempRR1;
  R2 = tempRR2;
  R3 = tempRR3;

  return t1;
}

void initreg()
{

  unsigned char i, t1, t2, t3, t4;

  unsigned int tempR1 = R1;
  unsigned int tempR2 = R2;
  unsigned int tempR3 = R3;

  /* Tapped 18,17,16,13th bit of R1 will decide LSB of R1 after
     clockin */

  t1 = (tempR1 & R11TAPS) >> 18;
  t2 = (tempR1 & R12TAPS) >> 17;
  t3 = (tempR1 & R13TAPS) >> 16;
  t4 = (tempR1 & R14TAPS) >> 13;
  tempR1 = (tempR1 << 1) & R1MASK;
  tempR1 |= (t1 ^ t2 ^ t3 ^ t4);


  /* Tapped 21,20th bit of R2 will decide LSB of R2 after clockin */

  t1 = (tempR2 & R21TAPS) >> 21;
  t2 = (tempR2 & R22TAPS) >> 20;
  tempR2 = (tempR2 << 1) & R2MASK;
  tempR2 |= (t1 ^ t2);


  /* Tapped 22,21,7th bit of R3 will decide LSB of R3 after clockin */

  t1 = (tempR3 & R31TAPS) >> 22;
  t2 = (tempR3 & R32TAPS) >> 21;
  t3 = (tempR3 & R33TAPS) >> 20;
  t4 = (tempR3 & R34TAPS) >> 7;
  tempR3 = (tempR3 << 1) & R3MASK;
  tempR3 |= (t1 ^ t2 ^ t3 ^ t4);


  R1 = tempR1;
  R2 = tempR2;
  R3 = tempR3;
}

void a5init ()
{

  unsigned char i;
  unsigned int keybit, framebit;

  /* Load the key into the shift registers, LSB of first byte of key
   * array first, clocking each register once for every key bit
   * loaded. (The usual clock control rule is temporarily
   * disabled.) */


  for (i = 0; i < 64; i++)
    {
      keybit = (key[i >> 5] >> (i & 31)) & 1;	/* The i-th bit of the key */
      R1 ^= keybit;
      R2 ^= keybit;
      R3 ^= keybit;
      initreg();	/*clockallthree(R1,R2,R3);  */
    }

  /* Load the frame number into the shift registers, LSB first,
   * clocking each register once for every key bit loaded. (The usual
   * clock control rule is still disabled.) */

  for (i = 0; i < 22; i++)
    {
      framebit = (frame >> i) & 1;	/* The i-th bit of the frame */
      R1 ^= framebit;
      R2 ^= framebit;
      R3 ^= framebit;
      initreg();	/*clockallthree(R1,R2,R3);  */
    }


  /* Run the shift registers for 100 clocks to mix the keying material
   * and frame number together with output generation disabled, so
   * that there is sufficient avalanche. We re-enable the
   * majority-based clock control rule from now on. */

  for (i = 0; i < 100; i++)
    {
      a5reg();
    }
}


int
main (void)
{
  /* Zero out the shift registers. */
  unsigned char i;
  unsigned int out = 0;

  R1 = R2 = R3 = 0;
  frame = 0;

  key[0] = 0xFFFFFFFF;
  key[1] = 0xFFFFFFFF;

  a5init();

#ifdef RUN
  printf("R1: %u\n", R1);
  printf("R2: %u\n", R2);
  printf("R3: %u\n", R3);
#endif 

  for (i = 0; i < 32; ++i)
    out |= a5reg() << (31 - (i & 31));
  
#ifdef RUN
  printf("stream: %u\n", out);
#endif 

  return out;
}

