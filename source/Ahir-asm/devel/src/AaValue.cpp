using namespace std;
#include <AaIncludes.h>
#include <AaEnums.h>
#include <AaUtil.h>
#include <AaRoot.h>
#include <AaScope.h>
#include <AaType.h>
#include <AaValue.h>
#include <AaExpression.h>
#include <AaObject.h>
#include <AaStatement.h>
#include <AaModule.h>
#include <AaProgram.h>


// *******************************************  VALUE ************************************
// AaValue
AaValue::AaValue(AaScope* parent):AaRoot() {this->_scope = parent;}
AaValue::~AaValue() {};

//AaStringValue
AaStringValue::AaStringValue(AaScope* parent, string value): AaValue(parent) 
{
  this->_value = value;
};
AaStringValue::~AaStringValue() {};
void AaStringValue::Print(ostream& ofile) 
{
  ofile << this->Get_Value_String(); 
}
bool AaStringValue::Equals(AaValue* other)
{
  return(other->Is("AaStringValue") && (other->Get_Value_String() == this->Get_Value_String()));

}
AaIntValue::AaIntValue(AaScope* s, int w):AaValue(s)
{
  _value = new IntValue(w);
}
void AaIntValue::Set_Value(string format)
{
  IntValue tmp(_value->_width,format);
  _value->Swap(tmp);
}
void AaIntValue::Assign(AaType* t, AaValue* expr_value)
{
  if(expr_value->Is("AaIntValue"))
    {
      
      if(t->Is("AaIntType"))
	this->_value->Signed_Assign(*(((AaIntValue*)expr_value)->_value));
      else
	this->_value->Unsigned_Assign(*(((AaIntValue*)expr_value)->_value));
    }
  else if(expr_value->Is("AaFloatValue"))
    {
      ((AaFloatValue*)expr_value)->_value->To_Integer(*(this->_value));
    }
}

bool AaIntValue::Equals(AaValue* other)
{
  return(other->Is("AaIntValue") && _value->Equal(*(((AaIntValue*)other)->_value)));
}
AaFloatValue::AaFloatValue(AaScope* s, int c, int m):AaValue(s)
{
  _value = new FloatValue(c,m);
}
bool AaFloatValue::Equals(AaValue* other)
{
  return(other->Is("AaFloatValue") && _value->Equal(*(((AaFloatValue*)other)->_value)));
}

 void AaFloatValue::Set_Value(string init_value)
{
  FloatValue tmp(_value->_characteristic_width, _value->_mantissa_width, init_value);
  _value->Swap(tmp);
}
void AaFloatValue::Assign(AaType* target_type, AaValue* expr_value)
{
  if(expr_value->Is("AaFloatValue"))
    {
      this->_value->Assign(*(((AaFloatValue*)expr_value)->_value));
    }
  else if(expr_value->Is("AaIntValue"))
    {
      if(target_type->Is("AaIntType"))
	{
	  *(this->_value) = ((AaIntValue*)expr_value)->_value
	    ->Signed_To_Float(this->_value->_characteristic_width,
			      this->_value->_mantissa_width);
	}
      else if(target_type->Is("AaUintType") || target_type->Is("AaPointerType"))
	{
	  *(this->_value) = ((AaIntValue*)expr_value)->_value->To_Float(this->_value->_characteristic_width,
									this->_value->_mantissa_width);
	}
    }
}
AaArrayValue::AaArrayValue(AaScope* s, 
			   int w, 
			   vector<unsigned int>& dims,
			   vector<string>& init_values):AaValue(s)
{
  _dimensions = dims;
  
  int total_length = 1;
  for(int idx =0; idx < dims.size(); idx++)
    total_length  *= dims[idx];
  assert(total_length == init_values.size());

  for(int idx = 0; idx < init_values.size(); idx++)
    {
      AaIntValue* new_val = new AaIntValue(s,w);
      new_val->Set_Value(init_values[idx]);
      _value_vector.push_back(new_val);
    }
}
AaArrayValue::AaArrayValue(AaScope* s, 
			   int c, 
			   int m, 
			   vector<unsigned int>& dims, 
			   vector<string>& init_values):AaValue(s)
{
  _dimensions = dims;
  
  int total_length = 1;
  for(int idx =0; idx < dims.size(); idx++)
    total_length  *= dims[idx];
  assert(total_length == init_values.size());
  
  for(int idx = 0; idx < init_values.size(); idx++)
    {
      AaFloatValue* new_val = new AaFloatValue(s,c,m);
      new_val->Set_Value(init_values[idx]);
      _value_vector.push_back(new_val);
    }
}


