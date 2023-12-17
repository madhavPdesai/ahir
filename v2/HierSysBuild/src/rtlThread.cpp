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
#include <rtlStatement.h>
#include <rtlThread.h>

bool Check_If_Assignment_To_Signal(rtlThread* t, rtlStatement* stmt)
{
	bool ret_val = true;
	set<rtlObject*> tgt_objs;
	stmt->Collect_Target_Objects(tgt_objs);
	for(set<rtlObject*>::iterator iter = tgt_objs.begin(), fiter = tgt_objs.end(); iter != fiter; iter++)
	{
		rtlObject* obj = *iter;
		if(!obj->Is_Signal())
		{	
			t->Report_Error("Immediate/Tick block statement targets must be signals: in thread " + t->Get_Id());
			ret_val = false;
		}
	}
	return(ret_val);
}

rtlThread::rtlThread(hierSystem* sys, string id): hierRoot(id)
{
	_parent = sys;
}

void rtlThread::Add_Statement(rtlStatement* stmt) 
{
	_statements.push_back(stmt); 
	_statement_map[stmt->Get_Label()] = stmt;
}

void rtlThread::Add_Immediate_Statement(rtlStatement* stmt) 
{
	bool check_status = Check_If_Assignment_To_Signal(this, stmt);	
	if(check_status)
		_immediate_statements.push_back(stmt);
}

void rtlThread::Add_Tick_Statement(rtlStatement* stmt) 
{
	bool check_status = Check_If_Assignment_To_Signal(this, stmt);	
	if(check_status)
		_tick_statements.push_back(stmt);
}

void rtlThread::Add_Object(rtlObject* obj)
{
	if(obj != NULL)
		_objects[obj->Get_Id()] = obj;
}

void rtlThread::Print(ostream& ofile)
{
	ofile << "$thread " << this->Get_Id() << endl;

	for(map<string,rtlObject*>::iterator oiter = _objects.begin(), foiter = _objects.end();
			oiter != foiter; oiter++)
	{
		(*oiter).second->Print(ofile);
	}

	ofile << "$default " << endl;
	for(int I = 0, fI = _default_statements.size(); I < fI; I++)
		_default_statements[I]->Print(ofile);

	ofile << endl;
	for(int I = 0, fI = _statements.size(); I < fI; I++)
	{
		_statements[I]->Print(ofile);
	}

	ofile << "$now " << endl;
	for(int I = 0, fI = _immediate_statements.size(); I < fI; I++)
		_immediate_statements[I]->Print(ofile);

	ofile << "$tick " << endl;
	for(int I = 0, fI = _tick_statements.size(); I < fI; I++)
		_tick_statements[I]->Print(ofile);
}


rtlString::rtlString(string inst_name, rtlThread* base):hierRoot(inst_name)
{
	_base_thread = base;
	_default_clock = "clk";
	_default_reset = "reset";
}


void rtlString::Add_Port_Map_Entry(string formal_obj, string actual)
{
	hierSystem* base_sys = this->_base_thread->Get_Parent();
	rtlObject* ng = this->_base_thread->Find_Object(formal_obj);
	if(ng == NULL)
	{
		base_sys->Report_Error(" formal interface " + formal_obj + " not found for string port map for instance " + this->Get_Id());
		return;
	}

	_formal_to_actual_map[formal_obj] = actual;


	if(ng->Is_InPort())
	{
		base_sys->Set_Driving_Pipe(actual);
		this->Set_PipeXSignal_Is_Read_From(actual);
	}
	else if(ng->Is_OutPort())
	{
		base_sys->Set_Driven_Pipe(actual);
		this->Set_PipeXSignal_Is_Written_Into(actual);
	}

	if(ng->Get_Type()->Size() != base_sys->Get_Pipe_Width(actual))
	{
		base_sys->Report_Error(" data interface " + ng->Get_Id() + " size does not match actual " + actual
				+ " in port map for rtlString instance " + this->Get_Id());
	}

	if(base_sys->Is_Signal(actual) == ng->Is_Pipe())
	{
		base_sys->Report_Error(" mismatch between formal " + formal_obj + " and actual " + actual + " in instance " + this->Get_Id());
	}
}

void rtlString::Print(ostream& ofile)
{
	ofile << "$string " << this->Get_Id() << ":"  << _base_thread->Get_Id() << " ";
	ofile << endl;
	for(map<string,string>::iterator piter = _formal_to_actual_map.begin(), fpiter = _formal_to_actual_map.end();
			piter != fpiter; piter++)
	{
		ofile << (*piter).first << " ";
		ofile << " => ";
		ofile <<  (*piter).second << endl;
	}

	if(this->_default_clock != "clk")
		ofile << "$clk => " << this->_default_clock << endl;
	if(this->_default_reset != "reset")
		ofile << "$reset => " << this->_default_reset << endl;

}


