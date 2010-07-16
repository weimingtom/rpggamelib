#include "MSGManager.h"

MSGManager MSGManager::Instance;
/************************************************************************/
/* ������ȡ
/************************************************************************/
MSGManager & MSGManager::getInstance(){
	return Instance;
}

MSGManager::MSGManager(void){

}

MSGManager::~MSGManager(void){

}
/************************************************************************/
/* ������Ϣ
/************************************************************************/
void MSGManager::msgListener(CInfo * cinfo){
	unsigned short key=NULL;
	memmove(&key,cinfo->zBuffer,sizeof(key));
	if (strlen(cinfo->zBuffer)<3){
		cout<<"�쳣��Ϣ:"<<key<<endl;
		return;
	}
	if (funcMap.count(key)){
		funcMap[key](cinfo);
	}
}
/************************************************************************/
/* ע����Ϣ
/************************************************************************/
void MSGManager::msgRegister(unsigned short msgType,action aFun){
	funcMap[msgType]=aFun;
}