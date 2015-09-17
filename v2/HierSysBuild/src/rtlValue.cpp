#include <istream>
#include <ostream>
#include <assert.h>
#include <hierSystem.h>
#include <rtlEnums.h>
#include <rtlType.h>
#include <Value.hpp>
#include <rtlValue.h>
#include <rtlThread.h>

using namespace std;
using namespace _base_value_;

void rtlIntegerValue::Print(ostream& ofile)
{
	ofile << " " << _value << " ";
}	

rtlValue* rtlIntegerValue::Copy()
{
	rtlValue* ret_val = new rtlIntegerValue(this->Get_Type(), this->To_Integer());
	return(ret_val);
}


void rtlUnsignedValue::Print(ostream& ofile)
{
	ofile << " " << this->Get_Value()->To_String() << " ";
}

rtlValue* rtlUnsignedValue::Copy()
{
	rtlValue* ret_val = new rtlUnsignedValue(this->Get_Type(), this->Get_Value());
	return(ret_val);
}

int  rtlUnsignedValue::To_Integer()
{
	return(_value->To_Integer());
}		
bool rtlUnsignedValue::Get_Bit(int bi)
{
	return(((Unsigned*)this->Get_Value())->Get_Bit(bi));
}
void rtlUnsignedValue::Set_Bit(int bit_index, bool bit_val)
{
	((Unsigned*)this->Get_Value())->Set_Bit(bit_index,bit_val);
}

rtlValue* rtlSignedValue::Copy()
{
	rtlValue* ret_val = new rtlSignedValue(this->Get_Type(), this->Get_Value());
	return(ret_val);
}
	
	
rtlValue* rtlUnsignedValue::Resize(int w)
{
	_type = Find_Or_Make_Unsigned_Type(w);
	((Unsigned*)_value)->Resize(w);
}

void rtlUnsignedValue::Not() 
{
	((Unsigned*)_value)->Complement();
}

void rtlUnsignedValue::And(rtlValue* other)
{
	assert(other->Is("rtlUnsignedValue"));
	rtlUnsignedValue* uo  = (rtlUnsignedValue*) other;
	((Unsigned*)_value)->And(*((Unsigned*)(uo->Get_Value())));
}

void rtlUnsignedValue::Or(rtlValue* other)
{
	assert(other->Is("rtlUnsignedValue"));
	rtlUnsignedValue* uo  = (rtlUnsignedValue*) other;
	((Unsigned*)_value)->Or(*((Unsigned*)(uo->Get_Value())));
}

void rtlUnsignedValue::Xor(rtlValue* other)
{
	assert(other->Is("rtlUnsignedValue"));
	rtlUnsignedValue* uo  = (rtlUnsignedValue*) other;
	((Unsigned*)_value)->Xor(*((Unsigned*)(uo->Get_Value())));
}
void rtlUnsignedValue::Nand(rtlValue* other)
{
	assert(other->Is("rtlUnsignedValue"));
	rtlUnsignedValue* uo  = (rtlUnsignedValue*) other;
	((Unsigned*)_value)->Nand(*((Unsigned*)(uo->Get_Value())));
}
void rtlUnsignedValue::Nor(rtlValue* other)
{
	assert(other->Is("rtlUnsignedValue"));
	rtlUnsignedValue* uo  = (rtlUnsignedValue*) other;
	((Unsigned*)_value)->Nor(*((Unsigned*)(uo->Get_Value())));
}
void rtlUnsignedValue::Xnor(rtlValue* other)
{
	assert(other->Is("rtlUnsignedValue"));
	rtlUnsignedValue* uo  = (rtlUnsignedValue*) other;
	((Unsigned*)_value)->Xnor(*((Unsigned*)(uo->Get_Value())));
}
void rtlUnsignedValue::Shl(rtlValue* other)
{
	((Unsigned*)_value)->Shift_Left(other->To_Integer());
}
void rtlUnsignedValue::Shr(rtlValue* other)
{
	((Unsigned*)_value)->Shift_Right(other->To_Integer());
}
void rtlUnsignedValue::Rol(rtlValue* other)
{
	((Unsigned*)_value)->Rotate_Left(other->To_Integer());
}
void rtlUnsignedValue::Ror(rtlValue* other)
{
	((Unsigned*)_value)->Rotate_Right(other->To_Integer());
}
	 
