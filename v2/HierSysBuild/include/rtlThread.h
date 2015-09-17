#ifndef rtl_Thread_h__
#define rtl_Thread_h__

using namespace std;
class hierRoot;
class hierSystem;
class rtlStatement;

//
//  rtl threads..
// 
class rtlThread: public hierRoot
{
  hierSystem* _parent;
  
	vector<rtlStatement*> _statements;
	map<string, rtlObject*> _objects;

	public:

	rtlThread(hierSystem* p, string id);
	hierSystem* Get_Parent() {return(_parent);}


	void Add_Statement(rtlStatement* stmt) {_statements.push_back(stmt);}

	void Add_Object(rtlObject* obj);
	rtlObject* Find_Object(string obj_name)
	{
		if(_objects.find(obj_name) != _objects.end())
			return(_objects[obj_name]);
		else
			return(NULL);
	}

	// replica print.
	void Print(ostream& ofile);
	friend class hierSystem;
};


class rtlString: public hierRoot
{

	rtlThread* _base_thread;
	map<string,vector<string> >  _actual_to_formal_port_map;


	public:
	
	rtlString(string inst_name, rtlThread* base);
	void Add_Port_Map_Entry(vector<string>& formals, string actual);
	void Print(ostream& ofile);

};

#endif
