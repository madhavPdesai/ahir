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
#include <istream>
#include <ostream>
#include <assert.h>
#include <hierSystem.h>
#include <rtlEnums.h>
#include <rtlType.h>
#include <Value.hpp>
#include <rtlValue.h>
#include <rtlObject.h>
#include <rtlExpression.h>
#include <rtlThread.h>


int e_counter = 0;

rtlExpression::rtlExpression(string id): hierRoot(id)
{
	e_counter++;
	_type = NULL;
	_value = NULL;
	_is_target = false;
	_tick = false;
}

rtlExpression::rtlExpression(): hierRoot("anon_expr_" + IntToStr(e_counter))
{
	e_counter++;
	_type = NULL;
	_value = NULL;
	_is_target = false;
	_tick = false;
}
	
string rtlExpression::Get_C_Name()
{
	string ret_val = "__expr_";
	ret_val += IntToStr(this->Get_Index());
	return(ret_val);
}
	
string rtlExpression::C_Int_Reference()
{
	rtlType* tt = this->Get_Type();
	if(tt->Is("rtlIntegerType"))
	{
		return(this->Get_C_Name());
	}
	else if(tt->Is("rtlUnsignedType"))
	{
		return(string("bit_vector_to_uint64(0, &(") +  this->Get_C_Name() + "))");
	}
	else if(tt->Is("rtlSignedType"))
	{
		return(string("bit_vector_to_uint64(1, &(") +  this->Get_C_Name() + "))");
	}
	else
		assert(0);
}


void rtlExpression::Print_C_Declaration(rtlValue* v, ostream& ofile)
{
	if(this->Get_Type()->Is("rtlUnsignedType"))
	{
		string c_name = this->Get_C_Name();
		ofile << "__declare_static_bit_vector(" << c_name << "," <<  this->Get_Type()->Size() 
				<< ");" << endl;
		if(v != NULL)
		{
			string init_string =  v->To_Bit_Vector_String();
			ofile << "bit_vector_assign_string(&(" << c_name << "),\"" << init_string << "\");" << endl;
		}
	}
	else
	{
		ofile << this->Get_Type()->Get_C_Name() << " " << this->Get_C_Name() << this->Get_Type()->Get_C_Dimension_String() << ";" << endl;
		this->Get_Type()->Print_C_Struct_Field_Initialization(this->Get_C_Name(), v, ofile);
	}
}

void rtlObjectReference::Set_Tick(bool v) 
{
	_tick = v;
	_object->Set_Assigned_Under_Tick(v);
}

rtlSimpleObjectReference::rtlSimpleObjectReference(rtlObject* obj): rtlObjectReference(obj->Get_Id(),obj) 
{
	_req_flag = false;
	_ack_flag = false;

	if(obj->Is_Constant())
	{
		_value = obj->Get_Value();
	}

	_type = obj->Get_Type();
}

rtlSimpleObjectReference::rtlSimpleObjectReference(rtlObject* obj, bool req_flag, bool ack_flag): rtlObjectReference(obj->Get_Id(),obj) 
{
	_req_flag  = req_flag;
	_ack_flag  = ack_flag;

	if(_req_flag | _ack_flag)
	{
		if(!obj->Is_Pipe())
		{
			this->Report_Error("non-pipe object " + obj->Get_Id() + " in req/ack object reference");
			assert(0);
		}
		_type = Find_Or_Make_Unsigned_Type(1);
	}
	else
		_type = obj->Get_Type();
}

bool rtlSimpleObjectReference::Writes_To_Signal()
{
	return(this->Get_Is_Target() && this->_object->Is_Signal() && 
			(this->_req_flag || (this->_object->Get_Assigned_Under_Volatile() || this->_object->Get_Assigned_Under_Tick())));
}

void rtlConstantLiteralExpression::Print(ostream& ofile)
{
	ofile << " (";
	this->_type->Print(ofile);
	ofile << ") ";
	this->Get_Value()->Print(ofile);
}

void rtlConstantLiteralExpression::Print_C(ostream& ofile)
{
	this->Print_C_Declaration(_value, ofile);
}

