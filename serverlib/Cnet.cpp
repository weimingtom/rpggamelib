#include "Cnet.h"

Cnet::Cnet(void)
{
}

Cnet::~Cnet(void)
{
}
/************************************************************************/
/* 创建套接字
/************************************************************************/
bool Cnet::CreateSocket()
{
	socket = ::WSASocket(AF_INET,SOCK_STREAM,0,NULL,0,WSA_FLAG_OVERLAPPED);
	if (INVALID_SOCKET==socket)
	{
		return false;
	}
	return true;
}
/************************************************************************/
/* 套接字端口绑定
/************************************************************************/
bool Cnet::bind(const unsigned short port)
{
	ZeroMemory((char *)&addr, sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = htonl(INADDR_ANY);
	addr.sin_port = htons(port);
	if(::bind(socket,(sockaddr *)&addr,sizeof(addr)) == SOCKET_ERROR)return false;
	return true;
}
/************************************************************************/
/* 开始监听
/************************************************************************/
bool Cnet::listen(const unsigned int max_connections)
{
	if(::listen(socket,max_connections) == SOCKET_ERROR)return false;
	return true;
}
/************************************************************************/
/* 获取错误信息
/************************************************************************/
int Cnet::getError()
{
	return ::WSAGetLastError();
}
/************************************************************************/
/* 关闭套接字
/************************************************************************/
bool Cnet::close()
{
	if(::closesocket(socket) == SOCKET_ERROR) return false;
	return true;
}