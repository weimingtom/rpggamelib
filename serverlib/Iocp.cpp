#include "Iocp.h"
#include "action.h"

Iocp Iocp::Instance;

Iocp & Iocp::getInstance()
{
	return Instance;
}

Iocp::Iocp(void)
{
}

Iocp::~Iocp(void)
{
}
bool Iocp::init(int port)
{
	__INIT_NET_ENVIR__

	if(server.CreateSocket()==false){
		cout<<"套接字创建失败"<<endl;
		return false;
	}
	if(server.bind()==false){
		cout<<"端口绑定失败"<<endl;
		return false;
	}
	if(server.listen()==false){
		cout<<"套接字监听失败"<<endl;
		return false;
	}

	return true;
}
bool Iocp::startup(){

	// 接收的字节数
	DWORD recvSize;
	// 接收标识
	DWORD flags = 0;
	CInfo* pClient;
	iocp = CreateIoCompletionPort(INVALID_HANDLE_VALUE,NULL,0,0);
	Thread th;
	th.create(workthread,(void*)this);
	
	while (true)
	{
		// 创建客户端信息对象
		pClient = new CInfo();
		// 接入连接
		*pClient = ::WSAAccept(server.socket,(sockaddr*)server.getAddr(),server.getAddrlen(),NULL,0);
		// 关联新接入来的socket和与创建好的完成端口,并传递一个套接字信息结构
		CreateIoCompletionPort((HANDLE)pClient->client,iocp,(ULONG_PTR)pClient,0);
		// 创建重叠I/O信息结构
		memset(&pClient->overlapped,0,sizeof(pClient->overlapped));
		pClient->wsaBuf.len = NET_MAX_RECV_SIZE;
		pClient->wsaBuf.buf = pClient->szBuffer;
		// 接收数据
		WSARecv(pClient->client,&pClient->wsaBuf,1,&recvSize,&flags,&pClient->overlapped,NULL);
		cout<<"用户:"<<server.getip()<<"连接"<<endl;
	}
	return false;
	cout<<"工作线程结束"<<endl;
}
workThread(workthread)
{
	Iocp* iocp = (Iocp*)param;
	// 接收标识
	DWORD flags = 0;
	// 数据缓冲区
	LPOVERLAPPED ptrOverlapped;
	// 接收的字节数
	DWORD recvSize = 0;
	BOOL bResult;
	// 客户端
	CInfo* pClient;/*=new CInfo();*/
	while (true){

		// 等待I/O完成
		bResult=GetQueuedCompletionStatus(iocp->iocp,&recvSize,(PULONG_PTR)&pClient,&ptrOverlapped,INFINITE);
		if (bResult == FALSE && ptrOverlapped == NULL)
		{
			printf("WorkerThread - GetQueuedCompletionStatus()错误.\n");
		}else if (bResult == FALSE && ptrOverlapped != NULL)
		{
			cout<<"用户非正常退出"<<endl;
		}
		else if (recvSize == 0)
		{    
			closesocket(pClient->client);
			cout<<"用户已经退出"<<endl;
		}
		else
		{
			cout<<"接收:"<<endl;
			short s=NULL;
			
			printf("recv data from client: %s\n", pClient->szBuffer);
			memmove(&s,pClient->szBuffer,sizeof(s));
			if(s==10010){
				cout<<"成功"<<endl;
				funcMap[100](pClient->szBuffer);
			}
			WSARecv(pClient->client,&pClient->wsaBuf,1,&recvSize,&flags,ptrOverlapped,NULL);
			
		}
	}
	ExitThread(0);
	return 0;
}