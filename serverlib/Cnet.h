#ifndef CNET_H
#define CNET_H
#include "Unit.h"

class Cnet{
public:
	SOCKET socket;
	sockaddr_in addr;
	int NET_ADDR_LEN;
public:
	Cnet(void);
	~Cnet(void);
	bool CreateSocket();
	bool bind(const unsigned short port=2012);
	bool listen(const unsigned int max_connections=4);
	int getError();
	bool close();
	inline sockaddr_in* getAddr(){return &addr;}
	inline const char* getip(){return inet_ntoa(addr.sin_addr);}
	inline int * getAddrlen(){NET_ADDR_LEN=sizeof(addr);return &NET_ADDR_LEN;}
};
#endif