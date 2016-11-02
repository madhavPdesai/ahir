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
#ifndef rtl2AaMatcher_h__
#define rtl2AaMatcher_h__
#include <BitVectors.h>

typedef enum
{
	_IDLE,
	_ACCESS,
	_DONE
} PipeMatcherState;;

typedef struct _PipeMatcherRec PipeMatcherRec;
struct _PipeMatcherRec
{
	
	bit_vector* _value;

	char*  _pipe_name;
	pthread_mutex_t _lock_mutex;


	PipeMatcherState  _state;

	PipeMatcherRec* _next;
};
PipeMatcherRec* makePipeMatcher(const char* pipe_name, int pipe_width);

typedef struct _SignalMatcherRec SignalMatcherRec;
struct _SignalMatcherRec
{
	
	bit_vector* _value;
	char*  _signal_name;

	pthread_mutex_t _lock_mutex;


	SignalMatcherRec* _next;
};
SignalMatcherRec* makeSignalMatcher(const char* signal_name, int signal_width);

void setNext(PipeMatcherRec* mrec, PipeMatcherRec* next);
PipeMatcherRec* getNext(PipeMatcherRec* mrec);


//   if(state == IDLE)
//   {
//      if(req == 1) 
//      {
//          ack = false. 
//          set state = BUSY  (pipe-access started with write-data).
//      }
//   }
//   else if(state == BUSY)
//   {
//      ack = false
//   }
//     (set state = DONE when pipe-access finished).
//   else if(state == DONE)
//   {
//      ack = true;
//      state = IDLE.
//   }  
void probeMatcher(PipeMatcherRec* mrec, char write_flag, char req, char* ack, bit_vector* write_val);


void setState(PipeMatcherRec* mrec, PipeMatcherState s);
PipeMatcherState getState(PipeMatcherRec* mrec);

void assignValue(PipeMatcherRec* mrec, bit_vector* v);


void getValue(PipeMatcherRec* mrec,bit_vector* dest);
void fetchFromPipe(PipeMatcherRec* mrec);
void sendToPipe(PipeMatcherRec* mrec);
char* getPipeName(PipeMatcherRec* mrec);

void Aa2RtlPipeTransferMatcher(void* mrec);
void Rtl2AaPipeTransferMatcher(void* mrec);

void setNextSignal(SignalMatcherRec* mrec, SignalMatcherRec* next);
SignalMatcherRec* getNextSignal(SignalMatcherRec* mrec);
void assignValueS(SignalMatcherRec* mrec, bit_vector* v);
void getSignalValue(SignalMatcherRec* mrec,bit_vector* dest);
char* getSignalName(SignalMatcherRec* mrec);

void Aa2RtlSignalTransferMatcher(void* sig_val);
void Rtl2AaSignalTransferMatcher(void* sig_val);


#endif