void rtlUnsignedValue::Plus(rtlValue* other)
{
	assert(other->Is("rtlUnsignedValue"));
	rtlUnsignedValue* uo  = (rtlUnsignedValue*) other;
	((Unsigned*)_value)->Add(*((Unsigned*)(uo->Get_Value())));
}
void rtlUnsignedValue::Minus(rtlValue* other)
{
	assert(other->Is("rtlUnsignedValue"));
	rtlUnsignedValue* uo  = (rtlUnsignedValue*) other;
	((Unsigned*)_value)->Subtract(*((Unsigned*)(uo->Get_Value())));
}
void rtlUnsignedValue::Mul(rtlValue* other)
{
	assert(other->Is("rtlUnsignedValue"));
	rtlUnsignedValue* uo  = (rtlUnsignedValue*) other;
	((Unsigned*)_value)->Multiply(*((Unsigned*)(uo->Get_Value())));
}

bool rtlUnsignedValue::Greater(rtlValue* other)
{
	assert(other->Is("rtlUnsignedValue"));
	rtlUnsignedValue* uo  = (rtlUnsignedValue*) other;
	bool ret_val = ((Unsigned*)_value)->Greater(*((Unsigned*)(uo->Get_Value())));
	return(ret_val);
}
bool rtlUnsignedValue::Less(rtlValue* other)
{
	assert(other->Is("rtlUnsignedValue"));
	rtlUnsignedValue* uo  = (rtlUnsignedValue*) other;
	bool ret_val = ((Unsigned*)_value)->Less_Than(*((Unsigned*)(uo->Get_Value())));
	return(ret_val);
}
bool rtlUnsignedValue::Equal(rtlValue* other)
{
	assert(other->Is("rtlUnsignedValue"));
	rtlUnsignedValue* uo  = (rtlUnsignedValue*) other;
	bool ret_val = ((Unsigned*)_value)->Equal(*((Unsigned*)(uo->Get_Value())));
	return(ret_val);
}

void rtlUnsignedValue::Concat(rtlValue* other)
{
	assert(other->Is("rtlUnsignedValue"));
	rtlUnsignedValue* uo  = (rtlUnsignedValue*) other;
	((Unsigned*)_value)->Concatenate(*((Unsigned*)(uo->Get_Value())));
}

void rtlSignedValue::Print(ostream& ofile)
{
	ofile << " " << this->Get_Value()->To_String() << " ";
}

int  rtlSignedValue::To_Integer()
{
	return(this->Get_Value()->To_Integer());
}

	
rtlValue* rtlSignedValue::Resize(int w)
{
	_type = Find_Or_Make_Signed_Type(w);
	((Signed*)_value)->Resize(w);
}

void rtlSignedValue::Shr(rtlValue* other)
{
	((Signed*)_value)->Shift_Right(other->To_Integer());
}

void rtlSignedValue::Plus(rtlValue* other)
{
	assert(other->Is("rtlSignedValue"));
	rtlSignedValue* uo  = (rtlSignedValue*) other;
	((Signed*)_value)->Add(*((Signed*)(uo->Get_Value())));
}

void rtlSignedValue::Minus(rtlValue* other)
{
	assert(other->Is("rtlSignedValue"));
	rtlSignedValue* uo  = (rtlSignedValue*) other;
	((Signed*)_value)->Subtract(*((Signed*)(uo->Get_Value())));
}

void rtlSignedValue::Mul(rtlValue* other)
{
	assert(other->Is("rtlSignedValue"));
	rtlSignedValue* uo  = (rtlSignedValue*) other;
	((Unsigned*)_value)->Multiply(*((Unsigned*)(uo->Get_Value())));
	((Signed*)_value)->Sign_Extend();
}

bool rtlSignedValue::Greater(rtlValue* other)
{
	assert(other->Is("rtlSignedValue"));
	rtlSignedValue* uo  = (rtlSignedValue*) other;
	bool ret_val = ((Signed*)_value)->Greater(*((Signed*)(uo->Get_Value())));
	return(ret_val);
}

bool rtlSignedValue::Less(rtlValue* other)
{
	assert(other->Is("rtlSignedValue"));
	rtlSignedValue* uo  = (rtlSignedValue*) other;
	bool ret_val = ((Signed*)_value)->Less_Than(*((Signed*)(uo->Get_Value())));
	return(ret_val);
}


rtlValue* rtlArrayValue::Copy()
{
	rtlValue* ret_val = new rtlArrayValue(this->Get_Type(), this->_values);
	return(ret_val);
}
		
	
void rtlArrayValue::Print(ostream& ofile)
{
	for(int I = 0, fI = _values.size(); I < fI; I++)
	{
		ofile << " ";
		_values[I]->Print(ofile);
		ofile << " ";
	}
}

rtlValue* rtlArrayValue::Get_Value(vector<int>& indices)
{
	assert(_type->Is("rtlArrayType"));	
	rtlArrayType* at = (rtlArrayType*) _type;	
	
	int idx = at->Get_Index(indices);

	assert((idx >= 0) && (idx < _values.size()));

	return(_values[idx]);	

}


