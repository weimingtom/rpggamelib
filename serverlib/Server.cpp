#include "Iocp.h"
#include "action.h"

Maps funcMap;
RLIList rlList;


void run(){
	SIOCP.init();
	SIOCP.startup();
}
int main(int argc, char *argv[]){
	
//=============================消息函数映射==============================
	MSGM.msgRegister(CMT_LOGIN,login);
	MSGM.msgRegister(CMT_LOGIN_SLECT_ROLE_OK,selectROK);
//==============================启动服务器===============================
	run();
return 0;
}