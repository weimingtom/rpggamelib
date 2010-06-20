#ifndef UNIT_H
#define UNIT_H
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <process.h>
#include "Winsock2.h"
#include <map>


#include "CInfo.h"

#pragma comment (lib,"WS2_32.lib")
typedef struct{
	OVERLAPPED Overlapped;
	int ioType;
}iodb,* lp_iodb;
typedef struct 
{
	unsigned int  id;
	unsigned char race;
	unsigned char sex;
	char		* name;
}roleinfo,RoleInfo[3];
#define SIOCP Iocp::getInstance()
#define MSGM MSGManager::getInstance()
#define IOCP_READ 1
#define IOCP_WRITE 2
using namespace std;
typedef void(*action)(CInfo*);
typedef map<short,action> Maps;
typedef map<unsigned int,RoleInfo> RLIList;
extern RLIList rlList;
extern Maps funcMap;
extern iodb IoRead;
extern iodb IoWrite;


#endif