<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>科协资源管理平台</title>
<%@include file="../common/form.jsp" %>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<script src="${contextPath}/js/validator/formValidator-4.1.3.js" type="text/javascript" ></script>
<script src="${contextPath}/js/validator/formValidatorRegex.js" type="text/javascript"></script>
<script type="text/javascript">
/*<![CDATA[*/
$(document).ready(function(){
	  //表单验证(公众)
	  $.formValidator.initConfig({
		  formID:"user_pwd_form",
		  theme:"Default",
		  submitOnce:true
		});
	   $("#user_pwd")
		    .formValidator({
	        	  onShow:"请输入密码",
	        	  onFocus:"密码长度至少为6-20个字符",
	        	  onCorrect:"输入密码正确"
	        	})
	        .inputValidator({
	        	  min:6,
	        	  max:20,
	        	  empty:{leftEmpty:false,rightEmpty:false,emptyError:"密码两边不能有空符号"},
	        	  onErrorMin:"密码长度至少为6",
	        	  onErrorMax:"密码长度不能超过20"
	        	});
	   $("#validate_pwd")
		      .formValidator({
	        	  onShow:"再次输入密码",
	        	  onFocus:"确认密码长度为6-20个字符",
	        	  onCorrect:"确认密码正确"
	        	})
	        .inputValidator({
	        	  min:1,
	        	  max:20,
	        	  empty:{leftEmpty:false,rightEmpty:false,emptyError:"确认密码两边不能有空符号"},
	        	  onErrorMax:"确认密码长度不能超过20",
		          onError:"确认密码不能为空,请确认"
	        	})
	         .compareValidator({
	        	  desID:"user_pwd",
	        	  operateor:"=",
	        	  onError:"两次密码输入不一致,请确认"
	           });
});
/*]]>*/
</script>
</head>

<body>
<div class="wrapper">
	<jsp:include page="../common/head.jsp" />
	<div class="content">
		<jsp:include page="../common/left.jsp" />
		<div class="right">
			<!--[if lt IE 8]><div class="both"></div><![endif]-->
			<div class="main">
				<div class="tit">修改密码</div>
				<div class="line">密码重置：</div>
				<form id="user_pwd_form" action="${contextPath}/manage/user/modifyPwd.rt" method="post">
				<input type="hidden" name="viewId" value="${viewId }" />
				<input type="hidden" name="leftId" value="${leftId }" />
				<input type="hidden" name="user.id" value="${user.id}" />
				<table width="96%" border="0" class="data">
				  <tr>
					<th scope="row" width="110"><span style="color:red;">*</span> 新密码：</th>
					<td><input  type="password" class="text" name="user.pwd" id="user_pwd"/></td>
					<td><span class="fl" id="user_pwdTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" align="right"><span style="color:red;">*</span> 确认新密码：</th>
					<td><input type="password" class="text" name="validatepwd" id="validate_pwd"/></td>
					<td><span class="fl" id="validate_pwdTip"></span></td>
				  </tr>
				  <tr class="buttom">
					<th scope="row" align="right"></th>
					<td>
						<input name="" type="submit" value="提 交" class="add_but fl" />
						<input name="" type="reset" value="重 置" class="add_but fl" />
						<a href="javascript:window.history.back();" class="but_fanhui fl" style="height:24px;border:0px;font-size:14px;color:white;font-weight:bold;">返 回</a>
					</td>
				  </tr>
				</table>
				</form>
			</div>
		</div>
		<div class="cb"></div>
	</div>
</div>
</body>
</html>