string rtlConstantLiteralExpression::To_Vhdl_String()
{
	return(this->_value->To_Vhdl_String());	
}

void rtlSimpleObjectReference::Print(ostream& ofile) 
{
	if(_value != NULL)
	{
		ofile << " (";
		this->_type->Print(ofile);
		ofile << ") ";

		_value->Print(ofile);
		return;
	}
	ofile << " " << _object->Get_Id();
	if(_req_flag)
		ofile << "$req ";
	else if(_ack_flag)
		ofile << "$ack ";
	
	if(this->_req_flag && !this->Get_Is_Target())
	{
		this->Report_Error("req-flag cannot be read for object " + _object->Get_Id());
	}
	if(this->_ack_flag && this->Get_Is_Target())
	{
		this->Report_Error("ack-flag cannot be written for object " + _object->Get_Id());
	}
	if(_object->Is_InPort() && (!_req_flag) && (!_ack_flag) && this->Get_Is_Target())
	{
		this->Report_Error("inport  object " + _object->Get_Id() + " cannot be a target");
	}
	if(_object->Is_OutPort() && (!_req_flag) && (!_ack_flag) && !this->Get_Is_Target())
	{
		this->Report_Error("outport  object " + _object->Get_Id() + " cannot be a source");
	}
}
	
string rtlSimpleObjectReference::To_Vhdl_String()
{
	if(this->_req_flag)
	{
		if(this->_object->Is_InPort())
			return(this->_object->Get_Id() + "_pipe_read_req");
		else
			return(this->_object->Get_Id() + "_pipe_write_req");
	}
	else if(this->_ack_flag)
	{
		if(this->_object->Is_InPort())
			return(this->_object->Get_Id() + "_pipe_read_ack");
		else
			return(this->_object->Get_Id() + "_pipe_write_ack");
	}
	else
	{
		if(this->Get_Is_Target() && this->_object->Needs_Next_Vhdl_Variable())
		{
			return(this->_object->Get_Variable_Id());
		}
		if(this->Get_Is_Target() && !this->_object->Needs_Next_Vhdl_Variable() &&
					this->_object->Is_OutPort())
		{
			return(this->_object->Get_Buf_Id());
		}
		else
		{
			return(this->_object->Get_Id());
		}
	}
}
	
void rtlObjectReference::Set_Is_Volatile(bool v)
{
	_object->Set_Assigned_Under_Volatile(v);
}

void rtlObjectReference::Set_Is_Not_Volatile(bool v)
{
	_object->Set_Not_Assigned_Under_Volatile(v);
}
	
void rtlSimpleObjectReference::Set_Is_Volatile(bool v)
{
	if(!(_req_flag || _ack_flag))
		_object->Set_Assigned_Under_Volatile(v);
}

void rtlSimpleObjectReference::Set_Is_Not_Volatile(bool v)
{
	if(_req_flag && v)
	{
		this->Report_Error("pipe-req signal must always be a volatile assignment: " + this->To_String());
		return;
	}

	if(!(_req_flag || _ack_flag))
		_object->Set_Not_Assigned_Under_Volatile(v);
}

void rtlSimpleObjectReference::Set_Tick(bool v)
{
	if(_req_flag && v)
	{
		this->Report_Error("pipe-req signal cannot be a tick assignment: " + this->To_String());
		return;
	}

	_tick = v;
	if(!(_req_flag || _ack_flag))
		_object->Set_Assigned_Under_Tick(v);
}

string rtlSimpleObjectReference::Get_C_Name() 
{
	if(_req_flag)
	{
		this->Report_Error("req-flag cannot be read for object " + _object->Get_Id());
		return("");
	}
	else if(_ack_flag)
		return(_object->Get_C_Ack_Name());
	else
		return(_object->Get_C_Name());
}

string rtlSimpleObjectReference::Get_C_Target_Name() 
{
	if(_ack_flag)
	{
		this->Report_Error("ack-flag cannot be written for object " + _object->Get_Id());
		return("");
	}
	else if(_req_flag)
		return(_object->Get_C_Req_Name());

	if(!this->Get_Tick())
		return(_object->Get_C_Target_Name());
	else
		return(_object->Get_C_Name());
}