AaArrayValue::AaArrayValue(AaScope* s, AaType* element_type, vector<unsigned int>& dims):AaValue(s)
{
  _dimensions = dims;
  int nelements = 1;
  for(int idx = 0; idx < dims.size(); idx++)
    nelements *= dims[idx];

  if(element_type->Is_Integer_Type())
    {
      for(int idx = 0; idx < nelements; idx++)
	_value_vector.push_back(new AaIntValue(s,element_type->Size()));
    }
  else if(element_type->Is_Float_Type())
    {
      for(int idx = 0; idx < nelements; idx++)
	_value_vector.push_back(new AaFloatValue(s,
						 ((AaFloatType*)element_type)->Get_Characteristic(),
						 ((AaFloatType*)element_type)->Get_Mantissa()));
    }
}

void AaArrayValue::Assign(AaType* target_type, AaValue* expr_value)
{
  assert(expr_value->Is("AaArrayValue") && target_type->Is("AaArrayType"));
  AaArrayValue* av = (AaArrayValue*) expr_value;
  assert(av->_value_vector.size() == this->_value_vector.size());
  AaType* et = ((AaArrayType*) target_type)->Get_Element_Type();
  for(int idx = 0; idx < av->_value_vector.size(); idx++)
    {
      this->_value_vector[idx]->Assign(et,av->_value_vector[idx]);
    }
}

// if indices = (I1,I2,..In)
// and dims   = (D1,D2,..Dn)
// the index into value_vector is
//   I1(D2D3..Dn) + I2(D3D4..Dn) + .. + In-1(Dn) + In
//     = In + Dn(In-1 + Dn-1(In-2 + ...)))
AaValue* AaArrayValue::Get_Element(vector<int>& indices)
{
  assert(indices.size() == _dimensions.size());

  int index_in_array = indices[indices.size()-1];
  for(int idx = indices.size()-1; idx > 0; idx--)
    {
      index_in_array += (_dimensions[idx]*indices[idx-1]);
    }

  assert(index_in_array < _value_vector.size()-1);
  return(_value_vector[index_in_array]);
}
  

bool AaArrayValue::Equals(AaValue* other)
{
  if(other->Is("AaArrayValue"))
    {
      if(this->_value_vector.size() == ((AaArrayValue*)other)->_value_vector.size())
	{
	  for(int idx = 0; idx < _value_vector.size(); idx++)
	    {
	      if(!_value_vector[idx]->Equals(((AaArrayValue*)other)->_value_vector[idx]))
		return(false);
	    }
	  return(true);
	}
      else
	return(false);
    }
  else
    return(false);
}

AaValue* Make_Aa_Value(AaScope* scope, AaType* t)
{
  AaValue* ret_value = NULL;
  if(t->Is_Integer_Type())
    {
      ret_value = new AaIntValue(scope,
				 t->Size());
    }
  else if(t->Is_Float_Type())
    {
      ret_value = new AaFloatValue(scope,
				   ((AaFloatType*)t)->Get_Characteristic(),
				   ((AaFloatType*)t)->Get_Mantissa());

    }
  else 
    {
      assert(t->Is("AaArrayType"));
      ret_value = new AaArrayValue(scope,
				   ((AaArrayType*)t)->Get_Element_Type(),
				   ((AaArrayType*)t)->Get_Dimension_Vector());
    }
  if(ret_value)
    ret_value->Set_Type(t);
  return(ret_value);
}

