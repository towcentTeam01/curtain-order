package com.towcent.curtain.order.portal.client;

import java.io.IOException;

import com.towcent.curtain.order.portal.common.vo.BaseParam;
import com.towcent.curtain.order.portal.sys.vo.input.LoginParamVo;
import org.apache.commons.lang3.StringUtils;

import com.fasterxml.jackson.databind.JsonNode;
import com.towcent.base.common.mapper.JsonMapper;
import com.towcent.base.common.utils.Md5Utils;
import com.towcent.curtain.order.portal.sys.vo.input.SmsSendParamVo;

/**
 * Http Client Test基类
 * 
 * @author huangtao
 * @date 2015年7月6日 下午12:00:35
 * @version 0.1.0 
 * @copyright zuojian.com
 */
public class BaseAppTest extends BaseClientTest {
	
	public static final String ACCOUNT = "18666296035";
	
	public static final String PASSWD = "a123456";
	
	private String account;
	private String passwd;
	
	@Override
	public void setInterfaceType(BaseParam param) {
		
	}
	
	@Override
	public void setLoginFlag(BaseParam param) throws IOException {
		param.setTokenId(dynamicQueryTokenId());
	}
	
	/**
	 * 动态获取Token
	 * @return
	 * @throws IOException 
	 */
	private String dynamicQueryTokenId() throws IOException {
		String path = "member/memberAccount/login";
		LoginParamVo paramVo = new LoginParamVo();
		super.setCommonParam(paramVo);
		paramVo.setAccount(getAccount());
		paramVo.setPassword(Md5Utils.encryption(getPasswd()));
		String context = sendHttpForNotLog(paramVo, path);
		JsonNode node = (JsonNode) JsonMapper.fromJsonString(context, JsonNode.class);
		String tokenId = node.findValue("data").findValue("tokenId").asText();
		System.out.println("动态获取tokenId : " + tokenId);
		return tokenId;
	}
	
	/**
	 * 模拟用户发送验证码
	 * @return 默认返回测试验证码9999
	 * @throws IOException 
	 */
	public String simulationSendSms(String phone, byte type) throws IOException {
		String path = "sys/sms/send";
		SmsSendParamVo paramVo = new SmsSendParamVo();
		this.setCommonParam(paramVo);
		paramVo.setPhone(phone);
		paramVo.setType(type);
		String context = sendHttpForNotLog(paramVo, path);
		JsonNode node = (JsonNode) JsonMapper.fromJsonString(context, JsonNode.class);
		String code = node.findValue("code").asText();
		if ("000".equals(code)) {
			System.out.println("模拟发送短信成功!");
			return "9999";
		} else {
			System.out.println("模拟发送短信失败!");
			return "";
		}
	}
	
	public static void main(String[] args) {
		System.out.println(Md5Utils.encryption("appKey=888888appType=appVersion=0.0.1deviceNo=865982025170278deviceToken=23fc08c4 332168b4 4f973c95 df44321f 3559c85f 45c532b2 9e6fe7bb 50c439c3merchantId=osVersion=9.2.1phoneModel=iphone 6 plusstructureNo=132sysType=1timestamp=20170228171657228tokenId=05cac797282e48a4a4c55057eee110ddversionNo=144d6d569341947ec947c711a18574de5"));
	}
	
	public String getAccount() {
		if (StringUtils.isNotBlank(account))
			return account;
		return ACCOUNT;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPasswd() {
		if (StringUtils.isNotBlank(passwd))
			return passwd;
		return PASSWD;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	static {
		descMap.put("member/memberAccount/login", "模拟用户登录");
	}
}