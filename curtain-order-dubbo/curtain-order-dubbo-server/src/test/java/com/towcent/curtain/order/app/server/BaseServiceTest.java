package com.towcent.curtain.order.app.server;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * 
 * 所有Service层测试请继承这个类
 * @author huangtao
 *
 */
@RunWith(value = SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = "/spring-service-test.xml")
public abstract class BaseServiceTest {
	
}