AaValue* Make_Aa_Value(AaScope* scope, AaType* t,vector<string>& literals)
{
  AaValue* ret_value = NULL;
  if(t->Is_Integer_Type())
    {
      ret_value = new AaIntValue(scope,
				 t->Size());
      if(literals.size() > 0)
	((AaIntValue*)ret_value)->Set_Value(literals[0]);
    }
  else if(t->Is_Float_Type())
    {
      ret_value = new AaFloatValue(scope,
				   ((AaFloatType*)t)->Get_Characteristic(),
				   ((AaFloatType*)t)->Get_Mantissa());

      if(literals.size() > 0)
	((AaFloatValue*)ret_value)->Set_Value(literals[0]);
    }
  else 
    {
      assert(t->Is("AaArrayType"));
      if(((AaArrayType*)t)->Get_Element_Type()->Is("AaIntType"))
	{
	  ret_value = new AaArrayValue(scope,
				       ((AaArrayType*)t)->Get_Element_Type()->Size(),
				       ((AaArrayType*)t)->Get_Dimension_Vector(),
				       literals);
	}
      else
	{
	  assert(((AaArrayType*)t)->Get_Element_Type()->Is("AaFloatType"));
	  ret_value = new AaArrayValue(scope,
				       ((AaFloatType*)((AaArrayType*)t)->
					Get_Element_Type())->Get_Characteristic(),
				       ((AaFloatType*)((AaArrayType*)t)->
					Get_Element_Type())->Get_Mantissa(),
				       ((AaArrayType*)t)->Get_Dimension_Vector(),
				       literals);
	}
    }
  if(ret_value)
    ret_value->Set_Type(t);
  return(ret_value);
}


AaValue* Perform_Unary_Operation(AaOperation op, AaValue* v)
{
  AaIntValue* iv = NULL;
  AaIntValue* irv = NULL;
  AaFloatValue* fv = NULL;
  AaFloatValue* frv = NULL;

  vector<string> dummy;
  if(v->Is("AaIntValue"))
    {
      iv = (AaIntValue*) v;
      irv = (AaIntValue*) Make_Aa_Value(v->Get_Scope(),v->Get_Type(),dummy);
      (*irv)._value = (*iv)._value;

      if(op == __NOT)
	{
	  ((AaIntValue*)irv)->_value->Complement();
	  return(irv);
	}
      else
	{
	  delete irv;
	  irv = NULL;
	}
      return(irv);
    }
  else
    return(NULL);
}

