#ifndef MSGTYPE_H
#define MSGTYPE_H

/**
* 登陆
* 消息(U2) 账号(32) 密码(32)
**/
#define CMT_LOGIN 10010
/**
* 返回登陆状态
* 消息(U2) 状体(UChar1)   0为密码错误 1用户名错误 2为验证码错误 3为登陆成功
*/
#define SMT_LOGIN 10011
/**
* 返回选择列表
* 消息(U2) 角色的个数(U1) [ID(UInt4) 种族(UChar1) 性别(UChar1) 名称(14)]
*/
#define SMT_POST_SELECT_ROLE 10012
/**
* 选择成功
* 消息(U2) 角色ID(UInt4)
*/
#define CMT_LOGIN_SLECT_ROLE_OK 10013
/**
* 角色所在地图
* 消息(U2) 地图ID(UChar1)
*/
#define SMT_POST_MAPID 10014

#endif