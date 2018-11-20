package com.towcent.curtain.order.portal.sys.biz.impl;

import static com.towcent.base.common.constants.BaseConstant.E_001;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.towcent.base.common.exception.RpcException;
import com.towcent.base.common.model.SmsParamDto;
import com.towcent.base.common.service.BasePortalService;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.manager.SmsNotifyApi;
import com.towcent.base.wx.service.WeixinService;
import com.towcent.curtain.order.app.client.sys.dto.Session;
import com.towcent.curtain.order.app.client.sys.dto.SysFrontAccount;
import com.towcent.curtain.order.app.client.sys.dto.SysParamQueryVo;
import com.towcent.curtain.order.app.client.sys.service.SessionApi;
import com.towcent.curtain.order.app.client.sys.service.SysFrontAccountApi;
import com.towcent.curtain.order.common.Constant;
import com.towcent.curtain.order.portal.common.utils.UserUtils;
import com.towcent.curtain.order.portal.common.vo.BaseParam;
import com.towcent.curtain.order.portal.sys.biz.MemberAccountService;
import com.towcent.curtain.order.portal.sys.vo.input.MemberAccountBaseInfoIn;
import com.towcent.curtain.order.portal.sys.vo.input.MemberAccountFastLoginIn;
import com.towcent.curtain.order.portal.sys.vo.input.MemberAccountLoginIn;
import com.towcent.curtain.order.portal.sys.vo.input.MemberAccountPhoneExistIn;
import com.towcent.curtain.order.portal.sys.vo.input.MemberAccountRegisterIn;
import com.towcent.curtain.order.portal.sys.vo.input.MemberAccountResetIn;
import com.towcent.curtain.order.portal.sys.vo.input.MemberAccountSaveBaseInfoIn;
import com.towcent.curtain.order.portal.sys.vo.input.MemberAccountUpdatePasswdIn;
import com.towcent.curtain.order.portal.sys.vo.input.MemberAccountUpdatePhoneIn;
import com.towcent.curtain.order.portal.sys.vo.input.MemberAccountUpdateWithdrawPassIn;
import com.towcent.curtain.order.portal.sys.vo.output.MemberAccountBaseInfoOut;
import com.towcent.curtain.order.portal.sys.vo.output.MemberAccountLoginOut;
import com.towcent.curtain.order.portal.sys.vo.output.MemberAccountPhoneExistOut;

import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.mp.bean.result.WxMpOAuth2AccessToken;

/**
 * MemberAccountServiceImpl
 *
 * @author huangtao
 * @version 0.0.3
 */
@Service
public class MemberAccountServiceImpl extends BasePortalService implements MemberAccountService {

    @Resource
    private SessionApi sessionApi;
    @Resource
    private SmsNotifyApi smsNotifyApi;
    @Resource
    private SysFrontAccountApi sysFrontAccountApi;
    @Autowired
	private WeixinService wxService;
    // @Resource
    // private NoticeApi noticeApi;

    @Override
    public ResultVo login(MemberAccountLoginIn paramIn) {
        ResultVo resultVo = new ResultVo();
        if (!validationObj(paramIn, resultVo)) {
            return resultVo;
        }
        try {
            // 先查询会员信息
            SysFrontAccount member = sessionApi.getMemberInfoByAccount(paramIn.getMerchantId(), paramIn.getAccount(), paramIn.getAppType().intValue());
            if (member == null) {
                return assemblyVo(resultVo, E_001, "账号不存在");
            }

            // 验证密码
            if (!StringUtils.endsWithIgnoreCase(paramIn.getPassword(),
                    member.getPassword()) && StringUtils.isNotEmpty(paramIn.getPassword())) {
                return assemblyVo(resultVo, E_001, "密码不正确");
            }
            // FIXME 需不需要增加锁定用户账号的功能
            
            MemberAccountLoginOut outParam = this.createLoginObjForOK(member, paramIn, paramIn.getCode());
            resultVo.setData(outParam);
        } catch (Exception e) {
            assemblyVo(resultVo, E_001, "登录失败");
            logger.error("登录失败", e);
        }
        return resultVo;
    }

