#include <AaType.h>
#include <AaValue.h>
#include <AaObject.h>
#include <AaExpression.h>
#include <Aa2C.h>

void Print_C_Declaration(string obj_name, AaType* t, ofstream& ofile)
{
  if(!t->Is_Pointer_Type())
    {
      if(t->Is_Integer_Type())
	{
	  ofile << "__declare_bit_vector(" << obj_name << "," << t->Size() << ");" << endl;
	}
      else 
	{
	  ofile <<  t->C_Base_Name() 
		<< " " 
		<< obj_name
		<< t->C_Dimension_String();
	  ofile << ";" << endl;
	}
    }
  else
    {
      ofile << t->C_Name() 
	    << " " 
	    << obj_name;
	ofile << ";" << endl;
    }
}

void Print_C_Assignment_To_Constant(string tgt_c_ref, AaType* tgt_type, AaValue* v, ofstream& ofile)
{
  if(tgt_type->Is_Integer_Type() || tgt_type->Is_Uinteger_Type())
    {
      uint32_t tsize = tgt_type->Size();
      uint32_t nbytes = (tsize % 8) ? (tsize/8)+1 : tsize/8;
      uint8_t* b_array = new uint8_t[nbytes];
      v->Fill_Byte_Array(b_array,nbytes);
      
      int i;
      for(i = 0; i < nbytes; i++)
	{
	  ofile <<  tgt_c_ref << ".val.byte_array[" << i << "] = " << b_array[i] << ";" << endl;
	}
      
      delete [] b_array;
    }
  else
    {
      ofile << tgt_c_ref << " = " << v->To_C_String() << ";" << endl;
    }
}
void Print_C_Assignment(string tgt, string src, AaType* t, ofstream& ofile)
{
  if(t->Is_Integer_Type() || t->Is_Uinteger_Type())
    {
      ofile << "bit_vector_assign_bit_vector(" << src << ", " << tgt << ");" << endl;
    }
  else
    {
      // will this work for array assignments.
      ofile << "memcpy( &" << tgt << ", &" <<  src << ", sizeof(" << tgt << "));" << endl;
    }

}
void Print_C_Value_Expression(string cref, AaType* t, ofstream& ofile)
{
  if(t->Is_Integer_Type() || t->Is_Uinteger_Type())
    {
      ofile << "bit_vector_to_uint64(" << (t->Is_Integer_Type() ? 1 : 0) << ", cref ) " << endl;
    }
  else
    ofile << cref << " ";
}

void Print_C_Pipe_Read(string tgt, AaType* tgt_type, AaPipeObject* p, ofstream& ofile)
{
  int tsize = tgt_type->Size();
  if(!( (tsize == 8) || (tsize == 16) || (tsize == 32) || (tsize == 64)))
    {
      AaRoot::Error("Aa2C: pipe widths can be 8/16/32/64", p);
      assert(0);
    }
  else
    {
      if(tgt_type->Is_Integer_Type() || tgt_type->Is_Uinteger_Type() || tgt_type->Is_Pointer_Type())
	{
	  ofile << "bit_vector_assign_uint64(" 
		<< (tgt_type->Is_Integer_Type() ? 1 : 0) << ","
		<< "read_uint" << tsize << "(" << p->Get_Name() << "); " << endl;
	}
      else if(tgt_type->Is_Float_Type())
	{
	  ofile << "{ " << endl;
	  ofile << ((tsize == 32) ? "float __tmp;" : "double __tmp;") << endl;
	  ofile << "__tmp = read_float" << tsize << "(" << p->Get_Name() << "); " << endl;
	  ofile << "bit_vector_assign_uint64(0, " 
		<< "&" << tgt << ","
		<< "((uint64_t) *((uint64_t*) &__tmp)));" << endl;
	}
    }
}

