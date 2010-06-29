#include <AaParserClasses.h>

bool StringCompare::operator() (string s11, string s21) const
{
  const char *s1 = s11.c_str ();
  const char *s2 = s21.c_str ();
  for (int i = 0; s2[i]; i++)
    {
      if (!s1[i])
	return ((!s2[i]) ? false : true);
      else if (s1[i] < s2[i])
	return true;
      else if (s1[i] > s2[i])
	return false;
    }
  return false;
};


//---------------------------------------------------------------------
// AaRoot
//---------------------------------------------------------------------

int AaRoot::_root_counter = 0;
bool AaRoot::_error_flag = false;

AaRoot::AaRoot() 
{
  this->Increment_Root_Counter();
}
AaRoot::~AaRoot() {};
bool AaRoot::Is(string& kinfo)
{ 
  const std::type_info& info = typeid(this);
  return(info.name() == kinfo);
}
void AaRoot::Increment_Root_Counter() { AaRoot::_root_counter += 1; }
int AaRoot::Get_Root_Counter() { return AaRoot::_root_counter; }
void AaRoot::Error() { AaRoot::_error_flag = true;}
bool AaRoot::Get_Error_Flag() { return AaRoot::_error_flag; }
void AaRoot::Print(ostream& ofile)
{
  assert(0);
}
void AaRoot::Print(ofstream& ofile)
{
  ostream *outstr = &ofile;
  this->Print(*outstr);
}
void AaRoot::Print(string& ostring) 
{
  ostringstream string_stream(ostringstream::out);
  this->Print(string_stream);
  ostring += string_stream.str();
}


//---------------------------------------------------------------------
// AaScope
//---------------------------------------------------------------------
AaScope::AaScope(AaScope* p):AaRoot() {this->_scope = p;}
AaScope::~AaScope() {}


void AaScope::Map_Child(string lbl, AaRoot* tn)
{
  if(tn != NULL)
    {
      if(this->_child_map.find(lbl) == this->_child_map.end())
	{
	  this->_child_map[lbl] = tn;
	}
    }
}

AaRoot* AaScope::Find_Child(string cname)
{
  AaRoot* ret_child = NULL;
  map<string,AaRoot*,StringCompare>::iterator miter =
    this->_child_map.find(cname);
  if(miter != this->_child_map.end())
    ret_child = (*miter).second;
  return(ret_child);
}

/*****************************************  TYPE ****************************/

//---------------------------------------------------------------------
// AaType
//---------------------------------------------------------------------
AaType::AaType(AaScope* p): AaRoot() {this->_scope = p;}
AaType::~AaType() {};

//---------------------------------------------------------------------
// AaScalarType
//---------------------------------------------------------------------
AaScalarType::AaScalarType(AaScope* p):AaType(p) {};
AaScalarType::~AaScalarType() {};

//---------------------------------------------------------------------
// AaUintType
//---------------------------------------------------------------------
AaUintType::AaUintType(AaScope* p, unsigned int width):AaScalarType(p) 
{
  this->_width = width;
}
AaUintType::~AaUintType() {};
void AaUintType::Print(ostream& ofile)
{
  ofile << "_uint<" << this->Get_Width() << ">";
}

//---------------------------------------------------------------------
// AaIntType
//---------------------------------------------------------------------
AaIntType::AaIntType(AaScope* p, unsigned int width):AaUintType(p, width) {};
AaIntType::~AaIntType() {};
void AaIntType::Print(ostream& ofile)
{
  ofile << "_int<" << this->Get_Width() << ">";
}

//---------------------------------------------------------------------
// AaPointerType: public AaUintType
//---------------------------------------------------------------------
AaPointerType::AaPointerType(AaScope* p, unsigned int object_width): AaUintType(p,object_width) {};
AaPointerType::~AaPointerType() {};
void AaPointerType::Print(ostream& ofile)
{
  ofile << " pointer<" << this->Get_Width() << "> ";
}

