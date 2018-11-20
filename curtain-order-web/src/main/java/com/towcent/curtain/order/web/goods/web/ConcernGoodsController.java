package com.towcent.curtain.order.web.goods.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.towcent.curtain.order.web.common.utils.MerchantUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.towcent.base.sc.web.common.config.Global;
import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.web.BaseController;
import com.towcent.base.sc.web.common.utils.StringUtils;
import com.towcent.curtain.order.web.goods.entity.ConcernGoods;
import com.towcent.curtain.order.web.goods.service.ConcernGoodsService;

/**
 * 关注商品Controller
 * @author HuangTao
 * @version 2018-07-19
 */
@Controller
@RequestMapping(value = "${adminPath}/goods/concernGoods")
public class ConcernGoodsController extends BaseController {

	@Autowired
	private ConcernGoodsService concernGoodsService;
	
	@ModelAttribute
	public ConcernGoods get(@RequestParam(required=false) String id) {
		ConcernGoods entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = concernGoodsService.get(id);
		}
		if (entity == null){
			entity = new ConcernGoods();
		}
		return entity;
	}
	
	@RequiresPermissions("goods:concernGoods:view")
	@RequestMapping(value = {"list", ""})
	public String list(ConcernGoods concernGoods, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ConcernGoods> p = new Page<ConcernGoods>(request, response);
		p.setOrderBy("a.create_date DESC");
		concernGoods.setMerchantId(MerchantUtils.getMerchantId(request));
		Page<ConcernGoods> page = concernGoodsService.findPage(p, concernGoods); 
		if (null != page && !CollectionUtils.isEmpty(page.getList())) {
			for (ConcernGoods g : page.getList()) {
				String mainUrls = g.getGoods().getMainUrls();
				g.setPicUrl(StringUtils.substringBefore(mainUrls, ";") + "?v=" + g.getGoods().getDescPicV());
			}
		}
		model.addAttribute("page", page);
		return "web/goods/concernGoodsList";
	}

	@RequiresPermissions("goods:concernGoods:view")
	@RequestMapping(value = "form")
	public String form(ConcernGoods concernGoods, Model model) {
		model.addAttribute("concernGoods", concernGoods);
		return "web/goods/concernGoodsForm";
	}

	@RequiresPermissions("goods:concernGoods:edit")
	@RequestMapping(value = "save")
	public String save(ConcernGoods concernGoods, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, concernGoods)){
			return form(concernGoods, model);
		}
		concernGoodsService.save(concernGoods);
		addMessage(redirectAttributes, "保存关注商品成功");
		return "redirect:"+Global.getAdminPath()+"/goods/concernGoods/?repage";
	}
	
	@RequiresPermissions("goods:concernGoods:edit")
	@RequestMapping(value = "delete")
	public String delete(ConcernGoods concernGoods, RedirectAttributes redirectAttributes) {
		concernGoodsService.delete(concernGoods);
		addMessage(redirectAttributes, "删除关注商品成功");
		return "redirect:"+Global.getAdminPath()+"/goods/concernGoods/?repage";
	}

}