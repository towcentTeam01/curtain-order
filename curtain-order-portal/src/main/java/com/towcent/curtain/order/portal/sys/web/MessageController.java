package com.towcent.curtain.order.portal.sys.web;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.towcent.base.common.annotation.Loggable;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.common.web.BaseController;
import com.towcent.curtain.order.portal.sys.biz.MessageService;
import com.towcent.curtain.order.portal.sys.vo.input.MessageListIn;
import com.towcent.curtain.order.portal.sys.vo.input.MessageReadIn;

/**
 * MessageController
 * @author huangtao
 * @version 0.0.1
 */
@RestController
@RequestMapping(value = "sys/message", method = RequestMethod.POST)
public class MessageController extends BaseController {

	@Resource
	private MessageService messageService;

	// 1.7.1 消息中心
	@RequestMapping(value = "list") @Loggable
	public ResultVo list(@RequestBody MessageListIn paramIn) {
		return messageService.list(paramIn);
	}

	// 1.7.2 标记已读消息
	@RequestMapping(value = "read") @Loggable
	public ResultVo read(@RequestBody MessageReadIn paramIn) {
		return messageService.read(paramIn);
	}
}