    @Override
    public ResultVo fastLogin(MemberAccountFastLoginIn paramIn) {
        ResultVo resultVo = new ResultVo();
        if (!validationObj(paramIn, resultVo)) {
            return resultVo;
        }
        try {
            // 先查询会员信息
            SysFrontAccount member = sessionApi.getMemberInfoByAccount(paramIn.getMerchantId(), paramIn.getAccount(), paramIn.getAppType().intValue());
            if (member == null) {
                return assemblyVo(resultVo, E_001, "账号不存在");
            }

            // 验证密码
            SmsParamDto smsParam = new SmsParamDto();
            smsParam.setMobile(paramIn.getAccount());
            smsParam.setSecurityCode(paramIn.getSecurityCode());
            smsParam.setSmsType(Constant.SMS_TYPE_2);
            if (!smsNotifyApi.verifySmsCode(smsParam)) {
                return assemblyVo(resultVo, E_001, "验证码不正确");
            }

            MemberAccountLoginOut outParam = this.createLoginObjForOK(member, paramIn, paramIn.getCode());
            resultVo.setData(outParam);
        } catch (Exception e) {
            assemblyVo(resultVo, E_001, "登录失败");
            logger.error("登录失败", e);
        }
        return resultVo;
    }
    
    /**
     * 返回登录成功之后需要的对象.
     * @Title createLoginObjForOK
     * @param member   会员对象
     * @param paramIn  接口入参
     * @param wxCode   微信code 再非公众号环境下为空
     * @return
     * @throws WxErrorException
     * @throws RpcException
     */
    private MemberAccountLoginOut createLoginObjForOK(SysFrontAccount member, BaseParam paramIn, String wxCode) throws WxErrorException, RpcException {
    	SysParamQueryVo queryVo = new SysParamQueryVo();
        queryVo.setDeviceNo(paramIn.getDeviceNo());
        queryVo.setAppType(paramIn.getAppType().intValue());
        queryVo.setAppVersion(paramIn.getAppVersion());
        queryVo.setPhoneModel(paramIn.getPhoneModel());
        queryVo.setSysType(paramIn.getSysType());
        queryVo.setDeviceToken(paramIn.getDeviceToken());
        queryVo.setAccount(member.getAccount());
        //根据微信code换取openId 
        String openId = "";
        if(StringUtils.isNotEmpty(wxCode)){
        	WxMpOAuth2AccessToken authToken = wxService.oauth2getAccessToken(wxCode);
			openId = authToken.getOpenId();
			logger.info("user openId ： " + openId);
        }
        queryVo.setOpenId(openId);
        Session obj = sessionApi.createSession(queryVo);
        MemberAccountLoginOut outParam = new MemberAccountLoginOut();
        outParam.setTokenId(obj.getTokenId());
        outParam.setNickName(member.getNickName());
        outParam.setRealName("");
        outParam.setIcon(member.getPortrait());
        outParam.setOpenId(openId);
        outParam.setUserId(member.getId());
        return outParam;
    }
    
    @Override
    public ResultVo reset(MemberAccountResetIn paramIn) {
        ResultVo resultVo = new ResultVo();
        if (!validationObj(paramIn, resultVo)) {
            return resultVo;
        }
        try {
            SmsParamDto spd = new SmsParamDto();
            spd.setSmsType(Constant.SMS_TYPE_3);
            spd.setMobile(paramIn.getPhone());
            spd.setSecurityCode(paramIn.getSecurityCode());
            if (!smsNotifyApi.verifySmsCode(spd)) {
                return assemblyVo(resultVo, E_001, "验证码不正确");
            }
            SysFrontAccount sysFrontAccount = new SysFrontAccount();
            sysFrontAccount.setMobile(paramIn.getPhone());
            sysFrontAccount.setPassword(paramIn.getPassword());
            sysFrontAccount.setUserType(paramIn.getAppType()+"");
            if (!sysFrontAccountApi.reset(sysFrontAccount)) {
                assemblyVo(resultVo, E_001, "重置失败");
            }
        } catch (RpcException e) {
            assemblyVo(resultVo, E_001, "重置失败");
            logger.error("重置失败", e);
        }
        return resultVo;
    }


