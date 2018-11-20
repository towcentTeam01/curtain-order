package com.towcent.curtain.order.web.config.web;

import java.util.Date;

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
import com.towcent.curtain.order.web.config.entity.SysLogisticsCompanyMerchant;
import com.towcent.curtain.order.web.config.service.SysLogisticsCompanyMerchantService;

/**
 * 商家物流配置Controller
 * @author HuangTao
 * @version 2018-07-11
 */
@Controller
@RequestMapping(value = "${adminPath}/config/sysLogisticsCompanyMerchant")
public class SysLogisticsCompanyMerchantController extends BaseController {

	@Autowired
	private SysLogisticsCompanyMerchantService sysLogisticsCompanyMerchantService;
	
	@ModelAttribute
	public SysLogisticsCompanyMerchant get(@RequestParam(required=false) String id) {
		SysLogisticsCompanyMerchant entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sysLogisticsCompanyMerchantService.get(id);
		}
		if (entity == null){
			entity = new SysLogisticsCompanyMerchant();
		}
		return entity;
	}
	
	@RequiresPermissions("config:sysLogisticsCompanyMerchant:view")
	@RequestMapping(value = {"list", ""})
	public String list(SysLogisticsCompanyMerchant sysLogisticsCompanyMerchant, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SysLogisticsCompanyMerchant> page = sysLogisticsCompanyMerchantService.findPage(new Page<SysLogisticsCompanyMerchant>(request, response), sysLogisticsCompanyMerchant); 
		model.addAttribute("page", page);
		return "web/config/sysLogisticsCompanyMerchantList";
	}

	@RequiresPermissions("config:sysLogisticsCompanyMerchant:view")
	@RequestMapping(value = "form")
	public String form(SysLogisticsCompanyMerchant sysLogisticsCompanyMerchant, Model model) {
		model.addAttribute("sysLogisticsCompanyMerchant", sysLogisticsCompanyMerchant);
		return "web/config/sysLogisticsCompanyMerchantForm";
	}

	@RequiresPermissions("config:sysLogisticsCompanyMerchant:edit")
	@RequestMapping(value = "save")
	public String save(SysLogisticsCompanyMerchant sysLogisticsCompanyMerchant, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysLogisticsCompanyMerchant)){
			return form(sysLogisticsCompanyMerchant, model);
		}
		if (null == sysLogisticsCompanyMerchant.getId()) {
			sysLogisticsCompanyMerchant.setCreateDate(new Date());
		}
		sysLogisticsCompanyMerchantService.save(sysLogisticsCompanyMerchant);
		addMessage(redirectAttributes, "保存商家物流配置成功");
		return "redirect:"+Global.getAdminPath()+"/config/sysLogisticsCompanyMerchant/?repage";
	}
	
	@RequiresPermissions("config:sysLogisticsCompanyMerchant:edit")
	@RequestMapping(value = "delete")
	public String delete(SysLogisticsCompanyMerchant sysLogisticsCompanyMerchant, RedirectAttributes redirectAttributes) {
		sysLogisticsCompanyMerchantService.delete(sysLogisticsCompanyMerchant);
		addMessage(redirectAttributes, "删除商家物流配置成功");
		return "redirect:"+Global.getAdminPath()+"/config/sysLogisticsCompanyMerchant/?repage";
	}

}