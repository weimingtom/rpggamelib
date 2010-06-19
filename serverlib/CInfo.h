#ifndef CINFO_H
#define CINFO_H

#define NET_BUFFER_SIZE		1024	// ���ջ�������С
#define NET_MAX_RECV_SIZE	1023	// �����ֽ�����С

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
	unsigned int nLastOffset;			// ƫ�Ƶ�ַ
	char zBuffer[NET_BUFFER_SIZE];		// ���ջ�����
};
#endif