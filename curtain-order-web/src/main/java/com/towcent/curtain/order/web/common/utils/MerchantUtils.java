package com.towcent.curtain.order.web.common.utils;

import com.towcent.base.common.utils.SpringContextHolder;
import com.towcent.base.sc.web.common.utils.StringUtils;
import com.towcent.curtain.order.web.sys.entity.SysMerchantInfo;
import com.towcent.curtain.order.web.sys.service.SysMerchantInfoService;

import javax.servlet.http.HttpServletRequest;

/**
 * TODO: 增加描述
 *
 * @author huangtao
 * @version 0.1.0
 * @date 2014年9月11日 下午12:16:03
 * @copyright cc.luoqi.
 */
public class MerchantUtils {

    private static SysMerchantInfoService sysMerchantInfoService = SpringContextHolder.getBean(SysMerchantInfoService.class);

    public MerchantUtils() {
    }


    public static Integer getMerchantId(HttpServletRequest request) {
        try {
            String uri = request.getServerName();
            if (StringUtils.isNotBlank(uri)) {
                String mid = sysMerchantInfoService.getMerchantId(uri);
                return null != mid ? Integer.parseInt(mid) : null;
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static SysMerchantInfo getMerchantInfo(HttpServletRequest request) {
        try {
            String uri = request.getServerName();
            if (StringUtils.isNotBlank(uri)) {
                return sysMerchantInfoService.getMerchantInfo(uri);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        return null;
    }
}
