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
		cout<<"�׽��ִ���ʧ��"<<endl;
		return false;
	}
	cout<<"�׽��ִ������"<<endl;
	if(server.bind()==false){
		cout<<"�˿ڰ�ʧ��"<<endl;
		return false;
	}
	cout<<"�˿ڰ󶨳ɹ�"<<endl;
	if(server.listen()==false){
		cout<<"�׽��ּ���ʧ��"<<endl;
		return false;
	}
	cout<<"�׽��ּ����ɹ�"<<endl;
	return true;
}
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
		memset(&pClient->overlapped,0,sizeof(pClient->overlapped));
		pClient->wsaBuf.len = NET_MAX_RECV_SIZE;
		pClient->wsaBuf.buf = pClient->szBuffer;
		pClient->iocpType=IOCP_READ;
		// ��������
		WSARecv(pClient->client,&pClient->wsaBuf,1,&recvSize,&flags,&pClient->overlapped,NULL);
		cout<<"�û�:"<<server.getip()<<"����"<<endl;
	}
	return false;
	cout<<"�����߳̽���"<<endl;
}
void Iocp::write(CInfo * info)
{
	// ���յ��ֽ���
	DWORD recvSize = 0;
	::WSASend(info->client,&info->wsaBuf,1,&recvSize,0,&info->overlapped,NULL);
}
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
	short s=NULL;
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

		switch (pClient->iocpType)
		{
			case IOCP_READ:

				memmove(&s,pClient->zBuffer,sizeof(s));

				printf("recv data from client: %s\n", pClient->zBuffer);
				if(s==10010){
					pClient->iocpType=IOCP_WRITE;
				}
				WSARecv(pClient->client,&pClient->wsaBuf,1,&recvSize,&flags,&pClient->overlapped,NULL);
				
			break;
			case IOCP_WRITE:

				
				if(s==10010){
					cout<<"�ɹ�"<<endl;
					funcMap[100](pClient);
					pClient->iocpType=IOCP_READ;
					
				}
			break;
			default:
				//We should never be reaching here, under normal circumstances.
			break;
		}
	}
	ExitThread(0);
	return 0;
}
