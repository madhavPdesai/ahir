#ifndef __pthreadUtils_h__
#define __pthreadUtils_h__

#define DEFINE_THREAD(x)  void* __##x() {  x(); }
#define DEFINE_THREAD_WITH_ARG(x)  void* __##x(void* arg) {  x(arg); }

#define PTHREAD_DECL(x)  pthread_t  __thread_##x;
#define PTHREAD_CREATE(x)  { fprintf(stderr,"Info:pThreadUtils: started thread " #x "\n"); pthread_create(&__thread_##x,NULL,&__##x,NULL);}
#define PTHREAD_CREATE_WITH_ARG(x,arg)  { fprintf(stderr,"Info:pThreadUtils: started thread " #x "\n"); pthread_create(&__thread_##x,NULL,&__##x,(void*) arg);}
#define PTHREAD_JOIN(x)  pthread_join(__thread_##x,NULL);
#define PTHREAD_CANCEL(x)  pthread_cancel(__thread_##x);

#endif
