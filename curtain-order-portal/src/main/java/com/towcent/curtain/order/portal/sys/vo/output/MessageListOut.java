package com.towcent.curtain.order.portal.sys.vo.output;


import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

/**
 * 1.7.1 消息中心(暂时未使用到)
 * @author huangtao
 * @version 0.0.1
 */
@Data
public class MessageListOut implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private Integer id;		// 消息id	
	private String title;		// 消息标题	
	private String content;		// 消息内容	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date date;		// 日期	
	/**
     * 业务编码(订单号).
     */
	private String bizNo;
	
	/**
     * 是否已读(0:未读 1:已读).
     */
	private Byte isRead;
	
}