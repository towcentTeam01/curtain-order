package com.towcent.curtain.order.web.common.utils;

import com.towcent.base.common.utils.DateUtils;
import com.towcent.base.common.utils.ImageUtils;
import com.towcent.base.common.utils.SpringContextHolder;
import com.towcent.base.sc.web.modules.sys.entity.SysImageConf;
import com.towcent.base.sc.web.modules.sys.service.SysImageConfService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Date;
import java.util.List;

public class CurtainImageUtils {
    protected static final String BASE_PATH = "/";
    protected static Logger logger = LoggerFactory.getLogger(ImageUtils.class);

    public CurtainImageUtils() {
    }

    public static String buildImageRelativePath(String BasePath, Integer merchantId, Integer imageType) {
        SysImageConf imageConf = getImageConfByType(merchantId, imageType);
        return buildImageRelativePath(BasePath, imageConf);
    }

    public static String buildImageRelativePath(String BasePath, SysImageConf imageConf) {
        StringBuffer sb = new StringBuffer(BasePath);
        if (imageConf == null) {
            sb.append("other/");
        } else {
            sb.append(imageConf.getMerchantId()).append("/");
            sb.append(imageConf.getImagePath());
            if (StringUtils.isNotBlank(imageConf.getSubDirFormat())) {
                sb.append(DateUtils.formatDate(new Date(), new Object[]{imageConf.getSubDirFormat()})).append("/");
            }
        }

        return sb.toString();
    }

    public static SysImageConf getImageConfByType(Integer merchantId, Integer imageType) {
        SysImageConfService sysImageConfService = SpringContextHolder.getBean(SysImageConfService.class);
        SysImageConf imageConf = null;

        try {
            SysImageConf param = new SysImageConf();
            param.setImageType(imageType+"");
            param.setMerchantId(merchantId);
            List<SysImageConf> list = sysImageConfService.findList(param);
            imageConf = list.get(0);
        } catch (Exception var5) {
            logger.error("获取图片配置异常.", var5);
        }

        return imageConf;
    }
}
