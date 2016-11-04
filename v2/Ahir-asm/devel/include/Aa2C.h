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
#ifndef __Aa2C__h__
#define __Aa2C__h__
#include <stdlib.h>
#include <stdint.h>
#include <AaEnums.h>
#define AASUCCESS 0
#define AAFAILURE 1

class AaType;
class AaExpression;
class AaValue;
class AaObject;
class AaPipeObject;


void Print_C_Trace(ostream& ofile);
void Print_C_Assert_If_Bitvector_Undefined(string var_name, ostream& ofile);
		
void Print_C_Pipe_Registration(string pipe_name, AaType* pipe_type, int  depth, bool signal_mode, bool lifo_mode, bool noblock_flag, ofstream& ofile);
void Print_C_Declaration(string obj_name, bool static_flag, AaType* obj_type,  ofstream& ofile);
void Print_C_Global_Declaration(string obj_name, AaType* obj_type, ofstream& ofile);
void Print_C_Global_Initialization(string obj_name, AaType* obj_type,  ofstream& ofile);
void Print_C_Assignment_To_Constant(string tgt_c_ref, AaType* tgt_type, AaValue* v, ofstream& ofile);
void Print_C_Assignment(string tgt, string src, AaType* t, ofstream& ofile);
string C_Value_Expression(string cref, AaType* t);
void Print_C_Value_Expression(string cref, AaType* t, ofstream& ofile);
			
void Print_C_Uint64_To_BitVector_Assignment(string src, string dest, AaType* t, ofstream& ofile); 
void Print_BitVector_To_C_Uint64_Assignment(string src, string dest, AaType* t, ofstream& ofile);

void Print_C_Pipe_Read(string tgt, AaType* tgt_type, AaPipeObject* p, ofstream& ofile);
void Print_C_Pipe_Write(string src, AaType* src_type, AaPipeObject* p, ofstream& ofile);
void Print_C_Type_Cast_Operation(bool bit_cast, string src, AaType* src_type, string tgt, AaType* tgt_type, ofstream& ofile);
void Print_C_Unary_Operation(string src, AaType* src_type, string tgt, AaType* tgt_type, AaOperation op, ofstream& ofile);
void Print_C_Binary_Operation(string src1, AaType* src1_type, string src2,  AaType* src2_type, 
			string tgt, AaType* tgt_type, AaOperation Op, ofstream& ofile);
void Print_C_Ternary_Operation(string test,
			AaType* test_type, string if_expr,
			AaType* if_expr_type, 
			string else_expr, AaType* else_expr_type, 
			string tgt, AaType* tgt_type, ofstream& ofile);
void Print_C_Slice_Operation(string src, AaType* src_type, int _low_index, string tgt,
				AaType* tgt_type, ofstream& ofile);


void Print_C_Report_String(string seq_id, string tag, string qs, ofstream& ofile);
void Print_C_Report_String_Expr_Pair(string seq_id, string tag, string qs, string expr, AaType* etype, ofstream& ofile);


#endif
