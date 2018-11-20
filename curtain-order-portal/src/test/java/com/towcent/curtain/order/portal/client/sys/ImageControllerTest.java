package com.towcent.curtain.order.portal.client.sys;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.lang3.math.NumberUtils;
import org.junit.Test;

import com.egzosn.pay.common.util.sign.encrypt.Base64;
import com.towcent.curtain.order.portal.client.BaseAppTest;
import com.towcent.curtain.order.portal.sys.vo.input.ImageVo;

/**
 * 
 * 员工端上传图片接口 -- 测试用例
 * @author huangtao
 *
 */
public class ImageControllerTest extends BaseAppTest {
	
	static {
		descMap.put("sys/image/upload", "图片上传");
		descMap.put("sys/image/wxupload", "图片上传");
	}
	
	@Test
	public void upload() throws IOException {
		String path = "sys/image/upload";
		ImageVo paramVo = new ImageVo();
		this.setCommonParam(paramVo);
		//this.setLoginFlag(paramVo);
		paramVo.setImageType(NumberUtils.INTEGER_ZERO);
		String content = sendHttpFile(paramVo, path, "C:\\Users\\Jerry\\Desktop\\图片\\123.jpg");
		System.out.println(content);
	}
	
	@Test
	public void wxUpload() throws IOException {
		String path = "sys/image/wxupload";
		ImageVo paramVo = new ImageVo();
		this.setCommonParam(paramVo);
		this.setLoginFlag(paramVo);
		paramVo.setImageData(this.getImageStr("d:\\img.jpg"));
		paramVo.setImageType(NumberUtils.INTEGER_ZERO);
		// String content = sendHttpFile(paramVo, path, "C:\\Users\\Jerry\\Desktop\\图片\\123.jpg");
		String content = sendHttp(paramVo, path);
		System.out.println(content);
	}
	
	/**
	 * @Description: 根据图片地址转换为base64编码字符串
	 * @Author: 
	 * @CreateTime: 
	 * @return
	 */
	public static String getImageStr(String imgFile) {
	    InputStream inputStream = null;
	    byte[] data = null;
	    try {
	        inputStream = new FileInputStream(imgFile);
	        data = new byte[inputStream.available()];
	        inputStream.read(data);
	        inputStream.close();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    // 加密
	    String s = Base64.encode(data);
	    System.out.println("s : " + s);
	    return s;
	}
	
}