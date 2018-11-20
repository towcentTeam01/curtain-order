package com.towcent.curtain.order.portal.client.sys;

import java.io.IOException;

import org.junit.Test;

import com.towcent.curtain.order.portal.client.BaseAppTest;
import com.towcent.curtain.order.portal.sys.vo.input.DictListIn;

public class DictControllerTest extends BaseAppTest {

	static {
		descMap.put("sys/dict/list", "数据字典接口");
	}

	@Test
	public void list() throws IOException {
		String path = "sys/dict/list";
		DictListIn paramVo = new DictListIn();
		this.setCommonParam(paramVo);
		this.setLoginFlag(paramVo);
		paramVo.setKey("car_type");
		String content = sendHttp(paramVo, path);
		System.out.println(content);
	}
}