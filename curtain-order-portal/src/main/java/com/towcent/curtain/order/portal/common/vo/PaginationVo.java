package com.towcent.curtain.order.portal.common.vo;

import java.io.Serializable;
/**
 * TODO: 增加描述
 * 
 * @author huangtao
 * @date 2015年6月25日 下午2:29:14
 * @version 0.1.0 
 */
public class PaginationVo implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int totalCount = 0;
	
	private Object list;

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public Object getList() {
		return null == list ? new Object(): list;
	}

	public void setList(Object list) {
		this.list = list;
	}
	
}