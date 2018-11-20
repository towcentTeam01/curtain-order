package com.towcent.curtain.order.app.client.sys.dto;

import java.io.Serializable;

/**
 * 移动端session对象(保存相关账户信息、以及角色等信息)
 * 
 * @author huangtao
 * @date 2015年11月19日 下午4:20:29
 * @version 0.1.0 
 */
public class Session implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	// sessionId
	private String tokenId;
	
	private String account;
	
	// App类别(1:客户端)
	private Byte appType = 1;
	
	private String deviceNo;
	
	private String deviceToken;
	
	private Byte sysType = 2;
	
	private String phoneModel;
	
	private String appVersion;
	
	private String openId;
	
	/** 会员账户  */
	private SysFrontAccount sysFrontAccount;
	
	public String getTokenId() {
		return tokenId;
	}
	
	public void setTokenId(String tokenId) {
		this.tokenId = tokenId;
	}
	
	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public Byte getAppType() {
		return appType;
	}

	public void setAppType(Byte appType) {
		this.appType = appType;
	}

	public String getDeviceNo() {
		return deviceNo;
	}

	public void setDeviceNo(String deviceNo) {
		this.deviceNo = deviceNo;
	}

	public String getDeviceToken() {
		return deviceToken;
	}

	public void setDeviceToken(String deviceToken) {
		this.deviceToken = deviceToken;
	}

	public Byte getSysType() {
		return sysType;
	}

	public void setSysType(Byte sysType) {
		this.sysType = sysType;
	}

	public String getPhoneModel() {
		return phoneModel;
	}

	public void setPhoneModel(String phoneModel) {
		this.phoneModel = phoneModel;
	}

	public String getAppVersion() {
		return appVersion;
	}

	public void setAppVersion(String appVersion) {
		this.appVersion = appVersion;
	}

	/**
	 * sysFrontAccount.
	 *
	 * @return the sysFrontAccount
	 */
	public SysFrontAccount getSysFrontAccount() {
		return sysFrontAccount;
	}

	/**
	 * sysFrontAccount.
	 *
	 * @param sysFrontAccount the sysFrontAccount to set
	 */
	public void setSysFrontAccount(SysFrontAccount sysFrontAccount) {
		this.sysFrontAccount = sysFrontAccount;
	}

	public String getOpenId() {
		return openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}
}