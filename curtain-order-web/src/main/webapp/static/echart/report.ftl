<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="数据报表">
    <title>数据报表</title>
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script src="${basePath?default('')}template/admin/bi/js/echarts.js"></script>   
    <script src="${basePath?default('')}template/admin/bi/js/esl/esl.js"></script>
    <script>   
  option = {
    title : {
        text: '${titleText?default("")}',
        subtext: '${titleSubtext?default("")}',
        x:'${titleX?default("center")}'
    },
    tooltip : {
        trigger: '${trigger?default("item")}',
        formatter: "${formatter?default('{a} <br/>{b} : {c} ({d}%)')}"
    },
    legend: {
        orient : '${legendOrient?default("vertical")}',
        x : '${legendX?default("left")}',
        data:${legendData?default("")}
    },
    toolbox: {
        show : true,
        feature : {
            mark : {show: true},
            dataView : {show: true, readOnly: false},
            magicType : {
                show: true, 
                type: ['pie', 'funnel'],
                option: {
                    funnel: {
                        x: '25%',
                        width: '50%',
                        funnelAlign: 'left',
                        max: 1548
                    }
                }
            },
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    calculable : true,
    series : [
        {
            name:'${seriesName?default("")}',
            type:'pie',
            radius : '55%',
            center: ['50%', '60%'],
            data:${seriesData?default("")}
        }
    ]
};

require.config({
        paths:{
             echarts:'${basePath?default('')}template/admin/bi/js/chart',
            'echarts/chart/bar' : '${basePath?default('')}template/admin/bi/js/chart/bar',
            'echarts/chart/line' : '${basePath?default('')}template/admin/bi/js/chart/line',
            'echarts/chart/scatter' : '${basePath?default('')}template/admin/bi/js/chart/scatter',
            'echarts/chart/k' : '${basePath?default('')}template/admin/bi/js/chart/k',
            'echarts/chart/pie' : '${basePath?default('')}template/admin/bi/js/chart/pie',
            'echarts/chart/radar' : '${basePath?default('')}template/admin/bi/js/chart/radar',
            'echarts/chart/force': '${basePath?default('')}template/admin/bi/js/chart/force',
            'echarts/chart/chord': '${basePath?default('')}template/admin/bi/js/chart/chord',
            'echarts/chart/gauge': '${basePath?default('')}template/admin/bi/js/chart/gauge',
            'echarts/chart/funnel': '${basePath?default('')}template/admin/bi/js/chart/funnel',
            'echarts/chart/eventRiver': '${basePath?default('')}template/admin/bi/js/chart/eventRiver'
        }
    });
	
	require(
        [
            'echarts',
            'echarts/chart/bar',
            'echarts/chart/line',
            'echarts/chart/scatter',
            'echarts/chart/k',
            'echarts/chart/pie',
            'echarts/chart/radar',
            'echarts/chart/force',
            'echarts/chart/chord',
            'echarts/chart/gauge',
            'echarts/chart/funnel',
            'echarts/chart/eventRiver'
        ],
        function(ec) {
            var myChart = ec.init(document.getElementById('chartArea'));
            myChart.setOption(option);
        }
    );
   </script>
</head>

<body>
<div id="chartArea" style="height:500px;border:1px solid #ccc;padding:10px;"></div>
</body>
</html>
