package com.towcent.curtain.order.web.mall.web;

import com.towcent.base.common.utils.Md5Utils;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.utils.StringUtils;
import com.towcent.base.sc.web.common.web.BaseController;
import com.towcent.base.sc.web.modules.sys.entity.*;
import com.towcent.base.sc.web.modules.sys.service.*;
import com.towcent.curtain.order.web.common.utils.MerchantUtils;
import com.towcent.curtain.order.web.mall.service.MallUserService;
import com.towcent.curtain.order.web.sys.entity.SysMerchantInfo;
import com.towcent.curtain.order.web.sys.entity.SysUserMerchantRel;
import com.towcent.curtain.order.web.sys.service.SysMerchantInfoService;
import com.towcent.curtain.order.web.sys.service.SysUserMerchantRelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

import static com.towcent.base.common.constants.BaseConstant.*;
import static com.towcent.curtain.order.common.Constant.SYS_ROLE_CUSTOMER;
import static com.towcent.curtain.order.common.Constant.SYS_USER_TYPE_3;

/**
 * 订单Controller
 *
 * @author HuangTao
 * @version 2018-07-19
 */
@Controller
public class MallUserController extends BaseController {

    @Autowired
    private SystemService systemService;

    @Autowired
    private MallUserService userService;

    @Autowired
    private SysMerchantInfoService sysMerchantInfoService;

    @Autowired
    private SysUserMerchantRelService sysUserMerchantRelService;

    @Autowired
    private SysCarouselConfService sysCarouselConfService;

    @Autowired
    private SysNoticeService sysNoticeService;

    @Autowired
    private SysDictMainService sysDictMainService;

    @Autowired
    private SysDictDtlService sysDictDtlService;

    private SysMerchantInfo getMerchantInfo(HttpServletRequest request) {
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

    public List<SysDictDtl> getDictListByKey(String key) {
        try {
            SysDictMain sysDictMain = new SysDictMain();
            sysDictMain.setCode(key);
            List<SysDictMain> mainList = sysDictMainService.findList(sysDictMain);
            if (CollectionUtils.isEmpty(mainList)) {
                return null;
            } else {
                SysDictDtl sysDictDtl = new SysDictDtl();
                sysDictDtl.setDictId(mainList.get(0).getId());
                List<SysDictDtl> list = sysDictDtlService.findList(sysDictDtl);
                return list;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @RequestMapping(value = "${adminPath}/mall/index", method = RequestMethod.GET)
    public String mallIndex(Model model, HttpServletRequest request, HttpServletResponse response) {
        SysCarouselConf sysCarouselConf = new SysCarouselConf();
        sysCarouselConf.setMerchantId(MerchantUtils.getMerchantId(request));
        List<SysCarouselConf> carouselList = sysCarouselConfService.findList(sysCarouselConf);
        model.addAttribute("carouselList", carouselList);

        Page<SysNotice> pageDto = new Page<>(request, response);
        pageDto.setPageSize(5);
        SysNotice sysNotice = new SysNotice();
        sysNotice.setMerchantId(MerchantUtils.getMerchantId(request));
        Page<SysNotice> page = sysNoticeService.findPage(pageDto, sysNotice);
        if (null != page && !CollectionUtils.isEmpty(page.getList())) {
            model.addAttribute("noticeList", page.getList());
        }

        List<SysDictDtl> dictDtls = getDictListByKey("label_type");
        model.addAttribute("dictDtls", dictDtls);

        return "web/mall/index";
    }

    @RequestMapping(value = "${adminPath}/toRegister", method = RequestMethod.GET)
    public String toRegister(User user, Model model, HttpServletRequest request) {
        SysMerchantInfo merchantInfo = getMerchantInfo(request);
        model.addAttribute("merchantInfo", merchantInfo);
        return "web/mall/register";
    }

    @ResponseBody
    @RequestMapping(value = "${adminPath}/getMerchantInfo", method = RequestMethod.POST)
    public ResultVo getMerchantInfo(User user, HttpServletRequest request) {
        ResultVo resultVo = new ResultVo();
        try {
            SysMerchantInfo merchantInfo = getMerchantInfo(request);
            resultVo.setData(merchantInfo);
            return resultVo(resultVo, E_000, "成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultVo(resultVo, E_001, "系统异常，请稍候再试");
    }

    @ResponseBody
    @RequestMapping(value = "${adminPath}/register", method = RequestMethod.POST)
    public ResultVo register(User user, HttpServletRequest request) {
        ResultVo resultVo = new ResultVo();
        try {

            if (StringUtils.isBlank(user.getLoginName())) {
                return resultVo(resultVo, E_001, "请输入用户名");
            }

            if (StringUtils.isBlank(user.getPassword())) {
                return resultVo(resultVo, E_001, "请输入密码");
            }

            User sysUser = new User();
            sysUser.setId(null);
            sysUser.setLoginName(user.getLoginName());
            sysUser.setNo("000");   // 代表普通会员
            sysUser.setJob("0");  // 待审核
            List<User> list = userService.findUser(sysUser);
            if (!CollectionUtils.isEmpty(list)) {
                return resultVo(resultVo, E_001, "用户名已存在");
            }

            SysMerchantInfo merchantInfo = getMerchantInfo(request);
            if (null != merchantInfo) {
                user.setMerchantId(Integer.parseInt(merchantInfo.getId()));
            }

            user.setPassword(Md5Utils.encryption(user.getPassword()));
            user.setUserType(SYS_USER_TYPE_3);
            user.setCompany(new Office("1"));
            user.setOffice(new Office("1"));
            user.setName(user.getLoginName());
            user.setCreateBy(new User("1"));
            user.setUpdateBy(user.getCreateBy());
            user.setCreateDate(new Date());
            user.setUpdateDate(user.getCreateDate());
            user.setDelFlag(DEL_FLAG_0);

            Role role = systemService.getRoleByEnname(SYS_ROLE_CUSTOMER);
            systemService.assignUserToRole(role, user);

            if (null != merchantInfo) {
                SysUserMerchantRel rel = new SysUserMerchantRel();
                rel.setUser(user);
                rel.setMerchant(merchantInfo);
                sysUserMerchantRelService.save(rel);
            }

            return resultVo(resultVo, E_000, "注册成功");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultVo(resultVo, E_001, "系统异常，请稍候再试");
    }

    protected ResultVo resultVo(ResultVo vo, String code, String message) {
        vo.setCode(code);
        vo.setErrorMessage(message);
        return vo;
    }
}