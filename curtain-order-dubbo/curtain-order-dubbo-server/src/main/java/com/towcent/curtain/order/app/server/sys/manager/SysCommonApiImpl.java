package com.towcent.curtain.order.app.server.sys.manager;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.towcent.base.common.constants.BaseConstant;
import com.towcent.base.common.exception.RpcException;
import com.towcent.base.common.exception.ServiceException;
import com.towcent.base.common.model.JPushDto;
import com.towcent.base.common.model.MessageMailVo;
import com.towcent.base.common.model.NotifyMail;
import com.towcent.base.common.model.SysAbout;
import com.towcent.base.common.model.SysAppFeedback;
import com.towcent.base.common.model.SysAppVersion;
import com.towcent.base.common.model.SysArea;
import com.towcent.base.common.model.SysCarouselConf;
import com.towcent.base.common.model.SysNotice;
import com.towcent.base.common.page.PaginationDto;
import com.towcent.base.common.page.SimplePage;
import com.towcent.base.common.page.SimplePageDto;
import com.towcent.base.common.utils.Assert;
import com.towcent.base.manager.BaseCommonApi;
import com.towcent.base.manager.PushApi;
import com.towcent.curtain.order.app.client.sys.service.SysCommonApi;
import com.towcent.base.service.BaseService;
import com.towcent.base.service.NotifyMailService;
import com.towcent.base.service.SysAboutService;
import com.towcent.base.service.SysAppFeedbackService;
import com.towcent.base.service.SysAppVersionService;
import com.towcent.base.service.SysAreaService;
import com.towcent.base.service.SysCarouselConfService;
import com.towcent.base.service.SysNoticeService;

@Service
public class SysCommonApiImpl extends BaseService implements SysCommonApi {
	
	@Resource
    private SysAppVersionService sysAppVersionService;
    @Resource
    private SysAreaService areaService;
    @Resource
    private PushApi pushApi;
    @Resource
    private BaseCommonApi baseCommonApi;
    @Resource
    private SysCarouselConfService carouselService;

    @Override
    public SysAppVersion validateVersion(SysAppVersion appVersion) throws RpcException {
        try {
            Map<String, Object> condtion = Maps.newHashMap();
            condtion.put("sysType", appVersion.getSysType());
            condtion.put("appType", appVersion.getAppType());
            condtion.put("version", appVersion.getCurrentVersion());
            List<SysAppVersion> sysAppVersions = sysAppVersionService.findByBiz(condtion);

            if (!CollectionUtils.isEmpty(sysAppVersions)) {
                // 获取其最新一条版本信息
                SysAppVersion sysAppVersion = sysAppVersions.get(sysAppVersions.size() - 1);
                // 判断版本是否需要强制升级
                if (appVersion.getCurrentVersion() < sysAppVersion.getCompatibleVersion()) {
                    sysAppVersion.setEnforceFlag(BaseConstant.YES);
                }
                return sysAppVersion;
            }
        } catch (ServiceException e) {
            logger.error("验证版本升级失败.", e);
            throw new RpcException("验证版本升级失败", e);
        }
        return null;
    }

    @Override
    public List<SysArea> getAreaListByParentId(Integer parentId) throws RpcException {
        try {
            return areaService.findByKeyVal("parentId", parentId);
        } catch (ServiceException e) {
            logger.error("通过parentId查询下级地址列表失败.", e);
            throw new RpcException("通过parentId查询下级地址列表失败", e);
        }
    }

    @Override
    public String getAreaDesc(Integer provinceId, Integer cityId, Integer areaId) throws RpcException {
        try {
            return areaService.getAreaDesc(provinceId, cityId, areaId, "-");
        } catch (ServiceException e) {
            logger.error("通过地址Id查询地址描述失败.", e);
            throw new RpcException("通过地址Id查询地址描述失败", e);
        }

    }

    @Resource
    private SysAboutService sysAboutService;

    @Override
    public SysAbout getSysAboutByType(byte appType) throws RpcException {
        try {
            return sysAboutService.findByKeyValSingle("appType", appType);
        } catch (ServiceException e) {
            logger.error("查询关于我们失败", e);
            throw new RpcException("", "查询关于我们失败", e);
        }
    }

    @Resource
    private SysAppFeedbackService feedBackService;

    @Override
    public boolean addFeedback(SysAppFeedback feedBack) throws RpcException {
        Assert.notNull(feedBack, "意见反馈内容不能为空!");
        boolean result = false;

        try {
            result = feedBackService.add(feedBack) > 0;
        } catch (ServiceException e) {
            logger.error("添加意见反馈失败", e);
            throw new RpcException("", "添加意见反馈失败", e);
        }
        return result;
    }

    @Resource
    private SysNoticeService sysNoticeService;
    @Resource
    private NotifyMailService notifyMailService;

