#include <AaType.h>
#include <AaValue.h>
#include <AaObject.h>
#include <AaModule.h>
#include <AaExpression.h>
#include <AaProgram.h>
#include <Aa2C.h>


#define __endl__  "\\\n" 

void Print_C_Trace(ostream& ofile)
{
	ofile << "__trace();" << __endl__;
}

void Print_C_Assert_If_Bitvector_Undefined(string var_name, ostream& ofile)
{
	ofile << "if (has_undefined_bit(&" << var_name << ")) {";
	ofile << "fprintf(stderr, \"Error: variable " << var_name << " has undefined value (%s) at test point.\\n\", to_string(&"
		<< var_name << "));";
	ofile << "assert(0);} " << __endl__;
}

void Print_C_Pipe_Registration(string pipe_name, AaType* pipe_type, int  depth, bool signal_mode, bool lifo_mode, 
						bool noblock_mode, ofstream& ofile)
{
	int wsize;
	int tsize = pipe_type->Size();
	if((tsize == 8) || (tsize == 16) || (tsize == 32) || (tsize == 64))
		wsize = tsize;
	else
		wsize = 8;

	int nwords = ((tsize % wsize) ? (tsize/wsize)+1 : tsize/wsize);

	if(signal_mode)
	{
		if(nwords != 1)
		{
			AaRoot::Error("Aa2C: signal-mode pipes can be either 8/16/32/64 bits-wide or must have width at most 8", NULL);
			return;
		}
		ofile << "register_signal(\"" << pipe_name << "\", " <<  wsize  << ");" << __endl__;
	}
	else
	{
		ofile << "register_pipe(\"" << pipe_name << "\", " <<  (nwords*depth)
			<< ", " << wsize << ", " <<   (lifo_mode ? 1 : (noblock_mode ? 2 : 0)) << ");" << __endl__;

	}
}

void Print_C_Declaration(string obj_name, bool static_flag, AaType* t, ofstream& ofile)
{
	if(!t->Is_Pointer_Type())
	{
		if(t->Is_Integer_Type())
		{
			if(static_flag)
			{
				ofile << "__declare_static_bit_vector(" << obj_name << "," << t->Size() << ");" << __endl__;
			}
			else
			{
				ofile << "__declare_bit_vector(" << obj_name << "," << t->Size() << ");" << __endl__;
			}
		}
		else 
		{
			ofile <<  (static_flag ? "static " : "") << t->C_Base_Name() 
				<< " " 
				<< obj_name
				<< t->C_Dimension_String();
			ofile << ";" << __endl__;
		}
	}
	else
	{
		ofile << (static_flag ? "static " : "") << t->C_Name() 
			<< " " 
			<< obj_name;
		ofile << ";" << __endl__;
	}

}

// Global objects need special care.. 
void Print_C_Global_Declaration(string obj_name, AaType* t, ofstream& ofile)
{
	//ofile << "volatile ";  // so that the compiler doesnt optimize the dang thing away.
	if(!t->Is_Pointer_Type())
	{
		if(t->Is_Integer_Type())
		{
			ofile << "bit_vector " << obj_name << ";" << __endl__;
		}
		else 
		{
			ofile <<  t->C_Base_Name() 
				<< " " 
				<< obj_name
				<< t->C_Dimension_String();
			ofile << ";" << __endl__;
		}
	}
	else
	{
		ofile << t->C_Name() 
			<< " " 
			<< obj_name;
		ofile << ";" << __endl__;
	}
}

