#ifndef MSGTYPE_H
#define MSGTYPE_H

/**
* ��½
* ��Ϣ(U2) �˺�(32) ����(32)
**/
#define CMT_LOGIN 10010
/**
* ���ص�½״̬
* ��Ϣ(U2) ״��(UChar1)   0Ϊ������� 1�û������� 2Ϊ��֤����� 3Ϊ��½�ɹ�
*/
#define SMT_LOGIN 10011
/**
* ����ѡ���б�
* ��Ϣ(U2) ��ɫ�ĸ���(U1) [ID(UInt4) ����(UChar1) �Ա�(UChar1) ����(14)]
*/
#define SMT_POST_SELECT_ROLE 10012
/**
* ѡ��ɹ�
* ��Ϣ(U2) ��ɫID(UInt4)
*/
#define CMT_LOGIN_SLECT_ROLE_OK 10013
/**
* ��ɫ���ڵ�ͼ
* ��Ϣ(U2) ��ͼID(UChar1)
*/
#define SMT_POST_MAPID 10014

#endif