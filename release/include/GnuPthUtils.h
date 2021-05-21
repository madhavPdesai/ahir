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
#ifndef GnuPthUtils_h___
#define GnuPthUtils_h___

#define MUTEX_DECL(x) pth_mutex_t x = PTH_MUTEX_INIT;
#define MUTEX_LOCK(x) pth_mutex_acquire(&x, 0, NULL);
#define MUTEX_UNLOCK(x) pth_mutex_release(&x);

#define DEFINE_THREAD(x)  void* __##x() {  x(); }
#define DEFINE_THREAD_WITH_ARG(x,arg)  void* __##x(void* arg) {  x(arg); }

#define PTHREAD_DECL(x)  pth_t  __thread_##x;
#define PTHREAD_CREATE(x)  {\
	 pth_attr_t t_attr = pth_attr_new(); \
         pth_attr_set(t_attr, PTH_ATTR_NAME, " #x ");\
	 pth_attr_set(t_attr, PTH_ATTR_JOINABLE, TRUE);\
	 __thread_##x = pth_spawn(t_attr,&__##x,NULL);\
         pth_attr_destroy(t_attr);\
	 fprintf(stderr,"Info:GnuPthUtils: started thread " #x "\n");\
	}
#define PTHREAD_CREATE_WITH_ARG(x,arg)  \
	{\
	 pth_attr_t t_attr = pth_attr_new(); \
         pth_attr_set(t_attr, PTH_ATTR_NAME, " #x ");\
	 pth_attr_set(t_attr, PTH_ATTR_JOINABLE, TRUE);\
	 __thread_##x = pth_spawn(t_attr,&__##x,(void*) arg);\
         pth_attr_destroy(t_attr);\
	 fprintf(stderr,"Info:GnuPthUtils: started thread " #x "\n");\
	}
#define PTHREAD_JOIN(x)    pth_join(__thread_##x,NULL);
#define PTHREAD_CANCEL(x)  pth_cancel(__thread_##x);
#define PTHREAD_DECL_AND_CREATE(x) PTHREAD_DECL(x); PTHREAD_CREATE(x);
#define PTHREAD_YIELD() pth_yield(NULL);

#endif
