/* -------------------------------------------------------------------------
 * Authors         : Steve Park & Dave Geyer
 * Language        : ANSI C
 * Latest Revision : 09-22-98
 * ------------------------------------------------------------------------- 
 */

#include <stdio.h>
#include <time.h>
#include "rngs.h"

#ifndef SW
#include "vhdlCStubs.h"
#endif

int main(void)
/* ------------------------------------------------------------------
 * Use this (optional) function to test for a correct implementation.
 * ------------------------------------------------------------------    
 */
{
  int32_t   i;
  int32_t   x = 100;
  int32_t u;
  char   ok = 0;  

  Initialize();
  SelectStream(0);                  /* select the default stream */
  PutSeed(1);                       /* and set the state to 1    */
  for(i = 0; i < 10000; i++)
  {
    u = Random();
    fprintf(stdout,"%d.  %d\n", i, u);
  }
  x = GetSeed();                      /* get the new state value   */
  ok = (x == CHECK);                /* and check for correctness */

  SelectStream(1);                  /* select stream 1                 */ 
  PlantSeeds(1);                    /* set the state of all streams    */
  x = GetSeed();                      /* get the state of stream 1       */
  ok = ok && (x == A256);           /* x should be the jump multiplier */    
  if (ok)
    printf("\n The implementation of rngs.c is correct.\n\n");
  else
    printf("\n\a ERROR -- the implementation of rngs.c is not correct.\n\n");
}
