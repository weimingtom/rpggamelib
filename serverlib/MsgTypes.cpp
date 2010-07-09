#include "MsgTypes.h"

MsgTypes MsgTypes::Instance;
/************************************************************************/
/* µ¥Àý»ñÈ¡
/************************************************************************/
MsgTypes & MsgTypes::getInstance(){
	return Instance;
}
int MsgTypes::initPond(int num=20)
{
	
	for (int i=0;i<num;i++)
	{
		MTPond.push_back(new iodb);
	}
	return num;
}
MsgTypes::MsgTypes(void){
	
}

MsgTypes::~MsgTypes(void){

}