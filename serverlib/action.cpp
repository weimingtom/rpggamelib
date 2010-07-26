#include "action.h"
#include "Iocp.h"
#include "Unit.h"
#include "transform.h"
/************************************************************************/
/* 登陆服务器验证
/************************************************************************/

void login(CInfo *cinfo){
	char uses[32];
	char pwds[32];
	unsigned int id;
	unsigned short msgtype=SMT_LOGIN;
	unsigned short pack=3;
	unsigned char isok=0;
	memcpy(uses,cinfo->zBuffer+2,32);
	memcpy(pwds,cinfo->zBuffer+34,32);

	ZeroMemory(cinfo->zBuffer,NET_MAX_RECV_SIZE);
	memcpy(cinfo->zBuffer,&pack,2);
	memcpy(cinfo->zBuffer+2,&msgtype,2);
	memcpy(cinfo->zBuffer+4,&isok,1);
	cinfo->wsaBuf.len=5;
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
	minfo->name=U"随风展翅";
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

	unsigned char len=0;
	char bf[4][20];
	unsigned short msgtype=SMT_POST_SELECT_ROLE;
	unsigned short pack=0;
	ZeroMemory(cinfo->zBuffer,NET_MAX_RECV_SIZE);
	
	for(char i=0;i<4;i++){
	rlList[id]->info;
		if( (rlList[id]->info[i])!=0){
			memcpy(bf[i],&(rlList[id]->info[i]->id),4);
			memcpy(bf[i]+4,&(rlList[id]->info[i]->race),1);
			memcpy(bf[i]+5,&(rlList[id]->info[i]->sex),1);
			memcpy(bf[i]+6,(rlList[id]->info[i]->name),14);
			len=len+1;
		}
	}
	pack=len*20+3;
	memcpy(cinfo->zBuffer,&pack,2);
	memcpy(cinfo->zBuffer+2,&msgtype,2);
	memcpy(cinfo->zBuffer+4,&len,1);
	for(char i=0;i<len;i++){
		memcpy(cinfo->zBuffer+5+i*20,&bf[i],20);
	}
	
	cinfo->wsaBuf.len=len*20+5;
	SIOCP.write(cinfo);
	return;
}
/************************************************************************/
/* 角色选择完成
/************************************************************************/
void selectROK(CInfo *cinfo){
	unsigned int id;
	unsigned char mapid=12;
	unsigned short pack=3;
	unsigned short msgtype=SMT_POST_MAPID;
	memcpy(&id,cinfo->zBuffer+2,4);
	ZeroMemory(cinfo->zBuffer,NET_MAX_RECV_SIZE);
	
	memcpy(cinfo->zBuffer,&pack,2);
	memcpy(cinfo->zBuffer+2,&msgtype,2);
	memcpy(cinfo->zBuffer+4,&mapid,1);
	cinfo->wsaBuf.len=5;
	SIOCP.write(cinfo);
}