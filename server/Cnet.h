#pragma once
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <string.h>
#include "Winsock2.h"
#pragma comment (lib,"WS2_32.lib")
using namespace std;
#define CNETPORT 2018;
class Cnet
{
public:
	Cnet(void);
	~Cnet(void);
private:
	int port;
	SOCKET server;
	
};
