#include "Iocp.h"
#include "action.h"
void run();
int main(int argc, char *argv[]){
	

//=============================��Ϣ����ӳ��==============================
	funcMap[100]=login;
	

//==============================����������===============================
	run();
return 0;
}

void run()
{
SIOCP.init();
SIOCP.startup();
}