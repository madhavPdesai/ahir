#include <aa_c_model.h>
uint_32 u[2];
uint_32 v[2][2];
int passpointer(uint_32 a, uint_32*  b)
{
passpointer_State* __top = (passpointer_State*) calloc(1,sizeof(passpointer_State));
__top->passpointer_entry = 1;
	__top->a = a;
	while(!__top->passpointer_exit) 
	{ 
		__top = passpointer_(__top);
	} 
	*b= __top->b;
cfree(__top);
return AASUCCESS; 
}
passpointer_State* passpointer_(passpointer_State* __top)
{
if (__top->passpointer_entry) {
__top->passpointer_entry = 0;
__top->passpointer_in_progress = 1;
__top->passpointer_entry = 0;
__top->passpointer_in_progress = 1;
__top->_assign_line_24_entry = 1;
}
if (__top->passpointer_in_progress) {
// -------------------------------------------------------------------------------------------
// Begin Statement _assign_line_24
// -------------------------------------------------------------------------------------------
if (__top->_assign_line_24_entry)
{
if (1) {
