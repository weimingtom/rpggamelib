#ifndef MSGTYPES_H
#define MSGTYPES_H
#include "Unit.h"
class MsgTypes
	{
	
	public:
		~MsgTypes(void);
		static MsgTypes & getInstance();
		int initPond(int);
	private:
		MsgTypes(void);
	private:
		vector<lp_iodb> MTPond;
		static MsgTypes Instance;
	};
#endif