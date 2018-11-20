package com.towcent.curtain.order.portal.common.utils;

import com.towcent.base.common.redis.RedisTemplateExt;
import com.towcent.base.common.utils.SpringContextHolder;
import com.towcent.curtain.order.app.client.sys.dto.Session;
import com.towcent.curtain.order.app.client.sys.dto.SysFrontAccount;
import com.towcent.curtain.order.common.CacheKeyUtils;
import com.towcent.curtain.order.portal.common.vo.BaseParam;

/**
 * 
 * @ClassName: UserUtils 
 * @Description: 用户操作相关工具类
 *
 * @author huangtao
 * @date 2018年1月16日 上午9:15:13
 * @version 1.0.0
 * @Copyright: 2018 www.songywang.com Inc. All rights reserved. 
 * 注意：本内容仅限于深圳市众旺网络科技有限公司内部传阅，禁止外泄以及用于其他的商业项目
 */
public class UserUtils {
	
	/**
	 * 通过tokenId获取session对象
	 * 
	 * @param tokenId
	 * @return
	 */
	public static Session getUser(String tokenId) {
		String cacheKey = CacheKeyUtils.getSessionKey(tokenId);
		RedisTemplateExt<String, Object> redisTemplate = SpringContextHolder.getBean("redisTemplateExt");
		return  (Session) redisTemplate.get(cacheKey);
	}

	/**
	 * 从Session获取用户信息
	 * @param vo
	 * @return
	 */
	public static SysFrontAccount getUserAccount(BaseParam vo) {
		Session session = getUser(vo.getTokenId());
		return session.getSysFrontAccount();
	}
	
	/**
	 * 从Session获取用户信息
	 * @param vo
	 * @return
	 */
	public static String getOpenId(BaseParam vo) {
		Session session = getUser(vo.getTokenId());
		return session.getOpenId();
	}
}