AaValue* Perform_Binary_Operation(AaOperation op, AaValue* u, AaValue* v)
{

  if(u->Is("AaIntValue") && v->Is("AaIntValue"))
    {
      vector<string> dummy;

      AaIntValue* irv = (AaIntValue*) 
	Make_Aa_Value(u->Get_Scope(),u->Get_Type(),dummy);
      (*irv)._value = ((AaIntValue*)u)->_value;

      AaIntValue* vv = (AaIntValue*) v;

      AaIntValue* icrv = (AaIntValue*)
	Make_Aa_Value(u->Get_Scope(),AaProgram::Make_Uinteger_Type(1),dummy);
      
      if(op == __OR)
	{
	  irv->_value->Or(*((*vv)._value)); return(irv);
	}
      else if(op == __AND)
	{
	  irv->_value->And(*((*vv)._value)); return(irv);
	}
      else if(op == __NOR)
	{ 
	  irv->_value->Nor(*((*vv)._value)); return(irv);
	}
      else if(op == __NAND)
	{ 
	  irv->_value->Nand(*((*vv)._value)); return(irv);
	}
      else if(op == __XOR)
	{ 
	  irv->_value->Xor(*((*vv)._value)); return(irv);
	}
      else if(op == __XNOR)
	{ 
	  irv->_value->Xnor(*((*vv)._value)); return(irv);
	}
      else if(op == __SHL)
	{ 
	  irv->_value->Shift_Left(((*vv)._value)->To_Integer()); return(irv);
	}
      else if(op == __SHR)
	{ 
	  if(u->Get_Type()->Is("AaIntType"))
	    irv->_value->Shift_Right_Signed(((*vv)._value)->To_Integer());
	  else 
	    irv->_value->Shift_Right(((*vv)._value)->To_Integer()); 
	  return(irv);
	}
      else if(op == __PLUS)
	{ 
	  irv->_value->Add(*((*vv)._value)); return(irv);
	}
      else if(op == __MINUS)
	{ 
	  irv->_value->Subtract(*((*vv)._value)); return(irv);
	}
      else if(op == __DIV)
	{ 
	  irv->_value->Divide(*((*vv)._value)); return(irv);
	}
      else if(op == __MUL)
	{ 
	  irv->_value->Multiply(*((*vv)._value)); return(irv);
	}
      else if(op == __EQUAL)
	{ 
	  icrv->_value->Set_Bit(0,irv->_value->Equal(*((*vv)._value))); return(icrv);
	}
      else if(op == __NOTEQUAL)
	{ 
	  icrv->_value->Set_Bit(0,!irv->_value->Equal(*((*vv)._value))); return(icrv);
	}
      else if(op == __LESS)
	{ 
	  icrv->_value->Set_Bit(0,irv->_value->Less_Than(*((*vv)._value))); return(icrv);
	}
      else if(op == __LESSEQUAL)
	{
	  icrv->_value->Set_Bit(0,irv->_value->Less_Equal(*((*vv)._value))); return(icrv); 
	}
      else if(op == __GREATER)
	{ 
	  icrv->_value->Set_Bit(0,irv->_value->Greater(*((*vv)._value))); return(icrv); 
	}
      else if(op == __GREATEREQUAL)
	{ 
	  icrv->_value->Set_Bit(0,irv->_value->Greater_Equal(*((*vv)._value))); return(icrv); 
	}
      else if(op == __CONCAT)
	{ 
	  irv->_value->Concatenate(*((*vv)._value)); 
	  return(irv);
	}
      else if(op == __BITSEL)
	{
	  icrv->_value->Set_Bit(0,irv->_value->Get_Bit(vv->_value->To_Integer()));
	  return(icrv);
	}
      else
	{
	  delete irv;
	  irv = NULL;
	  delete icrv;
	  icrv = NULL;
	}
    }
  else if(u->Is("AaFloatValue") && v->Is("AaFloatValue"))
    {
      vector<string> dummy;

      AaFloatValue* frv = (AaFloatValue*) 
	Make_Aa_Value(u->Get_Scope(),u->Get_Type(),dummy);
      (*frv)._value = ((AaFloatValue*)u)->_value;

      AaFloatValue* vv = (AaFloatValue*) v;

      AaIntValue* icrv = (AaIntValue*)
	Make_Aa_Value(u->Get_Scope(),AaProgram::Make_Uinteger_Type(1),dummy);
      if(op == __PLUS)
	{ 
	  frv->_value->Add(*((*vv)._value)); return(frv);
	}
      else if(op == __MINUS)
	{ 
	  frv->_value->Subtract(*((*vv)._value)); return(frv);
	}
      else if(op == __DIV)
	{ 
	  frv->_value->Divide(*((*vv)._value)); return(frv);
	}
      else if(op == __MUL)
	{ 
	  frv->_value->Multiply(*((*vv)._value)); return(frv);
	}
      else if(op == __EQUAL)
	{ 
	  icrv->_value->Set_Bit(0,frv->_value->Equal(*((*vv)._value))); return(icrv);
	}
      else if(op == __NOTEQUAL)
	{ 
	  icrv->_value->Set_Bit(0,!frv->_value->Equal(*((*vv)._value))); return(icrv);
	}
      else if(op == __LESS)
	{ 
	  icrv->_value->Set_Bit(0,frv->_value->Less_Than(*((*vv)._value))); return(icrv);
	}
      else if(op == __LESSEQUAL)
	{
	  icrv->_value->Set_Bit(0,frv->_value->Less_Equal(*((*vv)._value))); return(icrv); 
	}
      else if(op == __GREATER)
	{ 
	  icrv->_value->Set_Bit(0,frv->_value->Greater(*((*vv)._value))); return(icrv); 
	}
      else if(op == __GREATEREQUAL)
	{ 
	  icrv->_value->Set_Bit(0,frv->_value->Greater_Equal(*((*vv)._value))); return(icrv); 
	}
      else
	{
	  delete frv;
	  frv = NULL;
	  delete icrv;
	  icrv = NULL;
	}
    }
  return(NULL);
}
