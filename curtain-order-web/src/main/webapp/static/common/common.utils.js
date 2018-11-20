CUtils = (function(){
	return {
		
		/**
		 * 判断对象是否为空
		 * @obj
		 */
		objNull : function(obj){
			if(!obj || obj == null || obj == undefined){
				return true;
			}
			return false;
		},
		
		/**
		 * 判断是否是数字
		 * @obj
		 */
		objIsNumber : function(obj){
			if(this.objNull(obj))return false;
			var regu = /^[\-\+]?([0-9]\d*|0|[1-9]\d{0,2}(,\d{3})*)(\.\d+)?$/;
		 	if(isNaN(obj) || !regu.test(obj)){
		 		return false;
		 	}
		 	return true;
		},
		
		/**
		 * 判断是否是整数
		 * @obj
		 */
		objIsDigits : function(obj){
			if(this.objNull(obj))return false;
			var regu = /^\d+$/;
			if(isNaN(obj) || !regu.test(obj)){
				return false;
			}
			return true;
		},
		
		objIsBetween : function(obj,min,max){
			debugger
			if(obj < min || obj > max){
				return false;
			}
			return true;
		}
	}
})()