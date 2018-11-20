package com.towcent.curtain.order.portal.common.web;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.commons.lang3.ArrayUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;

import com.towcent.base.common.mapper.JsonMapper;


/**
 * 方法拦截器，拦截Controller中的方法，记录log
 * 
 * @author huangtao
 * @date 2016年1月22日 下午2:02:54
 * @version 0.1.0 
 */
public class ControllerMethodInterceptor implements MethodInterceptor {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public Object invoke(MethodInvocation invocation) throws Throwable {
		// logger.info("Before: interceptor name: {}", invocation.getMethod().getName());
		
		Object result = invocation.proceed();
		
		StringBuffer sb = new StringBuffer("/api/");
		RequestMapping mapping = invocation.getThis().getClass().getAnnotation(RequestMapping.class);
		String[] value = mapping.value();
		if (ArrayUtils.isNotEmpty(value)) {
			sb.append(value[0]).append("/");
		}
		mapping = invocation.getMethod().getAnnotation(RequestMapping.class);
		value = mapping.value();
		if (ArrayUtils.isNotEmpty(value)) {
			sb.append(value[0]);
		}
		logger.debug("After url: {}, result: {}", sb.toString(), JsonMapper.toJsonString(result));

		return result;
	}
}