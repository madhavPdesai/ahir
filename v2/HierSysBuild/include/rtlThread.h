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

	vector<rtlStatement*> _statements;


	public:

	rtlThread(string id);

	void Add_Statement(rtlStatement* stmt) {_statements.push_back(stmt);}


	// replica print.
	void Print(ostream& ofile);

	// print VHDL entity/architecture pair.
	//  (or better a procedure? no, leave it as an entity/architecture pair,
	//    so that we can use generics later).
	void Print_VHDL(ostream& ofile);

	
	//
	// print C model of thread.
	//
	// Not clear how this will be done.
	//   basically, we need an asynch to synch
	//   interface here..
	//
	void PrintC(ostream& header_file, ostream& source_file) {assert(0);}
	
	friend class hierSystem;
};


class rtlString: public hierRoot
{

	rtlThread* _base_thread;

	map<string,string> _port_map;

	public:
	
	rtlString(rtlThread* base, vector<pair<string,string> >& port_map);

	// not clear how this will be done.. 
	void PrintC(ostream& header_file, ostream& source_file);


	// each thread-instance is a component instance.
	void Print_VHDL(ostream& ofile);
};

#endif
