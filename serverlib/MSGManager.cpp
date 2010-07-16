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
	unsigned short key=NULL;
	memmove(&key,cinfo->zBuffer,sizeof(key));
	if (strlen(cinfo->zBuffer)<3){
		cout<<"异常消息:"<<key<<endl;
		return;
	}
	if (funcMap.count(key)){
		funcMap[key](cinfo);
	}
}
/************************************************************************/
/* 注册消息
/************************************************************************/
void MSGManager::msgRegister(unsigned short msgType,action aFun){
	funcMap[msgType]=aFun;
}