package com.towcent.curtain.order.web.sys.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.towcent.base.sc.web.common.config.Global;
import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.utils.StringUtils;
import com.towcent.base.sc.web.common.web.BaseController;
import com.towcent.curtain.order.web.sys.entity.SysLogisticsCompany;
import com.towcent.curtain.order.web.sys.service.SysLogisticsCompanyService;

/**
 * 系统物流公司Controller
 * @author HuangTao
 * @version 2018-07-11
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/sysLogisticsCompany")
public class SysLogisticsCompanyController extends BaseController {

	@Autowired
	private SysLogisticsCompanyService sysLogisticsCompanyService;
	
	@ModelAttribute
	public SysLogisticsCompany get(@RequestParam(required=false) String id) {
		SysLogisticsCompany entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sysLogisticsCompanyService.get(id);
		}
		if (entity == null){
			entity = new SysLogisticsCompany();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:sysLogisticsCompany:view")
	@RequestMapping(value = {"list", ""})
	public String list(SysLogisticsCompany sysLogisticsCompany, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SysLogisticsCompany> page = sysLogisticsCompanyService.findPage(new Page<SysLogisticsCompany>(request, response), sysLogisticsCompany); 
		model.addAttribute("page", page);
		return "web/sys/sysLogisticsCompanyList";
	}

	@RequiresPermissions("sys:sysLogisticsCompany:view")
	@RequestMapping(value = "form")
	public String form(SysLogisticsCompany sysLogisticsCompany, Model model) {
		model.addAttribute("sysLogisticsCompany", sysLogisticsCompany);
		return "web/sys/sysLogisticsCompanyForm";
	}

	@RequiresPermissions("sys:sysLogisticsCompany:edit")
	@RequestMapping(value = "save")
	public String save(SysLogisticsCompany sysLogisticsCompany, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysLogisticsCompany)){
			return form(sysLogisticsCompany, model);
		}
		sysLogisticsCompanyService.save(sysLogisticsCompany);
		addMessage(redirectAttributes, "保存系统物流公司成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysLogisticsCompany/?repage";
	}
	
	@RequiresPermissions("sys:sysLogisticsCompany:edit")
	@RequestMapping(value = "delete")
	public String delete(SysLogisticsCompany sysLogisticsCompany, RedirectAttributes redirectAttributes) {
		sysLogisticsCompanyService.delete(sysLogisticsCompany);
		addMessage(redirectAttributes, "删除系统物流公司成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysLogisticsCompany/?repage";
	}

    // 物流公司选择列表
    @RequiresPermissions("user")
    @RequestMapping(value = "searchLogisticsCompanyList")
    public String searchCarList(SysLogisticsCompany sysLogisticsCompany, HttpServletRequest request, HttpServletResponse response,
                                Model model) {
        Page<SysLogisticsCompany> page = sysLogisticsCompanyService.findPage(new Page<SysLogisticsCompany>(request, response), sysLogisticsCompany);
        model.addAttribute("page", page);
        model.addAttribute("myId", request.getParameter("myId"));
        model.addAttribute("myName", request.getParameter("myName"));
        model.addAttribute("sysLogisticsCompany", sysLogisticsCompany);
        return "modules/tag/searchLogisticsCompanyList";
    }
}