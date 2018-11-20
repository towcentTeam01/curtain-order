package com.towcent.curtain.order.web.mall.web;

import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.utils.StringUtils;
import com.towcent.base.sc.web.common.web.BaseController;
import com.towcent.base.sc.web.modules.sys.utils.UserUtils;
import com.towcent.curtain.order.web.goods.entity.ConcernGoods;
import com.towcent.curtain.order.web.goods.entity.Goods;
import com.towcent.curtain.order.web.goods.service.ConcernGoodsService;
import com.towcent.curtain.order.web.goods.service.GoodsService;
import com.towcent.curtain.order.web.mall.entity.ShoppingCart;
import com.towcent.curtain.order.web.sys.entity.SysMerchantInfo;
import com.towcent.curtain.order.web.sys.service.SysMerchantInfoService;
import com.towcent.curtain.order.web.sys.service.SysUserMerchantRelService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.List;

import static com.towcent.base.common.constants.BaseConstant.E_001;
import static com.towcent.curtain.order.common.Constant.GOODS_STATUS_2;

/**
 * 商品Controller
 * @author Huangtao
 * @version 2018-07-15
 */
@Controller
@RequestMapping(value = "${adminPath}/mall/goods")
public class MallGoodsController extends BaseController {

	@Autowired
	private GoodsService goodsService;

	@Autowired
	private ConcernGoodsService concernGoodsService;
	@Autowired
	private SysMerchantInfoService sysMerchantInfoService;

	private Integer getMerchantId(HttpServletRequest request) {
		try {
			String uri = request.getServerName();
			if (StringUtils.isNotBlank(uri)) {
				String mid = sysMerchantInfoService.getMerchantId(uri);
				return null != mid ? Integer.parseInt(mid) : null;
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		return null;
	}


	@ModelAttribute
	public Goods get(@RequestParam(required=false) String id) {
		Goods entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = goodsService.get(id);
		}
		if (entity == null){
			entity = new Goods();
			entity.setMerchantId(UserUtils.getMerchantId());
		}
		return entity;
	}
	
	@RequestMapping(value = {"list", ""})
	public String list(Goods goods, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Goods> p = new Page<Goods>(request, response);
		p.setOrderBy("a.create_date DESC");
		goods.setMerchantId(getMerchantId(request));
		goods.setGoodsStatus(GOODS_STATUS_2);
		Page<Goods> page = goodsService.findPage(p, goods);
		model.addAttribute("page", page);
		return "web/mall/goodsList";
	}

	@RequestMapping(value = "detail")
	public String form(ShoppingCart shoppingCart, Model model) {
		Goods goods = get(shoppingCart.getGoodsId());

		String isCollect = "0";

		ConcernGoods concernGoods = new ConcernGoods();
		concernGoods.setGoods(goods);
		concernGoods.setCreateBy(UserUtils.getUser());
		List<ConcernGoods> list = concernGoodsService.findList(concernGoods);
		if(!CollectionUtils.isEmpty(list)){
			isCollect = "1";
		}
		model.addAttribute("isCollect", isCollect);
		model.addAttribute("goods", goods);
		return "web/mall/goodsDetail";
	}

}