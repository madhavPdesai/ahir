#include <istream>
#include <ostream>
#include <assert.h>
#include <hierSystem.h>
#include <rtlThread.h>


rtlThread::rtlThread(hierSystem* sys, string id): hierRoot(id)
{
	_parent_system = sys;
}

void rtlThread::Set_Default_Parameter_Map(vector<pair<string,int> >& param_map)
{
	for(int idx = 0, fidx = param_map.size(); idx < fidx; idx++)
	{
		_default_parameter_map[param_map[idx].first] = param_map[idx].second;
	}
}

void rtlThread::Print(ostream& ofile)
{
	// TODO
	ofile << "// $def_thread " << this->Get_Id() << endl;
}


rtlThreadInstance::rtlThreadInstance(hierSystem* sys, string inst_name, string thread_name): hierRoot(inst_name)
{
	_parent_system = sys;
	_instance_name = inst_name;
	_thread_name = thread_name;	
}

void rtlThreadInstance::Set_Port_Map(vector<pair<string,string> >& port_map)
{
	for(int idx = 0, fidx = port_map.size(); idx < fidx; idx++)
	{
		_port_map[port_map[idx].first] = port_map[idx].second;
	}
}

void rtlThreadInstance::Set_Parameter_Map(vector<pair<string,int> >& param_map)
{
	for(int idx = 0, fidx = param_map.size(); idx < fidx; idx++)
	{
		_parameter_map[param_map[idx].first] = param_map[idx].second;
	}
}

void rtlThreadInstance::Print(ostream& ofile)
{
	// TODO
	ofile << "//$threadinstance " << this->Get_Id() << " TODO " << endl;
}
