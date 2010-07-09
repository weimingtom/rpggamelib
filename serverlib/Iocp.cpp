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
/* ��ʼ���׽���
/************************************************************************/
bool Iocp::init(int port)
{
	__INIT_NET_ENVIR__

	if(server.CreateSocket()==false){
		cout<<"�׽��ִ���ʧ��"<<endl;
		return false;
	}
	if(server.bind()==false){
		cout<<"�˿ڰ�ʧ��"<<endl;
		return false;
	}
	if(server.listen()==false){
		cout<<"�׽��ּ���ʧ��"<<endl;
		return false;
	}
	return true;
}
/************************************************************************/
/* ����������
/************************************************************************/
bool Iocp::startup(){

	// ���յ��ֽ���
	DWORD recvSize;
	// ���ձ�ʶ
	DWORD flags = 0;
	CInfo* pClient;
	iocp = CreateIoCompletionPort(INVALID_HANDLE_VALUE,NULL,0,0);
	Thread th;
	th.create(workthread,(void*)this);
	
	while (true)
	{
		// �����ͻ�����Ϣ����
		pClient = new CInfo();
		// ��������
		*pClient = ::WSAAccept(server.socket,(sockaddr*)server.getAddr(),server.getAddrlen(),NULL,0);
		// �����½�������socket���봴���õ���ɶ˿�,������һ���׽�����Ϣ�ṹ
		CreateIoCompletionPort((HANDLE)pClient->client,iocp,(ULONG_PTR)pClient,0);
		// �����ص�I/O��Ϣ�ṹ
		//memset(&pClient->overlapped,0,sizeof(pClient->overlapped));
		pClient->wsaBuf.len = NET_MAX_RECV_SIZE;
		pClient->wsaBuf.buf = pClient->zBuffer;
		//pClient->iocpType=IOCP_READ;
		// ��������
		lp_iodb IoRead =MSG.getInstance().getiodbR();
		WSARecv(pClient->client,&pClient->wsaBuf,1,&recvSize,&flags,&(IoRead->Overlapped),NULL);
		cout<<"�û�:"<<server.getip()<<"����"<<endl;
	}
	return false;
	cout<<"�����߳̽���"<<endl;
}
/************************************************************************/
/* ���
/************************************************************************/
void Iocp::write(CInfo * info)
{
	DWORD recvSize = 0;
	lp_iodb IoWrite = MSG.getInstance().getiodbW();
	::WSASend(info->client,&info->wsaBuf,1,&recvSize,0,&IoWrite->Overlapped,NULL);
}
/************************************************************************/
/* �����߳�
/************************************************************************/
workThread(workthread)
{
	Iocp* iocp = (Iocp*)param;
	// ���ձ�ʶ
	DWORD flags = 0;
	// ���ݻ�����
	LPOVERLAPPED ptrOverlapped;
	// ���յ��ֽ���
	DWORD recvSize = 0;
	BOOL bResult;
	// �ͻ���
	CInfo* pClient;/*=new CInfo();*/
	iodb* iodbtype=NULL;
	short s=NULL;
	lp_iodb IoRead;
	while (true){

		// �ȴ�I/O���
		bResult=GetQueuedCompletionStatus(iocp->iocp,&recvSize,(PULONG_PTR)&pClient,&ptrOverlapped,INFINITE);
		if (bResult == FALSE && ptrOverlapped == NULL)
		{
			printf("WorkerThread - GetQueuedCompletionStatus()����.\n");
		}else if (bResult == FALSE && ptrOverlapped != NULL)
		{
			cout<<"�û��������˳�"<<endl;

		}
		else if (recvSize == 0)
		{    
			closesocket(pClient->client);
			cout<<"�û��Ѿ��˳�"<<endl;
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
				printf("�յ�����: %s\n", pClient->zBuffer);
				MSGM.msgListener(pClient);
				ZeroMemory(pClient->zBuffer,NET_MAX_RECV_SIZE);
				pClient->wsaBuf.len=NET_MAX_RECV_SIZE;
				IoRead = MSG.getInstance().getiodbR();
				WSARecv(pClient->client,&pClient->wsaBuf,1,&recvSize,&flags,&IoRead->Overlapped,NULL);
				
			break;
			case IOCP_WRITE:
				
				printf("��������: %s\n", pClient->zBuffer);
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
