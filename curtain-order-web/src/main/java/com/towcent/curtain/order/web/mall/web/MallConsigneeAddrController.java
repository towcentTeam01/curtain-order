package com.towcent.curtain.order.web.mall.web;

import com.towcent.base.sc.web.common.config.Global;
import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.utils.StringUtils;
import com.towcent.base.sc.web.common.web.BaseController;
import com.towcent.base.sc.web.modules.sys.utils.UserUtils;
import com.towcent.curtain.order.web.common.utils.MerchantUtils;
import com.towcent.curtain.order.web.sys.entity.ConsigneeAddr;
import com.towcent.curtain.order.web.sys.service.ConsigneeAddrService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 收货地址Controller
 * @author HuangTao
 * @version 2018-07-19
 */
@Controller
@RequestMapping(value = "${adminPath}/mall/consigneeAddr")
public class MallConsigneeAddrController extends BaseController {

	@Autowired
	private ConsigneeAddrService consigneeAddrService;
	
	@ModelAttribute
	public ConsigneeAddr get(@RequestParam(required=false) String id) {
		ConsigneeAddr entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = consigneeAddrService.get(id);
		}
		if (entity == null){
			entity = new ConsigneeAddr();
		}
		return entity;
	}
	
	@RequiresPermissions("mall:consigneeAddr:view")
	@RequestMapping(value = {"list", ""})
	public String list(ConsigneeAddr consigneeAddr, HttpServletRequest request, HttpServletResponse response, Model model) {
		consigneeAddr.setUser(UserUtils.getUser());
		Page<ConsigneeAddr> page = consigneeAddrService.findPage(new Page<ConsigneeAddr>(request, response), consigneeAddr); 
		model.addAttribute("page", page);
		return "web/mall/consigneeAddrList";
	}

	@RequiresPermissions("mall:consigneeAddr:view")
	@RequestMapping(value = "form")
	public String form(ConsigneeAddr consigneeAddr, Model model) {
		model.addAttribute("consigneeAddr", consigneeAddr);
		return "web/mall/consigneeAddrForm";
	}

	@RequiresPermissions("mall:consigneeAddr:edit")
	@RequestMapping(value = "save")
	public String save(ConsigneeAddr consigneeAddr, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, consigneeAddr)){
			return form(consigneeAddr, model);
		}
		consigneeAddr.setUser(UserUtils.getUser());
		consigneeAddr.setMerchantId(MerchantUtils.getMerchantId(request));
		consigneeAddrService.save(consigneeAddr);
		addMessage(redirectAttributes, "保存收货地址成功");
		return "redirect:"+Global.getAdminPath()+"/mall/consigneeAddr/?repage";
	}
	
	@RequiresPermissions("mall:consigneeAddr:edit")
	@RequestMapping(value = "delete")
	public String delete(ConsigneeAddr consigneeAddr, RedirectAttributes redirectAttributes) {
		consigneeAddrService.delete(consigneeAddr);
		addMessage(redirectAttributes, "删除收货地址成功");
		return "redirect:"+Global.getAdminPath()+"/mall/consigneeAddr/?repage";
	}

}