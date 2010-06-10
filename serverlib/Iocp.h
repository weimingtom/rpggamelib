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
public:
	HANDLE iocp;
public:
	Iocp(void);
	~Iocp(void);
	bool init(int port=2012);
	bool startup();
	friend workThread(workthread);

};
#endif