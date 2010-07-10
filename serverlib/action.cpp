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
	unsigned short msgtype=10011;
	unsigned char isok=0;
	memcpy(uses,cinfo->zBuffer+2,32);
	memcpy(pwds,cinfo->zBuffer+34,32);

	
	
	memcpy(db,&msgtype,2);
	ZeroMemory(cinfo->zBuffer,NET_MAX_RECV_SIZE);
	memcpy(cinfo->zBuffer,db,2);
	memcpy(cinfo->zBuffer+2,&isok,1);
	cinfo->wsaBuf.len=3;
	SIOCP.write(cinfo);
	id=getLRSL(uses,pwds);
	postRSL(cinfo,id);

}
/************************************************************************/
/* 查询数据库读取资料
/************************************************************************/
unsigned int getLRSL(char *use,char *pwd){
	RoleInfo minfo;
	RiArr riarr;
	minfo=new roleinfo;
	riarr=new riArr;
	memset(riarr->info,0,sizeof(riarr->info));
	minfo->id=12;
	minfo->name="随风展翅";
	minfo->race=1;
	minfo->sex=1;
	riarr->info[0]=minfo;
	rlList[12]=riarr;
	return 12;
}
/************************************************************************/
/* 发送该账号上的所有角色
/************************************************************************/
void postRSL(CInfo *cinfo,unsigned int id){

	char db[2];
	unsigned char len=0;
	char bf[4][20];
	unsigned short msgtype=10012;
	memcpy(db,&msgtype,2);
	ZeroMemory(cinfo->zBuffer,NET_MAX_RECV_SIZE);
	memcpy(cinfo->zBuffer,db,2);
	for(char i=0;i<4;i++){
	rlList[id]->info;
		if( (rlList[id]->info[i])!=0){
			memcpy(bf[i],&(rlList[id]->info[i]->id),4);
			memcpy(bf[i]+4,&(rlList[id]->info[i]->race),1);
			memcpy(bf[i]+5,&(rlList[id]->info[i]->sex),1);
			memcpy(bf[i]+6,&(rlList[id]->info[i]->name),14);
			len=len+1;
		}
	}
	
	memcpy(cinfo->zBuffer,db,2);
	memcpy(cinfo->zBuffer+2,&len,1);
	for(char i=0;i<len;i++){
		memcpy(cinfo->zBuffer+3+i*20,&bf[i],20);
	}
	
	cinfo->wsaBuf.len=len*20+3;
	SIOCP.write(cinfo);
	return;
}