//---------------------------------------------------------------------
//AaFloatType
//---------------------------------------------------------------------
AaFloatType::AaFloatType(AaScope* p, unsigned int characteristic, unsigned int mantissa):AaScalarType(p)
{
  this->_characteristic = characteristic;
  this->_mantissa = mantissa;
}
AaFloatType::~AaFloatType() {};
void AaFloatType::Print(ostream& ofile)
{
  ofile << "_float<" << this->Get_Characteristic() << "," << this->Get_Mantissa() << ">";
}

//---------------------------------------------------------------------
// AaArrayType
//---------------------------------------------------------------------
AaArrayType::AaArrayType(AaScope* p, AaScalarType* stype, vector<unsigned int>& dimensions): AaType(p) 
{
  this->_element_type = stype;
  for(unsigned int i = 0; i < dimensions.size(); i++)
    this->_dimension.push_back(dimensions[i]);
};
AaArrayType::~AaArrayType() {};
unsigned int AaArrayType::Get_Dimension(unsigned int dim_id)
{
  unsigned int ret_value = 0;
  if(dim_id >= 0 && dim_id <= this->_dimension.size())
    {
      ret_value = this->_dimension[dim_id];
    }
  return(ret_value);
}
void AaArrayType::Print(ostream& ofile)
{
  ofile << "array";
  for(unsigned int i = 0; i < this->Get_Number_Of_Dimensions(); i++)
    ofile << "<" << this->Get_Dimension(i) << ">";
  ofile << " of ";
  this->Get_Element_Type()->Print(ofile);
}


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

/*****************************************  OBJECT  ****************************/

//---------------------------------------------------------------------
// AaObject
//---------------------------------------------------------------------
AaObject::AaObject(AaScope* parent_tpr, string oname, AaType* object_type):AaRoot() 
{
  this->_name = oname;
  this->_scope = parent_tpr;
  this->_value = NULL;
  this->_object_type = object_type;
}
AaObject::~AaObject() {};
void AaObject::Print(ostream& ofile)
{
  ofile << " " << this->Get_Name() << ":";
  this->Get_Object_Type()->Print(ofile);
  if(this->_value != NULL)
    {
      ofile << ":= ";
      this->_value->Print(ofile);
    }
  ofile << " ";
}

//---------------------------------------------------------------------
// AaInterfaceObject
//---------------------------------------------------------------------
AaInterfaceObject::AaInterfaceObject(AaScope* parent_tpr, 
				     string oname, 
				     AaType* otype, 
				     string mode):AaObject(parent_tpr,oname,otype) 
{
  this->_mode = mode;
}
AaInterfaceObject::~AaInterfaceObject() {};

//---------------------------------------------------------------------
// AaGlobal
//---------------------------------------------------------------------
AaGlobal::AaGlobal(AaScope* parent_tpr,string oname, AaType* otype, 
		   AaConstantLiteralReference* initial_value):AaObject(parent_tpr,oname,otype) 
{
  this->Set_Value(initial_value);
};
AaGlobal::~AaGlobal() {};
void AaGlobal::Print(ostream& ofile)
{
  ofile << "global ";
  this->AaObject::Print(ofile);
}

//---------------------------------------------------------------------
// AaLocal
//---------------------------------------------------------------------
AaLocal::AaLocal(AaScope* parent_tpr, string oname, AaType* otype, 
		 AaConstantLiteralReference* initial_value):AaObject(parent_tpr,oname,otype) 
{
  this->Set_Value(initial_value);
};
AaLocal::~AaLocal() {};
void AaLocal::Print(ostream& ofile)
{
  ofile << "local ";
  this->AaObject::Print(ofile);
}

//---------------------------------------------------------------------
// AaPipe
//---------------------------------------------------------------------
AaPipe::AaPipe(AaScope* parent_tpr, string oname, AaType* otype):AaObject(parent_tpr,oname,otype) {};
AaPipe::~AaPipe() {};
void AaPipe::Print(ostream& ofile)
{
  ofile << "pipe ";
  this->AaObject::Print(ofile);
}

