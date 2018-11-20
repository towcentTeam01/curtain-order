package com.towcent.curtain.order.portal.sys.web;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.towcent.base.common.annotation.Loggable;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.common.web.BaseController;
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

/**
 * MemberAccountController
 * @author huangtao
 * @version 0.0.3
 */
@RestController
@RequestMapping(value = "member/memberAccount", method = RequestMethod.POST)
public class MemberAccountController extends BaseController {

	@Resource
	private MemberAccountService memberAccountService;

	// 1.0.1 登录接口
	@RequestMapping(value = "login") @Loggable
	public ResultVo login(@RequestBody MemberAccountLoginIn paramIn) {
		return memberAccountService.login(paramIn);
	}
	
	// 1.0.2 快捷登录接口
	@RequestMapping(value = "fastLogin") @Loggable
	public ResultVo fastLogin(@RequestBody MemberAccountFastLoginIn paramIn) {
		return memberAccountService.fastLogin(paramIn);
	}

	// 1.0.3 注册
	@RequestMapping(value = "register") @Loggable
	public ResultVo register(@RequestBody MemberAccountRegisterIn paramIn) {
		return memberAccountService.register(paramIn);
	}

	// 1.0.4 手机号是否存在
	@RequestMapping(value = "phoneExist") @Loggable
	public ResultVo phoneExist(@RequestBody MemberAccountPhoneExistIn paramIn) {
		return memberAccountService.phoneExist(paramIn);
	}
	
	// 1.0.5 重置密码
	@RequestMapping(value = "reset") @Loggable
	public ResultVo reset(@RequestBody MemberAccountResetIn paramIn) {
		return memberAccountService.reset(paramIn);
	}
	
	// 1.0.7 修改密码
	@RequestMapping(value = "updatePasswd") @Loggable
	public ResultVo updatePasswd(@RequestBody MemberAccountUpdatePasswdIn paramIn) {
		return memberAccountService.updatePasswd(paramIn);
	}
	
	// 1.0.8 账号基本信息保存
	@RequestMapping(value = "saveBaseInfo") @Loggable
	public ResultVo saveBaseInfo(@RequestBody MemberAccountSaveBaseInfoIn paramIn) {
		return memberAccountService.saveBaseInfo(paramIn);
	}

	// 1.0.9 用户基本信息
	@RequestMapping(value = "baseInfo") @Loggable
	public ResultVo baseInfo(@RequestBody MemberAccountBaseInfoIn paramIn) {
		return memberAccountService.baseInfo(paramIn);
	}

	// 1.0.10 修改绑定手机
	@RequestMapping(value = "updatePhone") @Loggable
	public ResultVo updatePhone(@RequestBody MemberAccountUpdatePhoneIn paramIn) {
		return memberAccountService.updatePhone(paramIn);
	}

	// 1.0.11 修改提现密码
	@RequestMapping(value = "updateWithdrawPass") @Loggable
	public ResultVo updateWithdrawPass(@RequestBody MemberAccountUpdateWithdrawPassIn paramIn) {
		return memberAccountService.updateWithdrawPass(paramIn);
	}

}