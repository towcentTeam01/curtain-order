package com.towcent.curtain.order.web.mall.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.sc.web.modules.sys.entity.User;
import com.towcent.base.sc.web.modules.sys.utils.UserUtils;
import com.towcent.curtain.order.app.client.sys.dto.SysFrontAccount;
import com.towcent.curtain.order.common.Constant;
import com.towcent.curtain.order.web.config.entity.SysLogisticsCompanyMerchant;
import com.towcent.curtain.order.web.config.service.SysLogisticsCompanyMerchantService;
import com.towcent.curtain.order.web.goods.entity.Goods;
import com.towcent.curtain.order.web.goods.service.GoodsService;
import com.towcent.curtain.order.web.order.entity.OrderDtl;
import com.towcent.curtain.order.web.order.entity.OrderMain;
import com.towcent.curtain.order.web.order.service.OrderMainService;
import com.towcent.curtain.order.web.sys.service.ConsigneeAddrService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.towcent.base.sc.web.common.config.Global;
import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.web.BaseController;
import com.towcent.base.sc.web.common.utils.StringUtils;
import com.towcent.curtain.order.web.mall.entity.ShoppingCart;
import com.towcent.curtain.order.web.mall.service.ShoppingCartService;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import static com.towcent.base.common.constants.BaseConstant.E_000;
import static com.towcent.base.common.constants.BaseConstant.E_001;
import static com.towcent.curtain.order.common.Constant.GOODS_STATUS_2;

/**
 * 购物车Controller
 *
 * @author yxp
 * @version 2018-10-17
 */
@Controller
@RequestMapping(value = "${adminPath}/mall/shoppingCart")
public class ShoppingCartController extends BaseController {

    @Autowired
    private ShoppingCartService shoppingCartService;

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private ConsigneeAddrService consigneeAddrService;

    @Autowired
    private SysLogisticsCompanyMerchantService logisticsCompanyMerchantService;

