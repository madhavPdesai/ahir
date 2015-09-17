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
}

rtlExpression::rtlExpression(): hierRoot("anon_expr_" + IntToStr(e_counter))
{
	e_counter++;
	_type = NULL;
	_value = NULL;
	_is_target = false;
}

rtlSimpleObjectReference::rtlSimpleObjectReference(rtlObject* obj): rtlObjectReference(obj->Get_Id(),obj) 
{
	if(obj->Is_Constant())
	{
		_value = obj->Get_Value();
	}
}


void rtlConstantLiteralExpression::Print(ostream& ofile)
{
	ofile << " (";
	this->_type->Print(ofile);
	ofile << ") ";
	this->Get_Value()->Print(ofile);
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
	ofile << " " << _object->Get_Id() << " ";
}
	
	
rtlArrayObjectReference::rtlArrayObjectReference(rtlObject* obj, vector<rtlExpression*>& indices)
	: rtlObjectReference(obj->Get_Id() + "_array_ref", obj)
{
	_indices = indices;
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
	
rtlBinaryExpression::rtlBinaryExpression(rtlOperation op, rtlExpression* first, rtlExpression* second):
	rtlExpression("("+ first->Get_Id() + " " + rtlOp_To_String(op) + second->Get_Id() + ")")
{
	_op = op;
	_first = first;
	_second = second;
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
	_test = test;
	_if_true = if_true;
	_if_false = if_false;
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
