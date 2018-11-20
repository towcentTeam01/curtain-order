package com.towcent.curtain.order.web.order.web;

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
import com.towcent.base.sc.web.modules.sys.utils.UserUtils;
import com.towcent.base.sc.web.common.utils.StringUtils;
import com.towcent.curtain.order.web.order.entity.OrderLog;
import com.towcent.curtain.order.web.order.service.OrderLogService;

/**
 * 订单日志Controller
 * @author HuangTao
 * @version 2018-07-19
 */
@Controller
@RequestMapping(value = "${adminPath}/order/orderLog")
public class OrderLogController extends BaseController {

	@Autowired
	private OrderLogService orderLogService;
	
	@ModelAttribute
	public OrderLog get(@RequestParam(required=false) String id) {
		OrderLog entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = orderLogService.get(id);
		}
		if (entity == null){
			entity = new OrderLog();
		}
		return entity;
	}
	
	@RequiresPermissions("order:orderLog:view")
	@RequestMapping(value = {"list", ""})
	public String list(OrderLog orderLog, HttpServletRequest request, HttpServletResponse response, Model model) {
		orderLog.setMerchantId(UserUtils.getMerchantId());
		Page<OrderLog> p = new Page<OrderLog>(request, response);
		p.setOrderBy("a.create_date ASC");
		Page<OrderLog> page = orderLogService.findPage(p, orderLog); 
		model.addAttribute("page", page);
		return "web/order/orderLogList";
	}

	@RequiresPermissions("order:orderLog:view")
	@RequestMapping(value = "form")
	public String form(OrderLog orderLog, Model model) {
		model.addAttribute("orderLog", orderLog);
		return "web/order/orderLogForm";
	}

	@RequiresPermissions("order:orderLog:edit")
	@RequestMapping(value = "save")
	public String save(OrderLog orderLog, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, orderLog)){
			return form(orderLog, model);
		}
		orderLogService.save(orderLog);
		addMessage(redirectAttributes, "保存订单日志成功");
		return "redirect:"+Global.getAdminPath()+"/order/orderLog/?repage";
	}
	
	@RequiresPermissions("order:orderLog:edit")
	@RequestMapping(value = "delete")
	public String delete(OrderLog orderLog, RedirectAttributes redirectAttributes) {
		orderLogService.delete(orderLog);
		addMessage(redirectAttributes, "删除订单日志成功");
		return "redirect:"+Global.getAdminPath()+"/order/orderLog/?repage";
	}

}