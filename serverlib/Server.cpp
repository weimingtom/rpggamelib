#include "Iocp.h"
#include "action.h"
void run();
int main(int argc, char *argv[]){
	

//=============================消息函数映射==============================
MSGM.msgRegister(10010,login);

//==============================启动服务器===============================
	run();
return 0;
}

void run()
{
SIOCP.init();
SIOCP.startup();
}