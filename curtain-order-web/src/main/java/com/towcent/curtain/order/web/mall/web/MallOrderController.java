package com.towcent.curtain.order.web.mall.web;

import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.sc.web.common.config.Global;
import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.utils.StringUtils;
import com.towcent.base.sc.web.common.web.BaseController;
import com.towcent.base.sc.web.modules.sys.entity.User;
import com.towcent.base.sc.web.modules.sys.utils.UserUtils;
import com.towcent.curtain.order.web.config.service.SysLogisticsCompanyMerchantService;
import com.towcent.curtain.order.web.order.entity.OrderDtl;
import com.towcent.curtain.order.web.order.entity.OrderLog;
import com.towcent.curtain.order.web.order.entity.OrderMain;
import com.towcent.curtain.order.web.order.service.OrderDtlService;
import com.towcent.curtain.order.web.order.service.OrderLogService;
import com.towcent.curtain.order.web.order.service.OrderMainService;
import com.towcent.curtain.order.web.sys.entity.ConsigneeAddr;
import com.towcent.curtain.order.web.sys.service.ConsigneeAddrService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import static com.towcent.base.common.constants.BaseConstant.E_000;
import static com.towcent.base.common.constants.BaseConstant.E_001;
import static com.towcent.curtain.order.common.Constant.ORDER_STATUS_8;

/**
 * 订单Controller
 *
 * @author HuangTao
 * @version 2018-07-19
 */
@Controller
@RequestMapping(value = "${adminPath}/mall/order")
public class MallOrderController extends BaseController {

    @Autowired
    private OrderMainService orderMainService;
    @Autowired
    private OrderDtlService orderDtlService;

    @Autowired
    private ConsigneeAddrService consigneeAddrService;

    @Autowired
    private SysLogisticsCompanyMerchantService logisticsCompanyMerchantService;

    @Autowired
    private OrderLogService orderLogService;

    @ModelAttribute
    public OrderMain get(@RequestParam(required = false) String id) {
        OrderMain entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = orderMainService.get(id);
        }
        if (entity == null) {
            entity = new OrderMain();
        }
        return entity;
    }

    @RequestMapping(value = {"list", ""})
    public String list(OrderMain orderMain, HttpServletRequest request, HttpServletResponse response, Model model) {
        orderMain.setCreateBy(UserUtils.getUser());
        orderMain.setMerchantId(UserUtils.getMerchantId());
        Page<OrderMain> p = new Page<OrderMain>(request, response);
        p.setOrderBy("a.create_date DESC");
        Page<OrderMain> page = orderMainService.findPage(p, orderMain);
        model.addAttribute("page", page);
        return "web/mall/orderList";
    }


    @ResponseBody
    @RequestMapping(value = "crate")
    public ResultVo crate(OrderMain orderMain) {
        ResultVo resultVo = new ResultVo();
        try {

            User sysUser = UserUtils.getUser();
            if (null == sysUser) {
                return resultVo(resultVo, E_001, "请登录后操作");
            }

            if (StringUtils.isBlank(orderMain.getIds())) {
                return resultVo(resultVo, E_001, "请选择购买商品");
            }

            if (StringUtils.isBlank(orderMain.getConsigneeId())) {
                return resultVo(resultVo, E_001, "请选择收获地址");
            }

            if (StringUtils.isBlank(orderMain.getLogisticsNo())) {
                return resultVo(resultVo, E_001, "请选择物流公司");
            }

            ConsigneeAddr consigneeAddr = consigneeAddrService.get(orderMain.getConsigneeId());
            if(null == consigneeAddr){
                return resultVo(resultVo, E_001, "该收获地址已不存在");
            }
            orderMain.setConsigneeAddress(consigneeAddr.getAddress());
            orderMain.setConsigneeName(consigneeAddr.getConsigneeName());
            orderMain.setConsigneePhone(consigneeAddr.getMobilePhone());
            orderMainService.create(orderMain);

            resultVo.setData(orderMain);

            return resultVo(resultVo, E_000, "创建订单成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultVo(resultVo, E_001, "系统异常，请稍候再试");
    }

    protected ResultVo resultVo(ResultVo vo, String code, String message) {
        vo.setCode(code);
        vo.setErrorMessage(message);
        return vo;
    }

    // 订单查看
    @RequestMapping(value = "detail")
    public String detail(OrderMain orderMain, Model model) {
        model.addAttribute("orderMain", orderMain);
        // 订单明细
        OrderDtl orderDtl = new OrderDtl();
        orderDtl.setOrderId(orderMain.getId());
        List<OrderDtl> dlist = orderDtlService.findList(orderDtl);
        model.addAttribute("orderDtlList", dlist);
        // 订单日志
        OrderLog orderLog = new OrderLog();
        orderLog.setOrderId(orderMain.getId());
        Page<OrderLog> page = new Page<OrderLog>();
        page.setOrderBy("a.create_date ASC");
        orderLog.setPage(page);
        List<OrderLog> logList = orderLogService.findList(orderLog);
        model.addAttribute("logList", logList);

        return "web/mall/orderDetail";
    }

    @RequestMapping(value = "delete")
    public String delete(OrderMain orderMain, RedirectAttributes redirectAttributes) {
        orderMain.setOrderStatus(ORDER_STATUS_8);
        orderMainService.save(orderMain);
        addMessage(redirectAttributes, "取消订单成功");
        return "redirect:"+ Global.getAdminPath()+"/mall/order/?repage";
    }
}