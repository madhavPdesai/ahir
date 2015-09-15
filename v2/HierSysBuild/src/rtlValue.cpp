#include <istream>
#include <ostream>
#include <assert.h>
#include <hierSystem.h>
#include <rtlThread.h>
#include <rtlType.h>
#include <rtlValue.h>

	
rtlValue* rtlArrayValue::Get_Value(vector<int>& indices)
{
	assert(_type->Is("rtlArrayType"));	
	rtlArrayType* at = (rtlArrayType*) t;	
	
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
		Value* v = new Unsigned(width, init_string);
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

