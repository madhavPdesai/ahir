#include <istream>
#include <ostream>
#include <assert.h>
#include <hierSystem.h>
#include <rtlInclusions.h>
#include <rtlEnums.h>
#include <rtlType.h>
#include <Value.hpp>
#include <rtlValue.h>
#include <rtlObject.h>
#include <rtlExpression.h>
#include <rtlStatement.h>
#include <rtlThread.h>
	
rtlStatement::rtlStatement(rtlThread* p):hierRoot()
{
	_parent_thread = p;
}

	
rtlAssignStatement::rtlAssignStatement(rtlThread* p, bool volatile_flag, bool tick_flag, bool imm_flag, rtlExpression* tgt, rtlExpression* src):rtlStatement(p)
{
	_target = tgt;
	tgt->Set_Is_Target(true);

	_source = src;
	_volatile = (volatile_flag || imm_flag);

	tgt->Set_Is_Volatile(_volatile);
	tgt->Set_Is_Not_Volatile(!_volatile && !tick_flag);
	tgt->Set_Tick(tick_flag);

}


void rtlAssignStatement::Set_Tick(bool v)
{
	this->_target->Set_Tick(v);
}

void rtlAssignStatement::Print_Vhdl(ostream& ofile)
{
	ofile << "-- ";
	this->Print(ofile);
	ofile << endl;

	string assign_type = " := ";
	if(_target->Writes_To_Signal())
	{
		assign_type = " <= ";
	}
	ofile << _target->To_Vhdl_String()  << assign_type << _source->To_Vhdl_String() << ";" << endl;
}
	
void rtlAssignStatement::Collect_Target_Objects(set<rtlObject*> obj_set)
{
	_target->Collect_Target_Objects(obj_set);
}
	
void rtlAssignStatement::Collect_Source_Objects(set<rtlObject*> obj_set)
{
	_source->Collect_Target_Objects(obj_set);
}


	
void rtlAssignStatement::Print(ostream& ofile)
{
	if(_volatile)
		ofile << " $now ";
	_target->Print(ofile);
	ofile << " := ";
	_source->Print(ofile);
	ofile << endl;
}

	
void rtlAssignStatement::Print_C(ostream& source_file)
{
	source_file << "//";
	this->Print(source_file); 

	rtlType* tt = _target->Get_Type();
	if(tt->Is("rtlIntegerType"))
	{
		_target->Print_C(source_file);
		source_file << " = " ;
		_source->Print_C(source_file);
		source_file << ";" << endl;
	}
	else if(tt->Is("rtlUnsignedType") || tt->Is("rtlSignedType"))
	{
		_target->Print_C(source_file); // TODO: object references as target handled differently.
						//  In this case, the printing is only of rvalues in
						// the expression (e.g. array index expressions).
		_source->Print_C(source_file);
		source_file  << "bit_vector_bitcast_to_bit_vector(&(" << _target->Get_C_Target_Name() << "), &(" 
				<< _source->Get_C_Name() << "));" << endl;
	}
	else
		assert(0);

	if(_target->Is("rtlSimpleObjectReference"))
	{
		rtlSimpleObjectReference* sor = ((rtlSimpleObjectReference*) _target);
		rtlObject* obj = sor->Get_Object();
		if(sor->Get_Req_Flag())
			obj->Print_C_Probe_Matcher(source_file);

		if(sor->Get_Req_Flag())
		{
			if(!this->Get_Volatile())
			{
				this->Get_Parent_Thread()->Report_Error("req interface must be driven by volatile statement (for pipe"
								+ obj->Get_Id() + ").\n");
			}	
		}
		if(sor->Get_Ack_Flag())
		{
			this->Get_Parent_Thread()->Report_Error("ack interface cannot be driven (for pipe"
								+ obj->Get_Id() + ").\n");
		}
	}
}

	
	
rtlGotoStatement::rtlGotoStatement(rtlThread* p, string lbl):rtlStatement(p) 
{ 
	_label = lbl;
}

void rtlGotoStatement::Print(ostream& ofile)
{
	ofile << " $goto " << _label << endl;
	if(_parent_thread->Get_Statement(_label) == NULL)
	{
		_parent_thread->Get_Parent()->Report_Error("goto " + _label + " : no statement with this label in thread "
				+ _parent_thread->Get_Id());
	}
}

void rtlGotoStatement::Print_C(ostream& source_file)
{
	source_file << "//";
	this->Print(source_file); 
	source_file << "__sstate->_next_state = " << stateEnum(_label) << ";" << endl;
}

void rtlGotoStatement::Print_Vhdl(ostream& ofile)
{
	ofile << "next_thread_state := s_" << _label << ";" << endl;
}

void rtlIfStatement::Print(ostream& ofile)
{
	ofile << " $if ";
	_test->Print(ofile);
	ofile << endl;
	_if_block->Print(ofile);
	if(_else_block != NULL)
	{
		ofile << " $else " << endl;
		_else_block->Print(ofile);
	}
	ofile << endl;
}

