#include "Iocp.h"
#include "action.h"
Maps funcMap;
iodb IoRead;
iodb IoWrite;

void run(){
	SIOCP.init();
	SIOCP.startup();
}
int main(int argc, char *argv[]){
	IoRead.ioType=IOCP_READ;
	IoWrite.ioType=IOCP_WRITE;
	
//=============================��Ϣ����ӳ��==============================
	MSGM.msgRegister(10010,login);

//==============================����������===============================
	run();
return 0;
}