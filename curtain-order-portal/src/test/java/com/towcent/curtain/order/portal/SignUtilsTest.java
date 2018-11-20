package com.towcent.curtain.order.portal;

import java.io.IOException;
import java.util.Map;

import com.towcent.base.common.utils.SignUtils;

/**
 * TODO: 增加描述
 * 
 * @author huangtao
 * @date 2015年6月29日 下午2:42:27
 * @version 0.1.0 
 * @copyright zuojian.com
 */
public class SignUtilsTest {
	
	/** 
	 * appKey = 888888 
	 */
	static String secret = "44d6d569341947ec947c711a18574de5";
	
	public static String getSign(String json) throws IOException {
		Map<String, String> map = SignUtils.toJsonObject(json);
		return SignUtils.getSignature(map, secret);
	}
	
}