void rtlSimpleObjectReference::Print_C(ostream& ofile) 
{
	// nothing.  objects will be in string struct.
	if(this->_req_flag && !this->Get_Is_Target())
	{
		this->Report_Error("req-flag cannot be read for object " + _object->Get_Id());
	}
}
	
rtlArrayObjectReference::rtlArrayObjectReference(rtlObject* obj, vector<rtlExpression*>& indices)
	: rtlObjectReference(obj->Get_Id() + "_array_ref", obj)
{
	_indices = indices;
	rtlType* otype = obj->Get_Type();
	assert(otype->Is("rtlArrayType"));
	rtlArrayType* at = (rtlArrayType*) otype;
	assert(at->Get_Number_Of_Dimensions() == indices.size());

	rtlType* ele_type = at->Get_Element_Type();
	_type = ele_type;
}

string rtlArrayObjectReference::Get_C_Target_Name() 
{
	string ret_val = _object->Get_C_Target_Name();
	for(int I = 0, fI = _indices.size(); I < fI; I++)
		ret_val += "[" + _indices[I]->C_Int_Reference() + "]";
	
	return(ret_val);
}

bool rtlArrayObjectReference::Writes_To_Signal()
{
	return(this->Get_Is_Target() && this->_object->Is_Signal() && 
			(this->_object->Get_Assigned_Under_Volatile() || this->_object->Get_Assigned_Under_Tick()));
}

void rtlArrayObjectReference::Print_C(ostream& ofile)
{
	for(int I = 0, fI = _indices.size(); I < fI; I++)
		_indices[I]->Print_C(ofile);

	if(this->Get_Is_Target())
	{
		// do nothing.
	}
	else
	{
		this->Print_C_Declaration(_value,ofile);
		if(_value == NULL)
		{
			string obj_ref_string = this->Get_Object()->Get_C_Name();
			for(int I = 0, fI = _indices.size(); I < fI; I++)
			{
				obj_ref_string += "[" + _indices[I]->C_Int_Reference() + "]";
			}
			Print_C_Assignment(this->Get_C_Name(), obj_ref_string, this->Get_Type(), ofile);
		}
	}
}

string rtlArrayObjectReference::To_Vhdl_String()
{
	string ret_string;
	if(this->Get_Is_Target() && this->_object->Needs_Next_Vhdl_Variable())
	{
		ret_string += this->_object->Get_Variable_Id();
	}
	else
		ret_string += this->_object->Get_Id();

	for(int I = 0, fI = _indices.size(); I < fI; I++)
	{
		rtlExpression* idx = _indices[I];
		if(idx->Get_Type()->Is("rtlIntegerType"))
			ret_string += "(" + idx->To_Vhdl_String() + ")";
		else if(idx->Get_Type()->Is("rtlUnsignedType"))
			ret_string += string("(To_Integer(To_Unsigned(") + idx->To_Vhdl_String() + ")))";
		else if(idx->Get_Type()->Is("rtlSignedType"))
			ret_string += string("(To_Integer(To_Signed(") + idx->To_Vhdl_String() + ")))";
	}
	return(ret_string);
}

void rtlArrayObjectReference::Print(ostream& ofile)
{
	if(this->_value != NULL)
	{
		ofile << " (";
		this->_type->Print(ofile);
		ofile << ") ";
		this->_value->Print(ofile);
		return;
	}

	ofile << " ";
	ofile << _object->Get_Id();
	for(int I = 0, fI = _indices.size(); I < fI; I++)
	{
		ofile << "[";
		_indices[I]->Print(ofile);
		ofile << "]";
	}
	ofile << " ";
}

void rtlSliceExpression::Print_C(ostream& ofile)
{
	_base->Print_C(ofile);
	this->Print_C_Declaration(_value, ofile);

	if(_value == NULL)
	{
		rtlType* tt = this->Get_Type();
		assert(tt->Is("rtlUnsignedType") || tt->Is("rtlSignedType"));
		ofile << "bit_vector_slice(&(" << _base->Get_C_Name() << "), &(" << this->Get_C_Name() << "), " << _low << ");" << endl;
	}	
}
bool rtlSliceExpression::Writes_To_Signal()
{
	return(this->_base->Writes_To_Signal());
}

