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
#include <rtlStatement.h>
#include <rtlThread.h>


// C string ticker!
//   - print two functions for each 
//     thread
//         - run
//         - tick.
// these functions will be declared in the
// header and defined in the source file.
// 
// For each string, declare a data structure
// which encodes the string state (in the header file).
//
// Declare a ticker thread and define it in the
// source
//    - creates the string data structures
//    - runs an infinite loop
//         run-all-strings
//         tick-all-strings
//
// For each pipe mapped to an input of a string
//  - create an Aa2Rtl matcher structure and thread.
// 
// For each pipe mapped to an output of a string
// -  create an Rtl2Aa matcher structure.
//
// For each signal mapped to an input of a string
//  - create an Aa2Rtl matcher structure and thread.
// 
// For each signal mapped to an output of a string
// -  create an Rtl2Aa matcher structure.
//
// in start daemons, start the ticker and the individual
// threads for Rtl<->Aa matchers.
//
void hierSystem::Print_C_String_Ticker(ostream& header_file, ostream& source_file, vector<string>& match_daemons)
{
	// 
	/*
	  In the header file
		
		- struct declarations for the state of each thread.
		- run  function declarations for each thread.
			run(state*)
		- tick function declarations for each thread.
			tick(state*)
 
	  In the source file
	   	-- declare pipe matchers.
	  	PipeMatcherReq* pipe_p_to_string_s  declarations.
	  	PipeMatcherReq* string_s_to_pipe_p  declarations.

	  	StringState* declarations 
			(one for each string,
				contains state, variables, signals)

		allocateStringStates() one for each string.
		allocatePipeMatchers() one for each string.

	  	Ticker()
	  	{
			allocateStringStates() for all strings.
			while(1)
			{

				for each string
					Transfer-acks-from-pipe-matchers-to-string-states
					execute run
					Transfer-reqs from string-states to pipe-matchers

				for each string
					execute tick
			}
	  	}
	*/

	
	set<rtlThread*> printed_threads;	
	
	for(int I = 0, fI = _rtl_strings.size();  I < fI; I++)
	{
		rtlString* s = _rtl_strings[I];
		rtlThread* pt = s->Get_Base_Thread();

		if(printed_threads.find(pt) == printed_threads.end())
		{
			pt->Print_C_Struct_Declaration(header_file);
			pt->Print_C_Log_Function(source_file);
			pt->Print_C_Run_Function(source_file);
			pt->Print_C_Tick_Function(source_file);
			printed_threads.insert(pt);
		}
	
		s->Print_C_Rtl_Aa_Matcher_Structure_Declarations(source_file);
		s->Print_C_Rtl_Aa_Matcher_Allocator(source_file);

		s->Print_C_State_Structure_Declaration(source_file);
		s->Print_C_State_Structure_Allocator(source_file);
	}

	source_file << "void " << this->Get_Id() << "_String_Ticker()" << endl;
	source_file << "{" << endl;

	for(int I = 0, fI = _rtl_strings.size();  I < fI; I++)
	{
		rtlString* s = _rtl_strings[I];
		s->Print_C_State_Structure_Allocator_Call(source_file);
	}
	
	source_file << "while(1) { " << endl;
	for(int I = 0, fI = _rtl_strings.size();  I < fI; I++)
	{
		rtlString* s = _rtl_strings[I];
		s->Print_C_Run_Function_Call(source_file);
	}

	for(int I = 0, fI = _rtl_strings.size();  I < fI; I++)
	{
		rtlString* s = _rtl_strings[I];
		s->Print_C_Tick_Function_Call(source_file);
	}

	source_file << "}" << endl;
	source_file << "}" << endl;

	source_file << "DEFINE_THREAD(" << this->Get_Id() << "_String_Ticker);" << endl;
	for(int I = 0, fI = _rtl_strings.size();  I < fI; I++)
	{
		rtlString* s = _rtl_strings[I];
		s->Print_C_Matcher_Start_Daemons(source_file, match_daemons);
	}
}
