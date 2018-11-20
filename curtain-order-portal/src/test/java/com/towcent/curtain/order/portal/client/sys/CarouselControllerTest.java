package com.towcent.curtain.order.portal.client.sys;

import java.io.IOException;

import org.junit.Test;

import com.towcent.curtain.order.portal.client.BaseAppTest;
import com.towcent.curtain.order.portal.sys.vo.input.CarouselListIn;

public class CarouselControllerTest extends BaseAppTest {

	static {
		descMap.put("sys/carousel/list", "获取轮播图列表");
		
	}

	@Test
	public void list() throws IOException {
		String path = "sys/carousel/list";
		CarouselListIn paramVo = new CarouselListIn();
		this.setCommonParam(paramVo);
		paramVo.setCarouselType("1");
		String content = sendHttp(paramVo, path);
		System.out.println(content);
	}
}