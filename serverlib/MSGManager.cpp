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
	short s=NULL;
	memmove(&s,cinfo->zBuffer,sizeof(s));
	if (strlen(cinfo->zBuffer)<3){
		cout<<"�쳣��Ϣ:"<<s<<endl;
		return;
	}
	if (funcMap.count(s)){
		funcMap[s](cinfo);
	}
}
/************************************************************************/
/* ע����Ϣ
/************************************************************************/
void MSGManager::msgRegister(short msgType,action aFun){
	funcMap[msgType]=aFun;
}