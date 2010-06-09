#ifndef THREAD_H
#define THREAD_H
#include "Unit.h"

typedef unsigned int ThreadId;
typedef unsigned int (__stdcall *ThreadFunc)(void *param);
#define workThread(name) unsigned int __stdcall name(void *param)
#define CloseHandle CloseHandle((HANDLE)_beginthreadex(NULL,0,func_ptr,param,0,&nID)) == TRUE ? true : false;

class Thread
{
public:

	bool create(ThreadFunc func_ptr,void* param = NULL){
		return CloseHandle;
	}
	
	inline ThreadId getId() const{
		return nID;
	}
private:
	ThreadId nID;
};
#endif