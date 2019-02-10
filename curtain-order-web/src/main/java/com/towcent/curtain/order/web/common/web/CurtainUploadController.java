package com.towcent.curtain.order.web.common.web;

import com.google.common.collect.Maps;
import com.towcent.base.common.utils.*;
import com.towcent.base.sc.web.common.config.ConfigUtils;
import com.towcent.base.sc.web.common.web.UploadController;
import com.towcent.base.sc.web.modules.sys.entity.SysImageConf;
import com.towcent.curtain.order.web.common.utils.CurtainImageUtils;
import org.springframework.messaging.MessageChannel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Map;

import static com.towcent.base.common.constants.BaseConstant.NO;
import static com.towcent.base.common.constants.BaseConstant.YES;

/**
 * 文件上传Controller
 * @author lijian
 * @version 2016-01-08
 */
@Controller
@RequestMapping(value = "${adminPath}/image/upload")
public class CurtainUploadController extends UploadController {

	@Resource
	private MessageChannel ftpChannel;
	
	protected static final String BASE_PATH = "/";  // 正式上线要切换成"/"
	
	private static final String TMPDIR = System.getProperty("java.io.tmpdir");
	
	/** 统一后缀 */
	private static final String JPG = ".jpg";
	/** 小缩略图 */
	private static final String SJPG = "_s.jpg";
	private static final String SPRIT = "/";
	
	
	@RequestMapping(value = "imageUpload")
	public String curtainuploadImage(HttpServletRequest request, HttpServletResponse response, Model model) {
		// 1.1 图片类型
		String uploadType = request.getParameter("uploadType");
		
		Map<String, Object> result = Maps.newHashMap();
		
		// 2.1 获取图片配置
		SysImageConf imageConf = CurtainImageUtils.getImageConfByType(0, Integer.valueOf(uploadType));
		// 2.2 获取Ftp服务器相对目录
		String relativePath = CurtainImageUtils.buildImageRelativePath(BASE_PATH, imageConf);
		logger.info("图片存储路径 : " + relativePath);
		// 2.3. 获取本地临时目录
		String tempPath = this.getTempPath();
		String fileName = IdGen.randomString();
		
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		MultipartFile multiFile = multiRequest.getFile("fileupload");
		try {
			if (StringUtils.equals(uploadType, "2") || StringUtils.equals(uploadType, "3")) {
				// 商品图片有可能需要排序，则在图片名称上进行处理
				String orgFileName = multiFile.getOriginalFilename();
				String sort = StringUtils.substringBetween(orgFileName, "_", ".");
				if (StringUtils.isBlank(sort)) {
					sort = "00";
				}
				fileName = StringUtils.join(new String[]{sort, fileName},  "_");
			}
			// 1. 将图片写到应用服务器本地
			//	String realPath = request.getServletContext().getRealPath("/");
			//	String fileRealPath = realPath + uploadPath + fileName;
			//	FileUtils.copyInputStreamToFile(multiFile.getInputStream(), new File(fileRealPath + JPG));
			
			File tempFile = new File(tempPath + fileName);
			FileCopyUtils.copy(multiFile.getBytes(), tempFile);
			
			// 2. 处理原图(原图是否需要压缩)
			this.uploadOriginal(imageConf, tempFile, relativePath);
			
			// 3. 生成缩略图
			this.generateThumb(imageConf, tempFile, tempPath + fileName, relativePath);
			
			// 4. 拼接图片链接
			String imageUrl = this.apendImageUrl(ConfigUtils.getUrlHeader(), relativePath, fileName); 
			result.put("code", "0");
			result.put("imageUrl", imageUrl);
			result.put("thumbnailUrl", imageUrl.replaceAll(JPG, SJPG));
			logger.info("上传图片完毕.");
		} catch (Exception e) {
			result.put("code", "-1");
			logger.error("", e);
		} finally {
			org.apache.commons.io.FileUtils.deleteQuietly(new File(tempPath + fileName));
		}
		super.renderString(response, result);
		return null;
	}
	
	/**
	 * 拼接图片链接地址.
	 * @Title apendImageUrl
	 * @param urlHeader     图片服务器地址头 http://127.0.0.1:81/
	 * @param relativePath  Ftp服务器相对目录  /image/201707/
	 * @param fileName      文件名称   20180713.jpg
	 * @return
	 */
	private String apendImageUrl(String urlHeader, String relativePath, String fileName) {
		StringBuffer sb = new StringBuffer();
		if (StringUtils.endsWith(urlHeader, SPRIT)) {
			sb.append(StringUtils.substringBeforeLast(urlHeader, SPRIT));
		} else {
			sb.append(urlHeader);
		}
		sb.append(relativePath);
		sb.append(fileName);
		return sb.toString();
	}
	
	/**
	 * 上传原图到Ftp服务器.
	 * @Title uploadOriginal
	 * @param imageConf    图片类型配置
	 * @param srcFile      原图文件
	 * @param relativePath Ftp服务器相对路径
	 * @return
	 * @throws IOException
	 */
	private boolean uploadOriginal(SysImageConf imageConf, File srcFile, String relativePath) throws IOException {
		// 1. 判断原图需要压缩
		if (null != imageConf && StringUtils.equals(YES, imageConf.getIsOriginalCompress())) {
			String dest = srcFile.getAbsolutePath().replaceAll(JPG, "_t.jpg");
			FileUtils.moveFile(srcFile, new File(dest));
			// PictureUtils.scale(imageConf.getOriginalSize(), dest, srcFile.getAbsolutePath());
			ThumbnailatorUtil.thumbnail(imageConf.getOriginalSize(), dest, srcFile.getAbsolutePath());
		}
		
		return SpringFTPUtil.ftpUpload(ftpChannel, new File(srcFile.getAbsolutePath()), relativePath);
	}
	
	/**
	 * 生成缩略图
	 * @param imageConf 图片类型配置
	 * @param srcFile   原图文件
	 * @param srcPath   原图文件路径
	 * @param relativePath 相对目录
	 * @throws UnsupportedEncodingException
	 */
	private void generateThumb(SysImageConf imageConf, File srcFile, String srcPath, String relativePath)
			throws UnsupportedEncodingException {
		if (null == imageConf) {
			return;
		}
		// 判断是否需要缩略图
		if (StringUtils.equals(NO, imageConf.getIsThumb())) {
			return;
		}

		String sFilePath = srcPath.replaceAll(JPG, SJPG);
		// PictureUtils.scale(imageConf.getThumbSize(), srcFile, sFilePath);
		ThumbnailatorUtil.thumbnail(imageConf.getThumbSize(), srcFile, sFilePath);
		SpringFTPUtil.ftpUpload(ftpChannel, new File(sFilePath), relativePath);
	}
	
	/**
	 * 获取服务本地临时目录
	 * 
	 * @return
	 */
	private String getTempPath() {
		StringBuilder tempPath = new StringBuilder(TMPDIR);
		tempPath.append(File.separator);
		tempPath.append(IdGen.uuid()).append(File.separator);
		this.mkdir(tempPath.toString());
		return tempPath.toString();
	}

	private void mkdir(String directory) {
		File file = new File(directory);
		if (!file.exists()) {
			file.mkdirs();
		}
	}
		
	/**
	 * 图片删除方法
	 * @param request
	 * @param response
	 * @param model
	 */
	@ResponseBody
	@RequestMapping(value = "delete")
	public void curtaindeleteImg(HttpServletRequest request, HttpServletResponse response, Model model){
		
	}
}
