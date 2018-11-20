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
import com.towcent.curtain.order.common.Constant;
import com.towcent.curtain.order.web.goods.entity.ChannelGoods;
import com.towcent.curtain.order.web.goods.entity.GoodsChannelDtl;
import com.towcent.curtain.order.web.goods.service.GoodsChannelDtlService;
import com.towcent.curtain.order.web.goods.service.GoodsChannelService;

/**
 * 商品频道详情Controller
 *
 * @author yxp
 * @version 2018-07-09
 */
@Controller
@RequestMapping(value = "${adminPath}/goods/goodsChannelDtl")
public class GoodsChannelDtlController extends BaseController {

  @Autowired private GoodsChannelDtlService goodsChannelDtlService;
  @Autowired private GoodsChannelService goodsChannelService;

  @ModelAttribute
  public GoodsChannelDtl get(@RequestParam(required = false) String id) {
    GoodsChannelDtl entity = null;
    if (StringUtils.isNotBlank(id)) {
      entity = goodsChannelDtlService.get(id);
    }
    if (entity == null) {
      entity = new GoodsChannelDtl();
      entity.setMerchantId(UserUtils.getMerchantId());
    }
    return entity;
  }

  @RequestMapping(value = {"list", ""})
  public String list(
      ChannelGoods channelGoods,
      HttpServletRequest request,
      HttpServletResponse response,
      Model model) {
    channelGoods.setMerchantId(MerchantUtils.getMerchantId(request));
    channelGoods.setGoodsStatus(Constant.GOODS_STATUS_2);
    Page<ChannelGoods> page =
        goodsChannelDtlService.findChannelGoodsPage(
            new Page<ChannelGoods>(request, response), channelGoods);
    model.addAttribute("page", page);
    model.addAttribute("channel", goodsChannelService.get(channelGoods.getChannelId()));
    model.addAttribute("channelGoods", channelGoods);
    return "web/goods/goodsAssign";
  }

  @RequiresPermissions("goods:goodsChannelDtl:view")
  @RequestMapping(value = "form")
  public String form(GoodsChannelDtl goodsChannelDtl, Model model) {
    model.addAttribute("goodsChannelDtl", goodsChannelDtl);
    return "web/goods/goodsChannelDtlForm";
  }

  @RequiresPermissions("goods:goodsChannelDtl:edit")
  @RequestMapping(value = "save")
  public String save(
      GoodsChannelDtl goodsChannelDtl, Model model,HttpServletRequest request, RedirectAttributes redirectAttributes) {
    if (!beanValidator(model, goodsChannelDtl)) {
      return form(goodsChannelDtl, model);
    }
    goodsChannelDtl.setMerchantId(MerchantUtils.getMerchantId(request));
    goodsChannelDtlService.save(goodsChannelDtl);
    addMessage(redirectAttributes, "保存商品频道详情成功");
    return "redirect:" + Global.getAdminPath() + "/goods/goodsChannelDtl/?repage";
  }

  @RequiresPermissions("goods:goodsChannelDtl:edit")
  @RequestMapping(value = "delete")
  public String delete(GoodsChannelDtl goodsChannelDtl, RedirectAttributes redirectAttributes) {
    goodsChannelDtlService.delete(goodsChannelDtl);
    addMessage(redirectAttributes, "删除商品频道详情成功");
    return "redirect:" + Global.getAdminPath() + "/goods/goodsChannelDtl/?repage";
  }

  /** 确定商品分类 */
  @RequestMapping(value = "assign")
  public String assign(
      String goodsIds, String channelId, RedirectAttributes redirectAttributes, Model model) {
    addMessage(redirectAttributes, "商品分配成功");
    goodsChannelDtlService.assign(goodsIds.split(","), channelId, true);
    return "redirect:"
        + Global.getAdminPath()
        + "/goods/goodsChannelDtl/list?channelId="
        + channelId;
  }

  /** 确定商品分类 */
  @RequestMapping(value = "cancle")
  public String unAssign(
      String goodsIds, String channelId, RedirectAttributes redirectAttributes, Model model) {
    addMessage(redirectAttributes, "商品取消分配成功");
    goodsChannelDtlService.assign(goodsIds.split(","), channelId, false);
    return "redirect:"
        + Global.getAdminPath()
        + "/goods/goodsChannelDtl/list?channelId="
        + channelId;
  }
}