string rtlSliceExpression::To_Vhdl_String()
{
	string ret_string;
	ret_string += _base->To_Vhdl_String();
	ret_string += "(" + IntToStr(_high) + " downto " + IntToStr(_low) + ")";
	return(ret_string);
}

void rtlSliceExpression::Print(ostream& ofile)
{
	if(_value != NULL)
	{
		ofile << " (";
		this->_type->Print(ofile);
		ofile << ") ";

		_value->Print(ofile);
		return;
	}

	ofile << "($slice ";
	_base->Print(ofile);
	ofile << " " << _high << " " << _low << ") ";

}


rtlUnaryExpression::rtlUnaryExpression(rtlOperation op, rtlExpression* rest):
	rtlExpression("("+rtlOp_To_String(op) + rest->Get_Id() + ")")
{
	_op = op;
	_rest = rest;	
	_type = rest->Get_Type();
}

void rtlUnaryExpression::Print_C(ostream& ofile)
{
	if(_value == NULL)
	{
		_rest->Print_C(ofile);
		this->Print_C_Declaration(_value, ofile);
		//ofile << this->Get_Type()->Get_C_Name() << " " << this->Get_C_Name() << ";" << endl;

		rtlType* tt = this->Get_Type();
		assert(tt->Is("rtlUnsignedType") || tt->Is("rtlSignedType"));
		ofile << "bit_vector_not(&(" << _rest->Get_C_Name() << "), &(" << this->Get_C_Name() << ")); " << endl;
	}	
	else
	{
		this->Print_C_Declaration(_value, ofile);
	}
}

void rtlUnaryExpression::Print(ostream& ofile)
{
	if(this->_value)
	{
		ofile << " (";
		this->_type->Print(ofile);
		ofile << ") ";
		this->_value->Print(ofile);
		return;
	
	}
	ofile << "( ";
	ofile << rtlOp_To_String(_op);
	ofile << " ";
	_rest->Print(ofile);
	ofile << ") ";
}

string rtlUnaryExpression::To_Vhdl_String()
{
	string ret_string = "( not " + _rest->To_Vhdl_String() + ")";
	return(ret_string);
}

	
rtlBinaryExpression::rtlBinaryExpression(rtlOperation op, rtlExpression* first, rtlExpression* second):
	rtlExpression("("+ first->Get_Id() + " " + rtlOp_To_String(op) + second->Get_Id() + ")")
{
	_op = op;
	_first = first;
	_second = second;
	this->Infer_And_Set_Type();
}


void rtlBinaryExpression::Infer_And_Set_Type()
{
	switch(_op)
	{
		case __OR: 
		case __AND:
		case __XOR:
		case __NOR:
		case __NAND:
		case __XNOR:
		case __PLUS:
		case __MINUS:
		case __MUL:
		case __DIV:
			assert(_first->Get_Type() == _second->Get_Type());
			_type = _first->Get_Type();
			break;
		case __SHL:
		case __SHR:
		case __ROR:
		case __ROL:
			_type = _first->Get_Type();
			break;
		case __EQUAL:
		case __NOTEQUAL:
		case __LESS:
		case __LESSEQUAL:
		case __GREATER:
		case __GREATEREQUAL:
			assert(_first->Get_Type() == _second->Get_Type());
			_type = Find_Or_Make_Unsigned_Type(1);
			break;
		case __CONCAT:
			assert(_first->Get_Type()->Kind() == _second->Get_Type()->Kind());
			if(_first->Get_Type()->Is("rtlUnsignedType"))
				_type = Find_Or_Make_Unsigned_Type(_first->Get_Type()->Size() + _second->Get_Type()->Size());
			else if(_first->Get_Type()->Is("rtlSignedType"))
				_type = Find_Or_Make_Signed_Type(_first->Get_Type()->Size() + _second->Get_Type()->Size());
			else
				assert(0);
			break;
		default:
			assert(0);
	}
}

