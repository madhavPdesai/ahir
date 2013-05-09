#include <stdlib.h>
#include <timer.h>

void countDownTimer(uint32_t time_count)
{
	while(time_count > 0)
		time_count--;

	return;
}
