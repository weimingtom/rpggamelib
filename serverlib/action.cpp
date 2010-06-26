#include "action.h"
#include "Iocp.h"
#include "Unit.h"
/************************************************************************/
/* 登陆服务器验证
/************************************************************************/

void login(CInfo *cinfo){
	char uses[32];
	char pwds[32];
	char db[2];
	unsigned int id;
	short msgtype=10011;
	unsigned char isok=0;
	memcpy(uses,cinfo->zBuffer+2,32);
	memcpy(pwds,cinfo->zBuffer+34,32);

	id=getLRSL(uses,pwds);
	
	memcpy(db,&msgtype,2);
	ZeroMemory(cinfo->zBuffer,NET_MAX_RECV_SIZE);
	memcpy(cinfo->zBuffer,db,2);
	memcpy(cinfo->zBuffer+2,&isok,1);
	cinfo->wsaBuf.len=3;
	SIOCP.write(cinfo);
	postRSL(cinfo,id);

}
/************************************************************************/
/* 查询数据库读取资料
/************************************************************************/
unsigned int getLRSL(char *use,char *pwd){
	RoleInfo minfo;
	RiArr riarr;
	minfo=new roleinfo;
	riarr =new riArr;
	minfo->id=12;
	minfo->name="随风展翅";
	minfo->race=1;
	minfo->sex=1;
	riarr->info[0]=minfo;
	rlList[minfo->id]=riarr;
	return minfo->id;
}
/************************************************************************/
/* 发送该账号上的所有角色
/************************************************************************/
void postRSL(CInfo *cinfo,unsigned int id){
	
	return;
}
