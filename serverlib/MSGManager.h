#ifndef MSGMANAGER_H
#define MSGMANAGER_H
#include  "Iocp.h"

class MSGManager
	{
	public:
		~MSGManager(void);
		static MSGManager & getInstance();
		void msgListener(CInfo *);
		void msgRegister(unsigned short,action);
	private:
		MSGManager(void);
	private:
		static MSGManager Instance;
	};
#endif