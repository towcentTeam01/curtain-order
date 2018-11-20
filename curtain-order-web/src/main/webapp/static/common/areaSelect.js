function loadAndShowArea(id,province,city,county){
	if(id == null || id == ''){
		//填充省份
		getAreaSelect('province_no', '0', '2');
		
		//级联填充城市
		$('#province_no').change(function(){
			document.getElementById("city_no").options.length = 1;
			document.getElementById("county_no").options.length = 1;
			var parentId = $(this).val();
			if (parentId && parentId != '') {
				getAreaSelect('city_no', parentId, '3');
			}
		});
		
		//级联填充区县
		$('#city_no').change(function(){
			document.getElementById("county_no").options.length = 1;
			var parentId = $(this).val();
			if (parentId && parentId != '') {
				getAreaSelect('county_no', parentId, '4');
			}
		});
	}else{
		//填充省份
		getAreaSelectBySync('province_no', '0', '2');
		
		//级联填充城市
		$('#province_no').change(function(){
			document.getElementById("city_no").options.length = 1;
			document.getElementById("county_no").options.length = 1;
			
			$("#city_no").val($('#city_no').find('option')[0].text).trigger("change");
			$("#county_no").val($('#county_no').find('option')[0].text).trigger("change");
			var parentId = $(this).val();
			if (parentId && parentId != '') {
				getAreaSelectBySync('city_no', parentId, '3');				
			}
		});
		
		//级联填充区县
		$('#city_no').change(function(){
			document.getElementById("county_no").options.length = 1;
			var parentId = $(this).val();
			if (parentId && parentId != '') {
				getAreaSelectBySync('county_no', parentId, '4');				
			}
		});
	    
	    $("#province_no").val(province).trigger("change");
		$('#city_no').val(city).trigger("change");
	    $('#county_no').val(county).trigger("change");
	}
}