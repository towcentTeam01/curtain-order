package com.towcent.curtain.order.app.client.sys.dto;

import java.io.Serializable;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

/**
 * 系统参数查询Vo
 * @author huangtao
 *
 */
public class SysParamQueryVo implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	/**
	 * 商户Id
	 */
	private Integer merchantId;
	
	@NotBlank(message="账号不能为空")
	private String account;
	
	// App类别(0:承运商 1:货主 2:司机)
	@NotNull(message="App类别不能为空")
	@Min(value=0, message="App应用类型只能为(0:承运商 1:货主 2:司机)")
	@Max(value=2, message="App应用类型只能为(0:承运商 1:货主 2:司机)")
	private Integer appType = 0;
	
	@NotBlank(message="设备号不能为空")
	private String deviceNo;
	
	private String deviceToken;
	
	// 手机操作系统(1:Ios 2:Andriod)
	private Byte sysType = 2;
	
	private String phoneModel;
	
	private String appVersion;
	
	private String openId;
	
	public SysParamQueryVo() {
		super();
	}
	
	public SysParamQueryVo(String account, Integer appType, String deviceNo) {
		super();
		this.account = account;
		this.appType = appType;
		this.deviceNo = deviceNo;
	}
	
	public Integer getMerchantId() {
		return merchantId;
	}

	public void setMerchantId(Integer merchantId) {
		this.merchantId = merchantId;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public Integer getAppType() {
		return appType;
	}

	public void setAppType(Integer appType) {
		this.appType = appType;
	}

	public String getDeviceNo() {
		return deviceNo;
	}

	public void setDeviceNo(String deviceNo) {
		this.deviceNo = deviceNo;
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

	public String getDeviceToken() {
		return deviceToken;
	}

	public void setDeviceToken(String deviceToken) {
		this.deviceToken = deviceToken;
	}

	public String getOpenId() {
		return openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}
}