void Print_C_Global_Initialization(string obj_name, AaType* obj_type, ofstream& ofile)
{
	if(obj_type->Is_Integer_Type())
	{	
		ofile << "init_static_bit_vector(&(" << obj_name << "), " << obj_type->Size() << ");" << __endl__;
	}
	else if(obj_type->Is_Array_Type())
	{
		AaArrayType* at = ((AaArrayType*)obj_type);
		AaType* et = at->Get_Element_Type();

		// 
		// TODO: initialize the bit-vector 
		//       elements..
		//
		//
		// iterate over the different values to check
		//
		vector<int> element_indexing;
		for(int D = 0, Dmax = at->Get_Number_Of_Dimensions(); D < Dmax; D++)
		{
			element_indexing.push_back(0);
		}


		while(1)
		{
			string cref_prefix = obj_name;
			for(int D = 0, Dmax = at->Get_Number_Of_Dimensions();D < Dmax;  D++)
			{
				cref_prefix += "[" + IntToStr(element_indexing[D]) + "]";
			}

			Print_C_Global_Initialization(cref_prefix, et, ofile);

			bool maximal_element_reached = true;
			for(int D = 0, Dmax = at->Get_Number_Of_Dimensions(); D < Dmax; D++)
			{
				if(element_indexing[D] < at->Get_Dimension(D)-1)
				{
					maximal_element_reached = false;
					break;
				}
			}	


			if(maximal_element_reached)
				break;
				
			// increment.
			if(!maximal_element_reached)
			{
				bool carry = true;
				for(int D = 0, Dmax = at->Get_Number_Of_Dimensions(); D < Dmax; D++)
				{
					if(carry)
					{
						element_indexing[D] = element_indexing[D] + 1;
						if( element_indexing[D] == at->Get_Dimension(D))
						{
							carry = true;
							element_indexing[D] = 0;
						}
						else
							carry = false;
					}
				}
				
			}
		}	
	}
	else if(obj_type->Is_Record_Type())
	{
		AaRecordType* rt = ((AaRecordType*) obj_type);
		for(int D = 0, Dmax = rt->Get_Number_Of_Elements(); D < Dmax; D++)
		{
			string cref_prefix = obj_name + ".f_" + IntToStr(D);
			AaType* et = rt->Get_Element_Type(D);
			Print_C_Global_Initialization(cref_prefix, et, ofile);
		}
	}

}

void Print_C_Assignment_To_Constant(string tgt_c_ref, AaType* tgt_type, AaValue* v, ofstream& ofile)
{
	if(tgt_type->Is_Integer_Type())
	{
		uint32_t tsize = tgt_type->Size();
		uint32_t nbytes = (tsize % 8) ? (tsize/8)+1 : tsize/8;
		uint8_t* b_array = new uint8_t[nbytes];
		v->Fill_Byte_Array(b_array,nbytes);

		ofile << "bit_vector_clear(&" << tgt_c_ref << ");" << __endl__;
		int i;
		for(i = 0; i < nbytes; i++)
		{
			if(b_array[i] != 0)
				ofile <<  tgt_c_ref << ".val.byte_array[" << i << "] = " << ((int) b_array[i]) << ";" << __endl__;
		}

		delete [] b_array;
	}
	else  if(tgt_type->Is_Scalar_Type())
	{
		ofile << tgt_c_ref << " = " << v->To_C_String() << ";" << __endl__;
	}
	else
	{
		AaRoot::Error("Aa2C: assignment to non-scalar constant not currently supported.", NULL);
		assert(0);
	}
}
void Print_C_Assignment(string tgt, string src, AaType* t, ofstream& ofile)
{
	if(t->Is_Integer_Type())
	{
		ofile << "bit_vector_cast_to_bit_vector(" << (!t->Is_Uinteger_Type() ? 1 : 0) << ", &(" << tgt << "), &(" << src << "));" << __endl__;
	}
	else if(t->Is_Scalar_Type())
	{
		ofile << tgt << " = " << src << ";" << __endl__;
	}
	else
	{
		AaRoot::Error("Aa2C: assignment with non-scalar types not currently supported.", NULL);
		assert(0);

		// will this work for array assignments?
		ofile << "memcpy( &" << tgt << ", &" <<  src << ", sizeof(" << tgt << "));" << __endl__;
	}

}

string C_Value_Expression(string cref, AaType* t)
{
	string ret_string;
	if(t->Is_Uinteger_Type() || t->Is_Integer_Type())
	{
		ret_string  = string("bit_vector_to_uint64(") + (!t->Is_Uinteger_Type() ? "1" : "0") + ", &" + cref + ")" ;
	}
	else 
	{
		ret_string = cref;
	}

	return(ret_string);
}
void Print_C_Value_Expression(string cref, AaType* t, ofstream& ofile)
{
	ofile << C_Value_Expression(cref,t);
}

