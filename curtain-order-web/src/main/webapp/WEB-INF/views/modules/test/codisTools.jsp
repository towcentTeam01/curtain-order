<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>CodisTools</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#query_btn').click(function(){
				var vkey = $('#vkey').val();
				
				$.ajax({ url: "${ctx}/codis/get?key=" + vkey, type: "post", dataType: "text", 
					success: function(data){
						printlnLog("get", vkey, (data == 'noExist' ? false : true));
						showJson(data);
					},
					error: function(){
						printlnLog("get", vkey, false);
					}
				});
			});
			
			$('#del_btn').click(function(){
				var vkey = $('#vkey').val();
				$.ajax({ url: "${ctx}/codis/del?key=" + vkey, type: "post", dataType: "text", 
					success: function(data){
						if ("success" == data) {
							printlnLog("del", vkey, true);
							alertx("成功");
						} else {
							printlnLog("del", vkey, false);
							alertx("失败");
						}
					}, 
					error: function(){
						printlnLog("del", vkey, false);
					}
				});
			});
			
			$('#clear_btn').click(function(){
				$('#opt-log').val('');
				$('#json-target').html('');
				$('#vkey').val('');
			});
			
			$('#st').change(function(e){
				var xval = $(this).val();
				if (xval == 'Select Prefix') return;
				$('#vkey').val(xval);
            })
			
		});
		
		/*
		 * 打印日志
		 */
		function printlnLog(opt, key, flag) {
			if (!key) return;
			var html = ("get" == opt ? "查询" : "删除") + "Key[" + key + "]" + (flag ? "成功" : "失败");
			var obj = $('#opt-log');
			var shtml = obj.val() + html + "\n";
			obj.val(shtml);	
		}
		
		function init(){
		    renderLine();
		}
		
		function showJson(content) {
			if (content == 'noExist') { 
				$('#json-target').html('暂时没有找到对应的key!');
				return;
			}
			
		    init();
		    console.log(content);
		    var result = '';
		    if (content!='') {
		        try{
		            result = new JSONFormat(content,4).toString();
		        }catch(e){
		            result = '<span style="color: #f1592a;font-weight:bold;">' + e + '</span>';
		        }
		        $('#json-target').html(result);
		    }else{
		        $('#json-target').html('');
		    }
		}
		
		function renderLine(){
		    var line_num = $('#json-target').height()/20;
		    $('#line-num').html("");
		    var line_num_html = "";
		    for (var i = 1; i < line_num+1; i++) {
		        line_num_html += "<div>"+i+"<div>";
		    }
		    $('#line-num').html(line_num_html);
		} 
	</script>
</head>
<body style="over-flow:hidden;">
	<!-- <h4 align="center" style="padding-top:10px;">Codis Operating Tools</h4>
	<hr> -->
	<div class="form-group" style="margin-top:5px;">
		<select id="st" class="span2" style="margin-top:10px;">
			<option selected="selected">Select Prefix</option>
			<option>goods:dtl:</option>
			<option>member:info:</option>
			<option>merchant:info:</option>
			<option>merchant:infoext:</option>
			<option>c:session:</option>
		</select>
		
	    <label><b>Key : </b></label>
	    <input id="vkey" type="text" placeholder="Cache Key" style="margin-top:10px;">
		<button id="query_btn" type="button" class="btn btn-primary">查   询</button>	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
		<button id="del_btn" type="button" class="btn btn-danger">删   除</button>  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
		<button id="clear_btn" type="button" class="btn">清   空</button>
	</div>
	
	<hr>
	<div>
		<div class="col-md-8" style="padding:5;float:left;margin-left:5px;margin-top:-15px;">
	        <textarea id="opt-log" placeholder="" style="height:500px;padding:0px 10px 10px 10px;border:0;border-right:solid 1px #ddd;border-bottom:solid 1px #ddd;border-radius:0;resize: none; outline:none;"></textarea>
	    </div>
	    <div class="col-md-6" style="padding:0;">
			<div id="right-box"  style="height:495px;border-right:solid 1px #ddd;border-bottom:solid 1px #ddd;border-radius:0;resize: none;overflow-y:scroll; outline:none;position:relative;">
				<div id="line-num" style="background-color:#fafafa;padding:0px 8px;float:left;border-right:dashed 1px #eee;display:none;z-index:-1;color:#999;position:absolute;text-align:center;over-flow:hidden;">
					<div>0</div>
				</div>
				<div class="ro" id="json-target" style="padding:0px 15px;over">
				</div>
			</div>
		</div>
	</div>
	<script src="${ctxStatic}/jquery-plugin/jquery.json.js" />
</body>
</html>

<script type="text/javascript">

</script>