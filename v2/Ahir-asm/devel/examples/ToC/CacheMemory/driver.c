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
#include <stdio.h>
#include <aa_c_model.h>

typedef struct _Req
{
	unsigned char is_read;
	uint_8 address;
	uint_32 data;
} Req;


// the main program which calls the shift register
int main(int argc, char* argv[])
{
	cachememory();
	return(1);
}


int Fetch(pointer* req)
{
	static uint_8 addr = { 0 };
	static uint_32 data = { 0 };
	static char is_read = 0;

	if(req->__val == NULL)
		req->__val = (void*) calloc(1,sizeof(Req));

	((Req*)(req->__val))->is_read = is_read;
	((Req*)(req->__val))->address = addr;
	((Req*)(req->__val))->data    = data;


	is_read = 1 - is_read;

	if(!is_read)
	{
		addr.__val++;
		data.__val++;
	}

	if(addr.__val > 15)
		exit(0);

	return(0);
}

int Is_Read_Access(pointer req, uint_1* flag)
{
	if(req.__val && ((Req*)(req.__val))->is_read)
		(*flag).__val = 1;
	else
		(*flag).__val = 0;
	return(0);
}


int Access_Address(pointer req, uint_8* addr)
{
	if(req.__val)
		(*addr) = ((Req*)(req.__val))->address;
	return(0);
}

int Access_Data(pointer req, uint_32* data)
{
	if(req.__val)
		(*data) = ((Req*)(req.__val))->data;
	return(0);
}

int Write_Hit(uint_8 addr)
{
	printf("write hit on addr %d\n", addr.__val);
	return(0);
}

int Write_Miss(uint_8 addr)
{
	printf("write miss on addr %d\n", addr.__val);
	return(0);
}

int Read_Hit(uint_8 addr, uint_32 data)
{
	printf("read hit on addr %d, data %d\n", addr.__val, data.__val);
	return(0);
}

int Read_Miss(uint_8 addr)
{
	printf("read miss on addr %d\n", addr.__val);
	return(0);
}