rtlValue* Make_Rtl_Value(rtlType* t, vector<string>& init_values)
{
	rtlValue* ret_val = NULL;
	if(t->Is("rtlIntegerType"))
	{
		assert(init_values.size() == 1);
		string init_string = init_values[0];

		int v = atoi(init_string.c_str());
		ret_val = new rtlIntegerValue(t, v);
	}
	else if(t->Is("rtlUnsignedType"))
	{
		assert(init_values.size() == 1);
		string init_string = init_values[0];

		rtlUnsignedType* ut  = (rtlUnsignedType*) t;
		int width = ut->Get_Width();
		_base_value_::Value* v = new Unsigned(width, init_string);
		ret_val = new rtlUnsignedValue(t, v);
	}
	else if(t->Is("rtlSignedType"))
	{
		assert(init_values.size() == 1);
		string init_string = init_values[0];

		rtlSignedType* ut  = (rtlSignedType*) t;
		int width = ut->Get_Width();
		Value* v = new Signed(width, init_string);
		ret_val = new rtlSignedValue(t, v);
	}
	else if(t->Is("rtlArrayType"))
	{
		rtlArrayType* at = (rtlArrayType*) t;
		vector<rtlValue*> av;

		assert(init_values.size() == at->Number_Of_Elements());

		for(int I=0, fI = init_values.size(); I < fI; I++)
		{
			vector<string> t_init_string;
			t_init_string.push_back(init_values[I]);
			
			rtlValue* ev = Make_Rtl_Value(at->Get_Element_Type(), t_init_string);
			av.push_back(ev);	
		}
		ret_val = new rtlArrayValue(t,av);
	}
	else
		assert(0);

	return(ret_val);
}

rtlValue* Make_Unsigned_Zero(rtlType* t)
{
	if(t->Is("rtlUnsignedType"))
	{
		Unsigned* v = new Unsigned(t->Size());
		rtlValue* ret_val = new rtlUnsignedValue(t,v);
		return(ret_val);
	}
	else
		return(NULL);
}

rtlValue* Perform_Unary_Operation(rtlOperation op, rtlValue* v)
{
	if((op == __NOT) && (v->Is("rtlUnsignedValue")))
	{
		rtlUnsignedValue* uv = (rtlUnsignedValue*)v;
		Unsigned* nv = new Unsigned(*((Unsigned*)(uv->Get_Value())));
		nv->Complement();
		rtlValue* ret_val = new rtlUnsignedValue(v->Get_Type(), nv);
		return(ret_val);
	}
	else
	{
		return(NULL);
	}
}

rtlValue* Perform_Binary_Operation(rtlOperation op, rtlValue* f, rtlValue* s)
{
	bool rv = false;
	rtlValue* result = f->Copy();
	switch(op)
	{
		case __OR:
			result->Or(s);
			break;
		case __AND:
			result->And(s);
			break;
		case __XOR:
			result->Xor(s);
			break;
		case __NOR:
			result->Nor(s);
			break;
		case __NAND:
			result->Nand(s);
			break;
		case __XNOR:
			result->Xnor(s);
			break;
		case __SHL:
			result->Shl(s);
			break;
		case __SHR:
			result->Shr(s);
			break;
		case __ROR:
			result->Ror(s);
			break;
		case __ROL:
			result->Rol(s);
			break;
		case __EQUAL:
			rv = result->Equal(s);
			result->Resize(1);
			result->Set_Bit(0,rv);
			break;
		case __NOTEQUAL:
			rv = result->NotEqual(s);
			result->Resize(1);
			result->Set_Bit(0,rv);
			break;
		case __LESS:
			rv = result->Less(s);
			result->Resize(1);
			result->Set_Bit(0,rv);
			break;
		case __LESSEQUAL:
			rv = result->LessEqual(s);
			result->Resize(1);
			result->Set_Bit(0,rv);
			break;
		case __GREATER:
			rv = result->Greater(s);
			result->Resize(1);
			result->Set_Bit(0,rv);
			break;
		case __GREATEREQUAL:
			rv = result->GreaterEqual(s);
			result->Resize(1);
			result->Set_Bit(0,rv);
			break;
		case __PLUS:
			result->Plus(s);
			break;
		case __MINUS:
			result->Minus(s);
			break;
		case __MUL:
			result->Mul(s);
			break;
		case __CONCAT:
			result->Concat(s);
			break;
		default:
			break;
	}
}

bool  Is_Zero(rtlValue* v)
{
	return(v->To_Integer() == 0);
}

bool  Are_Equal(rtlValue* f, rtlValue* s)
{
	return(f->Equal(s));
}

