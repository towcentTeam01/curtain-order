//兼容不支持console的浏览器
if(!window.console){
	window['console'] = {
		log : function(){},
		info : function(){},
		debug : function(){},
		group : function(){}
	}
}

///////////////////////////////////////公用tab/////////////////////////////////////////
(function ($) {
	//图片上传
//	$.fn.upload = function(uploadType, data, fun){
//		//没有data时第三个参数是function
//		if (typeof(data) == 'function') {
//			fun = data;
//			data = null;
//		}
//		//没有data，创建新的data，data主要由width、height、
//		if (!data) {
//			data = {};
//		}
//		data.uploadType = uploadType;
//		var opt = {
//			    'swf'       : ctxStatic+'/swf/uploadify.swf',  //上传所用的flash 必须
//			    'fileObjName'   : 'fileupload',  //file的name,
//			    'method'		: 'post',
//			    'auto'			: true,
//			    'width'          : '107',
//			    'height'         : '32',
//			    'preventCaching'  : true,
//			    'removeCompleted'  : true,
//			    'buttonImage'      : ctxStatic+'/images/button_Groupupload.png',
//			    'cancelImage'      : ctxStatic+'/images/upload_cancel.png',  //删除的图片*/
//			    'multi'          : false,  //设置为true时可以上传多个文件
//			    'fileDesc'       : '*.jpg;*.jpeg;*.png',  //用来设置选择文件对话框中的提示文本
//			    'fileExt'        : '*.jpg;*.jpeg;*.png',  //设置可以选择的文件的类型，格式如：'*.doc;*.pdf;*.rar'
//			    'formData'   : data,
//			    'uploader' : ctx+'/common/upload/uploadImage'
//		};
//		if (fun) {
//			opt.onUploadSuccess = function(file, data, response) {
//				fun(data);
//			};
//		}
//		$(this).uploadify(opt); 
//	},
	$.fn.ImgUpload = function(uploadType, data, fun){
		//没有data时第三个参数是function
		if (typeof(data) == 'function') {
			fun = data;
			data = null;
		}
		//没有data，创建新的data，data主要由width、height、
		if (!data) {
			data = {};
		}
		data.uploadType = uploadType;
		var opt = {
			    'swf'       : ctxStatic+'/swf/uploadify.swf',  //上传所用的flash 必须
			    'fileObjName'   : 'fileupload',  //file的name,
			    'method'		: 'post',
			    'auto'			: true,
			    'width'          : '107',
			    'height'         : '32',
			    'preventCaching'  : true,
			    'removeCompleted'  : true,
			    'buttonImage'      : ctxStatic+'/images/button_Groupupload.png',
			    'cancelImage'      : ctxStatic+'/images/upload_cancel.png',  //删除的图片*/
			    'multi'          : false,  //设置为true时可以上传多个文件
			    'fileDesc'       : '*.jpg;*.jpeg;*.png',  //用来设置选择文件对话框中的提示文本
			    'fileExt'        : '*.jpg;*.jpeg;*.png',  //设置可以选择的文件的类型，格式如：'*.doc;*.pdf;*.rar'
			    'formData'   : data,
			    'uploader' : ctx+'/image/upload/imageUpload'
		};
		if (fun) {
			opt.onUploadSuccess = function(file, data, response) {
				fun(data);
			};
		}
		$(this).uploadify(opt); 
	}
})(jQuery);
//////////////////////////////////////////公用tab///////////////////////////////////////////////

/**
 * 判断浏览器
 */
function browserJudge (){
	
	if($.browser.msie&&($.browser.version == "6.0")&&!$.support.style){
		$('<div id="browserJudge"><img src="'+baseAppres+'/images/emessage.gif" /> 您使用的浏览器版本过低，影响网页性能及效果，建议您换用IE6以上版本、<a href="http://www.google.com/chrome" target="_blank">谷歌</a>、或<a href="http://www.firefox.com.cn/download/" target="_blank">火狐</a>浏览器。  <a href="javascript:">我知道了</a> </div>')
		.appendTo('body')
		.css({"position": "absolute","z-index":"99","top":"0px","background":"#FFFFEE","padding":"3px","border":"1px solid #FFD685"})
		.find('a:last').click(function(){
			$('#browserJudge').remove();
			$.cookie('browserJudge','false');
		});
		$(window).scroll(function(){
			$('#browserJudge').css("top",$(this).scrollTop());
		});
	}
}

