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
AaValue::AaValue(AaScope* parent, AaType* t):AaRoot() {this->_scope = parent;_type = t;}
AaValue::~AaValue() {};

//AaStringValue
AaStringValue::AaStringValue(AaScope* parent, string value): AaValue(parent,NULL) 
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
AaUintValue::AaUintValue(AaScope* s, int w):AaValue(s,AaProgram::Make_Integer_Type((unsigned int) w))
{
  _value = NULL;
}

void AaUintValue::Make_Value(int w)
{
  _value = new Unsigned(w);
}
void AaUintValue::Set_Value(string format)
{
  Unsigned tmp(((Unsigned*)_value)->_width,format);
  ((Unsigned*)_value)->Swap(tmp);
}
void AaUintValue::Assign(AaType* t, AaValue* expr_value)
{
  if(expr_value->Is("AaUintValue"))
    {
      ((Unsigned*)(this->_value))->Assign(*((Unsigned*)(expr_value->Get_Value())));
    }
  else if(expr_value->Is("AaIntValue"))
    {
      ((Unsigned*)(this->_value))->Assign(*((Signed*)(expr_value->Get_Value())));
    }
  else if(expr_value->Is("AaFloatValue"))
    {
      ((Float*)(expr_value->Get_Value()))->To_Unsigned(*((Unsigned*)(this->Get_Value())));
    }
}

bool AaUintValue::Equals(AaValue* other)
{
  return(other->Is("AaUintValue") && 
	 ((Unsigned*)(_value))->Equal(*((Unsigned*)(other->Get_Value()))));
}

AaIntValue::AaIntValue(AaScope* s, int width):AaUintValue(s,width)
{
}
void AaIntValue::Make_Value(int w)
{
  _value = new Signed(w);
}
void AaIntValue::Set_Value(string format)
{
  Signed tmp(((Signed*)_value)->_width,format);
  ((Signed*)(_value))->Swap(tmp);
}
void AaIntValue::Assign(AaType* target_type, AaValue* expr_value)
{
  if(expr_value->Is("AaUintValue"))
    {
      ((Signed*)(this->_value))->Assign(*((Unsigned*)(expr_value->Get_Value())));
    }
  else if(expr_value->Is("AaIntValue"))
    {
      ((Signed*)(this->_value))->Assign(*((Signed*)(expr_value->Get_Value())));
    }
  else if(expr_value->Is("AaFloatValue"))
    {
      ((Float*)(expr_value->Get_Value()))->To_Signed(*((Signed*)(this->Get_Value())));
    }
}


AaFloatValue::AaFloatValue(AaScope* s, int c, int m):
  AaValue(s,AaProgram::Make_Float_Type((unsigned int)c, (unsigned int) m))
{
  _value = new Float(c,m);
}
bool AaFloatValue::Equals(AaValue* other)
{
  return(other->Is("AaFloatValue") && 
	 ((Float*)(_value))->Equal(*((Float*)(other->Get_Value()))));
}

void AaFloatValue::Set_Value(string init_value)
{
  if(init_value == "0")
  {
	  Float tmp(_value->_characteristic_width, _value->_mantissa_width, init_value);
	  ((Float*)(_value))->Swap(tmp);
  }
  else
  {
	  assert(init_value.size() > 2 && init_value[0] == '_' && init_value[1] == 'f');
	  Float tmp(_value->_characteristic_width, _value->_mantissa_width, init_value.substr(2));
	  ((Float*)(_value))->Swap(tmp);
  }
}

void AaFloatValue::Assign(AaType* target_type, AaValue* expr_value)
{
  if(expr_value->Is("AaFloatValue"))
    {
      ((Float*)(this->_value))->Assign(*((Float*)(expr_value->Get_Value())));
    }
  else if(expr_value->Is("AaUintValue"))
    {
      *(this->_value) = 
	((Unsigned*)(expr_value->Get_Value()))->To_Float(this->_value->_characteristic_width,
							 this->_value->_mantissa_width);
    }
  else if(expr_value->Is("AaIntValue"))
    {
      *(this->_value) = 
	((Signed*)(expr_value->Get_Value()))->To_Float(this->_value->_characteristic_width,
							 this->_value->_mantissa_width);
    }
}

