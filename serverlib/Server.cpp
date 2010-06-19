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
	
//=============================消息函数映射==============================
	MSGM.msgRegister(10010,login);

//==============================启动服务器===============================
	run();
return 0;
}