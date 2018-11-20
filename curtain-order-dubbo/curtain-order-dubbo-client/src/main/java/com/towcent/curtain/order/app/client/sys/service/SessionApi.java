package com.towcent.curtain.order.app.client.sys.service;


import com.towcent.base.common.exception.RpcException;
import com.towcent.curtain.order.app.client.sys.dto.Session;
import com.towcent.curtain.order.app.client.sys.dto.SysFrontAccount;
import com.towcent.curtain.order.app.client.sys.dto.SysParamQueryVo;

/**
 * 
 * App Session 接口
 * 
 * @author huangtao
 *
 */
public interface SessionApi {
	
	/**
	 * 创建移动App session <br>
	 * 1. Session默认10天有效期 <br>
	 * 2. 账号、设备好、App类型 确定唯一tokenId <br>
	 * @param vo
	 * @return
	 * @throws RpcException
	 */
	Session createSession(SysParamQueryVo vo) throws RpcException;
	
	/**
	 * 通过openId获取tokenId
	 * @param openId
	 * @return
	 * @throws RpcException
	 */
	String getTokenByOpenId(String openId) throws RpcException;
	
	/**
	 * 根据账号获取会员信息  (默认获取userType=0)
	 * @param account 手机号码
	 * @return
	 * @throws RpcException
	 */
	SysFrontAccount getMemberInfoByAccount(Integer merchantId, String account) throws RpcException;
	
	/**
	 * 根据账号获取会员信息
	 * @param account 手机号码
	 * @param userType 账号类型
	 * @return
	 * @throws RpcException
	 */
	SysFrontAccount getMemberInfoByAccount(Integer merchantId, String account, Integer userType) throws RpcException;
	
	void updateSessionAccount(Integer merchantId, String tokenId, int appType, SysFrontAccount clientAccount) throws RpcException;
	
}