string AaFloatValue::To_VC_String()
{
  int w = this->Get_Type()->Size();
  Unsigned tmp = Signed(w);

  ((Float*)this->Get_Value())->Bit_Cast(tmp);
  return("_b" + tmp.To_String());
}


AaArrayValue::AaArrayValue(AaScope* s, AaArrayType* at,  vector<string>& init_values):AaValue(s,at)
{
  _dimensions = at->Get_Dimension_Vector();
  
  int total_length = 1;
  for(int idx =0; idx < _dimensions.size(); idx++)
    total_length  *= _dimensions[idx];
  
  unsigned int init_id = 0;
  for(int idx = 0; idx < total_length; idx++)
    {
      AaValue* new_val = Make_Aa_Value(s,at->Get_Element_Type());
      init_id = new_val->Eat(init_id, init_values);

      _value_vector.push_back(new_val);
    }
}


AaArrayValue::AaArrayValue(AaScope* s, AaArrayType* at):AaValue(s,at)
{
  _dimensions = at->Get_Dimension_Vector();
  int nelements = 1;
  for(int idx = 0; idx < _dimensions.size(); idx++)
    nelements *= _dimensions[idx];

  for(int idx = 0; idx < nelements; idx++)
    _value_vector.push_back(Make_Aa_Value(s,at->Get_Element_Type()));
}