void Print_C_Uint64_To_BitVector_Assignment(string src, string dest, AaType* t, ofstream& ofile) 
{
	ofile << "bit_vector_assign_uint64(" << (!t->Is_Uinteger_Type() ? 1 : 0) << ", &"
		<< dest << ", "  << src << ");" << __endl__;
}

void Print_BitVector_To_C_Uint64_Assignment(string src, string dest, AaType* t, ofstream& ofile) 
{
	ofile << dest << " =  bit_vector_to_uint64(" << (!t->Is_Uinteger_Type() ? 1 : 0) << ", &"
		<< src << ");" << __endl__;
}

void Print_C_Pipe_Read(string tgt, AaType* tgt_type, AaPipeObject* p, ofstream& ofile)
{
	int tsize = tgt_type->Size();
	if(tgt_type->Is_Integer_Type() || tgt_type->Is_Pointer_Type())
	{
		if(tgt_type->Is_Pointer_Type())
		{
			ofile << tgt << " = (" << tgt_type->C_Name() << "*)  read_pointer(\"" <<  p->Get_Name() << "\");" << __endl__;
		}
		else
		{
			ofile << "read_bit_vector_from_pipe(\"" << p->Get_Name() << "\",&(" << tgt << "));" << __endl__;
		}
	}
	else if(tgt_type->Is_Float_Type())
	{
		ofile << tgt <<  " = read_float" << tsize << "(\"" << p->Get_Name() << "\"); " << __endl__;
	}
}

void Print_C_Pipe_Write(string src, AaType* src_type, AaPipeObject* p, ofstream& ofile)
{
	int tsize = src_type->Size();
	if(src_type->Is_Integer_Type() || src_type->Is_Pointer_Type())
	{
		if(src_type->Is_Pointer_Type())
		{
			ofile << "write_pointer" << tsize << "(\"" << p->Get_Name() << "\", (void*) " << src << "); " << __endl__;
		}
		else
		{
			ofile << "write_bit_vector_to_pipe(\"" << p->Get_Name() << "\",&(" << src << "));" << __endl__;
		}
	}
	else if(src_type->Is_Float_Type())
	{
		ofile << "write_float" << tsize << "(\"" << p->Get_Name() << "\"," << src << "); " << __endl__;
	}
}

