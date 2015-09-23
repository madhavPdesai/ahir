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

rtlInterfaceGroup::rtlInterfaceGroup(string gname, vector<rtlObject*>& gvec, bool is_input): hierRoot(gname)
{
	_is_input = is_input;
	_is_pipe_access = (gvec.size() == 3);
	
	_req = (_is_pipe_access ? gvec[0] : NULL);
	_data = (_is_pipe_access ? gvec[1] : gvec[0]);
	_ack = (_is_pipe_access ? gvec[2] : NULL);

	if(_req)
		_req->Set_Group(this);
	if(_data)
		_data->Set_Group(this);
	if(_ack)
		_ack->Set_Group(this);
	
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

void rtlThread::Add_Object(rtlObject* obj)
{
	if(obj != NULL)
		_objects[obj->Get_Id()] = obj;
}

void rtlThread::Add_Interface_Group(string gname, vector<string>& gvec, bool is_input)
{
	bool err = false;
	vector<rtlObject*> objvec;
	for(int I = 0, fI = gvec.size(); I < fI; I++)
	{
		rtlObject* obj = this->Find_Object(gvec[I]);
		if(obj == NULL)
		{
			this->Get_Parent()->Report_Error("object " + gvec[I] + " not found in thread " + this->Get_Id());
			err = true;
		}
		else
			objvec.push_back(obj);
	}
	if(!err)
	{
		if(_interface_group_map.find(gname) == _interface_group_map.end())
		{
			rtlInterfaceGroup* ng = new rtlInterfaceGroup(gname, objvec, is_input);
			_interface_group_map[gname] = ng;
		}
		else
		{
			this->Get_Parent()->Report_Error("multiple interface groups with name  " + gname + " found in thread " + this->Get_Id());
		}
	}
}

void rtlThread::Print(ostream& ofile)
{
	ofile << "$thread " << this->Get_Id() << endl;

	for(map<string,rtlObject*>::iterator oiter = _objects.begin(), foiter = _objects.end();
			oiter != foiter; oiter++)
	{
		(*oiter).second->Print(ofile);
	}

	for(map<string,rtlInterfaceGroup*>::iterator iter = _interface_group_map.begin(), fiter = _interface_group_map.end();
			iter != fiter; iter++)
	{
		string gname = (*iter).first;
		rtlInterfaceGroup* ng = (*iter).second;

		ofile << "$group " << (ng->_is_input ? "$in" : "$out") << " "
			<< (ng->_is_pipe_access ? "$pipe" : "$signal") << " "
			<< "("
			<< ((ng->_req != NULL) ? (" " +  ng->_req->Get_Id()) : "")
			<< ((ng->_data != NULL) ? (" " +  ng->_data->Get_Id()) : "")
			<< ((ng->_ack != NULL) ? (" " +  ng->_ack->Get_Id()) : "")
			<< ")" << endl;
	}

	ofile << "$default " << endl;
	for(int I = 0, fI = _default_assignments.size(); I < fI; I++)
		_default_assignments[I]->Print(ofile);

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


void rtlString::Add_Port_Map_Entry(string formal_group, string actual)
{
	hierSystem* base_sys = this->_base_thread->Get_Parent();
	rtlInterfaceGroup* ng = this->_base_thread->Find_Interface_Group(formal_group);
	if(ng == NULL)
	{
		base_sys->Report_Error(" formal group " + formal_group + " not found for string port map for instance " + this->Get_Id());
		return;
	}

	_formal_group_to_actual_map[formal_group] = actual;

	rtlObject* obj = ng->_data;
	assert(obj != NULL);

	if(obj->Is_InPort())
	{
		base_sys->Set_Driving_Pipe(actual);
		this->Set_PipeXSignal_Is_Read_From(actual);
	}
	else if(obj->Is_OutPort())
	{
		base_sys->Set_Driven_Pipe(actual);
		this->Set_PipeXSignal_Is_Written_Into(actual);
	}

	if(obj->Get_Type()->Size() != base_sys->Get_Pipe_Width(actual))
	{
		base_sys->Report_Error(" data interface " + obj->Get_Id() + " size does not match actual " + actual
				+ " in port map for rtlString instance " + this->Get_Id());
	}

	if(!ng->_is_pipe_access)
	{
		if(!base_sys->Is_Signal(actual))
		{
			base_sys->Report_Error(" actual " + actual + " mapped to single-port in instance " + this->Get_Id() + " is not a signal");
		}
	}
	else 
	{
		rtlObject* req_obj = ng->_req;
		rtlObject* ack_obj = ng->_ack;

		if(base_sys->Is_Signal(actual))
		{
			base_sys->Report_Error(" actual " + actual + " mapped to 3-port-tuple in instance " + this->Get_Id() + " is not a pipe");
		}

		if(req_obj == NULL)
		{
			base_sys->Report_Error(" req in group " + ng->Get_Id() + " mapped to " + actual + " in rtlString " + this->Get_Id() + " not found");
		}
		else 
		{
			if(!(req_obj->Get_Type()->Is("rtlUnsignedType") || req_obj->Get_Type()->Is("rtlSignedType")))
				base_sys->Report_Error(" req in group " + ng->Get_Id() + " mapped to " + actual + " in rtlString " + this->Get_Id() + " not of unsigned/signed type");
			if(!req_obj->Is_OutPort())
				base_sys->Report_Error(" req in group " + ng->Get_Id() + " mapped to " + actual + " in rtlString " + this->Get_Id() + " not an OutPort");
			
		}
		if(ack_obj == NULL)
		{
			base_sys->Report_Error(" ack in group " + ng->Get_Id() + " mapped to " + actual + " in rtlString " + this->Get_Id() + " not found");
		}
		else 
		{
			if(!(ack_obj->Get_Type()->Is("rtlUnsignedType") || ack_obj->Get_Type()->Is("rtlSignedType")))
				base_sys->Report_Error(" ack in group " + ng->Get_Id() + " mapped to " + actual + " in rtlString " + this->Get_Id() + " not of unsigned/signed type");

			if(!ack_obj->Is_InPort())
				base_sys->Report_Error(" ack in group " + ng->Get_Id() + " mapped to " + actual + " in rtlString " + this->Get_Id() + " not an InPort");
		}
	}
}

void rtlString::Print(ostream& ofile)
{
	ofile << "$string " << this->Get_Id() << ":"  << _base_thread->Get_Id() << " ";
	ofile << endl;
	for(map<string,string>::iterator piter = _formal_group_to_actual_map.begin(), fpiter = _formal_group_to_actual_map.end();
			piter != fpiter; piter++)
	{
		ofile << (*piter).first << " ";
		ofile << " => ";
		ofile <<  (*piter).second << endl;
	}
}


