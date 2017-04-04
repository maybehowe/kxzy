/**
 * 身份证号码验证
 */
jQuery.validator.addMethod("isIdCardNo", function(value, element) {
	return this.optional(element) || isIdCardNo(value);
}, "请正确输入您的身份证号码！");
/**
 * 手机号码验证
 */
jQuery.validator.addMethod("mobile", function(value, element) {
	var length = value.length;
	var mobile = /^(((1[0-9]{2})|(1[0-9]{2}))+\d{8})$/;
	return this.optional(element) || (length == 11 && mobile.test(value));
}, "手机号码格式错误，只支持11位数手机号码！");
/**
 * 银行卡号验证
 */
jQuery.validator.addMethod("bankCard", function(value, element) {
	var length = value.length;
	var mobile = /^[0-9]{15,19}$/;
	return this.optional(element) || (mobile.test(value));
}, "银行卡号格式错误，只支持15位至19位银行卡号！");
/**
 * 电话号码验证
 */
jQuery.validator.addMethod("phone", function(value, element) {
	var tel = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/;
	return this.optional(element) || (tel.test(value));
}, "电话号码格式错误！");
/**
 * 联系电话(手机/电话皆可)验证
 */
jQuery.validator.addMethod("isPhone", function(value, element) {
	var length = value.length;
	var mobile = /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/;
	var tel = /^\d{3,4}-?\d{7,9}$/;
	return this.optional(element) || (tel.test(value) || mobile.test(value));
}, "请正确填写您的联系电话！");
/**
 * 邮政编码验证
 */
jQuery.validator.addMethod("zipCode", function(value, element) {
	var tel = /^[0-9]{6}$/;
	return this.optional(element) || (tel.test(value));
}, "邮政编码格式错误！");
/**
 * QQ号码验证
 */
jQuery.validator.addMethod("qq", function(value, element) {
	var tel = /^[1-9]\d{4,9}$/;
	return this.optional(element) || (tel.test(value));
}, "qq号码格式错误！");
/**
 * IP地址验证
 */
jQuery.validator
		.addMethod(
				"ip",
				function(value, element) {
					var ip = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
					return this.optional(element)
							|| (ip.test(value) && (RegExp.$1 < 256
									&& RegExp.$2 < 256 && RegExp.$3 < 256 && RegExp.$4 < 256));
				}, "Ip地址格式错误！");
/**
 * 字母和数字的验证
 */
jQuery.validator.addMethod("chrnum", function(value, element) {
	var chrnum = /^([a-zA-Z0-9]+)$/;
	return this.optional(element) || (chrnum.test(value));
}, "只能输入数字和字母(字符A-Z, a-z, 0-9)！");
/**
 * 26个英文字母
 */
jQuery.validator.addMethod("lettervalidate", function(value, element) {
	var chrnum = /^[A-Za-z]+$/;
	return this.optional(element) || (chrnum.test(value));
}, "只能输英文字母！");
/**
 * 中文的验证
 */
jQuery.validator.addMethod("chinese", function(value, element) {
	var chinese = /^[\u4e00-\u9fa5]+$/;
	return this.optional(element) || (chinese.test(value));
}, "只能输入中文！");
/**
 * 合法字符(只能输入中文、英文、数字、下划线)
 */
jQuery.validator.addMethod("inputvalidate", function(value, element) {
	var inputvalidate = /^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+$/;
	return this.optional(element) || (inputvalidate.test(value));
}, "只能输入中文、英文、数字、下划线！");
/**
 * 合法字符(只能输入英文、数字、下划线)
 */
jQuery.validator.addMethod("inputValidateCode", function(value, element) {
	var inputvalidate = /^(?!_)(?!.*?_$)[a-zA-Z0-9_]+$/;
	return this.optional(element) || (inputvalidate.test(value));
}, "只能输入英文、数字、下划线！");
/**
 * 下拉框验证
 */
$.validator.addMethod("selectNone", function(value, element) {
	return value == "请选择";
}, "必须选择一项！");
/**
 * 字节长度验证
 */
jQuery.validator.addMethod("byteRangeLength",
		function(value, element, param) {
			var length = value.length;
			for ( var i = 0; i < value.length; i++) {
				if (value.charCodeAt(i) > 127) {
					length++;
				}
			}
			return this.optional(element)
					|| (length >= param[0] && length <= param[1]);
		}, $.validator.format("请确保输入的值在{0}-{1}个字节之间(一个中文字算2个字节)！"));
/**
 * 联合查询验证
 */
$.validator.addMethod("unionUnique", function( value, element, param ) {
	var target = $(param.target);
	var postParam = { };
	var result;
	if ( this.settings.onfocusout) {
		target.unbind(".validate-unionUnique").bind("blur.validate-unionUnique", function() {
			$(element).valid();
		});
	}
	postParam[$(element).attr("name")] = value;
	target.each(function(index,element){
		var $ele = $(element);
		postParam[$ele.attr("name")] = $ele.val();
	});
	$.ajax({
	  type: 'POST',
	  url: param.url,
	  async:false,
	  data: postParam,
	  success: function(data){
		  result = data;
	  },
	  dataType: "json"
	});
	return result;
}, $.validator.format("联合查询验证！"));
/**
 * 特殊字符或者全角
 */
$.validator.addMethod("specialCharacter", function(value, element) {
	var re = /^[^\'\"\=\{\}\[\]\\\/\<\>\n\r\&\+\!\~\`\@\#\$\%\^\*\(\)\|\?]*$/;
	var fullRe = /[^\x00-\x80]/;
	var chinase = /.*[\u4e00-\u9fa5]+.*$/;
	if(chinase.test(value)){
		return this.optional(element) || (re.test(value));
	} else{
		return this.optional(element) || (re.test(value) && !fullRe.test(value));
	}
}, "包含特殊字符或者全角字符！");
/**
 * 特殊字符
 */
$.validator.addMethod("character", function(value, element) {
	var re = /^[^\'\"\=\{\}\[\]\\\/\<\>\n\r\&\+\!\~\`\@\#\$\%\^\*\(\)\|\?]*$/;
	return this.optional(element) || (re.test(value));
}, "包含特殊字符！");

$.validator.addMethod("isChinese", function(value, element) {
	var chinase = /.*[\u4e00-\u9fa5]+.*$/;
	return this.optional(element) || (!chinase.test(value));
}, "不能包含中文");

$.validator.addMethod("email", function(value, element) {
	var re =  /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/i;
	return this.optional(element) || (re.test(value));
}, "邮箱格式不正确！");

$.validator.addMethod("allowImage", function(value, element) {
	var name = value.substring(value.indexOf("."));
	if(name=="" || name==".png" || name==".bmp" || name==".gif" || name==".jpeg" || name==".jpg"){
		return true;
	}else{
		return false;
	}
}, "格式有误！");