/**
 * cookie 操作
 */
jQuery.cookie = function(name, value, options) { 
    if (typeof value != 'undefined') { // name and value given, set cookie 
        options = options || {}; 
        if (value === null) { 
            value = ''; 
            options.expires = -1; 
        } 
        var expires = ''; 
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) { 
            var date; 
            if (typeof options.expires == 'number') { 
                date = new Date(); 
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000)); 
            } else { 
                date = options.expires; 
            } 
            expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE 
        } 
        var path = options.path ? '; path=' + options.path : ''; 
        var domain = options.domain ? '; domain=' + options.domain : ''; 
        var secure = options.secure ? '; secure' : ''; 
        document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join(''); 
    } else { // only name given, get cookie 
        var cookieValue = null; 
        if (document.cookie && document.cookie != '') { 
            var cookies = document.cookie.split(';'); 
            for (var i = 0; i < cookies.length; i++) { 
                var cookie = jQuery.trim(cookies[i]); 
                // Does this cookie string begin with the name we want? 
                if (cookie.substring(0, name.length + 1) == (name + '=')) { 
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break; 
                } 
            } 
        } 
        return cookieValue; 
    } 
};

// 日期格式化
Date.prototype.format = function(format)
{
    var o =
    {
        "M+" : this.getMonth()+1, //month
        "d+" : this.getDate(),    //day
        "h+" : this.getHours(),   //hour
        "m+" : this.getMinutes(), //minute
        "s+" : this.getSeconds(), //second
        "q+" : Math.floor((this.getMonth()+3)/3),  //quarter
        "S" : this.getMilliseconds() //millisecond
    }
    if(/(y+)/.test(format))
    format=format.replace(RegExp.$1,(this.getFullYear()+"").substr(4 - RegExp.$1.length));
    for(var k in o)
    if(new RegExp("("+ k +")").test(format))
    format = format.replace(RegExp.$1,RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
    return format;
}

/**
 *	Description: 银行卡号Luhm校验
 *	Luhm校验规则：16位银行卡号（19位通用）:
 *	
 *		1.将未带校验位的 15（或18）位卡号从右依次编号 1 到 15（18），位于奇数位号上的数字乘以 2。
 *		2.将奇位乘积的个十位全部相加，再加上所有偶数位上的数字。
 *		3.将加法和加上校验位能被 10 整除。
 *		4.将加法和加上校验位能被 10 整除。
 *	
 *	方法步骤很清晰，易理解，需要在页面引用Jquery.js
 *	bankno为银行卡号 banknoInfo为显示提示信息的DIV或其他控件 
 */
function luhmCheck(bankno) {
	var lastNum = bankno.substr(bankno.length - 1, 1);// 取出最后一位（与luhm进行比较）

	var first15Num = bankno.substr(0, bankno.length - 1);// 前15或18位
	var newArr = new Array();
	for ( var i = first15Num.length - 1; i > -1; i--) { // 前15或18位倒序存进数组
		newArr.push(first15Num.substr(i, 1));
	}
	var arrJiShu = new Array(); // 奇数位*2的积 <9
	var arrJiShu2 = new Array(); // 奇数位*2的积 >9

	var arrOuShu = new Array(); // 偶数位数组
	for ( var j = 0; j < newArr.length; j++) {
		if ((j + 1) % 2 == 1) {// 奇数位
			if (parseInt(newArr[j]) * 2 < 9)
				arrJiShu.push(parseInt(newArr[j]) * 2);
			else
				arrJiShu2.push(parseInt(newArr[j]) * 2);
		} else
			// 偶数位
			arrOuShu.push(newArr[j]);
	}

	var jishu_child1 = new Array();// 奇数位*2 >9 的分割之后的数组个位数
	var jishu_child2 = new Array();// 奇数位*2 >9 的分割之后的数组十位数
	for ( var h = 0; h < arrJiShu2.length; h++) {
		jishu_child1.push(parseInt(arrJiShu2[h]) % 10);
		jishu_child2.push(parseInt(arrJiShu2[h]) / 10);
	}

	var sumJiShu = 0; // 奇数位*2 < 9 的数组之和
	var sumOuShu = 0; // 偶数位数组之和
	var sumJiShuChild1 = 0; // 奇数位*2 >9 的分割之后的数组个位数之和
	var sumJiShuChild2 = 0; // 奇数位*2 >9 的分割之后的数组十位数之和
	var sumTotal = 0;
	for ( var m = 0; m < arrJiShu.length; m++) {
		sumJiShu = sumJiShu + parseInt(arrJiShu[m]);
	}

	for ( var n = 0; n < arrOuShu.length; n++) {
		sumOuShu = sumOuShu + parseInt(arrOuShu[n]);
	}

	for ( var p = 0; p < jishu_child1.length; p++) {
		sumJiShuChild1 = sumJiShuChild1 + parseInt(jishu_child1[p]);
		sumJiShuChild2 = sumJiShuChild2 + parseInt(jishu_child2[p]);
	}
	// 计算总和
	sumTotal = parseInt(sumJiShu) + parseInt(sumOuShu)
			+ parseInt(sumJiShuChild1) + parseInt(sumJiShuChild2);

	// 计算Luhm值
	var k = parseInt(sumTotal) % 10 == 0 ? 10 : parseInt(sumTotal) % 10;
	var luhm = 10 - k;

	if (lastNum == luhm) {
		return true;
	} else {
		return false;
	}
}


/**
 * 获取区域信息
 * @param selector 填充到那个selectId
 * @param parentId 父节点Id
 * @param type 区域类型  （1：国家；2：省份、直辖市；3：地市；4：区县）
 */
function getAreaSelect(selector, parentId, type) {
	$.ajax({
		type : "GET",
		url : ctx + "/sys/area/getAreaListById",
		data : { "type" : type, "parentId" : parentId},
		dataType : 'json',
		success : function(data) {
			if(data != null || data.length > 0){
				var list = data;
				for (var i = 0; i < list.length; i++) {
					var obj = list[i];
					var option = $("<option>").val(obj.id).text(obj.name); 
					$('#' + selector).append(option);
				}
			}
			$("#" + selector).val($("#" + selector).find('option')[0].value).trigger("change");
		}
	});
}

/**
 * 同步获取区域信息
 * @param selector 填充到那个selectId
 * @param parentId 父节点Id
 * @param type 区域类型  （1：国家；2：省份、直辖市；3：地市；4：区县）
 */
function getAreaSelectBySync(selector, parentId, type) {
	$.ajax({
		type : "GET",
		url : ctx + "/sys/area/getAreaListById",
		data : { "type" : type, "parentId" : parentId},
		async : false,
		dataType : 'json',
		success : function(data) {
			if(data == null || data.length <= 0)return false;
			var list = data;
			for (var i = 0; i < list.length; i++) {
				var obj = list[i];
				var option = $("<option>").val(obj.id).text(obj.name); 
				$('#' + selector).append(option);
			}
		}
	});
}


/**验证金额*/
function validateMoney(money){
	var regu = /^[\-\+]?([0-9]\d*|0|[1-9]\d{0,2}(,\d{3})*)(\.\d+)?$/;
 	var re = new RegExp(regu);
 	if(!re.test(money) || isNaN(money)){
 		return false;
 	}
 	return true;
}

/**验证数字*/
function validateNum(num){
	var regu = /^[1-9]\d*|0$/
	var re = new RegExp(regu);
	if(!re.test(num) || isNaN(num)){
 		return false;
 	}
	return true;
}