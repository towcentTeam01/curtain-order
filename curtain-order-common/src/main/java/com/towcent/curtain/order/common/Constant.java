package com.towcent.curtain.order.common;

import com.towcent.base.common.constants.BaseConstant;

/**
 * 常量类
 * 
 * @author huangtao
 * @date 2015年6月24日 下午4:23:06
 * @version 0.1.0
 */
public final class Constant extends BaseConstant {

	/** 图片上传url */
	public static final String UPLOAD_URL = "/api/sys/image/upload";
	
	public static final String UPLOAD_URL_WX = "/api/sys/image/wxupload";
	
    /**
     * APP类型(0:客户)
     */
    public static final byte APP_TYPE_0 = 0;
    
	/** 用户注册 */
	public static final byte SMS_TYPE_1 = 1;
	/** 用户登录 */
    public static final byte SMS_TYPE_2 = 2;
    /** 用户修改密码 */
    public static final byte SMS_TYPE_3 = 3;

	/**
     * 常量：id
     */
    public static final String ID = "id";
    /**
     * 常量：userId
     */
    public static final String USER_ID = "userId";
    
	/** 订单状态(0:已下单 1:待审核 2:售后审核通过 3:财务审核通过 4:已下料 5:已出价 6:已发货 7:完成) */
	public static final String ORDER_STATUS_1 = "1";
	/** 订单状态(0:已下单 1:待审核 2:售后审核通过 3:财务审核通过 4:已下料 5:已出价 6:已发货 7:完成) */
	public static final String ORDER_STATUS_2 = "2";
	/** 订单状态(0:已下单 1:待审核 2:售后审核通过 3:财务审核通过 4:已下料 5:已出价 6:已发货 7:完成) */
	public static final String ORDER_STATUS_3 = "3";
	/** 订单状态(0:已下单 1:待审核 2:售后审核通过 3:财务审核通过 4:已下料 5:已出价 6:已发货 7:完成) */
	public static final String ORDER_STATUS_4 = "4";
	/** 订单状态(0:已下单 1:待审核 2:售后审核通过 3:财务审核通过 4:已下料 5:已出价 6:已发货 7:完成) */
	public static final String ORDER_STATUS_5 = "5";
	/** 订单状态(0:已下单 1:待审核 2:售后审核通过 3:财务审核通过 4:已下料 5:已出价 6:已发货 7:完成) */
	public static final String ORDER_STATUS_6 = "6";
	/** 订单状态(0:已下单 1:待审核 2:售后审核通过 3:财务审核通过 4:已下料 5:已出价 6:已发货 7:完成) */
	public static final String ORDER_STATUS_7 = "7";
	/** 订单状态(0:已下单 1:待审核 2:售后审核通过 3:财务审核通过 4:已下料 5:已出价 6:已发货 7:完成 8:取消) */
	public static final String ORDER_STATUS_8 = "8";
	
	/** 商品状态(1:未发布 2:上架 3:下架) */
	public static final String GOODS_STATUS_1 = "1";
	/** 商品状态(1:未发布 2:上架 3:下架) */
	public static final String GOODS_STATUS_2 = "2";
	/** 商品状态(1:未发布 2:上架 3:下架) */
	public static final String GOODS_STATUS_3 = "3";

	/**
	 * 普通用户角色名称
	 */
	public static final String SYS_ROLE_CUSTOMER = "customer";

	/**
	 * 系统用户类型 1：系统管理用户 2：商户 3：普通用户
	 */
	public static final String SYS_USER_TYPE_3 = "3";

	
}