	@Override
	public ResultVo register(MemberAccountRegisterIn paramIn) {
		ResultVo resultVo = new ResultVo();
		if (!validationObj(paramIn, resultVo)) {
			return resultVo;
		}
		try {
            SmsParamDto spv = new SmsParamDto();
            spv.setMobile(paramIn.getPhone());
            spv.setSecurityCode(paramIn.getSecurityCode());
            spv.setSmsType(Constant.SMS_TYPE_1);
            if (!smsNotifyApi.verifySmsCode(spv)) {
                assemblyVo(resultVo, E_001, "验证码不正确");
                return resultVo;
            }
            
            boolean exist = sysFrontAccountApi.accountIsExist(paramIn.getPhone(), paramIn.getAppType());
            if (exist) {
            	return assemblyVo(resultVo, E_001, "账号已经存在");
            }
            
            boolean flag = sysFrontAccountApi.register(paramIn.getPhone(), paramIn.getPassword(), paramIn.getAppType());
            if (flag) {
                SysFrontAccount member = sessionApi.getMemberInfoByAccount(paramIn.getMerchantId(), paramIn.getPhone(), paramIn.getAppType().intValue());
                
                MemberAccountLoginOut outParam = this.createLoginObjForOK(member, paramIn, paramIn.getCode());
                
                resultVo.setData(outParam);
                // 发送站内信
                // noticeApi.noticeForMail(member.getId(), SMS_TYPE_8, null);
            } else {
                assemblyVo(resultVo, E_001, "注册失败");
            }
        } catch (Exception e) {
            assemblyVo(resultVo, E_001, "注册失败");
            logger.error("注册失败", e);
        }
        return resultVo;
	}

	
	@Override
	public ResultVo phoneExist(MemberAccountPhoneExistIn paramIn) {
		ResultVo resultVo = new ResultVo();
		if (!validationObj(paramIn, resultVo)) {
			return resultVo;
		}
		try {
			MemberAccountPhoneExistOut outParam = new MemberAccountPhoneExistOut();
			outParam.setExist(sysFrontAccountApi.mobileIsExist(paramIn.getPhone(), paramIn.getAppType()));
			resultVo.setData(outParam);
		} catch (RpcException e) {
			assemblyVo(resultVo, E_001, "失败");
			logger.error("", e);
		}
		return resultVo;
	}

	@Override
	public ResultVo saveBaseInfo(MemberAccountSaveBaseInfoIn paramIn) {
		ResultVo resultVo = new ResultVo();
		if (!validationObj(paramIn, resultVo)) {
			return resultVo;
		}
		   try {
		    SysFrontAccount sysFrontAccount = UserUtils.getUserAccount(paramIn);
            assembly(sysFrontAccount, paramIn);
            sysFrontAccount.setAmount(null);
            sysFrontAccount.setFreezeAmount(null);
            sysFrontAccount.setMarginAmount(null);
            sysFrontAccountApi.saveBaseInfo(sysFrontAccount);
		 } catch (RpcException e) {
			assemblyVo(resultVo, E_001, "失败");
			logger.error("", e);
		 }
		return resultVo;
	}