//---------------------------------------------------------------------
// AaConstant
//---------------------------------------------------------------------
AaConstant::AaConstant(AaScope* parent_tpr , string oname, AaType* otype, 
		       AaConstantLiteralReference* value):AaObject(parent_tpr, oname,otype)
{
  this->Set_Value(value);
}
AaConstant::~AaConstant() {};
void AaConstant::Print(ostream& ofile)
{
  ofile << "constant ";
  this->AaObject::Print(ofile);
}



/***************************************** EXPRESSION  ****************************/
//---------------------------------------------------------------------
// AaExpression
//---------------------------------------------------------------------
AaExpression::AaExpression(AaScope* parent_tpr):AaRoot() {this->_scope = parent_tpr;}
AaExpression::~AaExpression() {};

//---------------------------------------------------------------------
// AaObjectReference
//---------------------------------------------------------------------
AaObjectReference::AaObjectReference(AaScope* parent_tpr, string object_id):AaExpression(parent_tpr)
{
  this->_object_ref_string = object_id;
}

AaObjectReference::~AaObjectReference() {};
void AaObjectReference::Print(ostream& ofile)
{
  ofile << this->Get_Object_Ref_String();
}

//---------------------------------------------------------------------
// AaConstantLiteralReference: public AaObjectReference
//---------------------------------------------------------------------
AaConstantLiteralReference::AaConstantLiteralReference(AaScope* parent_tpr, string literal_string):
  AaObjectReference(parent_tpr,literal_string) {};
AaConstantLiteralReference::~AaConstantLiteralReference() {};

//---------------------------------------------------------------------
//AaSimpleObjectReference
//---------------------------------------------------------------------
AaSimpleObjectReference::AaSimpleObjectReference(AaScope* parent_tpr, string object_id):AaObjectReference(parent_tpr, object_id) {};
AaSimpleObjectReference::~AaSimpleObjectReference() {};

//---------------------------------------------------------------------
// AaArrayObjectReference
//---------------------------------------------------------------------
AaArrayObjectReference::AaArrayObjectReference(AaScope* parent_tpr, 
					       string object_id, 
					       vector<AaExpression*>& index_list):AaObjectReference(parent_tpr,object_id)
{
  for(unsigned int i  = 0; i < index_list.size(); i++)
    this->_indices.push_back(index_list[i]);
}
AaArrayObjectReference::~AaArrayObjectReference()
{
}
void AaArrayObjectReference::Print(ostream& ofile)
{
  ofile << this->Get_Object_Ref_String();
  for(unsigned int i = 0; i < this->Get_Number_Of_Indices(); i++)
    {
      ofile << ".";
      this->Get_Array_Index(i)->Print(ofile);
    }
}
AaExpression*  AaArrayObjectReference::Get_Array_Index(unsigned int idx)
{
  assert (idx < this->Get_Number_Of_Indices());
  return(this->_indices[idx]);
}

//---------------------------------------------------------------------
// type cast expression (is unary)
//---------------------------------------------------------------------
AaTypeCastExpression::AaTypeCastExpression(AaScope* parent, AaType* ref_type,AaExpression* rest):AaExpression(parent)
{
  this->_to_type = ref_type;
  this->_rest = rest;
}

AaTypeCastExpression::~AaTypeCastExpression() {};
void AaTypeCastExpression::Print(ostream& ofile)
{
  ofile << "( (" ;
  this->Get_To_Type()->Print(ofile);
  ofile << ") ";
  this->Get_Rest()->Print(ofile);
  ofile << " )";
}


//---------------------------------------------------------------------
// AaUnaryExpression
//---------------------------------------------------------------------
AaUnaryExpression::AaUnaryExpression(AaScope* parent_tpr,AaStringValue* op, AaExpression* rest):AaExpression(parent_tpr)
{
  this->_operation  = op;
  this->_rest       = rest;
}
AaUnaryExpression::~AaUnaryExpression() {};
void AaUnaryExpression::Print(ostream& ofile)
{
  ofile << " ( ";
  if(this->Get_Operation())
    ofile << this->Get_Operation() << " ";
  this->Get_Rest()->Print(ofile);
  ofile << " )";
}

