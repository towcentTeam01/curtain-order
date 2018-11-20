package com.towcent.curtain.order.app.server.sys.manager;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.towcent.base.common.exception.RpcException;
import com.towcent.base.common.exception.ServiceException;
import com.towcent.base.common.model.SysAppSession;
import com.towcent.base.common.redis.RedisTemplateExt;
import com.towcent.base.common.utils.Assert;
import com.towcent.base.common.utils.DateUtils;
import com.towcent.base.common.utils.IdGen;
import com.towcent.curtain.order.app.client.sys.dto.Session;
import com.towcent.curtain.order.app.client.sys.dto.SysFrontAccount;
import com.towcent.curtain.order.app.client.sys.dto.SysParamQueryVo;
import com.towcent.curtain.order.app.client.sys.service.SessionApi;
import com.towcent.curtain.order.app.server.sys.service.SysFrontAccountService;
import com.towcent.curtain.order.common.CacheKeyUtils;
import com.towcent.base.service.BaseService;
import com.towcent.base.service.SysAppSessionService;

/**
 * 移动端App session 接口实现
 * @author huangtao
 *
 */
@Service("sessionApiImpl")
public class SessionApiImpl extends BaseService implements SessionApi {

	@Resource
	SysAppSessionService sessionService;
	@Resource
	RedisTemplateExt<String, Object> redisTemplateExt;
	@Value("${session.timeout}")
	private int timeout = 30;
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public Session createSession(SysParamQueryVo vo) throws RpcException {
		this.validationObj(vo);
		Session obj = null;
		String tokenId = null;
		SysAppSession appSession = null;
		try {
			appSession = sessionService.getAppSessionByParam(vo.getMerchantId(), vo.getAccount(),
					vo.getDeviceNo(), vo.getAppType());
			if (null == appSession) {
				tokenId = IdGen.uuid();
				appSession = new SysAppSession();
				BeanUtils.copyProperties(vo, appSession);
				appSession.setTokenId(tokenId);
				appSession.setFailureTime(DateUtils.addDate(new Date(), timeout));
				appSession.setUpdateDate(new Date());
				sessionService.add(appSession);
			} else {
				tokenId = appSession.getTokenId();
			}
			String cacheKey = CacheKeyUtils.getSessionKey(tokenId);

			obj = new Session();
			BeanUtils.copyProperties(vo, obj);
			obj.setSysFrontAccount(getMemberInfoByAccount(vo.getMerchantId(), vo.getAccount(), vo.getAppType()));
			obj.setTokenId(tokenId);
			//缓存时间，单位：分钟
			long cacheTime = (appSession.getFailureTime().getTime() - new Date().getTime())/(1000*60);
			redisTemplateExt.set(cacheKey, obj, (int) cacheTime);
		} catch (ServiceException e) {
			logger.error("创建移动App session失败", e);
			throw new RpcException("创建移动App session失败", e);
		} catch (Exception e) {
			logger.error("", e);
			throw new RpcException("创建移动App session异常", e);
		}
		return obj;
	}

	@Resource
	private SysFrontAccountService accountService;

	@Override
	public String getTokenByOpenId(String openId) throws RpcException {
		Assert.isNotEmpty(openId, "openId不能为空");

		Session session = null;
		try {
			SysFrontAccount member = accountService.findByKeyValSingle("openId", openId);
			
			if (null == member || StringUtils.equals("-1", member.getAccount())) {
				return null;
			}
			
			SysParamQueryVo vo = new SysParamQueryVo(member.getAccount(), 1, openId);
			session = this.createSession(vo);
		} catch (ServiceException e) {
			logger.error("", e);
			throw new RpcException("", e);
		}
		return (null == session) ? null : session.getTokenId();
	}
	
	
	@Override
	public SysFrontAccount getMemberInfoByAccount(Integer merchantId, String account) throws RpcException {
		// 账户类型默认为0
		return getMemberInfoByAccount(merchantId, account, 0);
	}
	
	@Override
	public SysFrontAccount getMemberInfoByAccount(Integer merchantId, String account, Integer userType) throws RpcException {
		SysFrontAccount info = new SysFrontAccount();
		try {
			Map<String, Object> params = Maps.newHashMap();
			params.put("accountAll", account);  // 包含account、mobile、email
			params.put("userType", userType + "");
			params.put("merchantId", merchantId);
			List<SysFrontAccount> list = accountService.findByBiz(params);
			if (CollectionUtils.isNotEmpty(list)) {
				info = list.get(0);
			} else {
				return null;
			}
		} catch (Exception e) {
			logger.error("查询账号信息失败", e);
			throw new RpcException("查询账号信息失败", e);
		}
		return info;
	}
	
	private long getCacheTime(Integer merchantId, String account,String deviceNo,Integer appType) throws ServiceException{
		SysAppSession appSession = sessionService.getAppSessionByParam(merchantId, account, deviceNo, appType);
		Date failureTime = DateUtils.addDate(new Date(), timeout);
		if(appSession!=null) failureTime = appSession.getFailureTime();
		return (failureTime.getTime() - new Date().getTime()) / (1000 * 60);
	}
	
	@Override
	public void updateSessionAccount(Integer merchantId, String tokenId, int appType, SysFrontAccount clientAccount) throws RpcException {
		try {
			String cacheKey = CacheKeyUtils.getSessionKey(tokenId);
			Session session = (Session) redisTemplateExt.get(cacheKey);
			long cacheTime = getCacheTime(merchantId, session.getAccount(),session.getDeviceNo(),session.getAppType().intValue());
			session.setAccount(clientAccount.getAccount());
			session.setSysFrontAccount(clientAccount);
			redisTemplateExt.set(cacheKey, session, (int)cacheTime);
		} catch (ServiceException e) {
		} 
	}
}