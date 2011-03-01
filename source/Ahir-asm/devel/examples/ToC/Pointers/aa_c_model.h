#include <Aa2C.h>
typedef struct passpointer_State__ {
	uint_32 a;
	uint_32 b;
	unsigned int _assign_line_24_entry: 1; 
	unsigned int _assign_line_24_in_progress: 1; 
	unsigned int _assign_line_24_exit: 1; 
	uint_32* q;
	unsigned passpointer_entry : 1;
	unsigned passpointer_in_progress : 1;
	unsigned passpointer_exit : 1;
} passpointer_State;
passpointer_State* passpointer_(passpointer_State*);
int passpointer(uint_32, uint_32* );