// These type casts are a ^%()@
void Print_C_Type_Cast_Operation(bool bit_cast, string src, AaType* src_type, string tgt, AaType* tgt_type, ofstream& ofile)
{
	uint8_t src_signed = src_type->Is_Integer_Type() && !src_type->Is_Uinteger_Type();
	uint8_t tgt_signed = tgt_type->Is_Integer_Type() && !tgt_type->Is_Uinteger_Type();


	uint8_t src_is_bv = src_type->Is_Integer_Type();
	uint8_t tgt_is_bv = tgt_type->Is_Integer_Type();


	// signed conversion if
	//   not bitcast and 
	//   src-is-signed and target is float/signed.
	//   tgt-is-signed and
	bool signed_conversion = (!bit_cast && 
			((tgt_type->Is_Float_Type() && src_signed) || tgt_signed));
	if(src_type->Is_Integer_Type())
	{

		if(tgt_type->Is_Integer_Type())
		{
			// if both are integer, then use bit_vector_op.
			// normal cast operation extends signs.
			uint8_t sign_flag = tgt_signed;
			if(bit_cast)
			{
				ofile << "bit_vector_bitcast_to_bit_vector("
					<< " &(" << tgt << "), &(" << src << "));" << __endl__;
			}
			else
			{
				ofile << "bit_vector_cast_to_bit_vector(" << (sign_flag ? 1 : 0) 
					<< ", &(" << tgt << "), &(" << src << "));" << __endl__;
			}
		}
		else
		{
			// target type is not an integer
			if(tgt_type->Is_Float_Type())
			{
				string tgt_type_string = "";
				if(tgt_type->Is_A_Native_C_Type())
				{
					if(tgt_type->Size() == 32)
					{
						tgt_type_string = "float";
					}
					else if(tgt_type->Size() == 64)
					{
						tgt_type_string = "double";
					}
					else
					{
						AaRoot::Error("Aa2C: unsupported float target type in conversion." , tgt_type);
						assert(0);
					}
				}

				if(src_is_bv)
				{

					uint8_t sign_flag = (!bit_cast && src_signed);
					if(bit_cast)
					{
						ofile << "bit_vector_bitcast_to_" << tgt_type_string << "(";
					}
					else
					{
						ofile << "bit_vector_cast_to_" << tgt_type_string
							<< "(" << (sign_flag ? 1 : 0)  << ", " ;
					}
					ofile << " &(" << tgt << "), "
						<< " &(" << src << "));" << __endl__;
				}
			}
			else if(tgt_type->Is_Pointer_Type())
			{
				ofile << tgt << " = (" << tgt_type->C_Name() << "*) " << " bit_vector_to_uint64(0, &(" << src << "));" << __endl__; 
			}
			else
			{
				AaRoot::Error("Aa2C: target type is not supported in conversion.", tgt_type);
				assert(0);
			}
		}
	}
	else 
	{ // src is not integer/uinteger.
		if(tgt_type->Is_Integer_Type() )
		{
			uint8_t sign_flag = tgt_signed;
			if(src_type->Is_Float_Type())
			{
				string src_type_string = "";
				if(src_type->Is_A_Native_C_Type())
				{
					uint8_t sign_flag = tgt_signed;

					// float to bit-vector.
					if(src_type->Size() == 32)
						src_type_string = "float";
					else
						src_type_string = "double";

					if(bit_cast)
						ofile << src_type_string << "_bitcast_to_bit_vector(" ;
					else 
					{
						ofile << src_type_string 
							<< "_cast_to_bit_vector(" << (sign_flag ? 1 : 0) << ", ";
					}

					ofile	<< " &(" << tgt << "), "
						<< "&("  << src << "));" << __endl__;

				}
				else
				{
					AaRoot::Error("Aa2C: unsupported float src type in conversion.", tgt_type);
					assert(0);
				}
			}
			else if(src_type->Is_Pointer_Type())
			{
				ofile << "bit_vector_assign_uint64(0"
					<< ", &(" << tgt << "), (uint64_t) ("  << src << "));" << __endl__;
			}
		}
		else
		{ // src and target are both not of integer types.
			ofile << tgt << " = (" << tgt_type->C_Name() << ") " << src << ";" << __endl__;
		} 
	}
}

void Print_C_Unary_Operation(string src, AaType* src_type, string tgt, AaType* tgt_type, AaOperation op, ofstream& ofile)
{
	if(src_type->Is_Integer_Type() )
	{
		switch(op)
		{
			case __NOT:
				ofile << "bit_vector_not( &(" << src << "), &(" << tgt << "));" << __endl__;
				break;
			case __NOP:
				ofile << "bit_vector_cast_to_bit_vector( " << (!src_type->Is_Uinteger_Type() ? 1 : 0) << ", &(" << tgt << "), &(" << src << "));" << __endl__;
				break;
			case __DECODE:
				ofile << "bit_vector_decode( &(" << src << "), &(" << tgt << "));" << __endl__;
				break;
			case __ENCODE:
				ofile << "bit_vector_encode( &(" << src << "), &(" << tgt << "));" << __endl__;
				break;
			case __PRIORITYENCODE:
				ofile << "bit_vector_priority_encode( &(" << src << "), &(" << tgt << "));" << __endl__;
				break;
			case __BITREDUCEOR:
				ofile << "bit_vector_reduce_or( &(" << src << "), &(" << tgt << "));" << __endl__;
				break;
			case __BITREDUCEAND:
				ofile << "bit_vector_reduce_and( &(" << src << "), &(" << tgt << "));" << __endl__;
				break;
			case __BITREDUCEXOR:
				ofile << "bit_vector_reduce_xor( &(" << src << "), &(" << tgt << "));" << __endl__;
				break;
			default:
				AaRoot::Error("Aa2C: unsupported unary operation", NULL);
				assert(0);
		}
	}
	else
	{
		switch(op)
		{
			case __NOT:
				ofile << tgt << " = ~(" << src << ");" << __endl__;
				break;
			case __NOP:
				ofile << tgt << " = (" << src << ");" << __endl__;
				break;
			default:
				AaRoot::Error("Aa2C: unsupported unary operation", NULL);
				assert(0);
		}
	}
}

