package com.towcent.curtain.order.web.order.web;

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
import com.towcent.base.sc.web.common.web.BaseController;
import com.towcent.base.sc.web.common.utils.StringUtils;
import com.towcent.curtain.order.web.order.entity.OrderDtl;
import com.towcent.curtain.order.web.order.service.OrderDtlService;

/**
 * 订单明细Controller
 * @author HuangTao
 * @version 2018-07-19
 */
@Controller
@RequestMapping(value = "${adminPath}/order/orderDtl")
public class OrderDtlController extends BaseController {

	@Autowired
	private OrderDtlService orderDtlService;
	
	@ModelAttribute
	public OrderDtl get(@RequestParam(required=false) String id) {
		OrderDtl entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = orderDtlService.get(id);
		}
		if (entity == null){
			entity = new OrderDtl();
		}
		return entity;
	}
	
	@RequiresPermissions("order:orderDtl:view")
	@RequestMapping(value = {"list", ""})
	public String list(OrderDtl orderDtl, HttpServletRequest request, HttpServletResponse response, Model model) {
		orderDtl.setMerchantId(MerchantUtils.getMerchantId(request));
		Page<OrderDtl> page = orderDtlService.findPage(new Page<OrderDtl>(request, response), orderDtl); 
		model.addAttribute("page", page);
		return "web/order/orderDtlList";
	}

	@RequiresPermissions("order:orderDtl:view")
	@RequestMapping(value = "form")
	public String form(OrderDtl orderDtl, Model model) {
		model.addAttribute("orderDtl", orderDtl);
		return "web/order/orderDtlForm";
	}

	@RequiresPermissions("order:orderDtl:edit")
	@RequestMapping(value = "save")
	public String save(OrderDtl orderDtl, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, orderDtl)){
			return form(orderDtl, model);
		}
		orderDtlService.save(orderDtl);
		addMessage(redirectAttributes, "保存订单明细成功");
		return "redirect:"+Global.getAdminPath()+"/order/orderDtl/?repage";
	}
	
	@RequiresPermissions("order:orderDtl:edit")
	@RequestMapping(value = "delete")
	public String delete(OrderDtl orderDtl, RedirectAttributes redirectAttributes) {
		orderDtlService.delete(orderDtl);
		addMessage(redirectAttributes, "删除订单明细成功");
		return "redirect:"+Global.getAdminPath()+"/order/orderDtl/?repage";
	}

}