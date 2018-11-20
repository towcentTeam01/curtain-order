package com.towcent.curtain.order.portal.common.web;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

/**
 * TODO: 增加描述
 * 
 * @author huangtao
 * @date 2015年6月26日 上午10:11:09
 * @version 0.1.0 
 */
public class HttpServletRequestReplacedFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		ServletRequest requestWrapper = null;
		String contentType = "multipart/form-data";		
		
		//if (request.get)
		
		if (StringUtils.isNotBlank(request.getContentType()) && 
				request.getContentType().startsWith(contentType)) {
			chain.doFilter(request, response);
		} else {
			if (request instanceof HttpServletRequest) {
				String path = ((HttpServletRequest) request).getServletPath();
				if (path.contains("alipay/notify") || path.contains("wechat/notify") || path.contains("logistic/receive") 
						|| path.contains("token/callback") || path.contains("wechat/portal")) {
					//TODO
				} else {
					requestWrapper = new BodyHttpServletRequestWrapper(
							(HttpServletRequest) request);
				}
			}
			if (null == requestWrapper) {
				chain.doFilter(request, response);
			} else {
				chain.doFilter(requestWrapper, response);
			}
		}
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

}