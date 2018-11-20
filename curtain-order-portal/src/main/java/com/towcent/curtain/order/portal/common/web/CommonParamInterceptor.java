package com.towcent.curtain.order.portal.common.web;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.google.common.collect.Maps;
import com.towcent.base.common.mapper.JsonMapper;
import com.towcent.base.common.service.BasePortalService;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.curtain.order.common.Constant;
import com.towcent.base.common.utils.SignUtils;
import com.towcent.curtain.order.portal.common.vo.BaseParam;

/**
 * 参数拦截器
 * 
 * @author huangtao
 * @date 2015年6月24日 下午2:01:22
 * @version 0.1.0 
 */
public class CommonParamInterceptor extends BasePortalService implements HandlerInterceptor {
	
	public static final Logger logger = LoggerFactory.getLogger(CommonParamInterceptor.class);
    
	public static final String KEY = "sys:portal:param";
	
	/** 
     * 在业务处理器处理请求之前被调用 
     * 如果返回false 
     *     从当前的拦截器往回执行所有拦截器的afterCompletion(),再退出拦截器链 
     *  
     * 如果返回true 
     *    执行下一个拦截器,直到所有的拦截器都执行完毕 
     *    再执行被拦截的Controller 
     *    然后进入拦截器链, 
     *    从最后一个拦截器往回执行所有的postHandle() 
     *    接着再从最后一个拦截器往回执行所有的afterCompletion() 
     */ 
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		response.setCharacterEncoding("UTF-8");
		ResultVo resultVo = new ResultVo();
		logger.debug("==============执行顺序: 1、common param, url:{} ================", request.getRequestURI()); 
		if (Constant.UPLOAD_URL.equals(request.getRequestURI()) || request.getRequestURI().contains("/wechat/portal")) {
			return true;
		}
		
		// TODO GET请求  Map<String, String> requestParams = getParameterMap(request);
		Map<String, String> requestParams = getParameterMapByPost(request);
		
		logger.debug("=======param========>" + requestParams.toString());
		try {
			String clientSign = request.getParameter(Constant.SIGN);
			//参数为空
			if (MapUtils.isEmpty(requestParams)) {
				PrintWriter out = response.getWriter();
				resultVo.setCode(Constant.E_003);
				resultVo.setErrorMessage("缺少参数.");
				out.print(JsonMapper.toJsonString(resultVo));
				return false;
			} 
			BaseParam baseParam = this.parseParam(requestParams);
			if (!validationObj(baseParam, resultVo)) {
				PrintWriter out = response.getWriter();
				out.print(JsonMapper.toJsonString(resultVo));
				return false;
			}
			
			if (StringUtils.isBlank(clientSign)) {
				PrintWriter out = response.getWriter();
				resultVo.setCode(Constant.E_003);
				resultVo.setErrorMessage("URL缺少sign参数.");
				out.print(JsonMapper.toJsonString(resultVo));
				return false;
			}
			
			requestParams.remove(Constant.SIGN);
			
			String appKey = baseParam.getAppKey();
			String appSecret = SignUtils.getSecretByKey(appKey);
			String serverSign = SignUtils.getSignature(requestParams, appSecret);
			if (!clientSign.equals(serverSign)) {
				PrintWriter out = response.getWriter();
				resultVo.setCode(Constant.E_105);
				resultVo.setErrorMessage("签名sign不正确.");
				out.print(JsonMapper.toJsonString(resultVo));
				return false;
			}
		} catch (Exception e) {
			logger.error("公共参数拦截器异常.", e);
			PrintWriter out = response.getWriter();
			resultVo.setCode(Constant.E_001);
			resultVo.setErrorMessage("参数解析异常.");
			out.print(JsonMapper.toJsonString(resultVo));
			return false;
		}
		
		return true;
	}
	
	/**
	 * 在业务处理器处理请求执行完成后,生成视图之前执行的动作
	 */
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
	}
	
    /** 
     * 在DispatcherServlet完全处理完请求后被调用  
     *  
     * 当有拦截器抛出异常时,会从当前拦截器往回执行所有的拦截器的afterCompletion() 
     */ 
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	private BaseParam parseParam(Map<String, String> requestMap) {
		BaseParam param = new BaseParam();
		param.setSysType(MapUtils.getByteValue(requestMap, "sysType"));
		param.setAppType(MapUtils.getByteValue(requestMap, "appType"));
		param.setDeviceNo(MapUtils.getString(requestMap, "deviceNo"));
		param.setDeviceToken(MapUtils.getString(requestMap, "deviceToken"));
		param.setPhoneModel(MapUtils.getString(requestMap, "phoneModel"));
		param.setVersionNo(MapUtils.getIntValue(requestMap, "versionNo"));
		param.setAppVersion(MapUtils.getString(requestMap, "appVersion"));
		param.setOsVersion(MapUtils.getString(requestMap, "osVersion"));
		param.setTokenId(MapUtils.getString(requestMap, "tokenId"));
		param.setAppKey(MapUtils.getString(requestMap, "appKey"));
		param.setTimestamp(MapUtils.getString(requestMap, "timestamp"));
		return param;
	}
	
	@SuppressWarnings("rawtypes")
	public static Map<String, String> getParameterMap(HttpServletRequest request) {
		// 参数Map
		Map properties = request.getParameterMap();
		// 返回值Map
		Map<String, String> returnMap = new TreeMap<String, String>();
		Iterator entries = properties.entrySet().iterator();
		Map.Entry entry;
		String name = "";
		String value = "";
		while (entries.hasNext()) {
			entry = (Map.Entry) entries.next();
			name = (String) entry.getKey();
			Object valueObj = entry.getValue();
			if (null == valueObj) {
				value = "";
			} else if (valueObj instanceof String[]) {
				String[] values = (String[]) valueObj;
				for (int i = 0; i < values.length; i++) {
					value = values[i] + ",";
				}
				value = value.substring(0, value.length() - 1);
			} else {
				value = valueObj.toString();
			}
			returnMap.put(name, value);
		}
		return returnMap;
	}
	
	public Map<String, String> getParameterMapByPost(HttpServletRequest request) throws IOException {
		String json = getRequestBodyString(request.getReader());
		if(StringUtils.isNotEmpty(json))
			return SignUtils.toJsonObject(json);
		else
			return Maps.newHashMap();	
	}
	
	/**
	 * 获取request Body中的数据
	 * @param br
	 * @return
	 */
	public String getRequestBodyString(BufferedReader br) {
		String inputLine;
		String str = "";
		try {
			while ((inputLine = br.readLine()) != null) {
				str += inputLine;
			}
			br.close();
		} catch (IOException e) {
			logger.error("Read Request Body IOException.", e);
		}
		return str;
	}
}