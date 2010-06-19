#ifndef CINFO_H
#define CINFO_H

#define NET_BUFFER_SIZE		1024	// 接收缓冲区大小
#define NET_MAX_RECV_SIZE	1023	// 接收字节数大小

class CInfo
{
public:
	CInfo()
	{
		nLastOffset = 0;
		memset(zBuffer,0,NET_BUFFER_SIZE);
		
	}
	inline CInfo operator =(SOCKET s){
		client=s;
		return *this;
	};
	SOCKET client;
	WSABUF wsaBuf;
	unsigned int nLastOffset;			// 偏移地址
	char zBuffer[NET_BUFFER_SIZE];		// 接收缓冲区
};
#endif