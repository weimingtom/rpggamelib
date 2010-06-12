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
#define SIOCP Iocp::getInstance()
using namespace std;
typedef void(*action)(CInfo*);
typedef map<short,action> Maps;
#endif