void rtlIfStatement::Print_C(ostream& source_file)
{
	_test->Print_C(source_file);
	source_file << "// if ";
	_test->Print(source_file);
	source_file << endl;

	source_file << "if (" << _test->C_Int_Reference() << ")";
	_if_block->Print_C(source_file);
	if(_else_block != NULL)
	{
		source_file << "// else" << endl;
		source_file << "else " << endl;
		_else_block->Print_C(source_file);
	}
}
void rtlIfStatement::Print_Vhdl(ostream& ofile)
{
	if(this->_test->Get_Type()->Is("rtlIntegerType"))
		ofile << "if (" << _test->To_Vhdl_String() << " /= 0)";
	else if(this->_test->Get_Type()->Is("rtlUnsignedType") || this->_test->Get_Type()->Is("rtlSignedType"))
		ofile << "if (isTrue(" << _test->To_Vhdl_String() << "))" ;
	ofile << " then  -- {" << endl;
	_if_block->Print_Vhdl(ofile);
	if(_else_block != NULL)
	{
		ofile << "--}" << endl;
		ofile << "else -- {" << endl;
		_else_block->Print_Vhdl(ofile);
	}
	ofile << "--}" << endl;
	ofile << "end if;" << endl;
	
}

void rtlBlockStatement::Print(ostream& ofile)
{
	ofile << "{" << endl;
	for(int I = 0, fI = _statement_block.size(); I < fI; I++)
	{
		_statement_block[I]->Print(ofile);
	}
	ofile << "}" << endl;
}

void rtlBlockStatement::Print_C(ostream& source_file)
{
	source_file << "{" << endl;
	for(int I = 0, fI = _statement_block.size(); I < fI; I++)
	{
		_statement_block[I]->Print_C(source_file);
	}
	source_file << "}" << endl;
}

void rtlBlockStatement::Print_Vhdl(ostream& ofile)
{
	for(int I = 0, fI = _statement_block.size(); I < fI; I++)
	{
		_statement_block[I]->Print_Vhdl(ofile);
	}
}

void rtlLabeledBlockStatement::Print(ostream& ofile)
{
	ofile << "<" << _label << "> ";
	this->rtlBlockStatement::Print(ofile);
}

void rtlLabeledBlockStatement::Print_C(ostream& source_file)
{
	// no label... 
	this->rtlBlockStatement::Print_C(source_file);
}

void rtlLabeledBlockStatement::Print_Vhdl(ostream& ofile)
{
	this->rtlBlockStatement::Print_Vhdl(ofile);
}

rtlNullStatement::rtlNullStatement(rtlThread* p): rtlStatement(p)
{
}

void rtlNullStatement::Print(ostream& ofile)
{
	ofile << " $null " << endl;
}


void rtlLogStatement::Print(ostream& ofile)
{
	if(_object != NULL)
		ofile << "$log " << _object->Get_Id();
}

void rtlLogStatement::Print_C(ostream& ofile)
{
	if(_object == NULL)
		return;

	if(_object->Get_Type()->Is("rtlIntegerType"))
	{
		ofile << "fprintf(stderr,\"log:%s:[%d]  %s = %d\\n\", __sstate->_string_name, __sstate->_tick_count, "
			<< "\"" << _object->Get_Id() << "\", " << _object->Get_C_Name() << ");" << endl;
		if(_object->Needs_Next())
		{
			ofile << "fprintf(stderr,\"log:%s:[%d]  %s = %d\\n\", __sstate->_string_name, __sstate->_tick_count, "
				<< "\"__next_" << _object->Get_Id() << "\", " << _object->Get_C_Target_Name() << ");" << endl;
		}
	}
	else if((_object->Get_Type()->Is("rtlUnsignedType")) || (_object->Get_Type()->Is("rtlSignedType")))
	{
		ofile << "fprintf(stderr,\"log:%s:[%d]  %s = %s\\n\", __sstate->_string_name, __sstate->_tick_count, "
			<< "\"" << _object->Get_Id() << "\", to_string(&(" << _object->Get_C_Name() << ")));" << endl;
		if(_object->Needs_Next())
		{
			ofile << "fprintf(stderr,\"log:%s:[%d]  %s = %s\\n\", __sstate->_string_name, __sstate->_tick_count, "
				<< "\"__next_" << _object->Get_Id() << "\", to_string(&(" << _object->Get_C_Target_Name() << ")));" << endl;
		}
		if(_object->Is_Pipe())
		{
			ofile << "fprintf(stderr,\"log:%s:[%d]  %s = %s\\n\", __sstate->_string_name, __sstate->_tick_count, "
				<< "\"" << _object->Get_Id() << "__req\", to_string(&(" << _object->Get_C_Req_Name() << ")));" << endl;
			ofile << "fprintf(stderr,\"log:%s:[%d]  %s = %s\\n\", __sstate->_string_name, __sstate->_tick_count, "
				<< "\"" << _object->Get_Id() << "__ack\", to_string(&(" << _object->Get_C_Ack_Name() << ")));" << endl;
		}
	}
}

void rtlLogStatement::Print_Vhdl(ostream& ofile)
{
	if(!_object->Is_OutPort())
		ofile << "assert false report \"" << _object->Get_Id() << " = \" & Convert_To_String(" 
				<< _object->Get_Id() << ") severity note;" << endl; 
	else
	{
		this->Report_Warning("can not log value of output port " + _object->Get_Id());
	}
}

