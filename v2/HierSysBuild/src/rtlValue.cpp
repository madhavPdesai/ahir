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
	rtlValue* ret_val = new rtlIntegerValue(this->Get_Type(), this->Get_Value());
}


void rtlUnsignedValue::Print(ostream& ofile)
{
	ofile << " " << this->Get_Value()->To_String() << " ";
}

rtlValue* rtlUnsignedValue::Copy()
{
	rtlValue* ret_val = new rtlUnsignedValue(this->Get_Type(), this->Get_Value());
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
}
	
void rtlSignedValue::Print(ostream& ofile)
{
	ofile << " " << this->Get_Value()->To_String() << " ";
}

int  rtlSignedValue::To_Integer()
{
	return(this->Get_Value()->To_Integer());
}

rtlValue* rtlArrayValue::Copy()
{
	rtlValue* ret_val = new rtlArrayValue(this->Get_Type(), this->_values);
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
	rtlType* ft = f->Get_Type();
	rtlType* st = s->Get_Type();


	// TODO
	assert(0);
}

bool  Is_Zero(rtlValue* v)
{
	return(v->To_Integer() == 0);
}

bool  Are_Equal(rtlValue* f, rtlValue* s)
{
	// TODO
	assert(0);
}

