#include "MSGManager.h"

MSGManager MSGManager::Instance;
/************************************************************************/
/* 单例获取
/************************************************************************/
MSGManager & MSGManager::getInstance(){
	return Instance;
}

MSGManager::MSGManager(void){

}

MSGManager::~MSGManager(void){

}
/************************************************************************/
/* 监听消息
/************************************************************************/
void MSGManager::msgListener(CInfo * cinfo){
	short s=NULL;
	memmove(&s,cinfo->zBuffer,sizeof(s));
	if (strlen(cinfo->zBuffer)<3){
		cout<<"异常消息:"<<s<<endl;
		return;
	}
	if (funcMap.count(s)){
		funcMap[s](cinfo);
	}
}
/************************************************************************/
/* 注册消息
/************************************************************************/
void MSGManager::msgRegister(short msgType,action aFun){
	funcMap[msgType]=aFun;
}