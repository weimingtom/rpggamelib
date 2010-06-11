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
		// ��������
		WSARecv(pClient->client,&pClient->wsaBuf,1,&recvSize,&flags,&pClient->overlapped,NULL);
		cout<<"�û�:"<<server.getip()<<"����"<<endl;
	}
	return false;
	cout<<"�����߳̽���"<<endl;
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
		}
		else
		{
			cout<<"����:"<<endl;
			short s=NULL;
			
			printf("recv data from client: %s\n", pClient->szBuffer);
			memmove(&s,pClient->szBuffer,sizeof(s));
			if(s==10010){
				cout<<"�ɹ�"<<endl;
				funcMap[100](pClient->szBuffer);
			}
			WSARecv(pClient->client,&pClient->wsaBuf,1,&recvSize,&flags,ptrOverlapped,NULL);
			
		}
	}
	ExitThread(0);
	return 0;
}