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
	MSGM.msgRegister(10010,login);

//==============================����������===============================
	run();
return 0;
}