<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<script src="${ctxStatic}/echart/js/echarts.js" type="text/javascript"></script>
<script src="${ctxStatic}/echart/js/esl/esl.js" type="text/javascript"></script>

<%@ attribute name="id" type="java.lang.String" required="true"
	description="编号"%>
<%@ attribute name="style" type="java.lang.String" required="false"
	description="样式"%>
<%@ attribute name="path" type="java.lang.String" required="false"
	description="请求路径"%>
<%@ attribute name="title" type="java.lang.String" required="false"
	description="标题"%>
<%@ attribute name="option" type="java.lang.String" required="false"
	description="option数据"%>

<div id="${id}"
	style="${not empty style ? style : 'width:600px;height:300px;'}"></div>


<script type="text/javascript">
/**
 * option的格式 
   option={
	   "series":[
		     {"name":"收入金额","data":[17773.00,45000.00,25.00,40.00,7776.00,6685.00,4611.00,2445.00,10059.00,28375.00],"type":"bar"},
		     {"name":"收入积分","data":[3000.00,2000.00,2000.00,2000.00,2000.00,3000.00,4000.00,2000.00,5000.00,9000.00],"type":"bar"}
		],
		"yAxis":"","legend":["收入金额","收入积分"],
		"xAxis":["三只松鼠","我的店铺","满汉全席","冰糖","袋鼠","宅急送","德玛西亚","肯德基","御膳房","袋鼠集市平台"]
	}
 *
 */
 
$(function(){

var title = '${title}';
var path = '${path}';
var option = '${option}';

if(!(option || path)){
	layer.msg('option属性和path属性不能同时为空');
	return false;
}

if(!option && path){
	$.ajax( {
		type : "POST",
		url : path,
		dataType : "json",
		async:false,
		success : function(data) {
			option = data;
		}
	});
}

if(typeof option == 'string'){
	option = eval("("+option+")");
}

if(option){
	
	option = {
	    title: {
            text: title
        },
	    tooltip: {},
	    legend: {
	        data:option.legend
	    },
	    xAxis: {
	        data: option.xAxis
	    },
	    yAxis: {
	        data: option.yAxis ? option.yAxis: ''
	    },
	    series: function(){
	    	var result = [];
	    	var data = option.series;
	    	
	    	if(data instanceof Array){
	    		$.each(data,function(i,item){
	    			result.push({
        		        name: item.name,
        		        type: item.type,
        		        data: item.data
        		    });
	    		});
	    	}
	    	return result;
	    }()
	};
	
}

console.info(option);

require.config({
	paths:{
		 echarts:'${ctxStatic}/echart/js/chart',
		'echarts/chart/bar' : '${ctxStatic}/echart/js/chart/bar',
		'echarts/chart/line' : '${ctxStatic}/echart/js/chart/line',
		'echarts/chart/scatter' : '${ctxStatic}/echart/js/chart/scatter',
		'echarts/chart/k' : '${ctxStatic}/echart/js/chart/k',
		'echarts/chart/pie' : '${ctxStatic}/echart/js/chart/pie'
	}
});

require(
	[
		'echarts',
		'echarts/chart/bar',
		'echarts/chart/line',
		'echarts/chart/scatter',
		'echarts/chart/k',
		'echarts/chart/pie'
	],
	function(ec) {
		var myChart = ec.init(document.getElementById('${id}'));
		myChart.setOption(option);
	}
);

});
</script>