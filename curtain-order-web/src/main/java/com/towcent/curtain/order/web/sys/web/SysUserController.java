package com.towcent.curtain.order.web.sys.web;

import com.google.common.collect.Lists;
import com.towcent.base.common.utils.Md5Utils;
import com.towcent.base.sc.web.common.config.Global;
import com.towcent.base.sc.web.common.constant.WebConstant;
import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.utils.StringUtils;
import com.towcent.base.sc.web.common.web.BaseController;
import com.towcent.base.sc.web.modules.sys.dao.UserDao;
import com.towcent.base.sc.web.modules.sys.entity.Office;
import com.towcent.base.sc.web.modules.sys.entity.Role;
import com.towcent.base.sc.web.modules.sys.entity.User;
import com.towcent.base.sc.web.modules.sys.service.SystemService;
import com.towcent.base.sc.web.modules.sys.utils.UserUtils;
import com.towcent.curtain.order.common.Constant;
import com.towcent.curtain.order.web.common.utils.MerchantUtils;
import com.towcent.curtain.order.web.mall.service.MallUserService;
import com.towcent.curtain.order.web.sys.entity.SysMerchantInfo;
import com.towcent.curtain.order.web.sys.entity.SysUserMerchantRel;
import com.towcent.curtain.order.web.sys.service.SysMerchantInfoService;
import com.towcent.curtain.order.web.sys.service.SysUserMerchantRelService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static com.towcent.base.common.constants.BaseConstant.DEL_FLAG_0;
import static com.towcent.base.common.constants.BaseConstant.E_001;
import static com.towcent.curtain.order.common.Constant.SYS_ROLE_CUSTOMER;
import static com.towcent.curtain.order.common.Constant.SYS_USER_TYPE_3;

/**
 * 用户Controller
 *
 * @version 2013-8-29
 */
@Controller
@RequestMapping(value = "${adminPath}/general/user")
public class SysUserController extends BaseController {

    @Autowired
    private SystemService systemService;
    @Autowired
    private SysUserMerchantRelService sysUserMerchantRelService;
    @Autowired
    private UserDao userDao;
    @Autowired
    private MallUserService userService;
    @Autowired
    private SysMerchantInfoService sysMerchantInfoService;

