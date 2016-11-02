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
// program downloaded from the internet!
// as a test case for the flow.
// 
// contributed by kanati
// http://www.blitzbasic.com/Community/posts.php?topic=57007
//


#include <stdint.h>
#include <iolib.h>
#include <stdio.h>

    
int list[100];                  
void insertionsort(int, int, int*);
int start(int N)                           // overhead!
{
    int i,j;

    // read N numbers
    for(i = 0; i < N; i++)
    {
       list[i] = read_uint32("inpipe");
    }
    
    insertionsort(0,N-1,list);
        

    // write out the sorted list        
    for(j = 0; j < N; j++)
    {
	write_uint32("outpipe",list[j]);
    }

    return 0;       // successful termination.
}

void insertionsort(int first,int last, int* list)
{
    int i,j,c;
        
    for (i=first;i<=last;i++) {
        j=list[i];
        c=i;
        while ((c > first) && (list[c-1]>j)) {
            list[c]=list[c-1];
            c--;
        }
        list[c]=j;
    }
}

