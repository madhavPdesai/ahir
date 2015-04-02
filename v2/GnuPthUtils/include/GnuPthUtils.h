#ifndef GnuPthUtils_h___
#define GnuPthUtils_h___

#define MUTEX_DECL(x) pth_mutex_t x = PTH_MUTEX_INIT;
#define MUTEX_LOCK(x) pth_mutex_acquire(&x, 0, NULL);
#define MUTEX_UNLOCK(x) pth_mutex_release(&x);

#define DEFINE_THREAD(x)  void* __##x() {  x(); }
#define DEFINE_THREAD_WITH_ARG(x)  void* __##x(void* arg) {  x(arg); }

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

#endif
