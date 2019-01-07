package com.towcent.curtain.order.web.order.service;

import com.google.common.collect.Lists;
import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.service.CrudService;
import com.towcent.base.sc.web.common.utils.StringUtils;
import com.towcent.curtain.order.web.goods.entity.Goods;
import com.towcent.curtain.order.web.mall.entity.ShoppingCart;
import com.towcent.curtain.order.web.mall.service.ShoppingCartService;
import com.towcent.curtain.order.web.order.dao.OrderMainDao;
import com.towcent.curtain.order.web.order.entity.OrderDtl;
import com.towcent.curtain.order.web.order.entity.OrderMain;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import static com.towcent.base.sc.web.common.constant.Constant.DEL_FLAG_1;
import static com.towcent.curtain.order.common.Constant.ORDER_STATUS_1;

/**
 * 订单Service
 *
 * @author HuangTao
 * @version 2018-07-19
 */
@Service
@Transactional(readOnly = true)
public class OrderMainService extends CrudService<OrderMainDao, OrderMain> {

    @Autowired
    private ShoppingCartService shoppingCartService;
    @Autowired
    private OrderDtlService orderDtlService;

    public OrderMain get(String id) {
        return super.get(id);
    }

    public List<OrderMain> findList(OrderMain orderMain) {
        return super.findList(orderMain);
    }

    public Page<OrderMain> findPage(Page<OrderMain> page, OrderMain orderMain) {
        return super.findPage(page, orderMain);
    }

    @Transactional(readOnly = false)
    public void save(OrderMain orderMain) {
        super.save(orderMain);
    }

    @Transactional(readOnly = false)
    public void delete(OrderMain orderMain) {
        super.delete(orderMain);
    }

    @Transactional(readOnly = false)
    public void sendGoods(OrderMain orderMain) {
        super.updateSelective(orderMain);
    }

    @Transactional(readOnly = false)
    public void create(OrderMain orderMain) {
        BigDecimal qty = BigDecimal.ZERO;
        BigDecimal amount = BigDecimal.ZERO;
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
                // amount = amount.add(shoppingCart.getAmount());
                qty = qty.add(shoppingCart.getQty());

                shoppingCartService.delete(shoppingCart);
            }
        }
        orderMain.setOrderDtls(orderDtls);
        orderMain.setOrderType("1");
        orderMain.setOrderNo(creatOrderNo("E"));
        orderMain.setOrderStatus(ORDER_STATUS_1);
        orderMain.setAmount(amount.toString());
        orderMain.setTotalAmount(orderMain.getAmount());
        orderMain.setTotalQty(qty.toString());
        orderMain.setPayAmount(orderMain.getAmount());
        save(orderMain);

        for (OrderDtl entity : orderDtls) {
            entity.setId(null);
            entity.setOrderId(orderMain.getId());
            orderDtlService.save(entity);
        }

    }

    public synchronized String creatOrderNo(String key) {
        SimpleDateFormat sdf = new SimpleDateFormat("MMyyddHHmmss");
        return key + sdf.format(new Date()) + RandomStringUtils.randomNumeric(3);
    }
}