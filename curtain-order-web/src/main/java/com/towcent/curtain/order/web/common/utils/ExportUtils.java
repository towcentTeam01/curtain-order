package com.towcent.curtain.order.web.common.utils;

import java.io.FileOutputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.ss.usermodel.PaperSize;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.towcent.curtain.order.web.order.entity.OrderDtl;
import com.towcent.curtain.order.web.order.entity.OrderMain;

/**
 * TODO: 增加描述
 * 
 * @author huangtao
 * @date 2014年9月11日 下午12:16:03
 * @version 0.1.0 
 * @copyright cc.luoqi.
 */
public class ExportUtils {
    
	public XSSFWorkbook convert(List<OrderMain> orderMains) {
		//工作区    
        XSSFWorkbook wb = new XSSFWorkbook();
        for (OrderMain order : orderMains) {
			String sheetName = "订单_" + order.getOrderNo();
			this.createSheet(wb, sheetName, order);
		}
        
        return wb;
	}
	
	public XSSFWorkbook convert(OrderMain orderMain) { 
        XSSFWorkbook wb = new XSSFWorkbook();
        String sheetName = "订单_" + orderMain.getOrderNo();
        this.createSheet(wb, sheetName, orderMain);
        
		return wb;
	}
	
	private void createSheet(XSSFWorkbook wb, String sheetName, OrderMain orderMain) {
		XSSFSheet sheet= wb.createSheet(sheetName);
        
        //设置横向打印
        sheet.getPrintSetup().setLandscape(true);
        sheet.getPrintSetup().setPaperSize(PaperSize.A4_PAPER);
        
        //设置每列的宽度
        sheet.setColumnWidth(0, 5250);
        sheet.setColumnWidth(1, 2650);
        sheet.setColumnWidth(2, 2650);
        sheet.setColumnWidth(3, 1800);
        sheet.setColumnWidth(4, 4100);
        sheet.setColumnWidth(5, 4100);
        sheet.setColumnWidth(6, 2200);
        //sheet.setColumnWidth(7, 900);
        sheet.setColumnWidth(7, 2800);
        sheet.setColumnWidth(8, 3200);
        sheet.setColumnWidth(9, 4700);
        //表头
        XSSFRow row = sheet.createRow(1);
        XSSFCell cell = row.createCell(0);
        cell.setCellStyle(getStyle(wb));
        StringBuffer sb = new StringBuffer(orderMain.getMerchantName() + "窗帘订单报表  ");
        sb.append(" ");
        sb.append(orderMain.getConsigneeAddress());
        cell.setCellValue(sb.toString());
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 7));
        
        cell = row.createCell(8);
        cell.setCellStyle(getStyle(wb));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
        cell.setCellValue(sdf.format(orderMain.getCreateDate()));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 8, 9));
        
        row = sheet.createRow(2);
        cell = row.createCell(0);
        XSSFCellStyle style = getStyle(wb);
        row.setHeightInPoints(30);
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        style.getFont().setFontHeightInPoints((short)14);
        style.getFont().setBold(true);
        cell.setCellStyle(style);
        cell.setCellValue("订单号：" + orderMain.getOrderNo());
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 0, 4));
        
        cell = row.createCell(5);
        cell.setCellStyle(style);
        cell.setCellValue("联系人：" + orderMain.getConsigneeName());
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 5, 7));
        
        cell = row.createCell(8);
        cell.setCellStyle(style);
        cell.setCellValue("联系电话：" + orderMain.getConsigneePhone());
        sheet.addMergedRegion(new CellRangeAddress(2, 2, 8, 9));
        
        String[] headers = new String[]{"型号", "成品宽单位:米", "成品高单位:米", "褶数(倍)", "辅料铅线、铅块、底边花边", "里衬/造型(返幔、帘头)", "对/单开", "打孔/捏褶(对花)", "环、S钩(不要可不填)", "注明"};
        // 产生表格标题行
        row = sheet.createRow(3);
        style = getStyle2(wb);
        row.setHeightInPoints(40);
        for (short i = 0; i < headers.length; i++) {
            cell = row.createCell(i);
            cell.setCellStyle(style);
            XSSFRichTextString text = new XSSFRichTextString(headers[i]);
            cell.setCellValue(text);
            //cell.setCellValue(value);
        }
        
        int index = 4;
        for(OrderDtl dtl : orderMain.getOrderDtls()){
        	// shipType = dtl.getShipType();
            row = sheet.createRow(index);     
            // 给这一行的第一列赋值     
            
            createCell(wb, row, 0, dtl.getGoodsName());
            createCell(wb, row, 1, dtl.getLength()+"");
            createCell(wb, row, 2, null == dtl.getHigh() ? "" : dtl.getHigh()+"");
            createCell(wb, row, 3, dtl.getMultiple()+"");
            createCell(wb, row, 4, dtl.getParam1());
            createCell(wb, row, 5, dtl.getParam2());
            createCell(wb, row, 6, dtl.getParam3());
            //createCell(wb, row, 7, "" + dtl.getNum());
            createCell(wb, row, 7, dtl.getParam4());
            createCell(wb, row, 8, dtl.getParam5());
            createCell(wb, row, 9, dtl.getRemarks()); 
            index++;
        } 
        
        row = sheet.createRow(index);
        cell = row.createCell(0);
        style = getStyle3(wb);
        style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
        cell.setCellStyle(style);
        cell.setCellValue("货运方式：" + orderMain.getLogisticsName());
        sheet.addMergedRegion(new CellRangeAddress(index, index, 0, 9));
        index++;
        
        row = sheet.createRow(index);
        cell = row.createCell(0);
        style = getStyle(wb);
        style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
        cell.setCellStyle(style);
        cell.setCellValue("注：请店主详细填写, 一经下料无法更改");
        sheet.addMergedRegion(new CellRangeAddress(index, index, 0, 9));
	}
	
	/**
	 * 
	 * @param wb
	 * @param row
	 * @param columnIndex
	 * @param content
	 */
	private void createCell(XSSFWorkbook wb, XSSFRow row, int columnIndex, String content) {
		XSSFCell cell = row.createCell(columnIndex);
        cell.setCellStyle(getStyle2(wb));
        cell.setCellValue(content); 
	}
	
	private XSSFCellStyle getStyle(XSSFWorkbook workbook) {
		// 生成一个样式
        XSSFCellStyle style = workbook.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
        // 生成一个字体
        XSSFFont font = workbook.createFont();
        font.setFontName("宋体");
        font.setFontHeightInPoints((short) 20);
        // 把字体应用到当前的样式
        style.setFont(font);
		return style;
	}
	
	private XSSFCellStyle getStyle2(XSSFWorkbook workbook) {
		// 生成一个样式
        XSSFCellStyle style = workbook.createCellStyle();
        // 设置这些样式
        style.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
        style.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
        style.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
        style.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_TOP);
        style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
        style.setWrapText(true);
        // 生成一个字体
        XSSFFont font = workbook.createFont();
        font.setFontName("宋体");
        font.setBoldweight((short)1);
        font.setFontHeightInPoints((short) 15);
        // 把字体应用到当前的样式
        style.setFont(font);
		return style;
	}
	
	private XSSFCellStyle getStyle3(XSSFWorkbook workbook) {
		// 生成一个样式
        XSSFCellStyle style = workbook.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
        // 生成一个字体
        XSSFFont font = workbook.createFont();
        font.setFontName("宋体");
        font.setFontHeightInPoints((short) 17);
        // 把字体应用到当前的样式
        style.setFont(font);
		return style;
	}
	
	public static void main(String[] args) throws Exception {
		OutputStream os = new FileOutputStream("D:/"+System.currentTimeMillis()+".xlsx");      
		ExportUtils export = new ExportUtils();
		
		List<OrderMain> orderMains = new ArrayList<OrderMain>();
		
		OrderMain order = new OrderMain();
		order.setOrderNo("O3546567687");
		order.setConsigneeAddress("河北省河间直营店");
		order.setCreateDate(new Date());
		order.setConsigneeName("罗丁丁");
		order.setConsigneePhone("18666296035");
		
		order.setMerchantId(0);
		order.setMerchantName("罗琦");
		order.setLogisticsName("顺丰物流");
		
		OrderDtl dtl = new OrderDtl();
		dtl.setNum(2);
		dtl.setGoodsName("ssdfsdff");
		dtl.setLength(BigDecimal.valueOf(2.3));
		dtl.setHigh(BigDecimal.valueOf(4.87));
		dtl.setMultiple(BigDecimal.valueOf(3));
		dtl.setParam1("345456");
		dtl.setParam2("3是辅导费45456");
		dtl.setParam3("水电费");
		dtl.setParam4("是");
		dtl.setParam5("是大股东非");
		dtl.setRemarks("wu");
		List<OrderDtl> list = new ArrayList<OrderDtl>();
		list.add(dtl);
		order.setOrderDtls(list);
		
		orderMains.add(order);
		
		order = new OrderMain();
		order.setOrderNo("O55667678");
		order.setConsigneeAddress("北京市西单直营店");
		order.setCreateDate(new Date());
		order.setConsigneeName("李明");
		order.setConsigneePhone("18454296035");
		
		dtl = new OrderDtl();
		dtl.setNum(2);
		dtl.setGoodsName("x9900987");
		dtl.setLength(BigDecimal.valueOf(13.02));
		dtl.setHigh(BigDecimal.valueOf(5));
		dtl.setMultiple(BigDecimal.valueOf(6.78));
		dtl.setParam1("zhongguo");
		dtl.setParam2("小学老师45456");
		dtl.setParam3("水电费");
		dtl.setParam4("是");
		dtl.setParam5("是大股东");
		dtl.setRemarks("无");
		List<OrderDtl> list2 = new ArrayList<OrderDtl>();
		list2.add(dtl);
		order.setOrderDtls(list2);
		
		orderMains.add(order);
		
		export.convert(orderMains).write(os);
		//关闭输出流     
		os.close();
	}
	
}
