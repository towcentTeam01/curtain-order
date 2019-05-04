package com.towcent.curtain.order.web.order.web;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.towcent.base.common.utils.DateUtils;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.sc.web.common.config.Global;
import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.utils.StringUtils;
import com.towcent.base.sc.web.common.web.BaseController;
import com.towcent.base.sc.web.modules.sys.entity.User;
import com.towcent.base.sc.web.modules.sys.utils.UserUtils;
import com.towcent.curtain.order.common.Constant;
import com.towcent.curtain.order.web.common.utils.ExportUtils;
import com.towcent.curtain.order.web.common.utils.MerchantUtils;
import com.towcent.curtain.order.web.config.entity.SysLogisticsCompanyMerchant;
import com.towcent.curtain.order.web.config.service.SysLogisticsCompanyMerchantService;
import com.towcent.curtain.order.web.order.entity.OrderDtl;
import com.towcent.curtain.order.web.order.entity.OrderLog;
import com.towcent.curtain.order.web.order.entity.OrderMain;
import com.towcent.curtain.order.web.order.service.OrderDtlService;
import com.towcent.curtain.order.web.order.service.OrderLogService;
import com.towcent.curtain.order.web.order.service.OrderMainService;
import com.towcent.curtain.order.web.sys.entity.SysMerchantInfo;
import com.towcent.curtain.order.web.sys.service.SysMerchantInfoService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.MessageFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import static com.towcent.base.common.constants.BaseConstant.E_000;
import static com.towcent.base.common.constants.BaseConstant.E_001;

/**
 * 订单Controller
 *
 * @author HuangTao
 * @version 2018-07-19
 */
@Controller
@RequestMapping(value = "${adminPath}/order/orderMain")
public class OrderMainController extends BaseController {

    @Autowired
    private OrderMainService orderMainService;
    @Autowired
    private OrderDtlService orderDtlService;
    @Autowired
    private OrderLogService orderLogService;
    @Autowired
    private SysLogisticsCompanyMerchantService logisticsCompanyMerchantService;
    @Autowired
    private SysMerchantInfoService merchantInfoService;

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

    @RequiresPermissions("order:orderMain:view")
    @RequestMapping(value = {"list", ""})
    public String list(OrderMain orderMain, HttpServletRequest request, HttpServletResponse response, Model model) {
        orderMain.setMerchantId(UserUtils.getMerchantId());
        Page<OrderMain> p = new Page<OrderMain>(request, response);
        orderMain.setMerchantId(MerchantUtils.getMerchantId(request));
        p.setOrderBy("a.create_date DESC");
        Page<OrderMain> page = orderMainService.findPage(p, orderMain);
        model.addAttribute("page", page);
        return "web/order/orderMainList";
    }

    @RequiresPermissions("order:orderMain:view")
    @RequestMapping(value = "form")
    public String form(OrderMain orderMain, Model model) {
        model.addAttribute("orderMain", orderMain);
        return "web/order/orderMainForm";
    }

