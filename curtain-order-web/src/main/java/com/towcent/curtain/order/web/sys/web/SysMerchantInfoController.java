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
import com.towcent.base.sc.web.common.web.BaseController;
import com.towcent.base.sc.web.common.utils.StringUtils;
import com.towcent.curtain.order.web.sys.entity.SysMerchantInfo;
import com.towcent.curtain.order.web.sys.service.SysMerchantInfoService;

/**
 * 商户管理Controller
 * @author Huangtao
 * @version 2018-08-03
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/sysMerchantInfo")
public class SysMerchantInfoController extends BaseController {

	@Autowired
	private SysMerchantInfoService sysMerchantInfoService;
	
	@ModelAttribute
	public SysMerchantInfo get(@RequestParam(required=false) String id) {
		SysMerchantInfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sysMerchantInfoService.get(id);
		}
		if (entity == null){
			entity = new SysMerchantInfo();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:sysMerchantInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(SysMerchantInfo sysMerchantInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SysMerchantInfo> page = sysMerchantInfoService.findPage(new Page<SysMerchantInfo>(request, response), sysMerchantInfo); 
		model.addAttribute("page", page);
		return "web/sys/sysMerchantInfoList";
	}

	@RequiresPermissions("sys:sysMerchantInfo:view")
	@RequestMapping(value = "form")
	public String form(SysMerchantInfo sysMerchantInfo, Model model) {
		model.addAttribute("sysMerchantInfo", sysMerchantInfo);
		return "web/sys/sysMerchantInfoForm";
	}

	@RequiresPermissions("sys:sysMerchantInfo:edit")
	@RequestMapping(value = "save")
	public String save(SysMerchantInfo sysMerchantInfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysMerchantInfo)){
			return form(sysMerchantInfo, model);
		}
		sysMerchantInfoService.save(sysMerchantInfo);
		addMessage(redirectAttributes, "保存商户管理成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysMerchantInfo/?repage";
	}
	
	@RequiresPermissions("sys:sysMerchantInfo:edit")
	@RequestMapping(value = "delete")
	public String delete(SysMerchantInfo sysMerchantInfo, RedirectAttributes redirectAttributes) {
		sysMerchantInfoService.delete(sysMerchantInfo);
		addMessage(redirectAttributes, "删除商户管理成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysMerchantInfo/?repage";
	}

    // 商户选择列表
    @RequiresPermissions("user")
    @RequestMapping(value = "searchMerchantList")
    public String searchCarList(SysMerchantInfo merchantInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<SysMerchantInfo> page = sysMerchantInfoService.findPage(new Page<SysMerchantInfo>(request, response), merchantInfo);
        model.addAttribute("page", page);
        model.addAttribute("myId", request.getParameter("myId"));
        model.addAttribute("myName", request.getParameter("myName"));
        model.addAttribute("merchantInfo", merchantInfo);
        return "modules/tag/searchMerchantList";
    }
}