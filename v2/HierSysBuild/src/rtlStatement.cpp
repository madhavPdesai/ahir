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

void rtlAssignStatementBase::Collect_Target_Objects(set<rtlObject*> obj_set)
{
	for(int I = 0, fI = _targets.size(); I < fI; I++)
		_targets[I]->Collect_Target_Objects(obj_set);
}
	
void rtlAssignStatementBase::Collect_Source_Objects(set<rtlObject*> obj_set)
{
	for(int I = 0, fI = _sources.size(); I < fI; I++)
		_sources[I]->Collect_Source_Objects(obj_set);
}
	
void rtlAssignStatementBase::Update_Target_Flags()
{
	for(int I = 0, fI = _targets.size(); I < fI; I++)
	{
		rtlExpression* tgt = _targets[I];
		tgt->Set_Is_Target(true);
		tgt->Set_Is_Volatile(_volatile);
		tgt->Set_Is_Not_Volatile(!_volatile && !_tick);
		tgt->Set_Tick(_tick);
	}
}

void rtlAssignStatementBase::Print(ostream& ofile, rtlExpression* target, rtlExpression* source)
{
	if(_volatile)
		ofile << " $now ";
	target->Print(ofile);
	ofile << " := ";
	source->Print(ofile);
	ofile << endl;
}

void rtlAssignStatementBase::Print_C(ostream& source_file, rtlExpression* target, rtlExpression* source)
{
	rtlType* tt = target->Get_Type();
	if(tt->Is("rtlIntegerType"))
	{
		target->Print_C(source_file);
		source_file << " = " ;
		source->Print_C(source_file);
		source_file << ";" << endl;
	}
	else if(tt->Is("rtlUnsignedType") || tt->Is("rtlSignedType"))
	{
		target->Print_C(source_file); // TODO: object references as target handled differently.
						//  In this case, the printing is only of rvalues in
						// the expression (e.g. array index expressions).
		source->Print_C(source_file);
		source_file  << "bit_vector_bitcast_to_bit_vector(&(" << target->Get_C_Target_Name() << "), &(" 
				<< source->Get_C_Name() << "));" << endl;
	}
	else
		assert(0);

	if(target->Is("rtlSimpleObjectReference"))
	{
		rtlSimpleObjectReference* sor = ((rtlSimpleObjectReference*) target);
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
	
void rtlAssignStatementBase::Print_Vhdl(ostream& ofile, rtlExpression* target, rtlExpression* src)
{
	string assign_type = " := ";
	if(target->Writes_To_Signal())
	{
		assign_type = " <= ";
	}
	ofile << target->To_Vhdl_String()  << assign_type << src->To_Vhdl_String() << ";" << endl;
}


rtlAssignStatement::rtlAssignStatement(rtlThread* p, bool volatile_flag, bool tick_flag, bool imm_flag, rtlExpression* tgt, rtlExpression* src):
		rtlAssignStatementBase(p, volatile_flag, tick_flag, imm_flag)
{
	_targets.push_back(tgt);
	_sources.push_back(src);
	_volatile = (volatile_flag || imm_flag);
	_tick = tick_flag;
	this->Update_Target_Flags();
}

void rtlAssignStatement::Print_Vhdl(ostream& ofile)
{
	ofile << "-- ";
	this->Print(ofile);
	ofile << endl;
	this->rtlAssignStatementBase::Print_Vhdl(ofile, _targets[0], _sources[0]);

}
	
	
void rtlAssignStatement::Print(ostream& ofile)
{
	this->rtlAssignStatementBase::Print(ofile, _targets[0], _sources[0]);
}


	
void rtlAssignStatement::Print_C(ostream& source_file)
{
	source_file << "//";
	this->Print(source_file); 
	source_file << endl;

	this->rtlAssignStatementBase::Print_C(source_file, _targets[0], _sources[0]);
}

	
rtlSplitStatement::rtlSplitStatement(rtlThread* p, bool volatile_flag, bool tick_flag, bool imm_flag,  
						vector<rtlExpression*>& tgts, rtlExpression* src):rtlAssignStatementBase(p,volatile_flag, tick_flag, imm_flag)
{
	if(!src->Get_Type()->Is("rtlUnsignedType") && !src->Get_Type()->Is("rtlSignedType"))
	{
		this->Report_Error("split statement source must be unsigned/signed.");
		return;
	}
	int H = src->Get_Type()->Size();
	_targets = tgts;
	for(int I = 0, fI = tgts.size(); I < fI; I++)
	{
		rtlExpression* expr = tgts[I];
		int L = (H - expr->Get_Type()->Size()) + 1;	
		rtlExpression* sI = new rtlSliceExpression(src, H, L);
		_sources.push_back(sI);
		H = L - 1;
	}
	this->Update_Target_Flags();
}

	
void rtlSplitStatement::Print(ostream& ofile)
{
	assert(_sources.size() == _targets.size());
	for(int I = 0, fI = _sources.size(); I < fI; I++)
	{
		this->rtlAssignStatementBase::Print(ofile, _targets[I], _sources[I]);
	}
}

void rtlSplitStatement::Print_C(ostream& ofile)
{
	assert(_sources.size() == _targets.size());
	for(int I = 0, fI = _sources.size(); I < fI; I++)
	{
		this->rtlAssignStatementBase::Print_C(ofile, _targets[I], _sources[I]);
	}
}

void rtlSplitStatement::Print_Vhdl(ostream& ofile)
{
	assert(_sources.size() == _targets.size());
	for(int I = 0, fI = _sources.size(); I < fI; I++)
	{
		this->rtlAssignStatementBase::Print_Vhdl(ofile, _targets[I], _sources[I]);
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

