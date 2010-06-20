#include "action.h"
#include "Iocp.h"
#include "Unit.h"
/************************************************************************/
/* 登陆服务器验证
/************************************************************************/
RoleInfo rlist;
roleinfo rinfo;
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
	rinfo.id=10;
	rinfo.race=0;
	rinfo.sex=1;
	rinfo.name="随风展翅";
	rlist[1]=rinfo;
	rlList[rinfo.id]=rlist;
	return rinfo.id;
}
/************************************************************************/
/* 发送该账号上的所有角色
/************************************************************************/
void postRSL(CInfo *cinfo,unsigned int id){
	rlList[id][0].name;
	return;
}
