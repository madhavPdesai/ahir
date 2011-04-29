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

