#ifndef MSGTYPES_H
#define MSGTYPES_H
#include "Unit.h"
class MsgTypes
	{
	
	public:
		~MsgTypes(void);
		static MsgTypes & getInstance();
		int initPond(int);
		lp_iodb getiodbR();
		lp_iodb getiodbW();
	private:
		MsgTypes(void);
	private:
		vector<lp_iodb> MTPond;
		static MsgTypes Instance;
	};
#endif