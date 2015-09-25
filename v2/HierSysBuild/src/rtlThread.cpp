#include <istream>
#include <ostream>
#include <assert.h>
#include <hierSystem.h>
#include <rtlEnums.h>
#include <rtlType.h>
#include <Value.hpp>
#include <rtlValue.h>
#include <rtlObject.h>
#include <rtlStatement.h>
#include <rtlThread.h>

rtlThread::rtlThread(hierSystem* sys, string id): hierRoot(id)
{
	_parent = sys;
}

void rtlThread::Add_Statement(rtlStatement* stmt) 
{
	_statements.push_back(stmt); 
	_statement_map[stmt->Get_Label()] = stmt;
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
}

rtlString::rtlString(string inst_name, rtlThread* base):hierRoot(inst_name)
{
	_base_thread = base;
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
}


