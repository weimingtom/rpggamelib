#include "action.h"
#include "Iocp.h"
#include "Unit.h"
Maps funcMap;
void login(CInfo *cinfo){
	char uses[32];
	char pwds[32];
	char db[2];
	short ss=10011;
	
	memcpy(uses,cinfo->szBuffer+2,32);
	memcpy(pwds,cinfo->szBuffer+34,32);
	memcpy(db,&ss,sizeof(ss));

	//memset(db+2,1,2);
	memcpy(cinfo->czBuffer,db,2);
	//cinfo->czBuffer[3]='\0';
	SIOCP.write(cinfo);
}