#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#ifdef USE_GNUPTH
#include <pth.h>
#include <GnuPthUtils.h>
#else
#include <pthread.h>
#include <pthreadUtils.h>
#endif 
#include <Pipes.h>
#include <pipeHandler.h>
#include "prog.h"
#ifndef SW
#include "vhdlCStubs.h"
#endif

int main(void)
{
  printf("%x\n", start());
}
