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
#include <rtlInclusions.h>
#include <rtlEnums.h>


string rtlOp_To_String(rtlOperation op)
{
	string ret_string;
	switch(op)
	{

		case __NOP:
			break;
		case __NOT:
			ret_string = "~";
			break;
		case __OR:
			ret_string = "|";
			break;
		case __AND:
			ret_string = "&";
			break;
		case __XOR:
			ret_string = "^";
			break;
		case __NOR:
			ret_string = "~|";
			break;
		case __NAND:
			ret_string = "~&";
			break;
		case __XNOR:
			ret_string = "~^";
			break;
		case __SHL:
			ret_string = "<<";
			break;
		case __SHR:
			ret_string = ">>";
			break;
		case __ROR:
			ret_string = ">o>";
			break;
		case __ROL:
			ret_string = "<o<";
			break;
		case __EQUAL:
			ret_string = "==";
			break;
		case __NOTEQUAL:
			ret_string = "!=";
			break;
		case __LESS:
			ret_string = "<";
			break;
		case __LESSEQUAL:
			ret_string = "<=";
			break;
		case __GREATER:
			ret_string = ">";
			break;
		case __GREATEREQUAL:
			ret_string = ">=";
			break;
		case __PLUS:
			ret_string = "+";
			break;
		case __MINUS:
			ret_string = "-";
			break;
		case __MUL:
			ret_string = "*";
			break;
		case __CONCAT:
			ret_string = "&&";
			break;
		default:
			break;
	}

	return(ret_string);

}

string rtlOp_To_Vhdl_String(rtlOperation op)
{
	string ret_string;
	switch(op)
	{

		case __NOP:
			break;
		case __NOT:
			ret_string = "not";
			break;
		case __OR:
			ret_string = "or";
			break;
		case __AND:
			ret_string = "and";
			break;
		case __XOR:
			ret_string = "xor";
			break;
		case __NOR:
			ret_string = "nor";
			break;
		case __NAND:
			ret_string = "nand";
			break;
		case __XNOR:
			ret_string = "xnor";
			break;
		case __SHL:
			ret_string = "shl";
			break;
		case __SHR:
			ret_string = "shr";
			break;
		case __ROR:
			ret_string = "ror";
			break;
		case __ROL:
			ret_string = "rol";
			break;
		case __EQUAL:
			ret_string = "=";
			break;
		case __NOTEQUAL:
			ret_string = "/=";
			break;
		case __LESS:
			ret_string = "<";
			break;
		case __LESSEQUAL:
			ret_string = "<=";
			break;
		case __GREATER:
			ret_string = ">";
			break;
		case __GREATEREQUAL:
			ret_string = ">=";
			break;
		case __PLUS:
			ret_string = "+";
			break;
		case __MINUS:
			ret_string = "-";
			break;
		case __MUL:
			ret_string = "*";
			break;
		case __CONCAT:
			ret_string = "&";
			break;
		default:
			break;
	}

	return(ret_string);

}
