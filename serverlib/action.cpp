#include "action.h"
#include "Iocp.h"
#include "Unit.h"
Maps funcMap;
void login(CInfo *cinfo){
	char uses[32];
	char pwds[32];
	char db[2];
	short ss=10011;
	
	memcpy(uses,cinfo->zBuffer+2,32);
	memcpy(pwds,cinfo->zBuffer+34,32);
	memcpy(db,&ss,2);
	ZeroMemory(cinfo->zBuffer,NET_MAX_RECV_SIZE);
	memcpy(cinfo->zBuffer,db,2);
	cinfo->wsaBuf.len=2;
	cinfo->iocpType=IOCP_WRITE;
	SIOCP.write(cinfo);
}