#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include "prog.h"
uint32_t doSum(uint32_t* ptr, uint32_t v)
{
	return(*ptr + v);
}

