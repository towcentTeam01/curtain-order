package com.towcent.curtain.order.app.server.sys.manager;

import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.towcent.base.common.exception.RpcException;
import com.towcent.base.common.exception.ServiceException;
import com.towcent.base.common.utils.Assert;
import com.towcent.base.manager.BaseCommonApi;
import com.towcent.curtain.order.app.client.sys.dto.SysFrontAccount;
import com.towcent.curtain.order.app.client.sys.service.SysFrontAccountApi;
import com.towcent.curtain.order.app.server.sys.service.SysFrontAccountService;
import com.towcent.base.service.BaseService;

/**
 * @author licheng、huangtao
 * @version 0.0.1
 * @date 2018/1/18 0018 11:39
 */
@Service
public class SysFrontAccountApiImpl extends BaseService implements SysFrontAccountApi {

	@Resource
	private BaseCommonApi baseCommonApi;
	@Resource
    private SysFrontAccountService sysFrontAccountService;
	
	@Override
	public SysFrontAccount getAccountById(Integer id) throws RpcException {
		Assert.notNull(id, "账户Id不能为空");
		try {
			return sysFrontAccountService.getAccountById(id);
		} catch (ServiceException e) {
			logger.error("查询账号对象失败", e);
            throw new RpcException("", "查询账户对象失败", e);
		}
	}

	@Override
	public SysFrontAccount getAccountByParams(Map<String, Object> params) throws RpcException {
		try {
			return sysFrontAccountService.getAccountByParams(params);
		} catch (ServiceException e) {
			logger.error("查询账号对象失败", e);
            throw new RpcException("", "查询账户对象失败", e);
		}
	}

	@Override
	public String getUserAccountById(Integer id) throws RpcException {
		SysFrontAccount account = this.getAccountById(id);
		return null == account ? "" : account.getAccount();
	}

    @Override
    public boolean mobileIsExist(String mobile, byte appType) throws RpcException {
        Assert.isNotEmpty(mobile, "mobile不能为空");
    	try {
            Map<String, Object> params = Maps.newHashMap();
            params.put("mobile", mobile);
            params.put("userType", appType + "");
            return sysFrontAccountService.findCount(params) > 0;
        } catch (ServiceException e) {
            logger.error("判断账户手机号码失败");
            throw new RpcException("", "判断账户手机号码失败", e);
        }
    }

    @Override
    public boolean emailIsExist(String email, byte appType) throws RpcException {
    	Assert.isNotEmpty(email, "email不能为空");
    	try {
            Map<String, Object> params = Maps.newHashMap();
            params.put("email", email);
            params.put("userType", appType + "");
            return sysFrontAccountService.findCount(params) > 0;
        } catch (ServiceException e) {
            logger.error("检查邮箱是否存在失败");
            throw new RpcException("", "检查邮箱是否存在失败", e);
        }
    }

    @Override
    public boolean accountIsExist(String account, byte appType) throws RpcException {
    	Assert.isNotEmpty(account, "account不能为空");
    	try {
            Map<String, Object> params = Maps.newHashMap();
            params.put("account", account);
            params.put("userType", appType + "");
            return sysFrontAccountService.findCount(params) > 0;
        } catch (ServiceException e) {
            logger.error("检查账户名失败");
            throw new RpcException("", "检查账户名失败", e);
        }
    }

    @Override
    public boolean reset(SysFrontAccount account) throws RpcException {
    	Assert.notNull(account, "账户对象不能为空");
    	Map<String, Object> params = Maps.newHashMap();
    	params.put("mobile", account.getMobile());
    	params.put("userType", account.getUserType());
    	SysFrontAccount oldAccount = this.getAccountByParams(params);
        try {
            account.setId(oldAccount.getId());
            account.setPassword(account.getPassword());
            return sysFrontAccountService.modifyById(account) > 0;
        } catch (ServiceException e) {
            logger.error("重置密码失败", e);
            throw new RpcException("", "重置密码失败", e);
        }
    }

	@Override @Transactional
	public boolean register(String phone, String password, byte appType) throws RpcException {
		Assert.isNotEmpty(phone, "手机号码不能为空");
		Assert.isNotEmpty(password, "密码不能为空");
		boolean result = false;
		try {
			SysFrontAccount sysFrontAccount = new SysFrontAccount();
			sysFrontAccount.setMobile(phone);
			sysFrontAccount.setAccount(phone);
			sysFrontAccount.setPassword(password);
			sysFrontAccount.setUserType(appType + "");
			sysFrontAccount.setCreateDate(new Date());
			sysFrontAccount.setLoginTimes(0);
			result = sysFrontAccountService.add(sysFrontAccount) > 0;

//			// 承运商
//			if (APP_TYPE_0 == appType) {
//				String carrierNo = baseCommonApi.getSerialNo("carrier_no");
//				CarrierInfo carrier = new CarrierInfo();
//				carrier.setCarrierNo(carrierNo);
//				carrier.setUserId(sysFrontAccount.getId());
//				carrier.setCreateBy(sysFrontAccount.getId());
//				carrier.setCreateDate(sysFrontAccount.getCreateDate());
//				carrier.setApproveStatus(APPROVE_STATUS_0);
//
//				result = carrierInfoService.add(carrier) > 0;
//			} else if (APP_TYPE_1 == appType) { // 货主
//				String shipperNo = baseCommonApi.getSerialNo("shipper_no");
//				ShipperInfo shipper = new ShipperInfo();
//				shipper.setShipperNo(shipperNo);
//				shipper.setUserId(sysFrontAccount.getId());
//				shipper.setCreateBy(sysFrontAccount.getId());
//				shipper.setCreateDate(sysFrontAccount.getCreateDate());
//				shipper.setApproveStatus(APPROVE_STATUS_0);
//
//				result = shipperInfoService.add(shipper) > 0;
//			}
		} catch (ServiceException e) {
			logger.error("注册失败", e);
            throw new RpcException("", "注册失败", e);
		}
		return result;
	}
	
	@Override
	public boolean saveBaseInfo(SysFrontAccount sysFrontAccount) throws RpcException {
		try {
			return sysFrontAccountService.modifyById(sysFrontAccount) > 0;
		} catch (ServiceException e) {
			logger.error("更新账号资料失败", e);
			throw new RpcException("", "更新账号资料失败", e);
		}
	}

	@Override
	public SysFrontAccount updateAccount(SysFrontAccount account) throws RpcException {
		try {
			boolean flag = sysFrontAccountService.modifyById(account) > 0;
			if (flag) {
				return sysFrontAccountService.getAccountById(account.getId());
			} else {
				return null;
			}
		} catch (ServiceException e) {
			logger.error("更新账号资料失败", e);
			throw new RpcException("", "更新账号资料失败", e);
		}
	}
}