package com.towcent.curtain.order.web.mall.web;

import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.sc.web.common.config.Global;
import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.utils.StringUtils;
import com.towcent.base.sc.web.common.web.BaseController;
import com.towcent.base.sc.web.modules.sys.entity.User;
import com.towcent.base.sc.web.modules.sys.utils.UserUtils;
import com.towcent.curtain.order.web.goods.entity.ConcernGoods;
import com.towcent.curtain.order.web.goods.entity.Goods;
import com.towcent.curtain.order.web.goods.service.ConcernGoodsService;
import com.towcent.curtain.order.web.goods.service.GoodsService;
import com.towcent.curtain.order.web.mall.entity.ShoppingCart;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.List;

import static com.towcent.base.common.constants.BaseConstant.E_000;
import static com.towcent.base.common.constants.BaseConstant.E_001;

/**
 * 关注商品Controller
 * @author HuangTao
 * @version 2018-07-19
 */
@Controller
@RequestMapping(value = "${adminPath}/mall/concernGoods")
public class MallConcernGoodsController extends BaseController {

	@Autowired
	private ConcernGoodsService concernGoodsService;

	@Autowired
	private GoodsService goodsService;


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
	
	@RequiresPermissions("mall:concernGoods:view")
	@RequestMapping(value = {"list", ""})
	public String list(ConcernGoods concernGoods, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ConcernGoods> p = new Page<ConcernGoods>(request, response);
		p.setOrderBy("a.create_date DESC");
		concernGoods.setCreateBy(UserUtils.getUser());
		Page<ConcernGoods> page = concernGoodsService.findPage(p, concernGoods); 
		if (null != page && !CollectionUtils.isEmpty(page.getList())) {
			for (ConcernGoods g : page.getList()) {
				String mainUrls = g.getGoods().getMainUrls();
				String firstUrl = StringUtils.substringBefore(mainUrls, ";");
				g.getGoods().setGoodsPicUrl(firstUrl.replaceAll(".jpg", "_300.jpg"));
				g.setPicUrl(firstUrl + "?v=" + g.getGoods().getDescPicV());
			}
		}
		model.addAttribute("page", page);
		return "web/mall/concernGoodsList";
	}

	@RequiresPermissions("mall:concernGoods:view")
	@RequestMapping(value = "form")
	public String form(ConcernGoods concernGoods, Model model) {
		model.addAttribute("concernGoods", concernGoods);
		return "web/mall/concernGoodsForm";
	}

	@RequiresPermissions("mall:concernGoods:edit")
	@RequestMapping(value = "save")
	public String save(ConcernGoods concernGoods, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, concernGoods)){
			return form(concernGoods, model);
		}
		concernGoodsService.save(concernGoods);
		addMessage(redirectAttributes, "保存关注商品成功");
		return "redirect:"+Global.getAdminPath()+"/mall/concernGoods/?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(ConcernGoods concernGoods, RedirectAttributes redirectAttributes) {
		concernGoodsService.delete(concernGoods);
		addMessage(redirectAttributes, "删除关注商品成功");
		return "redirect:"+Global.getAdminPath()+"/mall/concernGoods/?repage";
	}

	@ResponseBody
	@RequestMapping(value = "collect")
	public ResultVo collect(@RequestParam(required = true) String goodsId) {
		ResultVo resultVo = new ResultVo();
		try {

			User sysUser = UserUtils.getUser();
			if (null == sysUser) {
				return resultVo(resultVo, E_001, "请登录后操作");
			}

			Goods goods = goodsService.get(goodsId);
			if (null == goods) {
				return resultVo(resultVo, E_001, "该商品已下架");
			}

			ConcernGoods concernGoods = new ConcernGoods();
			concernGoods.setGoods(goods);
			concernGoods.setCreateBy(sysUser);
			List<ConcernGoods> list = concernGoodsService.findList(concernGoods);
			if(!CollectionUtils.isEmpty(list)){
				return resultVo(resultVo, E_001, "您已经收藏过商品");
			}

			concernGoods.setCreateBy(sysUser);
			concernGoodsService.save(concernGoods);

			return resultVo(resultVo, E_000, "收藏成功");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return resultVo(resultVo, E_001, "系统异常，请稍候再试");
	}

	protected ResultVo resultVo(ResultVo vo, String code, String message) {
		vo.setCode(code);
		vo.setErrorMessage(message);
		return vo;
	}


}