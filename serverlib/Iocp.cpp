#include "Iocp.h"
#include "MsgTypes.h"
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
/************************************************************************/
/* 初始化套接字
/************************************************************************/
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
/************************************************************************/
/* 启动服务器
/************************************************************************/
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
		//memset(&pClient->overlapped,0,sizeof(pClient->overlapped));
		pClient->wsaBuf.len = NET_MAX_RECV_SIZE;
		pClient->wsaBuf.buf = pClient->zBuffer;
		//pClient->iocpType=IOCP_READ;
		// 接收数据
		lp_iodb IoRead =MSG.getInstance().getiodbR();
		WSARecv(pClient->client,&pClient->wsaBuf,1,&recvSize,&flags,&(IoRead->Overlapped),NULL);
		cout<<"用户:"<<server.getip()<<"连接"<<endl;
	}
	return false;
	cout<<"工作线程结束"<<endl;
}
/************************************************************************/
/* 输出
/************************************************************************/
void Iocp::write(CInfo * info)
{
	DWORD recvSize = 0;
	lp_iodb IoWrite = MSG.getInstance().getiodbW();
	::WSASend(info->client,&info->wsaBuf,1,&recvSize,0,&IoWrite->Overlapped,NULL);
}
/************************************************************************/
/* 工作线程
/************************************************************************/
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
	iodb* iodbtype=NULL;
	short s=NULL;
	lp_iodb IoRead;
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
			continue;
		}
		iodbtype=(iodb *)ptrOverlapped;
		iodbtype->ioType=0;
		switch (iodbtype->ioType)
		{
			case IOCP_READ:
				
				//memmove(&s,pClient->zBuffer,sizeof(s));
				//printf("recv data from client: %s\n", pClient->zBuffer);
				//if(s==10010){
				//	pClient->iocpType=IOCP_WRITE;
				//}
				//ZeroMemory(pClient->zBuffer, 1024);
				printf("收到数据: %s\n", pClient->zBuffer);
				MSGM.msgListener(pClient);
				ZeroMemory(pClient->zBuffer,NET_MAX_RECV_SIZE);
				pClient->wsaBuf.len=NET_MAX_RECV_SIZE;
				IoRead = MSG.getInstance().getiodbR();
				WSARecv(pClient->client,&pClient->wsaBuf,1,&recvSize,&flags,&IoRead->Overlapped,NULL);
				
			break;
			case IOCP_WRITE:
				
				printf("发送数据: %s\n", pClient->zBuffer);
				ZeroMemory(pClient->zBuffer,NET_MAX_RECV_SIZE);
				
				
			break;
			default:
				//We should never be reaching here, under normal circumstances.
			break;
		}
	}
	ExitThread(0);
	return 0;
}
