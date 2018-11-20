package com.towcent.curtain.order.web.goods.web;

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
import com.towcent.base.sc.web.modules.sys.utils.UserUtils;
import com.towcent.curtain.order.web.goods.entity.GoodsChannel;
import com.towcent.curtain.order.web.goods.service.GoodsChannelService;

/**
 * 商品频道Controller
 * @author yxp
 * @version 2018-07-09
 */
@Controller
@RequestMapping(value = "${adminPath}/goods/goodsChannel")
public class GoodsChannelController extends BaseController {

	@Autowired
	private GoodsChannelService goodsChannelService;
	
	@ModelAttribute
	public GoodsChannel get(@RequestParam(required=false) String id) {
		GoodsChannel entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = goodsChannelService.get(id);
		}
		if (entity == null){
			entity = new GoodsChannel();
			entity.setMerchantId(UserUtils.getMerchantId());
		}
		return entity;
	}
	
	@RequiresPermissions("goods:goodsChannel:view")
	@RequestMapping(value = {"list", ""})
	public String list(GoodsChannel goodsChannel, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page pageDto = new Page<GoodsChannel>(request, response);
		pageDto.setOrderBy("sort");
		goodsChannel.setMerchantId(MerchantUtils.getMerchantId(request));
		Page<GoodsChannel> page = goodsChannelService.findPage(pageDto, goodsChannel);
		model.addAttribute("page", page);
		return "web/goods/goodsChannelList";
	}

	@RequiresPermissions("goods:goodsChannel:view")
	@RequestMapping(value = "form")
	public String form(GoodsChannel goodsChannel, Model model) {
		model.addAttribute("goodsChannel", goodsChannel);
		return "web/goods/goodsChannelForm";
	}

	@RequiresPermissions("goods:goodsChannel:edit")
	@RequestMapping(value = "save")
	public String save(GoodsChannel goodsChannel, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, goodsChannel)){
			return form(goodsChannel, model);
		}
		goodsChannelService.save(goodsChannel);
		addMessage(redirectAttributes, "保存商品频道成功");
		return "redirect:"+Global.getAdminPath()+"/goods/goodsChannel/?repage";
	}
	
	@RequiresPermissions("goods:goodsChannel:edit")
	@RequestMapping(value = "delete")
	public String delete(GoodsChannel goodsChannel, RedirectAttributes redirectAttributes) {
		goodsChannelService.delete(goodsChannel);
		addMessage(redirectAttributes, "删除商品频道成功");
		return "redirect:"+Global.getAdminPath()+"/goods/goodsChannel/?repage";
	}

}