package com.towcent.curtain.order.app.server.coding;

import javax.annotation.Resource;

import org.junit.Test;

import com.towcent.base.common.enums.RuleTypeEnum;
import com.towcent.base.common.exception.ServiceException;
import com.towcent.curtain.order.app.server.BaseServiceTest;
import com.towcent.base.service.CodingRuleService;

public class CodingRuleTest extends BaseServiceTest {
	
	@Resource
	private CodingRuleService codingRuleService;
	
	@Test 
	public void getCoding() throws ServiceException {
		String goodsNo = codingRuleService.getSerialNo(RuleTypeEnum.GOODS_NO, 0);
		System.out.println(goodsNo);
	}
	
}