void rtlBinaryExpression::Print_C(ostream& ofile)
{
	if(_value != NULL)
		this->Print_C_Declaration(_value, ofile);
	else
	{
		_first->Print_C(ofile);
		_second->Print_C(ofile);
		
		this->Print_C_Declaration(NULL, ofile);
		Print_C_Binary_Operation(this->Get_C_Name(), _first->Get_C_Name(), _second->Get_C_Name(), this->Get_Type(),  _op, ofile);
	}	
}

string rtlBinaryExpression::To_Vhdl_String()
{
	string ret_string;
	if(this->Get_Type()->Is("rtlIntegerType"))
		ret_string += 
			"(" + _first->To_Vhdl_String() + " " + rtlOp_To_Vhdl_String(_op) + " " + _second->To_Vhdl_String() + ")";
	else  if(this->Get_Type()->Is("rtlUnsignedType") || this->Get_Type()->Is("rtlSignedType"))
	{
		switch(_op)
		{

			case __OR:
				ret_string = "(" + _first->To_Vhdl_String() + " or " + _second->To_Vhdl_String() + ")";
				break;
			case __AND:
				ret_string = "(" + _first->To_Vhdl_String() + " and " + _second->To_Vhdl_String() + ")";
				break;
			case __XOR:
				ret_string = "(" + _first->To_Vhdl_String() + " xor " + _second->To_Vhdl_String() + ")";
				break;
			case __NOR:
				ret_string = "(not (" + _first->To_Vhdl_String() + " or " + _second->To_Vhdl_String() + "))";
				break;
			case __NAND:
				ret_string = "(not (" + _first->To_Vhdl_String() + " and " + _second->To_Vhdl_String() + "))";
				break;
			case __XNOR:
				ret_string = "(not (" + _first->To_Vhdl_String() + " xor " + _second->To_Vhdl_String() + "))";
				break;
			case __SHL:
				ret_string = "to_slv(shift_left(to_unsigned(" + _first->To_Vhdl_String() + ")," + 
						"to_integer(to_unsigned(" + _second->To_Vhdl_String() + "," + 
								 IntToStr(_first->Get_Type()->Size()) + "))));";
				break;
			case __SHR:
				if(this->Get_Type()->Is("rtlUnsignedType"))
					ret_string = "to_slv(shift_left(to_unsigned(" + _first->To_Vhdl_String() + ")," + 
						"to_integer(to_unsigned(" + _second->To_Vhdl_String() + "," + 
						IntToStr(_first->Get_Type()->Size()) + "))));";
				else
					ret_string = "to_slv(shift_left(to_signed(" + _first->To_Vhdl_String() + ")," + 
						"to_integer(to_signed(" + _second->To_Vhdl_String() + "," + 
						IntToStr(_first->Get_Type()->Size()) + "))));";
				break;
			case __ROR:
				ret_string = "to_slv(rotate_right(to_unsigned(" + _first->To_Vhdl_String() + ")," + 
					"to_integer(to_unsigned(" + _second->To_Vhdl_String() + "," + 
					IntToStr(_first->Get_Type()->Size()) + "))));";
				break;
			case __ROL:
				ret_string = "to_slv(rotate_left(to_unsigned(" + _first->To_Vhdl_String() + ")," + 
					"to_integer(to_unsigned(" + _second->To_Vhdl_String() + "," + 
					IntToStr(_first->Get_Type()->Size()) + "))));";
				break;
			case __EQUAL:
				ret_string = "areEqual(" + _first->To_Vhdl_String() + ", " + _second->To_Vhdl_String() + ")";
				break;
			case __NOTEQUAL:
				ret_string = "(not areEqual(" + _first->To_Vhdl_String() + ", " + _second->To_Vhdl_String() + "))";
				break;
			case __LESS:
				if(this->Get_Type()->Is("rtlUnsignedType"))
					ret_string = "uLessThan(" + _first->To_Vhdl_String() + " = " + _second->To_Vhdl_String() + ")";
				else
					ret_string = "sLessThan(" + _first->To_Vhdl_String() + " = " + _second->To_Vhdl_String() + ")";
				break;
			case __LESSEQUAL:
				if(this->Get_Type()->Is("rtlUnsignedType"))
					ret_string = "uLessEqual(" + _first->To_Vhdl_String() + " = " + _second->To_Vhdl_String() + ")";
				else
					ret_string = "sLessEqual(" + _first->To_Vhdl_String() + " = " + _second->To_Vhdl_String() + ")";
				break;
			case __GREATER:
				if(this->Get_Type()->Is("rtlUnsignedType"))
					ret_string = "uGreaterThan(" + _first->To_Vhdl_String() + " = " + _second->To_Vhdl_String() + ")";
				else
					ret_string = "sGreaterThan(" + _first->To_Vhdl_String() + " = " + _second->To_Vhdl_String() + ")";
				break;
			case __GREATEREQUAL:
				if(this->Get_Type()->Is("rtlUnsignedType"))
					ret_string = "uGreaterEqual(" + _first->To_Vhdl_String() + " = " + _second->To_Vhdl_String() + ")";
				else
					ret_string = "sGreaterEqual(" + _first->To_Vhdl_String() + " = " + _second->To_Vhdl_String() + ")";
				break;
			case __PLUS:
				if(this->Get_Type()->Is("rtlUnsignedType"))
					ret_string = "to_slv(to_unsigned(" + _first->To_Vhdl_String() 
							+ ") + to_unsigned(" + _second->To_Vhdl_String() + "))";
				else
					ret_string = "to_slv(to_signed(" + _first->To_Vhdl_String() 
							+ ") + to_signed(" + _second->To_Vhdl_String() + "))";
				break;
			case __MINUS:
				if(this->Get_Type()->Is("rtlUnsignedType"))
					ret_string = "to_slv(to_unsigned(" + _first->To_Vhdl_String() 
							+ ") - to_unsigned(" + _second->To_Vhdl_String() + "))";
				else
					ret_string = "to_slv(to_signed(" + _first->To_Vhdl_String() 
							+ ") - to_signed(" + _second->To_Vhdl_String() + "))";
				break;
			case __MUL:
				if(this->Get_Type()->Is("rtlUnsignedType"))
					ret_string = "to_slv(to_unsigned(" + _first->To_Vhdl_String() 
							+ ") * to_unsigned(" + _second->To_Vhdl_String() + "))";
				else
					ret_string = "to_slv(to_signed(" + _first->To_Vhdl_String() 
							+ ") * to_signed(" + _second->To_Vhdl_String() + "))";
				break;
			case __CONCAT:
				ret_string = "(" + _first->To_Vhdl_String() + " & " + _second->To_Vhdl_String() + ")";
				break;
			default:
				assert(0);
				break;
		}
	}
	return(ret_string);
}

