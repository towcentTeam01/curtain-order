package com.towcent.curtain.order.web.sys.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.towcent.base.sc.web.modules.sys.utils.UserUtils;
import com.towcent.curtain.order.web.sys.entity.ConsigneeAddr;
import com.towcent.curtain.order.web.sys.service.ConsigneeAddrService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.web.BaseController;
import com.towcent.base.sc.web.modules.sys.entity.User;
import com.towcent.base.sc.web.modules.sys.service.UserService;

@Controller
@RequestMapping(value = "${adminPath}/sys/tag")
public class SysTagController extends BaseController {

    @Autowired
    private UserService userService;

    @Autowired
    private ConsigneeAddrService consigneeAddrService;

    /**
     * 树结构选择标签（treeselect.tag）
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "treeselect")
    public String treeselect(HttpServletRequest request, Model model) {
        model.addAttribute("url", request.getParameter("url")); // 树结构数据URL
        model.addAttribute("extId", request.getParameter("extId")); // 排除的编号ID
        model.addAttribute("checked", request.getParameter("checked")); // 是否可复选
        model.addAttribute("selectIds", request.getParameter("selectIds")); // 指定默认选中的ID
        model.addAttribute("isAll", request.getParameter("isAll")); // 是否读取全部数据，不进行权限过滤
        model.addAttribute("module", request.getParameter("module")); // 过滤栏目模型（仅针对CMS的Category树）
        model.addAttribute("id", request.getParameter("id")); // 过滤栏目模型（仅针对CMS的Category树）
        return "modules/sys/tagTreeselect";
    }

    /**
     * 图标选择标签（iconselect.tag）
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "iconselect")
    public String iconselect(HttpServletRequest request, Model model) {
        model.addAttribute("value", request.getParameter("value"));
        model.addAttribute("id", request.getParameter("id"));
        return "modules/sys/tagIconselect";
    }

    @RequiresPermissions("user")
    @RequestMapping(value = "specsInput")
    public String specsInput(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "modules/tag/specsInput";
    }

    @RequiresPermissions("user")
    @RequestMapping(value = "skusInput")
    public String skusInput(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "modules/tag/skusInput";
    }

    // 选择系统用户
    @RequiresPermissions("user")
    @RequestMapping(value = "searchUserList")
    public String searchGoodsList(User user, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<User> page = userService.findPage(new Page<User>(request, response), user);
        model.addAttribute("page", page);
        model.addAttribute("myId", request.getParameter("myId"));
        model.addAttribute("myName", request.getParameter("myName"));
        return "modules/tag/searchUserList";
    }

    // 选择系统用户
    @RequiresPermissions("user")
    @RequestMapping(value = "searchAddressList")
    public String searchAddressList(ConsigneeAddr consigneeAddr, HttpServletRequest request, HttpServletResponse response, Model model) {
        consigneeAddr.setUser(UserUtils.getUser());
        Page<ConsigneeAddr> page = consigneeAddrService.findPage(new Page<ConsigneeAddr>(request, response), consigneeAddr);
        model.addAttribute("page", page);
        model.addAttribute("myId", request.getParameter("myId"));
        model.addAttribute("myName", request.getParameter("myName"));
        return "modules/tag/searchAddressList";
    }
}