    @Override
    public PaginationDto<MessageMailVo> getMessageMailByPage(Integer userId, String type, Byte appType, SimplePageDto pageDto) throws RpcException {
        Assert.isNotEmpty(type, "消息类型不能为空");

        Map<String, Object> params = Maps.newHashMap();
        params.put("appType", appType);

        PaginationDto<MessageMailVo> pagObj = new PaginationDto<MessageMailVo>();
        List<MessageMailVo> mailList = Lists.newArrayList();
        MessageMailVo mailVo = null;
        try {
            if ("0".equals(type)) { // 系统公告
                int totalCount = sysNoticeService.findCount(params);
                SimplePage page = new SimplePage(pageDto.getPageNo(), pageDto.getPageSize(), totalCount);
                List<SysNotice> list = sysNoticeService.findByPage(page, "create_date", "desc", params);
                if (!CollectionUtils.isEmpty(list)) {
                    for (SysNotice sysNotice : list) {
                        mailVo = new MessageMailVo();
                        mailVo.setId(sysNotice.getId());
                        mailVo.setTitle(sysNotice.getTitle());
                        mailVo.setContent(sysNotice.getContent());
                        mailVo.setNoticeType(sysNotice.getNoticeType());
                        mailVo.setDate(sysNotice.getCreateDate());
                        mailVo.setSysNotice(true);
                        mailVo.setIsRead((byte) 1);
                        mailList.add(mailVo);
                    }
                }
                pagObj.setTotalCount(totalCount);
                pagObj.setTotalPage(pageDto.getPageSize());
                pagObj.setList(mailList);
            } else { // 站内信
                if (null == userId) {
                    return pagObj;
                }
                params.put("noticeType", type);
                params.put("userId", userId);
                int totalCount = notifyMailService.findCount(params);
                SimplePage page = new SimplePage(pageDto.getPageNo(), pageDto.getPageSize(), totalCount);
                List<NotifyMail> list = notifyMailService.findByPage(page, "create_date", "desc", params);
                if (!CollectionUtils.isEmpty(list)) {
                    for (NotifyMail notifyMail : list) {
                        mailVo = new MessageMailVo();
                        mailVo.setId(notifyMail.getId());
                        mailVo.setTitle(notifyMail.getTitle());
                        mailVo.setContent(notifyMail.getContent());
                        mailVo.setNoticeType(notifyMail.getNoticeType());
                        mailVo.setDate(notifyMail.getCreateDate());
                        mailVo.setSysNotice(false);
                        mailVo.setBizNo(notifyMail.getBizNo());
                        mailVo.setIsRead(notifyMail.getIsRead());
                        mailList.add(mailVo);
                    }
                }
                pagObj.setTotalCount(totalCount);
                pagObj.setTotalPage(pageDto.getPageSize());
                pagObj.setList(mailList);
            }
        } catch (ServiceException e) {
            logger.error("查询消息列表失败", e);
            throw new RpcException("", "查询消息列表失败", e);
        }
        return pagObj;
    }

    @Override
    public boolean readMessage(String ids, String type) throws RpcException {
        Assert.isNotEmpty(ids, "消息Ids不能为空");
        if ("0".equals(type)) {
            return true;
        }
        try {
        	String[] idArray = ids.split(";");
        	for (String id : idArray) {
        		NotifyMail mail = new NotifyMail();
                mail.setId(Integer.parseInt(id));
                mail.setIsRead((byte) 1);
                notifyMailService.modifyById(mail);
			}
            return  true;
        } catch (ServiceException e) {
            logger.error("标记已读消息失败", e);
            throw new RpcException("", "标记已读消息失败", e);
        }
    }

    @Override
    public boolean sendNotifyMail(NotifyMail mail) throws RpcException {
        return this.sendNotifyMail(mail, false);
    }

    @Override
    public boolean sendNotifyMail(NotifyMail mail, boolean isPush) throws RpcException {
        try {
            mail.setCreateDate(new Date());
            mail.setIsRead((byte) 0); // 未读

            if (isPush) {
                // TODO 发送推送
                try {
                    JPushDto dto = new JPushDto();
                    dto.setUserId(mail.getUserId());
                    dto.setTitle(mail.getTitle());
                    dto.setContent(mail.getContent());
                    pushApi.jpushMsg(dto);
                } catch (Exception e) {
                    logger.error("发送推送失败", e);
                }
            }
            return notifyMailService.add(mail) > 0;
        } catch (ServiceException e) {
            logger.error("发送站内信失败", e);
            throw new RpcException("", "发送站内信失败", e);
        }
    }
    
    @Override
    public List<SysCarouselConf> getCarouselList(String carouselType) throws RpcException {
        try {
            return carouselService.findByKeyVal("carouselType", carouselType);
        } catch (ServiceException e) {
            logger.error("查询轮播图失败", e);
            throw new RpcException("", "查询轮播图失败", e);
        }
    }

}