void rtlBinaryExpression::Print(ostream& ofile)
{
	if(this->_value)
	{
		ofile << " (";
		this->_type->Print(ofile);
		ofile << ") ";
		this->_value->Print(ofile);
		return;
	}

	ofile << "( ";
	_first->Print(ofile);
	ofile << " ";
	ofile << rtlOp_To_String(_op);
	ofile << " ";
	_second->Print(ofile);
	ofile << ") ";
}

rtlTernaryExpression::rtlTernaryExpression(rtlExpression* test, rtlExpression* if_true, rtlExpression* if_false)
	: rtlExpression(string("(") + test->Get_Id() + " ? " + if_true->Get_Id() + " : " + if_false->Get_Id())
{
	assert((if_true != NULL) && (if_false != NULL) && (if_true->Get_Type() == if_false->Get_Type()));
	_test = test;
	_if_true = if_true;
	_if_false = if_false;
	_type = if_true->Get_Type();

}


void rtlTernaryExpression::Print(ostream& ofile)
{
	if(this->_value)
	{
		ofile << " (";
		this->_type->Print(ofile);
		ofile << ") ";
		this->_value->Print(ofile);
		return;
	}

	ofile << "( ";
	_test->Print(ofile);
	ofile << " ? ";
	_if_true->Print(ofile);
	ofile << " ";
	_if_false->Print(ofile);
	ofile << ") ";

}

