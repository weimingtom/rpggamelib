#include "Cnet.h"

Cnet::Cnet(void)
{
}

Cnet::~Cnet(void)
{
}
/************************************************************************/
/* �����׽���
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
/* �׽��ֶ˿ڰ�
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
/* ��ʼ����
/************************************************************************/
bool Cnet::listen(const unsigned int max_connections)
{
	if(::listen(socket,max_connections) == SOCKET_ERROR)return false;
	return true;
}
/************************************************************************/
/* ��ȡ������Ϣ
/************************************************************************/
int Cnet::getError()
{
	return ::WSAGetLastError();
}
/************************************************************************/
/* �ر��׽���
/************************************************************************/
bool Cnet::close()
{
	if(::closesocket(socket) == SOCKET_ERROR) return false;
	return true;
}