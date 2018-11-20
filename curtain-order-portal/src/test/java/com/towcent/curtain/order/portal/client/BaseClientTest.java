package com.towcent.curtain.order.portal.client;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Date;
import java.util.Map;

import com.towcent.base.common.utils.SignUtils;
import com.towcent.curtain.order.common.Constant;

import com.towcent.curtain.order.portal.common.vo.BaseParam;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;

import com.fasterxml.jackson.databind.JsonNode;
import com.google.common.collect.Maps;
import com.towcent.base.common.mapper.JsonMapper;
import com.towcent.base.common.utils.BaseHttpClient;
import com.towcent.base.common.utils.DateUtils;
import com.towcent.curtain.order.portal.SignUtilsTest;

/**
 * Http Client Test基类
 * 
 * @author huangtao
 * @date 2015年7月6日 下午12:00:35
 * @version 0.1.0 
 * @copyright zuojian.com
 */
public abstract class BaseClientTest {
	
	/** appKey */
	public static final String APP_KEY = "888888";
	/** appKey 密钥 */
	public static final String APP_SECRET = "44d6d569341947ec947c711a18574de5";
	
	public static final String LOCAL = "http://localhost:8068/api/";
	public static final String DEV = "";
	public static final String TEST = "";
	public static final String PRO = "";
	
	protected static final Map<String, String> descMap = Maps.newHashMap();
	
	/**
	 * 补充公共接口参数 
	 * @param param 
	 */
	public void setCommonParam(BaseParam param) {
		param.setSysType(NumberUtils.BYTE_ONE);      // 设备类型 (1:IOS 2:Android)
		param.setDeviceNo("865982025170278");        // 设备号
		param.setDeviceToken("23fc08c4 332168b4 4f973c95 df44321f 3559c85f 45c532b2 9e6fe7bb 50c439c3"); // IOS推送标识
		param.setPhoneModel("iphone 6 plus");        // 手机型号
		param.setVersionNo(NumberUtils.INTEGER_ONE); // 版本序号
		param.setAppVersion("0.0.1");                // APP版本
		param.setOsVersion("9.2.1");                 // 操作系统版本
		param.setAppType(Constant.APP_TYPE_0);
		param.setAppKey(APP_KEY);                    
		param.setTimestamp(DateUtils.formatDate(new Date(), "yyyyMMddHHmmssSSS"));
	}
	
	/**
	 * 设置接口类型 ()
	 * @param param
	 */
	public abstract void setInterfaceType(BaseParam param);
	
	/**
	 * 设置登录标识
	 * @param param
	 */
	public abstract void setLoginFlag(BaseParam param) throws IOException;
	
	protected String appendUrl(String path) {
		String env = getEnv();
		if (StringUtils.endsWithIgnoreCase(env, "local")) {
			System.out.println("本地环境:");
			return LOCAL + path;
		} else if (StringUtils.endsWithIgnoreCase(env, "test")) {
			System.out.println("测试环境:");
			return TEST + path;
		} else if (StringUtils.endsWithIgnoreCase(env, "dev")) {
			System.out.println("开发联调环境:");
			return DEV + path;
		} else if (StringUtils.endsWithIgnoreCase(env, "pro")) {
			System.out.println("生产环境:");
			return PRO + path;
		} else {
			return DEV + path;
		}
	}
	
	/**
	 * 读取环境字符串 [dev:开发联调环境  test:测试环境 local:本地环境]
	 * @return 
	 * @throws IOException
	 */
	private String getEnv() {
		String filepath = BaseClientTest.class.getResource("/").getPath() + "env";
		String env = this.readerFirstLine(filepath);
		return StringUtils.isBlank(env) ? "dev" : StringUtils.trimToEmpty(env);
	}
	
	protected String sendHttp(BaseParam paramVo, String path) throws IOException {
		System.out.println(StringUtils.center(MapUtils.getString(descMap, path) + " start", 120, "="));
		String json = JsonMapper.toJsonString(paramVo);
		String sign = SignUtilsTest.getSign(json);
		String url = appendUrl(path) + "?sign=" + sign;
		System.out.println("url : " + url);
		System.out.println("param : " + json);
		String content = BaseHttpClient.sendHttpMsg(url, json, null);
		System.out.println(StringUtils.center(MapUtils.getString(descMap, path) + " end..", 120, "="));
		return content;
	}
	
	public String sendHttpFile(BaseParam paramVo, String path, String filePath) throws IOException {
		System.out.println(StringUtils.center(MapUtils.getString(descMap, path) + " start", 120, "="));
		String json = JsonMapper.toJsonString(paramVo);
		String sign = SignUtilsTest.getSign(json);
		String url = appendUrl(path) + "?" + getUrlParamsByMap(json) + "&sign=" + sign;
		url = url.replaceAll(" ", "%20");
		System.out.println("url : " + url);
		String content = BaseHttpClient.sendHttpFile(url, filePath);
		System.out.println(StringUtils.center(MapUtils.getString(descMap, path) + " end..", 120, "="));
		return content;
	}
	
	/**
	 * 不打日志
	 * @param paramVo
	 * @param path
	 * @return
	 * @throws IOException
	 */
	protected String sendHttpForNotLog(BaseParam paramVo, String path) throws IOException {
		String json = JsonMapper.toJsonString(paramVo);
		String sign = SignUtilsTest.getSign(json);
		String url = appendUrl(path) + "?sign=" + sign;
		String content = BaseHttpClient.sendHttpMsg(url, json, null);
		return content;
	}
	
	/**
	 * 解析返回码
	 * @param context {"data":2,"code":"000","errorMessage":"成功"}
	 * @return
	 */
	protected String parseResultCode(String context) {
		JsonNode node = (JsonNode) JsonMapper.fromJsonString(context, JsonNode.class);
		return node.findValue("code").asText();
	}
	
	/**
	 * 读取文件的第一行
	 * @param fileName
	 * @return
	 */
	private String readerFirstLine(String fileName) {
		String v = null;
		BufferedReader br = null;
		InputStreamReader isr = null;
		try {
			isr = new InputStreamReader(new FileInputStream(fileName));
			br = new BufferedReader(isr);
			v = br.readLine();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (null != isr) {
				try {
					isr.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (null != br) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return v;
	}
	
	/** 
	 * 将map转换成url 
	 * @param map 
	 * @return 
	 */  
	public String getUrlParamsByMap(String json) {  
		Map<String, String> map = SignUtils.toJsonObject(json);
		if (map == null) {  
	        return "";  
	    }  
	    StringBuffer sb = new StringBuffer();  
	    for (Map.Entry<String, String> entry : map.entrySet()) {  
	        sb.append(entry.getKey() + "=" + entry.getValue());  
	        sb.append("&");  
	    }  
	    String s = sb.toString();  
	    if (s.endsWith("&")) {  
	        s = StringUtils.substringBeforeLast(s, "&");  
	    }  
	    return s;  
	}
}