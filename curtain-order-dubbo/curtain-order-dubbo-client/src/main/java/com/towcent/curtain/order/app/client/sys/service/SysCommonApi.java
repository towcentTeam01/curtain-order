package com.towcent.curtain.order.app.client.sys.service;

import java.util.List;

import com.towcent.base.common.exception.RpcException;
import com.towcent.base.common.model.MessageMailVo;
import com.towcent.base.common.model.NotifyMail;
import com.towcent.base.common.model.SysAbout;
import com.towcent.base.common.model.SysAppFeedback;
import com.towcent.base.common.model.SysAppVersion;
import com.towcent.base.common.model.SysArea;
import com.towcent.base.common.model.SysCarouselConf;
import com.towcent.base.common.page.PaginationDto;
import com.towcent.base.common.page.SimplePageDto;

public interface SysCommonApi {
	
	/**
     * App版本信息
     *
     * @param currentVersion
     * @return
     */
    public SysAppVersion validateVersion(SysAppVersion appVersion) throws RpcException;

    /**
     * 根据app类型获取关于我们
     *
     * @param appType
     * @return
     * @throws RpcException
     */
    SysAbout getSysAboutByType(byte appType) throws RpcException;

    /**
     * @param parentId
     * @return
     * @throws RpcException
     * @Title: getAreaListByParentId
     * @Description: 通过父地址Id查询下级地址列表.
     * @return: List<SysArea>
     */
    List<SysArea> getAreaListByParentId(Integer parentId) throws RpcException;

    /**
     * 获取地址描述
     *
     * @param provinceId
     * @param cityId
     * @param areaId
     * @return
     * @throws RpcException
     */
    String getAreaDesc(Integer provinceId, Integer cityId, Integer areaId) throws RpcException;

    /**
     * 添加意见反馈.
     *
     * @param feedBack
     * @return
     * @throws RpcException
     * @Title addFeedback
     */
    boolean addFeedback(SysAppFeedback feedBack) throws RpcException;

    /**
     * 通过type分页查询消息列表（按时间降序排列）.
     *
     * @param userId  账号
     * @param type    消息类型(0:系统公告 1:交易消息 2:活动消息)
     * @param appType 客户端类型(0:承运商 1:货主)
     * @param pageDto
     * @return
     * @throws RpcException
     * @Title getMessageMailByPage
     */
    PaginationDto<MessageMailVo> getMessageMailByPage(Integer userId, String type, Byte appType, SimplePageDto pageDto) throws RpcException;

    /**
     * 标记已读消息.
     *
     * @param id   消息Id(只针对站内信notify_mail)
     * @param type 消息类型(0:公告【忽略】1:交易消息 2:活动消息)
     * @return
     * @throws RpcException
     * @Title readMessage
     */
    boolean readMessage(String id, String type) throws RpcException;

    /**
     * 发送站内信.
     *
     * @param mail
     * @return
     * @throws RpcException
     * @Title sendNotifyMail
     */
    boolean sendNotifyMail(NotifyMail mail) throws RpcException;
	
	/**
	 * 发送站内信.
	 * @Title sendNotifyMail
	 * @param mail
	 * @param isPush 是否发送推送
	 * @return
	 * @throws RpcException
	 */
	boolean sendNotifyMail(NotifyMail mail, boolean isPush) throws RpcException;
	
	/**
	 * 根据类型获取轮播图列表
	 * @param carouselType 轮播图类型，数据字典carousel_type
	 *
	 * @return
	 * @throws RpcException
	 */
	List<SysCarouselConf> getCarouselList(String carouselType) throws RpcException;
	
}