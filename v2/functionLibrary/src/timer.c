#include <stdlib.h>
#include <timer.h>
#include <time.h>

void countDownTimer(uint32_t time_count)
{
	return;
}


uint32_t getClockTime()
{
	struct timespec c_time;
	clock_gettime(CLOCK_REALTIME,& c_time);
        return(c_time.tv_nsec);		
}
