#include <stdint.h>
#include "divider.h"
#include "gcd.h"
#include <timer.h>
uint16_t N[ORDER];

uint16_t gcd2(uint16_t a, uint16_t b)
{
	uint16_t L = (a < b ? a : b);
	uint16_t H = (a < b ? b : a);

	uint16_t r;
	uint16_t q;
	while(L != 0)
	{
		r = L;

		uint16_t tmp = L;
		q = udiv16(H,L,&L);
		H = tmp;
	}
	return(r);
}

uint16_t gcd()
{
	uint16_t i;
	uint16_t g = gcd2(N[0],N[1]);

	for(i = 2; i < ORDER; i++)
	{
		g = gcd2(g,N[i]);
	}

	return(g);
}

void gcd_daemon()
{
	while(1)
	{
		int i;
		for(i = 0; i < ORDER; i++)
			N[i] = read_uint16("in_data");

		uint32_t start_time = getClockTime();
		uint16_t g = gcd();
		countDownTimer(1024);
		uint32_t stop_time  = getClockTime();

		write_uint16("out_data",g);
		write_uint32("elapsed_time", (stop_time - start_time));
	}
}
