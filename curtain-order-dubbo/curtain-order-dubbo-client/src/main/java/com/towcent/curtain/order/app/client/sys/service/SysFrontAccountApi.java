package com.towcent.curtain.order.app.client.sys.service;

import java.util.Map;

import com.towcent.base.common.exception.RpcException;

import com.towcent.curtain.order.app.client.sys.dto.SysFrontAccount;

/**
 * @author licheng、huangtao
 * @version 0.0.1
 * @date 2018/1/18 0018 11:38
 */
public interface SysFrontAccountApi {
	
	/**
	 * 通过Id获取账号对象.
	 * @Title getAccountById
	 * @param id
	 * @return
	 * @throws RpcException
	 */
	SysFrontAccount getAccountById(Integer id) throws RpcException;
	
	/**
	 * 通过参数获取账户对象.
	 * @Title getAccountByParams
	 * @param params 参数映射表
	 * @return
	 * @throws RpcException
	 */
	SysFrontAccount getAccountByParams(Map<String, Object> params) throws RpcException;
	
	/**
	 * 通过id获取用户的账户名.
	 * @Title getUserAccountById
	 * @param id
	 * @return
	 * @throws RpcException
	 */
	String getUserAccountById(Integer id) throws RpcException;
	
    /**
     * 检查手机号是否存在（已经被绑定）
     *
     * @param mobile 手机号
     * @param appType 账户类别(0:承运商  1:货主)
     * @return 存在返回true，不存在返回false
     * @author licheng
     * @date 2018/1/3 16:48
     * @version 0.1.0
     */
    boolean mobileIsExist(String mobile, byte appType) throws RpcException;

    /**
     * 检查邮箱是否存在（已经被绑定）
     *
     * @param email 邮箱
     * @param appType 账户类别(0:承运商  1:货主)
     * @return 存在返回true，不存在返回false
     * @author licheng
     * @date 2018/1/3 16:49
     * @version 0.1.0
     */
    boolean emailIsExist(String email, byte appType) throws RpcException;

    /**
     * 检查账户名是否存在（已经被使用）
     *
     * @param account 账户名
     * @param appType 账户类别(0:承运商  1:货主)
     * @return 存在返回true，不存在返回false
     * @author licheng
     * @date 2018/1/3 18:34
     * @version 0.1.0
     */
    boolean accountIsExist(String account, byte appType) throws RpcException;

    /**
     * 重置账户密码
     *
     * @param sysFrontAccount 带有用户id和新密码的对象
     * @return 成功返回true，失败返回false
     * @throws RpcException
     */
    boolean reset(SysFrontAccount sysFrontAccount) throws RpcException;
    
    /**
     * @Title: register
     * @Description: 账户注册
     * @param phone 账户手机号码
     * @param password 密码(md5)
     * @param appType 账户类别(0:承运商  1:货主)
     * @return 
     * @throws RpcException 
     * @return: boolean 
     */
    boolean register(String phone, String password, byte appType) throws RpcException;
    
    /**
	 * 保存账户基本信息
	 * @param sysFrontAccount
	 * @return
	 * @throws RpcException
	 * @author licheng
	 * @date 2018/2/6 0006 11:50
	 * @version 0.1.0
	 */
    boolean saveBaseInfo(SysFrontAccount sysFrontAccount) throws RpcException;
    
    /**
     * 修改账号基本资料.<br>
     * 并且在修改之后返回最新的账号信息
     * @Title updateAccount  
     * @param account  需要修改的对象
     * @return         最新的账号资料对象
     * @throws RpcException
     */
    SysFrontAccount updateAccount(SysFrontAccount account) throws RpcException;
}