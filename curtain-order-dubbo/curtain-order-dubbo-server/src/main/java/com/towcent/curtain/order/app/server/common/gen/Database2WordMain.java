/*
 * All rights Reserved, Designed By www..com
 * @Project : sdx-logistics-dubbo-server
 * @Title : Database2WordMain.java
 * @Package : com.towcent.sdx.logistics.app.server.common.gen
 * @date : 2017年12月25日上午11:55:00
 * @Copyright: 2017 www..com Inc. All rights reserved. 
 * 注意：本内容仅限于深圳市前海金田科技有限公司内部传阅，禁止外泄以及用于其他的商业项目
 */
package com.towcent.curtain.order.app.server.common.gen;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.towcent.generator.db.code.gen.dao.GenDataBaseDictDao;

/**
 * @ClassName: Database2WordMain 
 * @Description: 导出数据字典文档
 *
 * @author huangtao
 * @date 2017年12月25日 上午11:55:00
 * @version 1.0.0
 * @Copyright: 2017 www..com Inc. All rights reserved. 
 * 注意：本内容仅限于深圳市前海金田科技有限公司内部传阅，禁止外泄以及用于其他的商业项目
 */
public class Database2WordMain {

	@SuppressWarnings("resource")
	public static void main(String[] args) throws Exception {
		ApplicationContext context = new ClassPathXmlApplicationContext("classpath:META-INF/spring-context.xml");
		
		GenDataBaseDictDao dao = context.getBean(GenDataBaseDictDao.class);
		
		com.towcent.generator.database.doc.Database2WordMain.exportDoc(dao);

	}

}