unsigned int AaArrayValue::Eat(unsigned int init_id, vector<string>& init_vals)
{
  for(int idx = 0; idx < _value_vector.size(); idx++)
    {
      init_id = _value_vector[idx]->Eat(init_id,init_vals);
    }
  return(init_id);
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
// (ie. the array is stored in row-major form..)
AaValue* AaArrayValue::Get_Element(vector<int>& indices)
{

  vector<int> my_indices;
  vector<int> succ_indices;

  for(int idx = 0; idx < indices.size(); idx++)
    {
      if(idx < _dimensions.size())
	my_indices.push_back(indices[idx]);
      else
	succ_indices.push_back(indices[idx]);
    }

  int index_in_array = my_indices[my_indices.size()-1];
  for(int idx = my_indices.size()-1; idx > 0; idx--)
    {
      index_in_array += (_dimensions[idx]*my_indices[idx-1]);
    }

  assert(index_in_array < _value_vector.size());

  AaValue* ret_val = _value_vector[index_in_array];
  if(succ_indices.size() > 0)
    ret_val = ret_val->Get_Element(succ_indices);

  return(ret_val);
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

AaRecordValue::AaRecordValue(AaScope* s, AaRecordType* rt):AaValue(s,rt)
{
  for(int idx = 0; idx < rt->Get_Number_Of_Elements(); idx++)
    {
      _value_vector.push_back(Make_Aa_Value(s,rt->Get_Element_Type(idx)));
    }
  
}
AaRecordValue::AaRecordValue(AaScope* s, AaRecordType* rt, vector<string>& init_values):
  AaValue(s,rt)
{
  for(int idx = 0; idx < rt->Get_Number_Of_Elements(); idx++)
    {
      _value_vector.push_back(Make_Aa_Value(s,rt->Get_Element_Type(idx)));
    }

  unsigned int init_id = 0;
  for(int idx = 0; idx < _value_vector.size(); idx++)
    {
      init_id = _value_vector[idx]->Eat(init_id,init_values);
    }
}
AaValue* AaRecordValue::Get_Element(vector<int>& indices)
{
  assert(indices.size() > 0);
  
  AaValue* v = this->_value_vector[indices[0]];

  vector<int> succ_indices;
  for(int idx = 1; idx < indices.size(); idx++)
    {
      succ_indices.push_back(indices[idx]);
    }

  if(succ_indices.size() > 0)
    {
      v = v->Get_Element(succ_indices);
    }
  return(v);
}

unsigned int AaRecordValue::Eat(unsigned int init_id, vector<string>& init_vals)
{
  for(int idx = 0; idx < _value_vector.size(); idx++)
    {
      init_id = _value_vector[idx]->Eat(init_id,init_vals);
    }
  return(init_id);
}


void AaRecordValue::Assign(AaType* target_type, AaValue* expr_value)
{
  assert(expr_value->Is("AaRecordValue") && target_type->Is("AaRecordType"));
  AaRecordValue* rv = (AaRecordValue*) expr_value;
  AaRecordType* rt = (AaRecordType*) target_type;
  assert(rv->_value_vector.size() == this->_value_vector.size());

  for(int idx = 0; idx < rv->_value_vector.size(); idx++)
    {
      this->_value_vector[idx]->Assign(rt->Get_Element_Type(idx),rv->_value_vector[idx]);
    }
}

bool AaRecordValue::Equals(AaValue* other)
{
  if(!other->Is("AaRecordValue"))
    return(false);
  if(!(other->Get_Type() == this->Get_Type()))
    return(false);
  
  AaRecordValue* rv = (AaRecordValue*) other;
  if(rv->_value_vector.size() != this->_value_vector.size())
    return(false);

  bool ret_val = true;
  for(int idx = 0; idx < this->_value_vector.size(); idx++)
    {
      if(!this->_value_vector[idx]->Equals(rv->_value_vector[idx]))
	{
	  ret_val = false;
	  break;
	}
    }
  return(ret_val);
}

AaValue* Make_Aa_Value(AaScope* scope, AaType* t)
{
  AaValue* ret_value = NULL;
  if(t->Is("AaUintType") || t->Is("AaPointerType"))
    {
      ret_value = new AaUintValue(scope,
				 t->Size());
      ((AaUintValue*)ret_value)->Make_Value(t->Size());
    }
  else if(t->Is("AaIntType"))
    {
      ret_value = new AaIntValue(scope,
				 t->Size());
      ((AaIntValue*)ret_value)->Make_Value(t->Size());
    }
  else if(t->Is_Float_Type())
    {
      ret_value = new AaFloatValue(scope,
				   ((AaFloatType*)t)->Get_Characteristic(),
				   ((AaFloatType*)t)->Get_Mantissa());
    }
  else if(t->Is("AaArrayType"))
    {
      ret_value = new AaArrayValue(scope,((AaArrayType*)t));
    }
  else if(t->Is("AaRecordType"))
    {
      ret_value = new AaRecordValue(scope,((AaRecordType*)t));
    }

  return(ret_value);
}

AaValue* Make_Aa_Value(AaScope* scope, AaType* t,vector<string>& literals)
{
  AaValue* ret_value = Make_Aa_Value(scope,t);
  ret_value->Eat(0,literals);
  return(ret_value);
}


AaValue* Perform_Unary_Operation(AaOperation op, AaValue* v)
{
  AaUintValue* iv = NULL;
  AaUintValue* irv = NULL;
  AaFloatValue* fv = NULL;
  AaFloatValue* frv = NULL;

  if(op == __NOT)
    {
      assert(v->Is_IntValue());

      AaValue* irv = Make_Aa_Value(v->Get_Scope(),v->Get_Type());
      irv->Assign(v->Get_Type(),v);
      ((Unsigned*)(irv->Get_Value()))->Complement();
      return(irv);

    }
  else
    {
      //
      // int-to-float etc not yet implemented...
      //
      return(NULL);
    }

}

AaValue* Perform_Binary_Operation(AaOperation op, AaValue* u, AaValue* v)
{

  if(u->Is_IntValue() && v->Is_IntValue())
    {

      AaValue* irv = Make_Aa_Value(u->Get_Scope(),u->Get_Type());
      irv->Assign(u->Get_Type(),u);

      Unsigned* irvv = ((Unsigned*)(irv->Get_Value()));
      Unsigned* vv = ((Unsigned*)(v->Get_Value()));
      AaValue* icrv =  Make_Aa_Value(u->Get_Scope(),AaProgram::Make_Uinteger_Type(1));
      Unsigned* icrvv = ((Unsigned*)(icrv->Get_Value()));
      
      if(op == __OR)
	{
	  irvv->Or(*vv); return(irv);
	}
      else if(op == __AND)
	{
	  irvv->And(*vv); return(irv);
	}
      else if(op == __NOR)
	{ 
	  irvv->Nor(*vv); return(irv);
	}
      else if(op == __NAND)
	{ 
	  irvv->Nand(*vv); return(irv);
	}
      else if(op == __XOR)
	{ 
	  irvv->Xor(*vv); return(irv);
	}
      else if(op == __XNOR)
	{ 
	  irvv->Xnor(*vv); return(irv);
	}
      else if(op == __SHL)
	{ 
	  irvv->Shift_Left(vv->To_Integer()); return(irv);
	}
      else if(op == __SHR)
	{ 
	  irvv->Shift_Right(vv->To_Integer());
	  return(irv);
	}
      else if(op == __PLUS)
	{ 
	  irvv->Add(*vv); return(irv);
	}
      else if(op == __MINUS)
	{ 
	  irvv->Subtract(*vv); return(irv);
	}
      else if(op == __DIV)
	{ 
	  irvv->Divide(*vv); return(irv);
	}
      else if(op == __MUL)
	{ 
	  irvv->Multiply(*vv); return(irv);
	}
      else if(op == __EQUAL)
	{ 
	  icrvv->Set_Bit(0,irvv->Equal(*vv)); return(icrv);
	}
      else if(op == __NOTEQUAL)
	{ 
	  icrvv->Set_Bit(0,!irvv->Equal(*vv)); return(icrv);
	}
      else if(op == __LESS)
	{ 
	  icrvv->Set_Bit(0,irvv->Less_Than(*vv)); return(icrv);
	}
      else if(op == __LESSEQUAL)
	{
	  icrvv->Set_Bit(0,irvv->Less_Equal(*vv)); return(icrv); 
	}
      else if(op == __GREATER)
	{ 
	  icrvv->Set_Bit(0,irvv->Greater(*vv)); return(icrv); 
	}
      else if(op == __GREATEREQUAL)
	{ 
	  icrvv->Set_Bit(0,irvv->Greater_Equal(*vv)); return(icrv); 
	}
      else if(op == __CONCAT)
	{ 
	  irvv->Concatenate(*vv); 
	  return(irv);
	}
      else if(op == __BITSEL)
	{
	  icrvv->Set_Bit(0,irvv->Get_Bit(vv->To_Integer()));
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

      AaValue* frv = Make_Aa_Value(u->Get_Scope(),u->Get_Type());
      frv->Assign(u->Get_Type(),u);

      Float* frvv = (Float*)(frv->Get_Value());

      AaValue* icrv = Make_Aa_Value(u->Get_Scope(),AaProgram::Make_Uinteger_Type(1));
      Unsigned* icrvv = (Unsigned*)(icrv->Get_Value());

      Float* vv = ((Float*)(v->Get_Value()));
      if(op == __PLUS)
	{ 
	  frvv->Add(*vv); return(frv);
	}
      else if(op == __MINUS)
	{ 
	  frvv->Subtract(*vv); return(frv);
	}
      else if(op == __DIV)
	{ 
	  frvv->Divide(*vv); return(frv);
	}
      else if(op == __MUL)
	{ 
	  frvv->Multiply(*vv); return(frv);
	}
      else if(op == __EQUAL)
	{ 
	  icrvv->Set_Bit(0,frvv->Equal(*vv)); return(icrv);
	}
      else if(op == __NOTEQUAL)
	{ 
	  icrvv->Set_Bit(0,!frvv->Equal(*vv)); return(icrv);
	}
      else if(op == __LESS)
	{ 
	  icrvv->Set_Bit(0,frvv->Less_Than(*vv)); return(icrv);
	}
      else if(op == __LESSEQUAL)
	{
	  icrvv->Set_Bit(0,frvv->Less_Equal(*vv)); return(icrv); 
	}
      else if(op == __GREATER)
	{ 
	  icrvv->Set_Bit(0,frvv->Greater(*vv)); return(icrv); 
	}
      else if(op == __GREATEREQUAL)
	{ 
	  icrvv->Set_Bit(0,frvv->Greater_Equal(*vv)); return(icrv); 
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

string To_VC_String(unsigned int val, unsigned int size)
{
  AaType* t = AaProgram::Make_Uinteger_Type(size);
  AaValue* v = Make_Aa_Value(NULL,t);
  v->Set_Value(IntToStr(val));
  string ret_string = v->To_VC_String();
  delete v;
  return(ret_string);
}
