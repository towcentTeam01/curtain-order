package com.towcent.curtain.order.web.sys.web;

import static com.towcent.base.common.constants.BaseConstant.E_000;
import static com.towcent.base.common.constants.BaseConstant.YES;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.sc.web.common.config.Global;
import com.towcent.base.sc.web.common.persistence.Page;
import com.towcent.base.sc.web.common.web.BaseController;
import com.towcent.base.sc.web.modules.sys.entity.User;
import com.towcent.base.sc.web.modules.sys.utils.UserUtils;
import com.towcent.base.sc.web.common.utils.StringUtils;
import com.towcent.curtain.order.web.sys.entity.SysUserMerchantRel;
import com.towcent.curtain.order.web.sys.service.SysUserMerchantRelService;

/**
 * 商户用户关系Controller
 * @author HuangTao
 * @version 2018-08-03
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/sysUserMerchantRel")
public class SysUserMerchantRelController extends BaseController {

	@Autowired
	private SysUserMerchantRelService sysUserMerchantRelService;
	
	@ModelAttribute
	public SysUserMerchantRel get(@RequestParam(required=false) String id) {
		SysUserMerchantRel entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sysUserMerchantRelService.get(id);
		}
		if (entity == null){
			entity = new SysUserMerchantRel();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:sysUserMerchantRel:view")
	@RequestMapping(value = {"list", ""})
	public String list(SysUserMerchantRel sysUserMerchantRel, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SysUserMerchantRel> page = sysUserMerchantRelService.findPage(new Page<SysUserMerchantRel>(request, response), sysUserMerchantRel); 
		model.addAttribute("page", page);
		return "web/sys/sysUserMerchantRelList";
	}

	@RequiresPermissions("sys:sysUserMerchantRel:view")
	@RequestMapping(value = "form")
	public String form(SysUserMerchantRel sysUserMerchantRel, Model model) {
		model.addAttribute("sysUserMerchantRel", sysUserMerchantRel);
		return "web/sys/sysUserMerchantRelForm";
	}

	@RequiresPermissions("sys:sysUserMerchantRel:edit")
	@RequestMapping(value = "save")
	public String save(SysUserMerchantRel sysUserMerchantRel, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysUserMerchantRel)){
			return form(sysUserMerchantRel, model);
		}
		sysUserMerchantRelService.save(sysUserMerchantRel);
		addMessage(redirectAttributes, "保存商户用户关系成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysUserMerchantRel/?repage";
	}
	
	@RequiresPermissions("sys:sysUserMerchantRel:edit")
	@RequestMapping(value = "delete")
	public String delete(SysUserMerchantRel sysUserMerchantRel, RedirectAttributes redirectAttributes) {
		sysUserMerchantRelService.delete(sysUserMerchantRel);
		addMessage(redirectAttributes, "删除商户用户关系成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysUserMerchantRel/?repage";
	}

    @ResponseBody
    @RequestMapping(value = "getMerchantList")
    public List<Map<String, Object>> getMerchantList(SysUserMerchantRel sysUserMerchantRel) {
        List<Map<String, Object>> mapList = Lists.newArrayList();
        try {
            User user = UserUtils.getUser();
            sysUserMerchantRel.setUser(user);
            List<SysUserMerchantRel> list = sysUserMerchantRelService.findList(sysUserMerchantRel);
            if (!CollectionUtils.isEmpty(list)) {
                for (SysUserMerchantRel entity : list) {
                    Map<String, Object> map = Maps.newHashMap();
                    map.put("id", entity.getMerchant().getId());
                    map.put("no", entity.getMerchant().getMerchantNo());
                    map.put("name", entity.getMerchant().getMerchantName());
                    map.put("logo", entity.getMerchant().getLogo());
                    if (null != user.getMerchantId() && entity.getMerchant().getId().equals(user.getMerchantId()+"")) {
                        map.put("sel", YES);
                    }
                    mapList.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mapList;
    }

    @ResponseBody
    @RequestMapping(value = "changeBindShop")
    public ResultVo changeBindShop(
            @RequestParam(required = false) Integer merchantId) {
        ResultVo resultVo = new ResultVo();
        UserUtils.updateUserMerchant(merchantId);
        resultVo.setErrorMessage("切换成功");
        resultVo.setCode(E_000);
        return resultVo;
    }
}