// type of operation.
void Print_C_Binary_Operation(string src1, AaType* src1_type, string src2,  AaType* src2_type, 
		string tgt, AaType* tgt_type, AaOperation op, ofstream& ofile)
{
	bool src1_is_int = src1_type->Is_Integer_Type();
	bool src1_is_signed = (src1_is_int & !src1_type->Is_Uinteger_Type());
	uint8_t src1_is_float  = src1_type->Is_Float_Type();

	bool src2_is_int = src2_type->Is_Integer_Type();
	bool src2_is_signed = (src2_is_int & !src1_type->Is_Uinteger_Type());
	bool src2_is_float  = src2_type->Is_Float_Type();

	bool tgt_is_int = tgt_type->Is_Integer_Type();
	bool tgt_is_signed = (tgt_is_int & !src1_type->Is_Uinteger_Type());
	bool tgt_is_float  = tgt_type->Is_Float_Type();

	switch(op)
	{
		case __OR:
			if(src1_is_int)
			{
				ofile << "bit_vector_or(&(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;
			}
			else
			{
				ofile << tgt << " = (" << src1 << " | " << src2 << ");" << __endl__;
			}
			break;
		case __AND:
			if(src1_is_int)
			{
				ofile << "bit_vector_and(&(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;
			}
			else
			{
				ofile << tgt << " = (" << src1 << " & " << src2 << ");" << __endl__;
			}
			break;
		case __XOR:
			if(src1_is_int)
			{
				ofile << "bit_vector_xor(&(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;
			}
			else
			{
				ofile << tgt << " = (" << src1 << " ^ " << src2 << ");" << __endl__;
			}
			break;
		case __NOR:
			if(src1_is_int)
			{
				ofile << "bit_vector_nor(&(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;
			}
			else
			{
				ofile << tgt << " = ~(" << src1 << " | " << src2 << ");" << __endl__;
			}
			break;
		case __NAND:
			if(src1_is_int)
			{
				ofile << "bit_vector_nand(&(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;
			}
			else
			{
				ofile << tgt << " = ~(" << src1 << " & " << src2 << ");" << __endl__;
			}
			break;
		case __XNOR:
			if(src1_is_int)
			{
				ofile << "bit_vector_xnor(&(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;
			}
			else
			{
				ofile << tgt << " = ~(" << src1 << " ^ " << src2 << ");" << __endl__;
			}
			break;
		case  __SHL:
			if(src1_is_int)
			{
				ofile << "bit_vector_shift_left(&(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;
			}
			else
			{
				ofile << tgt << " = (" << src1 << " << " << src2 << ");" << __endl__;
			}
			break;
		case __SHR:
			if(src1_is_int)
			{
				ofile << "bit_vector_shift_right(" << src1_is_signed << ", &(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;	
			}
			else
			{
				ofile << tgt << " = (" << src1 << " >> " << src2 << ");" << __endl__;
			}
			break;
		case __ROR:
			if(src1_is_int)
			{
				ofile << "bit_vector_rotate_right( &(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;	
			}
			else
			{
				AaRoot::Error("Aa2C: rotate-right supported only for ints.", NULL);
				assert(0);
			}
			break;
		case __ROL:
			if(src1_is_int)
			{
				ofile << "bit_vector_rotate_left( &(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;	
			}
			else
			{
				AaRoot::Error("Aa2C: rotate-left supported only for ints.", NULL);
				assert(0);
			}
		case __PLUS:
			if(src1_is_int)
			{
				ofile << "bit_vector_plus( &(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;	
			}
			else
			{
				ofile << tgt << " = (" << src1 << " + " << src2 << ");" << __endl__;
			}
			break;
		case __MINUS:
			if(src1_is_int)
			{
				ofile << "bit_vector_minus( &(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;	
			}
			else
			{
				ofile << tgt << " = (" << src1 << " - " << src2 << ");" << __endl__;
			}
			break;
		case __MUL:
			if(src1_is_int)
			{
				ofile << "bit_vector_mul( &(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;	
			}
			else
			{
				ofile << tgt << " = (" << src1 << " * " << src2 << ");" << __endl__;
			}
			break;
		case __DIV:
			if(src1_is_int)
			{
				ofile << "bit_vector_div( &(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;	
			}
			else
			{
				ofile << tgt << " = (" << src1 << " / " << src2 << ");" << __endl__;
			}
			break;
		case __EQUAL:
			if(src1_is_int)
			{
				ofile << "bit_vector_equal(" << (!src1_type->Is_Uinteger_Type() ? 1 : 0) << ", &(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;	
			}
			else
			{
				string op_string = "(" + src1 + " == " + src2 + ")";
				ofile << "bit_vector_assign_uint64(0" <<  ", &(" << tgt << "), " << op_string << ");" << __endl__;
			}
			break;
		case __NOTEQUAL:
			if(src1_is_int)
			{
				ofile << "bit_vector_not_equal(" << (!src1_type->Is_Uinteger_Type() ? 1 : 0) << ", &(" << src1 << "), &(" << src2 << "), &" << tgt << ");" << __endl__;	
			}
			else
			{
				string op_string = "(" + src1 + " != " + src2 + ")";
				ofile << "bit_vector_assign_uint64(0" <<  ", &(" << tgt << "), " << op_string << ");" << __endl__;
			}
			break;
		case __LESS:
			if(src1_is_int)
			{
				ofile << "bit_vector_less(" << (!src1_type->Is_Uinteger_Type() ? 1 : 0) << ", &(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;	
			}
			else
			{
				string op_string = "(" + src1 + " < " + src2 + ")";
				ofile << "bit_vector_assign_uint64(0" <<  ", &(" << tgt << "), " << op_string << ");" << __endl__;
			}
			break;
		case __LESSEQUAL:
			if(src1_is_int)
			{
				ofile << "bit_vector_less_equal(" << (!src1_type->Is_Uinteger_Type() ? 1 : 0) << ", &(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;	
			}
			else
			{
				string op_string = "(" + src1 + " <= " + src2 + ")";
				ofile << "bit_vector_assign_uint64(0" <<  ", &(" << tgt << "), " << op_string << ");" << __endl__;
			}
			break;
		case __GREATER:
			if(src1_is_int)
			{
				ofile << "bit_vector_greater(" << (!src1_type->Is_Uinteger_Type() ? 1 : 0) << ", &(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;	
			}
			else
			{
				string op_string = "(" + src1 + " > " + src2 + ")";
				ofile << "bit_vector_assign_uint64(0" <<  ", &(" << tgt << "), " << op_string << ");" << __endl__;
			}
			break;
		case __GREATEREQUAL:
			if(src1_is_int)
			{
				ofile << "bit_vector_greater_equal(" << (!src1_type->Is_Uinteger_Type() ? 1 : 0) << ", &(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;	
			}
			else
			{
				string op_string = "(" + src1 + " >= " + src2 + ")";
				ofile << "bit_vector_assign_uint64(0" <<  ", &(" << tgt << "), " << op_string << ");" << __endl__;
			}
			break;
		case __CONCAT:
			if(src1_is_int)
			{
				ofile << "bit_vector_concatenate( &(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;	
			}
			else
			{
				AaRoot::Error("Aa2C: concatenate supported only for ints.", NULL);
				assert(0);
			}
			break;
		case __BITSEL:
			if(src1_is_int)
			{
				ofile << "bit_vector_bitsel( &(" << src1 << "), &(" << src2 << "), &(" << tgt << "));" << __endl__;	
			}
			else
			{
				AaRoot::Error("Aa2C: bit-select supported only for ints.", NULL);
				assert(0);
			}
			break;
		case __UNORDERED:
			if(!src1_type->Is_Float_Type())
			{
				AaRoot::Error("Aa2C: unordered operation valid only for floats.", NULL);
				return;
			}
			if(src1_type->Size() == 32)
			{
				ofile << "if(fp32_unordered(" << src1 << "," << src2 << ")) bit_vector_set(&(" << tgt << "));" 
					<< " else bit_vector_clear(&(" << tgt << "));"
					<< __endl__;
				//ofile << "bit_vector_set_bit(&(" << tgt << "),0, fp32_unordered(" << src1 << "," << src2 << "));" 
					//<< __endl__;
			}
			else if(src1_type->Size() == 64)
			{
				ofile << "if(fp64_unordered(" << src1 << "," << src2 << ")) bit_vector_set(&(" << tgt << "));" 
					<< " else bit_vector_clear(&(" << tgt<< "));" << __endl__;
				//ofile << "bit_vector_set_bit(&(" << tgt << "),0, fp64_unordered(" << src1 << "," << src2 << "));" 
					//<< __endl__;
			}
			else
			{
				AaRoot::Error("Aa2C: unordered operation valid only for 32-bit and 64-bit floats.", NULL);
				return;
			}
			break;
		default:
			assert(0);
	}
}