//---------------------------------------------------------------------
// AaBinaryExpression
//---------------------------------------------------------------------
AaBinaryExpression::AaBinaryExpression(AaScope* parent_tpr,AaStringValue* op, AaExpression* first, AaExpression* second):AaExpression(parent_tpr)
{
  this->_operation = op;
  this->_first = first;
  this->_second = second;
}
AaBinaryExpression::~AaBinaryExpression() {};
void AaBinaryExpression::Print(ostream& ofile)
{
  ofile << "(" ;
  this->Get_First()->Print(ofile);
  ofile << " ";
  this->Get_Operation()->Print(ofile);
  ofile << " ";
  this->Get_Second()->Print(ofile);
  ofile << ")";
}

//---------------------------------------------------------------------
// AaTernaryExpression
//---------------------------------------------------------------------
AaTernaryExpression::AaTernaryExpression(AaScope* parent_tpr,
					 AaExpression* test,
					 AaExpression* iftrue, 
					 AaExpression* iffalse):AaExpression(parent_tpr)
{
  this->_test = test;
  this->_if_true = iftrue;
  this->_if_false = iffalse;
}
AaTernaryExpression::~AaTernaryExpression() {};
void AaTernaryExpression::Print(ostream& ofile)
{
  ofile << "( ";
  this->Get_Test()->Print(ofile);
  ofile << " ? ";
  this->Get_If_True()->Print(ofile);
  ofile << " : ";
  this->Get_If_False()->Print(ofile);
  ofile << " ) ";
}


//---------------------------------------------------------------------
// AaStatement
//---------------------------------------------------------------------
AaStatement::AaStatement(AaScope* p): AaScope(p) {}
AaStatement::~AaStatement() {};

//---------------------------------------------------------------------
// AaStatementSequence
//---------------------------------------------------------------------
AaStatementSequence::AaStatementSequence(AaScope* scope, vector<AaStatement*>& statement_sequence):AaScope(scope)
{
  for(unsigned int i=0; i < statement_sequence.size();i++)
    this->_statement_sequence.push_back((statement_sequence[i]));
}
AaStatementSequence::~AaStatementSequence() {}
  
void AaStatementSequence::Print(ostream& ofile)
{
  for(unsigned int i=0; i < this->_statement_sequence.size();i++)
    this->_statement_sequence[i]->Print(ofile);
}

//---------------------------------------------------------------------
// AaNullStatement: public AaStatement
//---------------------------------------------------------------------
AaNullStatement::AaNullStatement(AaScope* parent_tpr):AaStatement(parent_tpr) {};
AaNullStatement::~AaNullStatement() {};


//---------------------------------------------------------------------
// AaAssignmentStatement
//---------------------------------------------------------------------
AaAssignmentStatement::AaAssignmentStatement(AaScope* parent_tpr, AaObjectReference* tgt, AaExpression* src):
  AaStatement(parent_tpr) 
{
  assert(tgt); assert(src);
  this->_target = tgt;
  this->_source = src;
}
AaAssignmentStatement::~AaAssignmentStatement() {};
void AaAssignmentStatement::Print(ostream& ofile)
{
  this->Get_Target()->Print(ofile);
  ofile << " := ";
  this->Get_Source()->Print(ofile);
}

//---------------------------------------------------------------------
// AaCallStatement
//---------------------------------------------------------------------
AaCallStatement::AaCallStatement(AaScope* parent_tpr,
				 string func_name,
				 vector<AaObjectReference*>& inargs, 
				 vector<AaObjectReference*>& outargs): AaStatement(parent_tpr)
{

  this->_function_name = func_name;

  for(unsigned int i = 0; i < inargs.size(); i++)
    {
      this->_input_args.push_back(inargs[i]);
    }

  for(unsigned int i = 0; i < outargs.size(); i++)
    {
      this->_output_args.push_back(outargs[i]);
    }

  // \todo 
  // map all targets!

}
AaCallStatement::~AaCallStatement() {};
  
