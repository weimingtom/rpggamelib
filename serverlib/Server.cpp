#include "Iocp.h"
#include "action.h"

Maps funcMap;
RLIList rlList;


void run(){
	SIOCP.init();
	SIOCP.startup();
}
int main(int argc, char *argv[]){
	
//=============================��Ϣ����ӳ��==============================
	MSGM.msgRegister(CMT_LOGIN,login);
	MSGM.msgRegister(CMT_LOGIN_SLECT_ROLE_OK,selectROK);
//==============================����������===============================
	run();
return 0;
}