void Print_C_Ternary_Operation(string test,
		AaType* test_type, string if_expr,
		AaType* if_expr_type, 
		string else_expr, AaType* else_expr_type, 
		string tgt, AaType* tgt_type, ofstream& ofile)
{
	assert(test_type->Is_Integer_Type());
	ofile << "if(" << C_Value_Expression( test, test_type) << ")";
	ofile << "{" << __endl__;
	if(tgt_type->Is_Integer_Type())
		ofile << "bit_vector_cast_to_bit_vector(" << (!tgt_type->Is_Uinteger_Type() ? 1 : 0) << ", &(" << tgt 
			<< "), &(" << if_expr << "));" << __endl__;
	else
		ofile << tgt << " = " << if_expr << ";" << __endl__;
	ofile << "}" << __endl__;
	ofile << "else" << __endl__;
	ofile << "{" << __endl__;
	if(tgt_type->Is_Integer_Type())
		ofile << "bit_vector_cast_to_bit_vector(" << (!tgt_type->Is_Uinteger_Type() ? 1 : 0) << ", &(" << tgt << "), &(" 
			<< else_expr << "));" << __endl__;
	else
		ofile << tgt << " = " << else_expr<< ";" << __endl__;
	ofile << "}" << __endl__;

}
void Print_C_Slice_Operation(string src, AaType* src_type, int _low_index, string tgt,
		AaType* tgt_type, ofstream& ofile)
{
	if(src_type->Is_Integer_Type())
	{
		if(tgt_type->Is_Integer_Type())
		{
			ofile << "bit_vector_slice(&(" << src << "), &(" << tgt << "), " << _low_index << ");" << __endl__;
		}
		else
		{
			AaRoot::Error("Aa2C: slice operation permitted only on uints/ints.", NULL);
			assert(0);
		}
	}
	else
	{
		AaRoot::Error("Aa2C: slice operation permitted only on uints/ints.", NULL);
		assert(0);
	}
}

void Print_C_Report_String(string seq_id, string tag, string qs, ofstream& ofile)
{
	string log_file_name = AaProgram::Report_Log_File_Name();
	ofile << "if(" << log_file_name << " != NULL) ";
	ofile << "fprintf(" << log_file_name << ",\"[%u]" <<  tag << ">\\t%s\\n\"," << seq_id << "," << "\"" <<  qs << "\");";
}

void Print_C_Report_String_Expr_Pair(string seq_id, string tag, string qs, string expr, AaType* etype, ofstream& ofile)
{
	string log_file_name = AaProgram::Report_Log_File_Name();
	ofile << "if(" << log_file_name << " != NULL) {";
	ofile << "fprintf(" << log_file_name << ",\"[%u]" << tag << ">\\t\\t%s\\t\\t\"," << seq_id << "," << "\"" << qs << "\");";
	if(etype->Is_Integer_Type())
	{
		ofile << "fprintf(" << log_file_name << ", \":= 0x%s\\n\",to_hex_string(&(" << expr  << ")));";
	}
	else if(etype->Is_Float_Type())
	{
		ofile << "fprintf(" << log_file_name << ", \":= %le\\n\"," << expr  << ");";
	}
	ofile << "}"; 
}