AaObjectReference* AaCallStatement::Get_Input_Arg(unsigned int index)
{
  assert(index < this->Get_Number_Of_Input_Args());
  return(this->_input_args[index]);
}
AaObjectReference* AaCallStatement::Get_Output_Arg(unsigned int index)
{
  assert(index < this->Get_Number_Of_Output_Args());
  return(this->_output_args[index]);
}
  
void AaCallStatement::Print(ostream& ofile)
{

  ofile << " (";
  for(unsigned int i = 0; i < this->Get_Number_Of_Output_Args(); i++)
    {
      this->_output_args[i]->Print(ofile);
      ofile << " ";
    }
  ofile << ")";

  ofile << " := ";
  ofile << this->Get_Function_Name();

  ofile << " (";
  for(unsigned int i = 0; i < this->Get_Number_Of_Input_Args(); i++)
    {
      this->_input_args[i]->Print(ofile);
      ofile << " ";
    }
  ofile << ")";

}

//---------------------------------------------------------------------
// AaBlockStatement: public AaStatement
//---------------------------------------------------------------------
AaBlockStatement::AaBlockStatement(AaScope* scope,string label):AaStatement(scope) {this->_label = label;}
AaBlockStatement::~AaBlockStatement() {}

 void AaBlockStatement::Print(ostream& ofile)
{
  ofile << this->Get_Label() << " {" << endl;
  this->_statement_sequence->Print(ofile);
  ofile << "}" << endl;
}

//---------------------------------------------------------------------
// AaSeriesBlockStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaSeriesBlockStatement::AaSeriesBlockStatement(AaScope* scope,string label):AaBlockStatement(scope,label) {}
AaSeriesBlockStatement::~AaSeriesBlockStatement() {}
 void AaSeriesBlockStatement::Print(ostream& ofile)
{
  ofile << " $seriesblock ";
  this->AaBlockStatement::Print(ofile);
}


//---------------------------------------------------------------------
// AaParallelBlockStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaParallelBlockStatement::AaParallelBlockStatement(AaScope* scope,string label):AaBlockStatement(scope,label) {}
AaParallelBlockStatement::~AaParallelBlockStatement() {}
 void AaParallelBlockStatement::Print(ostream& ofile)
{
  ofile << " $parallelblock ";
  this->AaBlockStatement::Print(ofile);
}

//---------------------------------------------------------------------
// AaForkBlockStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaForkBlockStatement::AaForkBlockStatement(AaScope* scope,string label):AaBlockStatement(scope,label) {}
AaForkBlockStatement::~AaForkBlockStatement() {}
 void AaForkBlockStatement::Print(ostream& ofile)
{
  ofile << " $forkblock ";
  this->AaBlockStatement::Print(ofile);
}

//---------------------------------------------------------------------
// AaBranchBlockStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaBranchBlockStatement::AaBranchBlockStatement(AaScope* scope,string label):AaBlockStatement(scope,label) {}
AaBranchBlockStatement::~AaBranchBlockStatement() {}
void AaBranchBlockStatement::Print(ostream& ofile)
{
  ofile << " $branchblock ";
  this->AaBlockStatement::Print(ofile);
}

//---------------------------------------------------------------------
//  AaJoinForkStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaJoinForkStatement::AaJoinForkStatement(AaForkBlockStatement* scope):AaBlockStatement(scope,"") {}
AaJoinForkStatement::~AaJoinForkStatement() {}
void AaJoinForkStatement::Print(ostream& ofile) 
{
  ofile << " $join " << "{ " ;
  for(unsigned int i = 0; i < this->_join_labels.size(); i++)
    ofile << this->_join_labels[i] << " ";
  ofile << "}";
  if(this->Get_Statement_Count() > 0)
    {
      ofile << " $fork ";
      this->AaBlockStatement::Print(ofile);
    }
}