void Print_C_Pipe_Write(string src, AaType* src_type, AaPipeObject* p, ofstream& ofile)
{
  int tsize = src_type->Size();
  if(!( (tsize == 8) || (tsize == 16) || (tsize == 32) || (tsize == 64)))
    {
      AaRoot::Error("Aa2C: pipe widths can be 8/16/32/64", p);
      assert(0);
    }
  else
    {

      if(src_type->Is_Integer_Type() || src_type->Is_Uinteger_Type() || src_type->Is_Pointer_Type())
	{
	  ofile << "{ " << endl;
	  ofile << src_type->Native_C_Name() << " __tmp;";
	  ofile << "__tmp = bit_vector_to_uint64(0, &" << src << ");" << endl;
	  ofile << "write_uint" << tsize << "(" << p->Get_Name() << ", __tmp); " << endl;
	  ofile << "}" << endl;
	}
      else if(src_type->Is_Float_Type())
	{
	  ofile << "write_float" << tsize << "(" << p->Get_Name() << "," << src << "); " << endl;
	}
    }
}

// These type casts are a ^%()@
void Print_C_Type_Cast_Operation(string src, AaType* src_type, string tgt, AaType* tgt_type, ofstream& ofile)
{
  uint8_t src_signed = src_type->Is_Integer_Type();
  uint8_t tgt_signed = tgt_type->Is_Integer_Type();
  if(src_type->Is_Integer_Type() || src_type->Is_Uinteger_Type())
    {
      if(tgt_type->Is_Integer_Type() || tgt_type->Is_Uinteger_Type())
	{
	  // if both are integer, then use bit_vector_op.
	  uint8_t sign_flag =( (src_signed && tgt_signed) ? 0 : 1);
	  ofile << "bit_vector_assign_bit_vector(" << sign_flag << ", &" << src << ", &" << tgt << ");" << endl;
	}
      else
	{
	  if(tgt_type->Is_Float_Type())
	    {
	      if(tgt_type->Is_A_Native_C_Type())
		{
		  if(tgt_type->Size() == 32)
		    {
		      ofile << tgt  << " = bit_vector_to_float(" << (src_type->Is_Integer_Type() ? 1 : 0) << ", &" << src << ");" << endl; 
		    }
		}
	      else
		{
		  AaRoot::Error("Aa2C: unsupported float target type in conversion." , tgt_type);
		  assert(0);
		}
	    }
	  else if(tgt_type->Is_Pointer_Type())
	    {
	      ofile << tgt << " = (" << tgt_type->C_Name() << "*) " << " bit_vector_to_uint64(0, &" << src << ");" << endl; 
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
      if(tgt_type->Is_Integer_Type() || tgt_type->Is_Uinteger_Type())
	{
	  if(src_type->Is_Float_Type())
	    {
	      if(src_type->Is_A_Native_C_Type())
		{
		  // float to bit-vector.
		  if(src_type->Size() == 32)
		    ofile << "bit_vector_assign_float(" << (tgt_type->Is_Integer_Type() ? 1 : 0)
			  << ", &" << tgt << ", " << src << ");" << endl;
		  else
		    ofile << "bit_vector_assign_double(" << (tgt_type->Is_Integer_Type() ? 1 : 0)
			  << ", &" << tgt << ", " << src << ");" << endl;
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
		    << ", &" << tgt << ", " << src << ");" << endl;
	    }
	}
      else
	{ // src and target are both not of integer types.
	  ofile << tgt << " = (" << tgt_type->C_Name() << ") " << src << ";" << endl;
	} 
    }
}

void Print_C_Unary_Operation(string src, AaType* src_type, string tgt, AaType* tgt_type, AaOperation op, ofstream& ofile)
{
	if(src_type->Is_Integer_Type() || src_type->Is_Uinteger_Type())
	  {
	    switch(op)
	      {
	      case __NOT:
		ofile << "bit_vector_not( &" << src << ", &" << tgt << ");" << endl;
		break;
	      case __NOP:
		ofile << "bit_vector_assign_bit_vector( " << (src_type->Is_Integer_Type() ? 1 : 0) << ", &" << src << ", &" << tgt << ");" << endl;
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
		ofile << tgt << " = ~(" << src << ");" << endl;
		break;
	      case __NOP:
		ofile << tgt << " = (" << src << ");" << endl;
		break;
	      default:
		AaRoot::Error("Aa2C: unsupported unary operation", NULL);
		assert(0);
	      }
	  }
}
void Print_C_Binary_Operation(string src1, AaType* src1_type, string src2,  AaType* src2_type, 
			string tgt, AaType* tgt_type, AaOperation op, ofstream& ofile)
{
  uint8_t bv_flag = tgt_type->Is_Uinteger_Type() || tgt_type->Is_Integer_Type();
  uint8_t signed_flag = tgt_type->Is_Integer_Type();
  switch(op)
    {
    case __OR:
      if(bv_flag)
	{
	  ofile << "bit_vector_or(&" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;
	}
      else
	{
	  ofile << tgt << " = (" << src1 << " | " << src2 << ");" << endl;
	}
      break;
    case __AND:
      if(bv_flag)
	{
	  ofile << "bit_vector_and(&" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;
	}
      else
	{
	  ofile << tgt << " = (" << src1 << " & " << src2 << ");" << endl;
	}
      break;
    case __XOR:
      if(bv_flag)
	{
	  ofile << "bit_vector_xor(&" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;
	}
      else
	{
	  ofile << tgt << " = (" << src1 << " ^ " << src2 << ");" << endl;
	}
      break;
    case __NOR:
      if(bv_flag)
	{
	  ofile << "bit_vector_nor(&" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;
	}
      else
	{
	  ofile << tgt << " = ~(" << src1 << " | " << src2 << ");" << endl;
	}
      break;
    case __NAND:
      if(bv_flag)
	{
	  ofile << "bit_vector_nand(&" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;
	}
      else
	{
	  ofile << tgt << " = ~(" << src1 << " & " << src2 << ");" << endl;
	}
      break;
    case __XNOR:
      if(bv_flag)
	{
	  ofile << "bit_vector_xnor(&" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;
	}
      else
	{
	  ofile << tgt << " = ~(" << src1 << " ^ " << src2 << ");" << endl;
	}
      break;
    case  __SHL:
      if(bv_flag)
	{
	  ofile << "bit_vector_shift_left(&" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;
	}
      else
	{
	  ofile << tgt << " = (" << src1 << " << " << src2 << ");" << endl;
	}
      break;
    case __SHR:
      if(bv_flag)
	{
	  ofile << "bit_vector_shift_right(0, &" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;	
	}
      else
	{
	  ofile << tgt << " = (" << src1 << " >> " << src2 << ");" << endl;
	}
      break;
    case    __ASHR:
      if(bv_flag)
	{
	  ofile << "bit_vector_shift_right(1, &" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;	
	}
      else
	{
	  ofile << tgt << " = (" << src1 << " >> " << src2 << ");" << endl;
	}
      break;
    case __ROR:
      if(bv_flag)
	{
	  ofile << "bit_vector_rotate_right( &" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;	
	}
      else
	{
	  AaRoot::Error("Aa2C: rotate-right supported only for ints.", NULL);
	  assert(0);
	}
      break;
    case __ROL:
      if(bv_flag)
	{
	  ofile << "bit_vector_rotate_left( &" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;	
	}
      else
	{
	  AaRoot::Error("Aa2C: rotate-left supported only for ints.", NULL);
	  assert(0);
	}
    case __PLUS:
      if(bv_flag)
	{
	  ofile << "bit_vector_plus( &" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;	
	}
      else
	{
	  ofile << tgt << " = (" << src1 << " + " << src2 << ");" << endl;
	}
      break;
    case __MINUS:
      if(bv_flag)
	{
	  ofile << "bit_vector_minus( &" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;	
	}
      else
	{
	  ofile << tgt << " = (" << src1 << " - " << src2 << ");" << endl;
	}
      break;
    case __MUL:
      if(bv_flag)
	{
	  ofile << "bit_vector_mul( &" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;	
	}
      else
	{
	  ofile << tgt << " = (" << src1 << " * " << src2 << ");" << endl;
	}
      break;
    case __DIV:
      if(bv_flag)
	{
	  ofile << "bit_vector_div( &" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;	
	}
      else
	{
	  ofile << tgt << " = (" << src1 << " / " << src2 << ");" << endl;
	}
      break;
    case __EQUAL:
      if(bv_flag)
	{
	  ofile << "bit_vector_equal(" << (src1_type->Is_Integer_Type() ? 1 : 0) << ", &" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;	
	}
      else
	{
	  ofile << tgt << " = (" << src1 << " == " << src2 << ");" << endl;
	}
      break;
    case __NOTEQUAL:
      if(bv_flag)
	{
	  ofile << "bit_vector_not_equal(" << (src1_type->Is_Integer_Type() ? 1 : 0) << ", &" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;	
	}
      else
	{
	  ofile << tgt << " = (" << src1 << " != " << src2 << ");" << endl;
	}
      break;
    case __LESS:
      if(bv_flag)
	{
	  ofile << "bit_vector_less(" << (src1_type->Is_Integer_Type() ? 1 : 0) << ", &" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;	
	}
      else
	{
	  ofile << tgt << " = (" << src1 << " < " << src2 << ");" << endl;
	}
      break;
    case __LESSEQUAL:
      if(bv_flag)
	{
	  ofile << "bit_vector_less_equal(" << (src1_type->Is_Integer_Type() ? 1 : 0) << ", &" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;	
	}
      else
	{
	  ofile << tgt << " = (" << src1 << " <= " << src2 << ");" << endl;
	}
      break;
    case __GREATER:
      if(bv_flag)
	{
	  ofile << "bit_vector_greater(" << (src1_type->Is_Integer_Type() ? 1 : 0) << ", &" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;	
	}
      else
	{
	  ofile << tgt << " = (" << src1 << " > " << src2 << ");" << endl;
	}
      break;
    case __GREATEREQUAL:
      if(bv_flag)
	{
	  ofile << "bit_vector_greater_equal(" << (src1_type->Is_Integer_Type() ? 1 : 0) << ", &" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;	
	}
      else
	{
	  ofile << tgt << " = (" << src1 << " > " << src2 << ");" << endl;
	}
      break;
    case __CONCAT:
      if(bv_flag)
	{
	  ofile << "bit_vector_concatenate( &" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;	
	}
      else
	{
	  AaRoot::Error("Aa2C: concatenate supported only for ints.", NULL);
	  assert(0);
	}
      break;
    case __BITSEL:
      if(bv_flag)
	{
	  ofile << "bit_vector_bitsel( &" << src1 << ", &" << src2 << ", &" << tgt << ");" << endl;	
	}
      else
	{
	  AaRoot::Error("Aa2C: bit-select supported only for ints.", NULL);
	  assert(0);
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
	assert(test_type->Is_Integer_Type() || test_type->Is_Uinteger_Type());
	ofile << "if(bit_vector_to_uint64(0," << test << ")";
	ofile << "{" << endl;
	if(tgt_type->Is_Integer_Type() || tgt_type->Is_Uinteger_Type())
	  ofile << "bit_vector_assign_bit_vector(0, &" << if_expr << ", &" << tgt << ");" << endl;
	else
	  ofile << tgt << " = " << if_expr << ";" << endl;
	ofile << "}" << endl;
	ofile << "else" << endl;
	ofile << "{" << endl;
	if(tgt_type->Is_Integer_Type() || tgt_type->Is_Uinteger_Type())
	  ofile << "bit_vector_assign_bit_vector(0, &" << else_expr << ", &" << tgt << ");" << endl;
	else
	  ofile << tgt << " = " << else_expr<< ";" << endl;
	ofile << "}" << endl;

}
void Print_C_Slice_Operation(string src, AaType* src_type, int _low_index, string tgt,
				AaType* tgt_type, ofstream& ofile)
{
	ofile << endl << "// print C  slice expression from " << src << " to " << tgt << endl;
	if(src_type->Is_Integer_Type() || src_type->Is_Uinteger_Type())
	  {
	    if(tgt_type->Is_Integer_Type() || tgt_type->Is_Uinteger_Type())
	      {
		ofile << "bit_vector_slice(&" << src << ", &" << tgt << ");" << endl;
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


