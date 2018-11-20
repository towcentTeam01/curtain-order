package com.towcent.curtain.order.web.common;

import javax.annotation.Resource;

import org.junit.Test;

import com.towcent.base.common.exception.RpcException;
import com.towcent.curtain.order.app.client.sys.service.SysCommonApi;
import com.towcent.curtain.order.web.BaseServiceTest;

public class SysCommonTest extends BaseServiceTest {
	
	@Resource SysCommonApi commonApi;
	
	@Test public void getAreaList() throws RpcException {
		// List<SysArea> list = commonApi.
		
		// System.out.println(list.size());
	}
	
}