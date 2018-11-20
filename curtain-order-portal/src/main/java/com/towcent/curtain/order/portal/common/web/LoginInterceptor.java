package com.towcent.curtain.order.portal.common.web;

import static com.towcent.curtain.order.common.Constant.UPLOAD_URL;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.towcent.base.common.mapper.JsonMapper;
import com.towcent.base.common.redis.RedisTemplateExt;
import com.towcent.base.common.utils.SpringContextHolder;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.curtain.order.common.CacheKeyUtils;
import com.towcent.curtain.order.common.Constant;
import com.towcent.base.common.utils.SignUtils;

/**
 * 登录拦截器
 * 
 * @author huangtao
 * @date 2015年6月24日 下午2:01:22
 * @version 0.1.0 
 */
public class LoginInterceptor implements HandlerInterceptor {
	
	public static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
    
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
		String uri = request.getRequestURI();
		logger.debug("=====uri=====>" + uri);
		if (UPLOAD_URL.equals(uri)) {
			String tokenId = request.getParameter(Constant.TOKENID);
			if (StringUtils.isBlank(tokenId)) {
				PrintWriter out = response.getWriter();
				ResultVo resultVo = new ResultVo();
				resultVo.setCode(Constant.E_003);
				resultVo.setErrorMessage("缺少tokenId参数.");
				out.print(JsonMapper.toJsonString(resultVo));
				return false;
			}
			// 判断tokenId是否有效
			boolean valid = verfiyToken(tokenId);
			if (!valid) {
				PrintWriter out = response.getWriter();
				ResultVo resultVo = new ResultVo();
				resultVo.setCode(Constant.E_004);
				resultVo.setErrorMessage("Invalid tokenId");
				out.print(JsonMapper.toJsonString(resultVo));
				return false;
			}
			return true;
		}
		try {
			Map<String, String> requestParams = getParameterMapByPost(request);
			// String tokenId = request.getParameter(Constant.TOKENID);
			String tokenId = MapUtils.getString(requestParams, Constant.TOKENID);
			if (StringUtils.isBlank(tokenId)) {
				PrintWriter out = response.getWriter();
				ResultVo resultVo = new ResultVo();
				resultVo.setCode(Constant.E_003);
				resultVo.setErrorMessage("缺少tokenId参数.");
				out.print(JsonMapper.toJsonString(resultVo));
				return false;
			}
			// 判断tokenId是否有效
			boolean valid = verfiyToken(tokenId);
			if (!valid) {
				PrintWriter out = response.getWriter();
				ResultVo resultVo = new ResultVo();
				resultVo.setCode(Constant.E_004);
				resultVo.setErrorMessage("Invalid tokenId");
				out.print(JsonMapper.toJsonString(resultVo));
				return false;
			}
		} catch (Exception e) {
			logger.error("login 拦截器异常.", e);
			PrintWriter out = response.getWriter();
			ResultVo resultVo = new ResultVo();
			resultVo.setCode(Constant.E_001);
			resultVo.setErrorMessage("登录异常.");
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
	
	private boolean verfiyToken(String tokenId) {
		String key = CacheKeyUtils.getSessionKey(tokenId);
		RedisTemplateExt<String, Object> redisTemplate = SpringContextHolder.getBean("redisTemplateExt");
		return redisTemplate.exists(key);
	}
	
	public Map<String, String> getParameterMapByPost(HttpServletRequest request) throws IOException {
		String json = getRequestBodyString(request.getReader());
		return SignUtils.toJsonObject(json);
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