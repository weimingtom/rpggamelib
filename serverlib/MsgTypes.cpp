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
	lp_iodb type=NULL;
	for (int i=0;i<num;i++)
	{
		type=new iodb();
		type->ioType=0;
		MTPond.push_back(type);
	}
	return num;
}
lp_iodb MsgTypes::getiodbR()
{
	lp_iodb type=NULL;
	for (unsigned int i=0;i<MTPond.size();i++)
	{
		if(MTPond[i]->ioType==0)
		{
			type=MTPond[i];
			type->ioType=IOCP_READ;
			break;
		}
	}
	if (type==NULL)
	{
		type = new iodb();
		type->ioType=IOCP_READ;
		MTPond.push_back(type);
	}
	return type;
}
lp_iodb MsgTypes::getiodbW()
{
	lp_iodb type=NULL;
	for (unsigned int i=0;i<MTPond.size();i++)
	{
		if(MTPond[i]->ioType==0)
		{
			type=MTPond[i];
			type->ioType=IOCP_WRITE;
			break;
		}
	}
	if (type==NULL)
	{
		type = new iodb();
		type->ioType=IOCP_WRITE;
		MTPond.push_back(type);
	}
	return type;
}
MsgTypes::MsgTypes(void){
	
}

MsgTypes::~MsgTypes(void){

}