    @ModelAttribute
    public User get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return systemService.getUser(id);
        } else {
            return new User();
        }
    }

    @RequiresPermissions("general:user:view")
    @RequestMapping(value = {"list", ""})
    public String list(User user, HttpServletRequest request,
                       HttpServletResponse response, Model model) {
        // User user1 = UserUtils.getUser();
        // if (!WebConstant.isLeader()) {
        //    user.setOffice(user1.getOffice());
        // }
        // user.setUserType("3");   // 普通用户

        SysUserMerchantRel userMerchantRel = new SysUserMerchantRel();
        SysMerchantInfo merchantInfo = new SysMerchantInfo();
        merchantInfo.setId(MerchantUtils.getMerchantId(request) + "");
        userMerchantRel.setMerchant(merchantInfo);
        user.setDelFlag(Constant.DEL_FLAG_0);
        user.setNo("000"); // 000代表普通用户
        userMerchantRel.setUser(user);
        Page<SysUserMerchantRel> p = new Page<SysUserMerchantRel>(request, response);
        p.setOrderBy("u.create_date DESC");
        Page<SysUserMerchantRel> page = sysUserMerchantRelService.findPage(p, userMerchantRel);

        // 设置排序规则
        // Page<User> p = new Page<User>(request, response);
        // p.setOrderBy("u.create_date DESC");
        // Page<User> page = systemService.findUser(p, user);
        model.addAttribute("page", page);
        return "web/sys/sysUserList";
    }

    @RequiresPermissions("general:user:view")
    @RequestMapping(value = "form")
    public String form(User user, Model model) {
        if (user.getCompany() == null || user.getCompany().getId() == null) {
            user.setCompany(UserUtils.getUser().getCompany());
        }
        if (user.getOffice() == null || user.getOffice().getId() == null) {
            user.setOffice(UserUtils.getUser().getOffice());
        }
        model.addAttribute("user", user);
        model.addAttribute("allRoles", systemService.findAllRole());
        return "web/sys/sysUserForm";
    }

    @RequiresPermissions("general:user:view")
    @RequestMapping(value = "updatePasswd")
    public String updatePasswd(User user, Model model) {
        if (user.getCompany() == null || user.getCompany().getId() == null) {
            user.setCompany(UserUtils.getUser().getCompany());
        }
        if (user.getOffice() == null || user.getOffice().getId() == null) {
            user.setOffice(UserUtils.getUser().getOffice());
        }
        model.addAttribute("user", user);
        model.addAttribute("allRoles", systemService.findAllRole());
        return "web/sys/sysUserPasswd";
    }

    @RequiresPermissions("general:user:edit")
    @RequestMapping(value = "save")
    public String save(User user, HttpServletRequest request, Model model,
                       RedirectAttributes redirectAttributes) {

        // 修正引用赋值问题，不知道为何，Company和Office引用的一个实例地址，修改了一个，另外一个跟着修改。
        List<String> roleIds = new ArrayList<String>();
        user.setRoleIdList(roleIds);
        if (StringUtils.isNotBlank(user.getId())) {
            // userDao.updateSelective(user);
            Role role = systemService.getRoleByEnname(SYS_ROLE_CUSTOMER);
            systemService.assignUserToRole(role, user);
        } else {
            user.setId(null);
            user.setLoginName(user.getLoginName());
            user.setNo("000");   // 代表普通会员
            user.setJob("0");  // 待审核
            List<User> list = userService.findUser(user);
            if (!CollectionUtils.isEmpty(list)) {
                // return resultVo(resultVo, E_001, "用户名已存在");
                return "web/sys/sysUserForm";
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

//        user.setCompany(new Office(request.getParameter("company.id")));
//        user.setOffice(new Office(request.getParameter("office.id")));
//        // 如果新密码为空，则不更换密码
//        if (StringUtils.isNotBlank(user.getNewPassword())) {
//            // user.setPassword(SystemService.entryptPassword(user.getNewPassword()));
//            user.setPassword(Md5Utils.encryption(user.getNewPassword()));
//        }
//        if (!"true".equals(checkLoginName(user.getOldLoginName(),
//                user.getLoginName()))) {
//            addMessage(model, "保存用户'" + user.getLoginName() + "'失败，登录名已存在");
//            return form(user, model);
//        }
//        // 角色数据有效性验证，过滤不在授权内的角色
//        List<Role> roleList = Lists.newArrayList();
//        List<String> roleIdList = user.getRoleIdList();
//        for (Role r : systemService.findAllRole()) {
//            if (roleIdList.contains(r.getId())) {
//                roleList.add(r);
//            }
//        }
//        user.setRoleList(roleList);
//         保存用户信息
//            systemService.saveUser(user);
        }
        // 清除当前用户缓存
        if (user.getLoginName().equals(UserUtils.getUser().getLoginName())) {
            UserUtils.clearCache();
            // UserUtils.getCacheMap().clear();
        }
        addMessage(redirectAttributes, "保存用户'" + user.getLoginName() + "'成功");
        return "redirect:" + adminPath + "/general/user/list?repage";
    }

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

    @RequiresPermissions("general:user:edit")
    @RequestMapping(value = "delete")
    public String delete(User user, RedirectAttributes redirectAttributes) {
        if (Global.isDemoMode()) {
            addMessage(redirectAttributes, "演示模式，不允许操作！");
            return "redirect:" + adminPath + "/general/user/list?repage";
        }
        if (UserUtils.getUser().getId().equals(user.getId())) {
            addMessage(redirectAttributes, "删除用户失败, 不允许删除当前用户");
        } else if (User.isAdmin(user.getId())) {
            addMessage(redirectAttributes, "删除用户失败, 不允许删除超级管理员用户");
        } else {
            systemService.deleteUser(user);
            addMessage(redirectAttributes, "删除用户成功");
        }
        return "redirect:" + adminPath + "/general/user/list?repage";
    }

    /**
     * 验证登录名是否有效
     *
     * @param oldLoginName
     * @param loginName
     * @return
     */
    @ResponseBody
    @RequiresPermissions("general:user:edit")
    @RequestMapping(value = "checkLoginName")
    public String checkLoginName(String oldLoginName, String loginName) {
        if (loginName != null && loginName.equals(oldLoginName)) {
            return "true";
        } else if (loginName != null
                && systemService.getUserByLoginName(loginName) == null) {
            return "true";
        }
        return "false";
    }

    /**
     * 验证登录用户是否通过审核
     *
     * @return
     */
    @ResponseBody
    // @RequiresPermissions("general:user:edit")
    @RequestMapping(value = "checkLoginNameStatus")
    public String checkLoginNameStatus() {
        User user = UserUtils.getUser();
        if ("1".equals(user.getJob())) {
            return "true";
        }
        return "false";
    }

    /**
     * 用户信息显示及保存
     *
     * @param user
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "info")
    public String info(User user, HttpServletResponse response, Model model) {
        User currentUser = UserUtils.getUser();
        if (StringUtils.isNotBlank(user.getName())) {
            if (Global.isDemoMode()) {
                model.addAttribute("message", "演示模式，不允许操作！");
                return "modules/sys/userInfo";
            }
            currentUser.setEmail(user.getEmail());
            currentUser.setPhone(user.getPhone());
            currentUser.setMobile(user.getMobile());
            currentUser.setRemarks(user.getRemarks());
            currentUser.setPhoto(user.getPhoto());
            currentUser.setSex(user.getSex());
            systemService.updateUserInfo(currentUser);
            model.addAttribute("message", "保存用户信息成功");
        }
        model.addAttribute("user", currentUser);
        model.addAttribute("Global", new Global());
        return "modules/sys/userInfo";
    }

    /**
     * 修改个人用户密码
     *
     * @param oldPassword
     * @param newPassword
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "modifyPwd")
    public String modifyPwd(String oldPassword, String newPassword, Model model) {
        User user = UserUtils.getUser();
        if (StringUtils.isNotBlank(oldPassword)
                && StringUtils.isNotBlank(newPassword)) {
            if (Global.isDemoMode()) {
                model.addAttribute("message", "演示模式，不允许操作！");
                return "modules/sys/userModifyPwd";
            }
            if (SystemService.validatePassword(oldPassword, user.getPassword())) {
                systemService.updatePasswordById(user.getId(),
                        user.getLoginName(), newPassword);
                model.addAttribute("message", "修改密码成功");
            } else {
                model.addAttribute("message", "修改密码失败，旧密码错误");
            }
        }
        model.addAttribute("user", user);
        return "modules/sys/userModifyPwd";
    }


    @RequiresPermissions("general:user:edit")
    @RequestMapping(value = "savePasswd")
    public String savePasswd(User user, HttpServletRequest request, Model model,
                       RedirectAttributes redirectAttributes) {

        // 修正引用赋值问题，不知道为何，Company和Office引用的一个实例地址，修改了一个，另外一个跟着修改。
        List<String> roleIds = new ArrayList<String>();
        user.setRoleIdList(roleIds);
        if (StringUtils.isNotBlank(user.getId())) {
            user.setPassword(Md5Utils.encryption(user.getPassword()));
            // userDao.updateSelective(user);
            Role role = systemService.getRoleByEnname(SYS_ROLE_CUSTOMER);
            systemService.assignUserToRole(role, user);
        }
        // 清除当前用户缓存
        if (user.getLoginName().equals(UserUtils.getUser().getLoginName())) {
            UserUtils.clearCache();
            // UserUtils.getCacheMap().clear();
        }
        addMessage(redirectAttributes, "修改用户'" + user.getLoginName() + "'密码成功");
        return "redirect:" + adminPath + "/general/user/list?repage";
    }
}
