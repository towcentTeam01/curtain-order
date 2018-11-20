package com.towcent.curtain.order.portal.common.web;

import java.io.File;

import com.towcent.base.common.utils.IdGen;
import com.towcent.base.common.vo.ResultVo;
import com.towcent.base.common.web.BaseController;

/**
 * 图片处理控制类
 * 
 * @author huangtao
 *
 */
public class BaseImageController extends BaseController {
	
	protected static String TMPDIR = System.getProperty("java.io.tmpdir");
	
	protected static final String BASE_PATH = "/";  // 正式上线要切换成"/"
	
	/**
	 * 获取服务本地临时目录
	 * @return
	 */
	protected String getTempPath() {
		StringBuilder tempPath = new StringBuilder(TMPDIR);
		tempPath.append(File.separator);
		tempPath.append(IdGen.uuid()).append(File.separator);
		this.mkdir(tempPath.toString());
		return tempPath.toString();
	}
	
	/**
	 * 创建目录
	 * @param directory
	 */
	protected void mkdir(String directory) {
		File file = new File(directory);
		if (!file.exists()) {
			file.mkdirs();
		}
	}
	
	/**
	 * 
	 * @param vo
	 * @param code
	 * @param message
	 * @return
	 */
	protected ResultVo assemblyVo(ResultVo vo, String code, String message) {
		vo.setCode(code);
		vo.setErrorMessage(message);
		return vo;
	}
}