package com.towcent.curtain.order.app.server.pay;

import com.egzosn.pay.ali.bean.AliTransactionType;
import com.egzosn.pay.common.bean.MethodType;
import com.egzosn.pay.common.bean.PayOrder;
import com.egzosn.pay.wx.bean.WxTransactionType;
import com.towcent.base.pay.service.PayResponse;
import com.towcent.curtain.order.app.server.BaseServiceTest;
import com.towcent.base.service.PayAccountService;
import org.junit.Test;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;
import java.util.UUID;

public class PayAccountTest extends BaseServiceTest {
	
	@Resource PayAccountService payService;
	
	@Test public void getById() {
		PayResponse payResponse = payService.getPayResponse(1);
		System.out.println(payResponse);
	}

	@Test public void getById2() {
		//获取对应的支付账户操作工具（可根据账户id）
		PayResponse payResponse = payService.getPayResponse(2);

		PayOrder order = new PayOrder("订单title", "摘要", new BigDecimal(0.01), UUID.randomUUID().toString().replace("-", ""), AliTransactionType.SWEEPPAY);

		Map orderInfo = payResponse.getService().orderInfo(order);
		payResponse.getService().buildRequest(orderInfo, MethodType.POST);

	}

	@Test public void toWxQrPay() throws IOException {
		PayResponse payResponse = payService.getPayResponse(1);

		PayOrder order = new PayOrder("订单title", "摘要", new BigDecimal(0.01), UUID.randomUUID().toString().replace("-", ""), WxTransactionType.NATIVE);

		ByteArrayOutputStream baos = new ByteArrayOutputStream();

		ImageIO.write(payResponse.getService().genQrPay(order), "PNG", baos);

		byte[] bs = baos.toByteArray();

		File file = new File("d:/1.PNG");
		FileOutputStream out = new FileOutputStream(file);
		out.write(bs);
		out.close();
	}
}