    @ModelAttribute
    public ShoppingCart get(@RequestParam(required = false) String id) {
        ShoppingCart entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = shoppingCartService.get(id);
        }
        if (entity == null) {
            entity = new ShoppingCart();
        }
        return entity;
    }

    @RequiresPermissions("mall:shoppingCart:view")
    @RequestMapping(value = {"list", ""})
    public String list(ShoppingCart shoppingCart, HttpServletRequest request, HttpServletResponse response, Model model) {
        shoppingCart.setCreateBy(UserUtils.getUser());
        Page<ShoppingCart> page = shoppingCartService.findPage(new Page<ShoppingCart>(request, response), shoppingCart);
        model.addAttribute("page", page);
        return "web/mall/shoppingCartList";
    }

    @RequiresPermissions("mall:shoppingCart:view")
    @RequestMapping(value = "form")
    public String form(ShoppingCart shoppingCart, Model model) {
        model.addAttribute("shoppingCart", shoppingCart);
        return "web/mall/shoppingCartForm";
    }

    @RequiresPermissions("mall:shoppingCart:edit")
    @RequestMapping(value = "save")
    public String save(ShoppingCart shoppingCart, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, shoppingCart)) {
            return form(shoppingCart, model);
        }
        Goods goods = goodsService.get(shoppingCart.getGoodsId());
        shoppingCart.setPrice(new BigDecimal(goods.getPrice()));
        shoppingCart.setNum(1);
        shoppingCart.setQty(shoppingCart.getLength().multiply(new BigDecimal(shoppingCart.getNum().toString())));
        shoppingCart.setAmount(shoppingCart.getPrice().multiply(shoppingCart.getQty()));
        shoppingCart.setGoodsName(goods.getGoodsName());
        shoppingCart.setGoodsPicUrl(goods.getGoodsPicUrl());
        shoppingCartService.save(shoppingCart);
        addMessage(redirectAttributes, "保存购物车成功");
        return "redirect:" + Global.getAdminPath() + "/mall/shoppingCart/?repage";
    }

    @RequiresPermissions("mall:shoppingCart:edit")
    @RequestMapping(value = "delete")
    public String delete(ShoppingCart shoppingCart, RedirectAttributes redirectAttributes) {
        shoppingCartService.delete(shoppingCart);
        addMessage(redirectAttributes, "删除购物车成功");
        return "redirect:" + Global.getAdminPath() + "/mall/shoppingCart/?repage";
    }

    @ResponseBody
    @RequestMapping(value = "addToCart")
    public ResultVo addToCart(ShoppingCart shoppingCart) {
        ResultVo resultVo = new ResultVo();
        try {

            User sysUser = UserUtils.getUser();
            if (null == sysUser) {
                return resultVo(resultVo, E_001, "请登录后操作");
            }

            if (null == shoppingCart.getHigh()) {
                // return resultVo(resultVo, E_001, "成品高为必填项");
            }

            if (null == shoppingCart.getLength()) {
                return resultVo(resultVo, E_001, "成品宽为必填项");
            }
            if (null == shoppingCart.getMultiple()) {
                return resultVo(resultVo, E_001, "褶数为必填项");
            }

            if (StringUtils.isBlank(shoppingCart.getGoodsId())) {
                return resultVo(resultVo, E_001, "请选择购买商品");
            }

            Goods goods = goodsService.get(shoppingCart.getGoodsId());
            if (null == goods) {
                return resultVo(resultVo, E_001, "该商品已下架");
            }

//            if (!GOODS_STATUS_2.equals(goods.getGoodsStatus())) {
//                return resultVo(resultVo, E_001, "该商品已下架");
//            }

            // shoppingCart.setPrice(new BigDecimal(goods.getPrice()));
            shoppingCart.setNum(1);
            shoppingCart.setQty(shoppingCart.getLength().multiply(shoppingCart.getMultiple()));
            // shoppingCart.setAmount(shoppingCart.getPrice().multiply(shoppingCart.getQty()));

            shoppingCart.setGoodsName(goods.getGoodsName());
            shoppingCart.setGoodsPicUrl(goods.getGoodsPicUrl());
            shoppingCart.setCreateBy(sysUser);
            shoppingCartService.save(shoppingCart);

            resultVo.setData(shoppingCart);

            return resultVo(resultVo, E_000, "添加到购车成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultVo(resultVo, E_001, "系统异常，请稍候再试");
    }


    @RequestMapping(value = "toConfirm")
    public String toConfirm(OrderMain orderMain, Model model) {
        List<OrderDtl> orderDtls = Lists.newArrayList();
        String[] idArr = StringUtils.split(orderMain.getIds(), ";");
        if (null != idArr && idArr.length > 0) {
            for (String key : idArr) {
                OrderDtl dtl = new OrderDtl();
                ShoppingCart shoppingCart = shoppingCartService.get(key);
                BeanUtils.copyProperties(shoppingCart, dtl);
                Goods goods = new Goods();
                goods.setGoodsPicUrl(shoppingCart.getGoodsPicUrl());
                goods.setGoodsName(shoppingCart.getGoodsName());
                goods.setId(shoppingCart.getGoodsId());
                dtl.setGoods(goods);
                orderDtls.add(dtl);
            }
        }
        orderMain.setOrderDtls(orderDtls);
        model.addAttribute("orderMain", orderMain);
        model.addAttribute("mapList", getExpressCompany());
        return "web/mall/toConfirm";
    }

    public List<Map<String, Object>> getExpressCompany() {
        List<Map<String, Object>> mapList = Lists.newArrayList();
        SysLogisticsCompanyMerchant expressCompany = new SysLogisticsCompanyMerchant();
        expressCompany.setMerchantId(UserUtils.getMerchantId());
        expressCompany.setDelFlag(Constant.DEL_FLAG_0);
        List<SysLogisticsCompanyMerchant> list = logisticsCompanyMerchantService.findList(expressCompany);
        for (SysLogisticsCompanyMerchant entity : list) {
            Map<String, Object> map = Maps.newHashMap();
            map.put("id", entity.getCompany().getId());
            map.put("code", entity.getCompany().getCompanyNo());
            map.put("name", entity.getCompany().getCompanyName());
            mapList.add(map);
        }
        return mapList;
    }

    protected ResultVo resultVo(ResultVo vo, String code, String message) {
        vo.setCode(code);
        vo.setErrorMessage(message);
        return vo;
    }

}