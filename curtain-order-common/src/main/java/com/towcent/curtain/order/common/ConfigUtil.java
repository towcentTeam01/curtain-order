package com.towcent.curtain.order.common;

import com.google.common.collect.Maps;
import com.towcent.base.common.utils.StringUtils;

import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * 获取spring中注入的属性配置项
 */
@Lazy(false)
@Component
public class ConfigUtil implements InitializingBean {
	
	private static Map<String, String> map = Maps.newHashMap();

	public static String getUrlHeader() {
		return map.get("urlHeader");
	}
	
	/**
	 * 判断支付测试标识.
	 * @Title getPayTestFlag
	 * @return
	 */
	public static boolean getPayTestFlag() {
		String flag = MapUtils.getString(map, "payTestFlag", "true");
		return StringUtils.equalsIgnoreCase(flag, "true");
	}
	
	/**
	 * 获取钱包充值支付同步返回地址.
	 * @Title getPayRechargeReturnUrl
	 * @return
	 */
	public static String getPayRechargeReturnUrl() {
		return MapUtils.getString(map, "payRechargeReturnUrl");
	}
	
	/**
	 * 获取微信支付商户证书路径.
	 * @Title getPayWxCertPath
	 * @return
	 */
	public static String getPayWxCertPath() {
		return MapUtils.getString(map, "payWxCertPath");
	}
	
	@Override
	public void afterPropertiesSet() throws Exception {
		map.put("urlHeader", urlHeader);
		map.put("payTestFlag", payTestFlag);
		map.put("payRechargeReturnUrl", payRechargeReturnUrl);
		map.put("payWxCertPath", payWxCertPath);
	}
	
	@Value("${image.url.header}")
	private String urlHeader;
	
	@Value("${pay.test.flag}")
	private String payTestFlag;
	
	@Value("${pay.recharge.return.url}")
	private String payRechargeReturnUrl;
	
	@Value("${pay.wx.cert.path}")
	private String payWxCertPath;
}