	private void assembly(SysFrontAccount sysFrontAccount, MemberAccountSaveBaseInfoIn paramIn) {
        if (StringUtils.isNotEmpty(paramIn.getAccount())) {
            sysFrontAccount.setAccount(paramIn.getAccount());
        }
        if (StringUtils.isNotEmpty(paramIn.getNickName())) {
            sysFrontAccount.setNickName(paramIn.getNickName());
        }
        if (StringUtils.isNotEmpty(paramIn.getSex())) {
            sysFrontAccount.setSex(paramIn.getSex());
        }
        if (StringUtils.isNotEmpty(paramIn.getPortrait())) {
            sysFrontAccount.setPortrait(paramIn.getPortrait());
        }
    }

	
	@Override
	public ResultVo baseInfo(MemberAccountBaseInfoIn paramIn) {
		ResultVo resultVo = new ResultVo();
		if (!validationObj(paramIn, resultVo)) {
			return resultVo;
		}
		try {
			SysFrontAccount account = UserUtils.getUserAccount(paramIn);
			MemberAccountBaseInfoOut outParam = new MemberAccountBaseInfoOut();
			account = sysFrontAccountApi.getAccountById(account.getId());
			outParam.setName(account.getAccount());
			outParam.setNickName(account.getNickName());
			outParam.setAppType(account.getUserType());
			outParam.setPortrait(account.getPortrait());
			resultVo.setData(outParam);
		} catch (RpcException e) {
			assemblyVo(resultVo, E_001, "失败");
			logger.error("", e);
		}
		return resultVo;
	}

	
	@Override
	public ResultVo updatePasswd(MemberAccountUpdatePasswdIn paramIn) {
		ResultVo resultVo = new ResultVo();
		if (!validationObj(paramIn, resultVo)) {
			return resultVo;
		}
		try {
            SysFrontAccount userAccount = UserUtils.getUserAccount(paramIn);
            if (!userAccount.getPassword().equals(paramIn.getOldPass())) {
                assemblyVo(resultVo, E_001, "原密码有误！");
                return resultVo;
            } else if (userAccount.getPassword().equals(paramIn.getNewPass())) {
                assemblyVo(resultVo, E_001, "新密码不能和原密码一样！");
                return resultVo;
            } else {
                SysFrontAccount newAccount = new SysFrontAccount();
                newAccount.setId(userAccount.getId());
                newAccount.setPassword(paramIn.getNewPass());
                newAccount = sysFrontAccountApi.updateAccount(newAccount);
                sessionApi.updateSessionAccount(paramIn.getMerchantId(), paramIn.getTokenId(), paramIn.getAppType(), newAccount);
            }
        } catch (RpcException e) {
            assemblyVo(resultVo, E_001, "失败");
            logger.error("", e);
        }
        return resultVo;
	}
	
	
	@Override
	public ResultVo updatePhone(MemberAccountUpdatePhoneIn paramIn) {
		ResultVo resultVo = new ResultVo();
		if (!validationObj(paramIn, resultVo)) {
			return resultVo;
		}
		try {
            SysFrontAccount userAccount = UserUtils.getUserAccount(paramIn);
            if (!userAccount.getMobile().equals(paramIn.getOldPhone())) {
                assemblyVo(resultVo, E_001, "原手机号码有误！");
                return resultVo;
            }
            if (!sysFrontAccountApi.mobileIsExist(paramIn.getNewPhone(), paramIn.getAppType())) {
                SysFrontAccount newAccount = new SysFrontAccount();
                newAccount.setId(userAccount.getId());
                newAccount.setMobile(paramIn.getNewPhone());
                newAccount = sysFrontAccountApi.updateAccount(newAccount);
                sessionApi.updateSessionAccount(paramIn.getMerchantId(), paramIn.getTokenId(), paramIn.getAppType(), newAccount);
            } else {
                assemblyVo(resultVo, E_001, "新手机号已存在！");
                return resultVo;
            }
        } catch (RpcException e) {
            assemblyVo(resultVo, E_001, "失败");
            logger.error("", e);
        }
        return resultVo;
	}

	
	@Override
	public ResultVo updateWithdrawPass(MemberAccountUpdateWithdrawPassIn paramIn) {
		ResultVo resultVo = new ResultVo();
		if (!validationObj(paramIn, resultVo)) {
			return resultVo;
		}
		try {
            SysFrontAccount userAccount = UserUtils.getUserAccount(paramIn);
            if (userAccount.getTradePassword() != null && !userAccount.getTradePassword().equals(paramIn.getOldPass())) {
                assemblyVo(resultVo, E_001, "原提现密码有误！");
                return resultVo;
            } else if (userAccount.getTradePassword() != null && userAccount.getTradePassword().equals(paramIn.getNewPass())) {
                assemblyVo(resultVo, E_001, "新提现密码不能和原提现密码一样！");
                return resultVo;
            } else {
                SysFrontAccount newAccount = new SysFrontAccount();
                newAccount.setId(userAccount.getId());
                newAccount.setTradePassword(paramIn.getNewPass());
                newAccount = sysFrontAccountApi.updateAccount(newAccount);
                sessionApi.updateSessionAccount(paramIn.getMerchantId(), paramIn.getTokenId(), paramIn.getAppType(), newAccount);
                // 发送通知提醒
                // noticeApi.noticeForAll(userAccount.getId(), SMS_TYPE_9, new Object[]{userAccount.getAccount()});
            }
        } catch (RpcException e) {
            assemblyVo(resultVo, E_001, "失败");
            logger.error("", e);
        }
        return resultVo;
	}


}