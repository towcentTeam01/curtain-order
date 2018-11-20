/*
 * All rights Reserved, Designed By www..com
 * @Project : zhengzhou-bank-dubbo-server
 * @Title : CodeMain.java
 * @Package : com.towcent.zz.bank.logistics.app.server
 * @date : 2017年12月25日上午10:18:10
 * @Copyright: 2017 www..com Inc. All rights reserved. 
 * 注意：本内容仅限于深圳市前海金田科技有限公司内部传阅，禁止外泄以及用于其他的商业项目
 */
package com.towcent.curtain.order.app.server.common.gen;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.towcent.generator.db.code.gen.dao.GenDataBaseDictDao;
import com.towcent.generator.db.code.utils.GenUtils;

/**
 * @ClassName: CodeMain 
 * @Description: 生成持久层代码
 *
 * @author huangtao
 * @date 2017年12月25日 上午10:18:10
 * @version 1.0.0
 * @Copyright: 2017 www..com Inc. All rights reserved. 
 * 注意：本内容仅限于深圳市前海金田科技有限公司内部传阅，禁止外泄以及用于其他的商业项目
 */
public class CodeMain {

	@SuppressWarnings("resource")
	public static void main(String[] args) {		
		ApplicationContext context = new ClassPathXmlApplicationContext("classpath:META-INF/spring-context.xml");
		
		GenDataBaseDictDao dao = context.getBean(GenDataBaseDictDao.class);
		GenUtils.generateCode(dao);
		System.out.println("生成代码完毕");
	}
	
}

