#include "action.h"
#include "Iocp.h"
#include "Unit.h"

void login(CInfo *cinfo){
	char uses[32];
	char pwds[32];
	char db[2];
	short msgtype=10011;
	unsigned char isok=3;
	
	memcpy(uses,cinfo->zBuffer+2,32);
	memcpy(pwds,cinfo->zBuffer+34,32);
	memcpy(db,&msgtype,2);
	ZeroMemory(cinfo->zBuffer,NET_MAX_RECV_SIZE);
	memcpy(cinfo->zBuffer,db,2);
	memcpy(cinfo->zBuffer+2,&isok,1);
	cinfo->wsaBuf.len=3;
	//cinfo->iocpType=IOCP_WRITE;
	SIOCP.write(cinfo);

}
