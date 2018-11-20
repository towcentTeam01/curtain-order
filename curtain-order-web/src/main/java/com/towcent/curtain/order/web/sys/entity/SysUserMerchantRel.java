package com.towcent.curtain.order.web.sys.entity;

import com.towcent.base.sc.web.common.persistence.DataEntity;
import com.towcent.base.sc.web.modules.sys.entity.User;

/**
 * 商户用户关系Entity
 * @author HuangTao
 * @version 2018-08-03
 */
public class SysUserMerchantRel extends DataEntity<SysUserMerchantRel> {
	
	private static final long serialVersionUID = 1L;
	private User user;        // 系统用户
    private SysMerchantInfo merchant;        // 商户
	
	public SysUserMerchantRel() {
		super();
	}

	public SysUserMerchantRel(String id){
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public SysMerchantInfo getMerchant() {
		return merchant;
	}

	public void setMerchant(SysMerchantInfo merchant) {
		this.merchant = merchant;
	}

}