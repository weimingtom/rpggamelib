#ifndef UNIT_H
#define UNIT_H
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <process.h>
#include "Winsock2.h"
#include <map>
#include <vector>
#pragma comment (lib,"WS2_32.lib")
using namespace std;

#include "CInfo.h"
#include "MsgType.h"

typedef struct{
	OVERLAPPED Overlapped;
	unsigned char ioType;
}iodb,* lp_iodb;
typedef struct 
{
	unsigned int  id;
	unsigned char race;
	unsigned char sex;
	char		* name;
}roleinfo,*RoleInfo;
typedef struct
{
	RoleInfo info [4];
}riArr,*RiArr;

#define U (CUtf8String)
#define W (CGb2312String)
#define SIOCP Iocp::getInstance()
#define MSGM MSGManager::getInstance()
#define MSG MsgTypes::getInstance()
#define IOCP_READ 1
#define IOCP_WRITE 2
typedef void(*action)(CInfo*);
typedef map<unsigned short,action> Maps;
typedef map<unsigned int,RiArr> RLIList;
extern RLIList rlList;
extern Maps funcMap;


#endif