    @RequiresPermissions("order:orderMain:edit")
    @RequestMapping(value = "save")
    public String save(OrderMain orderMain, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, orderMain)) {
            return form(orderMain, model);
        }
        orderMainService.save(orderMain);

        // 修改订单发货日志
        OrderLog orderLog = new OrderLog();
        orderLog.setOrderId(orderMain.getId());
        orderLog.setContent("修改订单成功");
        orderLog.setCreateBy(UserUtils.getUser());
        orderLog.setCreateDate(new Date());
        orderLogService.save(orderLog);

        addMessage(redirectAttributes, "保存订单成功");
        return "redirect:" + Global.getAdminPath() + "/order/orderMain/?repage";
    }

    @RequiresPermissions("order:orderMain:edit")
    @RequestMapping(value = "delete")
    public String delete(OrderMain orderMain, RedirectAttributes redirectAttributes) {
        // 判断一下当前订单的状态
        orderMain = orderMainService.get(orderMain.getId());
        if (!(StringUtils.equals("0", orderMain.getOrderStatus()) || StringUtils.equals("1", orderMain.getOrderStatus()))) {
            addMessage(redirectAttributes, "该订单状态不允许取消");
            return "redirect:" + Global.getAdminPath() + "/order/orderMain/?repage";
        }
        orderMainService.delete(orderMain);

        // 修改订单发货日志
        OrderLog orderLog = new OrderLog();
        orderLog.setOrderId(orderMain.getId());
        orderLog.setContent("删除订单成功");
        orderLog.setCreateBy(UserUtils.getUser());
        orderLog.setCreateDate(new Date());
        orderLogService.save(orderLog);
        addMessage(redirectAttributes, "删除订单成功");
        return "redirect:" + Global.getAdminPath() + "/order/orderMain/?repage";
    }

    // 订单查看
    @RequiresPermissions("order:orderMain:view")
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

        return "web/order/orderDetail";
    }

    @ResponseBody
    @RequestMapping(value = "sendGoods")
    public ResultVo sendGoods(
            @RequestParam(required = true) String id,
            String freightNumber,
            String logisticsNo,
            String logisticsName,
            String freightRemark) {
        ResultVo resultVo = new ResultVo();
        try {
            OrderMain entity = orderMainService.get(id);
            if (null != entity) {
                if (Constant.ORDER_STATUS_5.equals(entity.getOrderStatus())) {
                    entity.setOrderStatus(Constant.ORDER_STATUS_6);
                    entity.setLogisticsNo(logisticsNo);
                    if (StringUtils.isNotBlank(freightRemark)) {
                        entity.setLogisticsName(freightRemark);
                    } else {
                        entity.setLogisticsName(logisticsName);
                    }
                    entity.setFreightNumber(freightNumber);
                    entity.setDeliveryTime(new Date());

                    User user = UserUtils.getUser();
                    orderMainService.sendGoods(entity, user);

                    return resultVo(resultVo, E_000, "发货成功");

                } else {
                    return resultVo(resultVo, E_001, "该状态的订单不能执行此操作");
                }
            }

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

    @ResponseBody
    @RequestMapping(value = "checkLogNo")
    public ResultVo checkLogNo(
            @RequestParam(required = false) String freightNumber, String logisticsNo) {
        ResultVo resultVo = new ResultVo();
        try {
            OrderMain entity = new OrderMain();
            entity.setFreightNumber(freightNumber);
            entity.setLogisticsNo(logisticsNo);
            // entity.setLogisticsName(logisticsName);
            List<OrderMain> applyList = orderMainService.findList(entity);
            if (CollectionUtils.isNotEmpty(applyList)) {
                return resultVo(resultVo, E_000, "该物流单号已使用");
            } else {
                return resultVo(resultVo, E_000, "物流单号可以使用");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultVo(resultVo, E_001, "系统异常，请稍候再试");
    }

    @ResponseBody
    @RequestMapping(value = "getExpressCompany")
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

    /**
     * 导出订单数据
     *
     * @param orderMain
     * @param request
     * @param response
     * @param redirectAttributes
     * @return
     * @throws IOException
     */
    @RequiresPermissions("order:orderMain:edit")
    @RequestMapping(value = "export", method = RequestMethod.GET)
    public String exportFile(OrderMain orderMain, HttpServletRequest request,
                             HttpServletResponse response, RedirectAttributes redirectAttributes) throws IOException {
        OutputStream ouputStream = null;
        try {
            // 查询商品品牌名称
            SysMerchantInfo merchant = merchantInfoService.get(orderMain.getMerchantId() + "");
            orderMain.setMerchantName(merchant.getMerchantName());

            OrderDtl orderDtl = new OrderDtl();
            orderDtl.setOrderId(orderMain.getId());
            List<OrderDtl> list = orderDtlService.findList(orderDtl);
            orderMain.setOrderDtls(list);

            String fileName = "订单" + orderMain.getOrderNo();

            ExportUtils export = new ExportUtils();
            XSSFWorkbook wb = export.convert(orderMain);
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-disposition", MessageFormat.format(
                    "attachment;filename={0}_{1}.xlsx", fileName,
                    DateUtils.formatDate(new Date(), "MMddHHmm")));
            ouputStream = response.getOutputStream();
            wb.write(ouputStream);
            ouputStream.flush();

            // 改变导出状态
            OrderMain exportOrder = new OrderMain();
            exportOrder.setId(orderMain.getId());
            exportOrder.setIsExport("1");
            orderMainService.updateSelective(exportOrder);

            // 导出订单日志
            OrderLog orderLog = new OrderLog();
            orderLog.setOrderId(orderMain.getId());
            orderLog.setContent("导出订单成功");
            orderLog.setCreateBy(UserUtils.getUser());
            orderLog.setCreateDate(new Date());
            orderLogService.save(orderLog);

            return null;
        } catch (Exception e) {
            addMessage(redirectAttributes, "导出订单失败！失败信息：" + e.getMessage());
        } finally {
            if (null != ouputStream) {
                ouputStream.close();
            }
        }
        return "redirect:" + adminPath + "/order/orderMain/list?repage";
    }

    @ResponseBody
    @RequestMapping(value = "updateStatus")
    public ResultVo updateStatus(
            @RequestParam(required = true) String id, @RequestParam(required = true) String status, String oldStatus, BigDecimal amount) {
        ResultVo resultVo = new ResultVo();
        try {

            OrderMain orderMain = get(id);
            if (!oldStatus.equals(orderMain.getOrderStatus())) {
                return resultVo(resultVo, E_001, "订单状态已更新，请刷新页面再试");
            }

            if (null != amount && amount.compareTo(BigDecimal.ZERO) > 0) {
                orderMain.setTotalAmount(amount.toString());
                if ("4".equals(oldStatus)) {
                    orderMain.setOrderStatus(status);
                }
            } else {
                orderMain.setOrderStatus(status);
            }
            orderMainService.save(orderMain);

            // 修改订单状态日志
            String msg = "";
            if ("2".equals(status)) {
                msg = "售后审核通过";
            } else if ("3".equals(status)) {
                msg = "财务审核通过";
            } else if ("4".equals(status)) {
                msg = "已下料";
            } else if ("5".equals(status)) {
                msg = "已报价";
            } else if ("7".equals(status)) {
                msg = "已完成";
            }

            OrderLog orderLog = new OrderLog();
            orderLog.setOrderId(orderMain.getId());
            orderLog.setContent(msg);
            orderLog.setCreateBy(UserUtils.getUser());
            orderLog.setCreateDate(new Date());
            orderLogService.save(orderLog);

            return resultVo(resultVo, E_000, "操作成功");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultVo(resultVo, E_001, "系统异常，请稍候再试");
    }

    @ResponseBody
    @RequestMapping(value = "addRemark")
    public ResultVo addRemark(
            @RequestParam(required = true) String id, @RequestParam(required = true) String remark) {
        ResultVo resultVo = new ResultVo();
        try {

            OrderMain orderMain = get(id);
            String remarks = DateUtils.formatDateTime(new Date()) + "：" + remark;
            if (StringUtils.isNotBlank(orderMain.getRemarks())) {
                remarks = orderMain.getRemarks() + "</br>" + remark;
            }
            orderMain.setRemarks(remarks);
            orderMainService.save(orderMain);

            // 添加订单备注日志
            OrderLog orderLog = new OrderLog();
            orderLog.setOrderId(orderMain.getId());
            orderLog.setContent("添加订单备注");
            orderLog.setCreateBy(UserUtils.getUser());
            orderLog.setCreateDate(new Date());
            orderLogService.save(orderLog);

            return resultVo(resultVo, E_000, "操作成功");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultVo(resultVo, E_001, "系统异常，请稍候再试");
    }

}