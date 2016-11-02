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


#ifdef RUN
#include <stdio.h>
#else
#include <stdint.h>
#endif

#define N 10
#define MAXELT          100
#define INFINITY        32760         // numbers in list should not exceed
                                      // this. change the value to suit your
                                      // needs
#define SMALLSIZE       5            // not less than 3
#define STACKSIZE       100           // should be ceiling(lg(MAXSIZE)+1)

int list[MAXELT+1];                   // one extra, to hold INFINITY

struct {                              // stack element.
        int a,b;
} stack[STACKSIZE];

int top;                           // initialise stack

int main_inner()                           // overhead!
{
    int i=-1,j,n;
    void quicksort(int);

    top = -1;
       
#ifdef RUN
    fprintf(stdout,"Enter %d numbers:\n ",N);
    for(i = 0; i < N; i++)
    {
	fscanf(stdin,"%d",&(list[i]));
    }

#else
    uint32_t read_uint32(const char*);

    // read N numbers
    for(i = 0; i < N; i++)
    {
       list[i] = read_uint32("inpipe");
    }
#endif
    

    quicksort(N-1);
        
        
#ifdef RUN
    printf("\nThe list obtained is ");
    for (j=0;j<N;j++)
        printf("\n %d",list[j]);
    printf("\n\nProgram over.\n");
#else
    void write_uint32(const char*, uint32_t);
    for(j = 0; j < N; j++)
    {
	write_uint32("outpipe",list[j]);
    }
#endif

    return 0;       // successful termination.
}



void interchange(int *x,int *y)        // swap
{
    int temp;
        
    temp=*x;
    *x=*y;
    *y=temp;
}

// no divider!
int divBy2(int x)
{
	return( x >> 1);
}

void split(int first,int last,int *splitpoint)
{
    int x,i,j,s,g;
    int mid = divBy2(first+last);
    // here, atleast three elements are needed
    if (list[first]< list[mid]) {  // find median
        s=first;
        g=mid;
    }
    else {
        g=first;
        s=mid;
    }
    if (list[last]<=list[s]) 
        x=s;
    else if (list[last]<=list[g])
        x=last;
    else
        x=g;
    interchange(&list[x],&list[first]);      // swap the split-point element
                                             // with the first
    x=list[first];
    i=first+1;                               // initialise
    j=last+1;
    while (i<j) {
        do {                                 // find j 
            j--;
        } while (list[j]>x);
        do {
            i++;                             // find i
        } while (list[i]<x);
        interchange(&list[i],&list[j]);      // swap
    }
    interchange(&list[i],&list[j]);          // undo the extra swap
    interchange(&list[first],&list[j]);      // bring the split-point 
                                             // element to the first
    *splitpoint=j;
}

void push(int a,int b)                        // push
{
    top++;
    stack[top].a=a;
    stack[top].b=b;
}

void pop(int *a,int *b)                       // pop
{
    *a=stack[top].a;
    *b=stack[top].b;
    top--;
}

void insertion_sort(int first,int last)
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

void quicksort(int n)
{
    int first,last,splitpoint;
    top = -1;
        
    push(0,n);
    while (top!=-1) {
        pop(&first,&last);
        for (;;) {
            if (last-first>SMALLSIZE) {
                // find the larger sub-list
                split(first,last,&splitpoint);
                // push the smaller list
                if (last-splitpoint<splitpoint-first) {
                    push(first,splitpoint-1);
                    first=splitpoint+1;
                }
                else {
                    push(splitpoint+1,last);
                    last=splitpoint-1;
                }
            }
            else {  // sort the smaller sub-lists
                    // through insertion sort
                insertion_sort(first,last);
                break;
            }
        }
    }                        // iterate for larger list
}


