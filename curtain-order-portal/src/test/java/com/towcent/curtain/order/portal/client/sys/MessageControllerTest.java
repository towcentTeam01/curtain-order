package com.towcent.curtain.order.portal.client.sys;

import java.io.IOException;

import org.junit.Test;

import com.towcent.curtain.order.portal.client.BaseAppTest;
import com.towcent.curtain.order.portal.sys.vo.input.MessageListIn;
import com.towcent.curtain.order.portal.sys.vo.input.MessageReadIn;

public class MessageControllerTest extends BaseAppTest {

	static {
		descMap.put("sys/message/read", "标记已读消息");
		descMap.put("sys/message/list", "消息中心");
		
	}

	@Test
	public void list() throws IOException {
		String path = "sys/message/list";
		MessageListIn paramVo = new MessageListIn();
		this.setCommonParam(paramVo);
		paramVo.setType("0");
		paramVo.setPageNo(1);
		paramVo.setPageSize(10);
		this.setLoginFlag(paramVo);
		String content = sendHttp(paramVo, path);
		System.out.println(content);
	}

	@Test
	public void read() throws IOException {
		String path = "sys/message/read";
		MessageReadIn paramVo = new MessageReadIn();
		this.setCommonParam(paramVo);
		paramVo.setType("");
		paramVo.setIds("1");
		paramVo.setTokenId("");
		String content = sendHttp(paramVo, path);
		System.out.println(content);
	}
}