string rtlTernaryExpression::To_Vhdl_String()
{
	return("Mux2To1(" + _test->To_Vhdl_String() + "," + _if_true->To_Vhdl_String() + "," + _if_false->To_Vhdl_String() + ")");
}


//               Evaluation functions..
void rtlConstantLiteralExpression::Evaluate(rtlThread* t)
{
	assert(this->_value != NULL);
}
void rtlSimpleObjectReference::Evaluate(rtlThread* t)
{
	if(_value)
		return;
	return;
}
void rtlArrayObjectReference::Evaluate(rtlThread* t)
{
	if(_value)
		return;

	vector<int> e_index;
	bool constant_indices = true;
	for(int I = 0, fI = _indices.size(); I < fI; I++)
	{
		_indices[I]->Evaluate(t);
		if(_indices[I]->Get_Value())
		{
		  e_index.push_back(_indices[I]->Get_Value()->To_Integer());
		}
		else
		  constant_indices = false;
	}

	if(this->_value != NULL)
		return;

	if(this->Get_Object()->Is_Constant() && constant_indices)
	{
		rtlValue* ov = this->Get_Object()->Get_Value();
		assert ((ov != NULL) && (ov->Is("rtlArrayValue")));
		this->_value = 	((rtlArrayValue*)ov)->Get_Value(e_index);
	}
}

void rtlSliceExpression::Evaluate(rtlThread* t)
{
	if(_value)
		return;

	_base->Evaluate(t);
	if(_base->Get_Value() == NULL)
		return;

	rtlValue* v = Make_Unsigned_Zero(_type);
	rtlValue* bv = _base->Get_Value();

	assert(bv->Is("rtlUnsignedType") || bv->Is("rtlSignedType"));
	for(int I = 0, fI = _type->Size(); I < fI; I++)
	{
	  v->Set_Bit(I,bv->Get_Bit(I+_low));
	}		
}

void rtlUnaryExpression::Evaluate(rtlThread* t)
{
	if(_value)
		return;

	_rest->Evaluate(t);
	if(_rest->Get_Value() == NULL)
		return;

	rtlValue* v = Make_Unsigned_Zero(_type);
	rtlValue* bv = _rest->Get_Value();

	_value = Perform_Unary_Operation(_op, bv);
}

void rtlBinaryExpression::Evaluate(rtlThread* t)
{
	if(_value)
		return;

	_first->Evaluate(t);
	_second->Evaluate(t);

	rtlValue* fv = _first->Get_Value();
	rtlValue* sv = _second->Get_Value();

	if((fv == NULL) || (sv == NULL))
		return;

	_value = Perform_Binary_Operation(_op, fv, sv);	
}

void rtlTernaryExpression::Evaluate(rtlThread* t)
{
	if(_value)
		return;

	_test->Evaluate(t);
	rtlValue* tv = _test->Get_Value();

	_if_true->Evaluate(t);
	rtlValue* iv = _if_true->Get_Value();

	_if_false->Evaluate(t);
	rtlValue* ev = _if_false->Get_Value();

	if((iv != NULL) && (ev != NULL) && Are_Equal(iv,ev))
	{
		_value = iv;
	}
	else if(tv != NULL) 
	{
		if(Is_Zero(tv))
			_value = ev;
		else
			_value = iv;
	}
	else 
		_value = NULL;
}

void rtlTernaryExpression::Print_C(ostream& ofile)
{
	if(_value != NULL)
		this->Print_C_Declaration(_value, ofile);
	else
	{
		_test->Print_C(ofile);
		_if_true->Print_C(ofile);
		_if_false->Print_C(ofile);

		this->Print_C_Declaration(NULL, ofile);
		//ofile << this->Get_Type()->Get_C_Name() << " " << this->Get_C_Name() << ";" << endl;
		ofile << "if (" << _test->C_Int_Reference() << ") {" << endl;
		Print_C_Assignment(this->Get_C_Name(), _if_true->Get_C_Name(), this->Get_Type(), ofile);
		ofile << "}" << endl;
		ofile << " else {" << endl;
		Print_C_Assignment(this->Get_C_Name(), _if_false->Get_C_Name(), this->Get_Type(), ofile);
		ofile << "}" << endl;
	}	
}

		
