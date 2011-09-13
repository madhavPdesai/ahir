#include <stdint.h>
#define __DIV_LOOP(reduced_dividend,divisor,quotient,TNAME) while(reduced_dividend >= divisor)\
   	{\
		TNAME curr_quotient = 1;\
        	TNAME shifted_divisor = divisor;\
        	TNAME reduced_dividend_by_2 = (reduced_dividend >> 1);\
		while(1)\
		{\
			if(shifted_divisor < reduced_dividend_by_2)\
			{\
				shifted_divisor = (shifted_divisor << 1);\
				curr_quotient = (curr_quotient << 1);\
			}\
			else	\
		  	break;\
		}\
		quotient += curr_quotient;\
		reduced_dividend -= shifted_divisor;\
   	}

uint64_t udiv64(uint64_t dividend, uint64_t divisor) 
{

   uint64_t quotient = 0;
   if(divisor != 0)
   {
   	uint64_t reduced_dividend = dividend;
	__DIV_LOOP(reduced_dividend,divisor,quotient,uint64_t)
   }
   return(quotient);
}
int64_t  sdiv64(int64_t dividend, int64_t divisor)
{
   char sign = 1;  // 1 is positive. 
   uint64_t udividend, udivisor;
   if(dividend < 0 )
   {
	sign = -sign;
        udividend = (uint64_t) (-dividend);
   }
   else
	udividend = (uint64_t) dividend;

   if(divisor < 0)
   {
	sign = -sign;
	udivisor = (uint64_t) (-divisor);
   }
   else
	udivisor = (uint64_t) divisor;

   int64_t quotient = -1;
   if(udivisor != 0)
   {
   	quotient = (int64_t) udiv64(udividend, udivisor);
   	if(sign < 0)
		quotient = - quotient;
   }
	
   return(quotient);
}
uint32_t udiv32(uint32_t dividend, uint32_t divisor) 
{

   uint32_t quotient = 0;
   if(divisor != 0)
   {
   	uint32_t reduced_dividend = dividend;
	__DIV_LOOP(reduced_dividend,divisor,quotient,uint32_t)
   }
   return(quotient);
}
int32_t  sdiv32(int32_t dividend, int32_t divisor)
{
   char sign = 1;  // 1 is positive. 
   uint32_t udividend, udivisor;
   if(dividend < 0 )
   {
	sign = -sign;
        udividend = (uint32_t) (-dividend);
   }
   else
	udividend = (uint32_t) dividend;

   if(divisor < 0)
   {
	sign = -sign;
	udivisor = (uint32_t) (-divisor);
   }
   else
	udivisor = (uint32_t) divisor;

   int32_t quotient = -1;
   if(udivisor != 0)
   {
   	quotient = (int32_t) udiv32(udividend, udivisor);
   	if(sign < 0)
		quotient = - quotient;
   }
	
   return(quotient);
}
uint16_t udiv16(uint16_t dividend, uint16_t divisor) 
{

   uint16_t quotient = 0;
   if(divisor != 0)
   {
   	uint16_t reduced_dividend = dividend;
	__DIV_LOOP(reduced_dividend,divisor,quotient,uint16_t)
   }
   return(quotient);
}
int16_t  sdiv16(int16_t dividend, int16_t divisor)
{
   char sign = 1;  // 1 is positive. 
   uint16_t udividend, udivisor;
   if(dividend < 0 )
   {
	sign = -sign;
        udividend = (uint16_t) (-dividend);
   }
   else
	udividend = (uint16_t) dividend;

   if(divisor < 0)
   {
	sign = -sign;
	udivisor = (uint16_t) (-divisor);
   }
   else
	udivisor = (uint16_t) divisor;

   int16_t quotient = -1;
   if(udivisor != 0)
   {
   	quotient = (int16_t) udiv16(udividend, udivisor);
   	if(sign < 0)
		quotient = - quotient;
   }
	
   return(quotient);
}
uint8_t udiv8(uint8_t dividend, uint8_t divisor) 
{

   uint8_t quotient = 0;
   if(divisor != 0)
   {
   	uint8_t reduced_dividend = dividend;
	__DIV_LOOP(reduced_dividend,divisor,quotient,uint8_t)
   }
   return(quotient);
}
int8_t  sdiv8(int8_t dividend, int8_t divisor)
{
   char sign = 1;  // 1 is positive. 
   uint8_t udividend, udivisor;
   if(dividend < 0 )
   {
	sign = -sign;
        udividend = (uint8_t) (-dividend);
   }
   else
	udividend = (uint8_t) dividend;

   if(divisor < 0)
   {
	sign = -sign;
	udivisor = (uint8_t) (-divisor);
   }
   else
	udivisor = (uint8_t) divisor;

   int8_t quotient = -1;
   if(udivisor != 0)
   {
   	quotient = (int8_t) udiv8(udividend, udivisor);
   	if(sign < 0)
		quotient = - quotient;
   }
	
   return(quotient);
}
uint64_t urem64(uint64_t dividend, uint64_t divisor) 
{
   uint64_t quotient = 0;
   uint64_t reduced_dividend = dividend;
   if(divisor != 0)
   {
	__DIV_LOOP(reduced_dividend,divisor,quotient,uint64_t)
   }
   return(reduced_dividend);
}
int64_t  srem64(int64_t dividend, int64_t divisor)
{
   char sign = 1;  // 1 is positive. 
   uint64_t udividend, udivisor;
   if(dividend < 0 )
   {
	sign = -sign;
        udividend = (uint64_t) (-dividend);
   }
   else
	udividend = (uint64_t) dividend;

   if(divisor < 0)
   {
	sign = -sign;
	udivisor = (uint64_t) (-divisor);
   }
   else
	udivisor = (uint64_t) divisor;

   int64_t remainder = dividend;
   if(udivisor != 0)
   {
   	remainder = (int64_t) urem64(udividend, udivisor);
   	if(sign < 0)
		remainder = - remainder;
   }
   return(remainder);
}
uint32_t urem32(uint32_t dividend, uint32_t divisor) 
{
   uint32_t quotient = 0;
   uint32_t reduced_dividend = dividend;
   if(divisor != 0)
   {
	__DIV_LOOP(reduced_dividend,divisor,quotient,uint32_t)
   }
   return(reduced_dividend);
}
int32_t  srem32(int32_t dividend, int32_t divisor)
{
   char sign = 1;  // 1 is positive. 
   uint32_t udividend, udivisor;
   if(dividend < 0 )
   {
	sign = -sign;
        udividend = (uint32_t) (-dividend);
   }
   else
	udividend = (uint32_t) dividend;

   if(divisor < 0)
   {
	sign = -sign;
	udivisor = (uint32_t) (-divisor);
   }
   else
	udivisor = (uint32_t) divisor;

   int32_t remainder = dividend;
   if(udivisor != 0)
   {
   	remainder = (int32_t) urem32(udividend, udivisor);
   	if(sign < 0)
		remainder = - remainder;
   }
   return(remainder);
}
uint16_t urem16(uint16_t dividend, uint16_t divisor) 
{
   uint16_t quotient = 0;
   uint16_t reduced_dividend = dividend;
   if(divisor != 0)
   {
	__DIV_LOOP(reduced_dividend,divisor,quotient,uint16_t)
   }
   return(reduced_dividend);
}
int16_t  srem16(int16_t dividend, int16_t divisor)
{
   char sign = 1;  // 1 is positive. 
   uint16_t udividend, udivisor;
   if(dividend < 0 )
   {
	sign = -sign;
        udividend = (uint16_t) (-dividend);
   }
   else
	udividend = (uint16_t) dividend;

   if(divisor < 0)
   {
	sign = -sign;
	udivisor = (uint16_t) (-divisor);
   }
   else
	udivisor = (uint16_t) divisor;

   int16_t remainder = dividend;
   if(udivisor != 0)
   {
   	remainder = (int16_t) urem16(udividend, udivisor);
   	if(sign < 0)
		remainder = - remainder;
   }
   return(remainder);
}
uint8_t urem8(uint8_t dividend, uint8_t divisor) 
{
   uint8_t quotient = 0;
   uint8_t reduced_dividend = dividend;
   if(divisor != 0)
   {
	__DIV_LOOP(reduced_dividend,divisor,quotient,uint8_t)
   }
   return(reduced_dividend);
}
int8_t  srem8(int8_t dividend, int8_t divisor)
{
   char sign = 1;  // 1 is positive. 
   uint8_t udividend, udivisor;
   if(dividend < 0 )
   {
	sign = -sign;
        udividend = (uint8_t) (-dividend);
   }
   else
	udividend = (uint8_t) dividend;

   if(divisor < 0)
   {
	sign = -sign;
	udivisor = (uint8_t) (-divisor);
   }
   else
	udivisor = (uint8_t) divisor;

   int8_t remainder = dividend;
   if(udivisor != 0)
   {
   	remainder = (int8_t) urem8(udividend, udivisor);
   	if(sign < 0)
		remainder = - remainder;
   }
   return(remainder);
}
