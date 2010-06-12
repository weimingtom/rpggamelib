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
		memset(szBuffer,0,NET_BUFFER_SIZE);
		memset(czBuffer,0,NET_BUFFER_SIZE);
	}
	inline CInfo operator =(SOCKET s){
		client=s;
		return *this;
	};
	SOCKET client;
	OVERLAPPED overlapped;
	WSABUF wsaBuf;
	bool type;
	unsigned int nLastOffset;			// 偏移地址
	char szBuffer[NET_BUFFER_SIZE];		// 接收缓冲区
	char czBuffer[NET_BUFFER_SIZE];
};
#endif