//---------------------------------------------------------------------
// AaMergeStatement: public AaStatement
//---------------------------------------------------------------------
AaMergeStatement::AaMergeStatement(AaBranchBlockStatement* scope):AaStatement(scope) {}
AaMergeStatement::~AaMergeStatement() {}
 void AaMergeStatement::Print(ostream& ofile)
{
  ofile << "$merge (" ;
  for(unsigned int i=0; i < this->_targets.size(); i++)
    { 
      this->_targets[i]->Print(ofile);
      ofile << " ";
    }
  ofile << " )  := ( ";
  map<string,vector<AaObjectReference*>*,StringCompare>::iterator iter;
  for(iter = this->_source_map.begin(); iter != this->_source_map.end(); iter++)
    {
      ofile << (*iter).first << " : ( ";
      for(unsigned int i = 0; i < ((*iter).second)->size(); i++)
	(*((*iter).second))[i]->Print(ofile);
      ofile << ")" << endl;
    }
	
  ofile << " )" << endl;
}

//---------------------------------------------------------------------
// AaSwitchStatement: public AaStatement
//---------------------------------------------------------------------
AaSwitchStatement::AaSwitchStatement(AaBranchBlockStatement* scope):AaStatement(scope) {}
AaSwitchStatement::~AaSwitchStatement() {}
void AaSwitchStatement::Print(ostream& ofile)
{
  ofile << "$switch ";
  for(unsigned int i=0; i < this->_choice_pairs.size(); i++)
    {
      ofile << " $when ";
      this->_choice_pairs[i].first->Print(ofile);
      ofile << " $then  {";
      this->_choice_pairs[i].second->Print(ofile);
      ofile << " }" << endl;
      ofile << endl;
    }
}


//---------------------------------------------------------------------
// AaIfStatement: public AaStatement
//---------------------------------------------------------------------
AaIfStatement::AaIfStatement(AaBranchBlockStatement* scope):AaStatement(scope) 
{
  this->_test_expression = NULL;
  this->_if_sequence = NULL;
  this->_else_sequence = NULL;
}
AaIfStatement::~AaIfStatement() {}
void AaIfStatement::Print(ostream& ofile)
{
  assert(this->_test_expression);
  assert(this->_if_sequence);
  assert(this->_else_sequence);

  ofile << " $if ";
  this->_test_expression->Print(ofile);
  ofile << " $then { ";
  this->_if_sequence->Print(ofile);
  ofile << " }" << endl;
  ofile << " $else { ";
  this->_else_sequence->Print(ofile);
  ofile << " }" << endl;
}


/***************************************** MODULE   ****************************/

//---------------------------------------------------------------------
// AaModule
//---------------------------------------------------------------------
AaModule::AaModule(AaScope* parent, string fname): AaBlockStatement(parent,fname)
{
  if(parent != NULL)
    parent->Map_Child(fname,this);
}

void AaModule::Add_Argument(AaInterfaceObject* obj)
{

  assert(obj);

  this->Map_Child(obj->Get_Name(), obj);

  if(obj->Get_Mode() == "in")
    {
      this->_input_args.push_back(obj);
    }
  else if(obj->Get_Mode() == "out")
    {
      this->_output_args.push_back(obj);
    }
  else
    {
      assert(0 && "unknown interface mode");
    }
}

void AaModule::Print(ostream& ofile)
{
  ofile << " $module [" << this->Get_Label() << "] ";
  ofile << " (";
  for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
    {
      this->_input_args[i]->Print(ofile);
      ofile << " ";
    }
  ofile << ")";

  ofile << " (";
  for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
    {
      this->_output_args[i]->Print(ofile);
      ofile << " ";
    }
  ofile << ")";
  ofile << endl;
  ofile << " { ";
  this->_statement_sequence->Print(ofile);
  ofile << " } " << endl;
}


/***************************************** PROGRAM   ****************************/

//---------------------------------------------------------------------
// AaProgram
//---------------------------------------------------------------------
AaProgram::AaProgram():AaScope((AaScope*) NULL) {};
AaProgram::~AaProgram() {};

void AaProgram::Add_Module(AaModule* fn)
{
  this->_modules.push_back(fn);
  this->Map_Child(fn->Get_Label(), fn);
}
    
void AaProgram::Print(ostream& ofile)
{
  for(unsigned int i=0; i < this->_modules.size(); i++)
    {
      this->_modules[i]->Print(ofile);
      ofile << endl;
    }
}
  



