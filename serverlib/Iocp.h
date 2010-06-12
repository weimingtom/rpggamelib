#ifndef IOCP_H
#define IOCP_H

#include "Thread.h"
#include "CInfo.h"
#include "Cnet.h"

#define __INIT_NET_ENVIR__ int nError;WSADATA wsaData;if((nError=WSAStartup(MAKEWORD(2,2),&wsaData))!=0){cout<<"Æô¶¯WinSocketÊ§°Ü!"<<endl;return false;}

class Iocp
{
private:
	Cnet server;
	static Iocp Instance;
public:
	HANDLE iocp;
public:
	~Iocp(void);
	bool init(int port=2012);
	bool startup();
	friend workThread(workthread);
	static Iocp & getInstance();
	void write(CInfo*);
private:
	Iocp(void);

};
#endif