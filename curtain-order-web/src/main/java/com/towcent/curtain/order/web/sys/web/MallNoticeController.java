package com.towcent.curtain.order.web.sys.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.towcent.curtain.order.web.common.utils.MerchantUtils;
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
import com.towcent.base.sc.web.modules.sys.entity.SysNotice;
import com.towcent.base.sc.web.modules.sys.service.SysNoticeService;
import com.towcent.base.sc.web.modules.sys.utils.UserUtils;

/**
 * 系统公告Controller
 * @author licheng
 * @version 2018-03-29
 */
@Controller
@RequestMapping(value = "${adminPath}/mall/sysNotice")
public class MallNoticeController extends BaseController {

	@Autowired
	private SysNoticeService sysNoticeService;
	
	@ModelAttribute
	public SysNotice get(@RequestParam(required=false) String id) {
		SysNotice entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sysNoticeService.get(id);
		}
		if (entity == null){
			entity = new SysNotice();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:sysNotice:view")
	@RequestMapping(value = {"list", ""})
	public String list(SysNotice sysNotice, HttpServletRequest request, HttpServletResponse response, Model model) {
		sysNotice.setMerchantId(MerchantUtils.getMerchantId(request));
		Page<SysNotice> page = sysNoticeService.findPage(new Page<SysNotice>(request, response), sysNotice); 
		model.addAttribute("page", page);
		return "modules/notice/sysNoticeList";
	}

	@RequiresPermissions("sys:sysNotice:view")
	@RequestMapping(value = "form")
	public String form(SysNotice sysNotice, Model model) {
		model.addAttribute("sysNotice", sysNotice);
		return "modules/notice/sysNoticeForm";
	}

	@RequiresPermissions("sys:sysNotice:edit")
	@RequestMapping(value = "save")
	public String save(SysNotice sysNotice, Model model, HttpServletRequest request,RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysNotice)){
			return form(sysNotice, model);
		}
		if (StringUtils.isBlank(sysNotice.getId())) {
			sysNotice.setMerchantId(MerchantUtils.getMerchantId(request));
		}
		sysNoticeService.save(sysNotice);
		addMessage(redirectAttributes, "保存系统公告成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysNotice/?repage";
	}
	
	@RequiresPermissions("sys:sysNotice:edit")
	@RequestMapping(value = "delete")
	public String delete(SysNotice sysNotice, RedirectAttributes redirectAttributes) {
		sysNoticeService.delete(sysNotice);
		addMessage(redirectAttributes, "删除系统公告成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysNotice/?repage";
	}

}