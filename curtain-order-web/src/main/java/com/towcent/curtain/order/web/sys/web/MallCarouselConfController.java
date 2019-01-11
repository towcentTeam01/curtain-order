package com.towcent.curtain.order.web.sys.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.towcent.curtain.order.web.common.utils.MerchantUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.towcent.base.sc.web.common.config.Global;
import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.utils.StringUtils;
import com.towcent.base.sc.web.common.web.BaseController;
import com.towcent.base.sc.web.modules.sys.entity.SysCarouselConf;
import com.towcent.base.sc.web.modules.sys.service.SysCarouselConfService;
import com.towcent.base.sc.web.modules.sys.utils.UserUtils;

/**
 * 轮播图配置表Controller
 * @author licheng
 * @version 2018-04-18
 */
@Controller("mallCarouselConf")
@RequestMapping(value = "${adminPath}/mall/sysCarouselConf")
public class MallCarouselConfController extends BaseController {

	@Autowired
	private SysCarouselConfService sysCarouselConfService;
	
	@ModelAttribute
	public SysCarouselConf get(@RequestParam(required=false) String id) {
		SysCarouselConf entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sysCarouselConfService.get(id);
		}
		if (entity == null){
			entity = new SysCarouselConf();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:sysCarouselConf:view")
	@RequestMapping(value = {"list", ""})
	public String list(SysCarouselConf sysCarouselConf, HttpServletRequest request, HttpServletResponse response, Model model) {
		sysCarouselConf.setMerchantId(MerchantUtils.getMerchantId(request));
		Page<SysCarouselConf> page = sysCarouselConfService.findPage(new Page<SysCarouselConf>(request, response), sysCarouselConf); 
		model.addAttribute("page", page);
		return "modules/carousel/sysCarouselConfList";
	}

	@RequiresPermissions("sys:sysCarouselConf:view")
	@RequestMapping(value = "form")
	public String form(SysCarouselConf sysCarouselConf, Model model) {
		model.addAttribute("sysCarouselConf", sysCarouselConf);
		return "modules/carousel/sysCarouselConfForm";
	}

	@RequiresPermissions("sys:sysCarouselConf:edit")
	@RequestMapping(value = "save")
	public String save(SysCarouselConf sysCarouselConf, Model model,HttpServletRequest request, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysCarouselConf)){
			return form(sysCarouselConf, model);
		}
		if (StringUtils.isBlank(sysCarouselConf.getId())) {
			sysCarouselConf.setMerchantId(MerchantUtils.getMerchantId(request));
		}
		sysCarouselConfService.save(sysCarouselConf);
		addMessage(redirectAttributes, "保存轮播图配置表成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysCarouselConf/?repage";
	}
	
	@RequiresPermissions("sys:sysCarouselConf:edit")
	@RequestMapping(value = "delete")
	public String delete(SysCarouselConf sysCarouselConf, RedirectAttributes redirectAttributes) {
		sysCarouselConfService.delete(sysCarouselConf);
		addMessage(redirectAttributes, "删除轮播图配置表成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysCarouselConf/?repage";
	}

	@RequiresPermissions("sys:sysCarouselConf:edit")
	@ResponseBody
	@RequestMapping(value = "changeSort", method = RequestMethod.POST)
	public void changeSort(SysCarouselConf sysCarouselConf) {
		sysCarouselConfService.save(sysCarouselConf);
	}

}