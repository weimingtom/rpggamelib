#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include "Winsock2.h"
#pragma comment (lib,"WS2_32.lib")
using namespace std;

void CreateWorkerThreads();
DWORD WINAPI WorkerThread(LPVOID pVoid);
HANDLE hand;
struct sockaddr_in client;
int clientSize = sizeof(client);
struct _OVERLAPPELUS
	{
	SOCKET      socket;                    
	char        InBuffer[9999];   // ����
	OVERLAPPED  ovIn;         
	int         nOutBufIndex;       
	char        OutBuffer[1024];  // ���
	OVERLAPPED  ovOut;
	DWORD       dwWritten;
	}OVERLAPPELUS, *LPOVERLAPPELUS;
_OVERLAPPELUS aa[100];
int i=0;
int main(int argc,char* argv[]){
	SOCKET server;
	struct sockaddr_in tcpddr;
	int Err;
	int bErr;
	WSAData wsadata;

	tcpddr.sin_family = AF_INET;
	tcpddr.sin_addr.s_addr = inet_addr("0.0.0.0"); 
	tcpddr.sin_port = htons(2018);

		  
	
	hand = CreateIoCompletionPort(INVALID_HANDLE_VALUE, NULL,0,0);
	if(hand==NULL){
		cout<<"IOCP����ʧ��"<<endl;
		return 1;
	}
	CreateWorkerThreads();

	Err=WSAStartup(MAKEWORD(2,8),&wsadata);
	if (Err!=0)
	{
		cout<<"socket ��ʼ��ʧ��!"<<Err<<endl;
		WSACleanup();
		return Err;
	}
	server=WSASocket(AF_INET, SOCK_STREAM, 0, NULL, 0,WSA_FLAG_OVERLAPPED);
	bErr=bind(server,(SOCKADDR*)&tcpddr,sizeof(tcpddr));
	/*switch(bErr){
		case SOCKET_ERROR:

		break;
		case 
		
		break;
	}*/
	listen(server,4);
	while (TRUE){
		OVERLAPPELUS.socket=WSAAccept(server,(SOCKADDR *) &client, &clientSize,NULL,0);
		cout<<"�û�:"<<inet_ntoa(client.sin_addr)<<endl;
		aa[i]=OVERLAPPELUS;
		i++;
	}


	PostQueuedCompletionStatus(hand,0,NULL,NULL);
	closesocket(server);
	return 0;
}

void CreateWorkerThreads(){
	SYSTEM_INFO  sysinfo;
	DWORD        dwThreadId;
	DWORD        dwThreads;
	DWORD        i;

	GetSystemInfo(&sysinfo);
	dwThreads = sysinfo.dwNumberOfProcessors * 2 + 2;
	for (i=0; i<dwThreads; i++)
		{
		HANDLE hThread;
		hThread = CreateThread(NULL, 0, WorkerThread, NULL, 0, &dwThreadId);
		CloseHandle(hThread);
		}
	}
// ÿһ�������̴߳����￪ʼ.
DWORD WINAPI WorkerThread(LPVOID pVoid)
	{
	BOOL    bResult;
	DWORD   dwNumRead;
	struct _OVERLAPPELUS *pCntx;
	LPOVERLAPPED lpOverlapped = NULL;

	UNREFERENCED_PARAMETER(pVoid);

	// ����ѭ���� I/O completion port ��ȡ��Ϣ.
	while (true)
		{
		bResult = GetQueuedCompletionStatus(hand, &dwNumRead, (DWORD*)&pCntx, &lpOverlapped, INFINITE);

		if (bResult == FALSE && lpOverlapped == NULL)
			{
			printf("WorkerThread - GetQueuedCompletionStatus()����.\n");
			}
		else if (bResult == FALSE && lpOverlapped != NULL)
			{
			fprintf(stderr,"�û��������˳�.\n"); 
			}
		else if (dwNumRead == 0)
			{    
			fprintf(stderr, "�û��Ѿ��˳�.\n");
			fprintf(stderr, "------------------.\n");
			}
		else
			{
			printf("recv data from client: %s\n", pCntx->InBuffer);
			}
		}
	ExitThread(0);
	return 0;
	}
