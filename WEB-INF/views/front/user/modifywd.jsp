<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>浙江省科普资源共享服务平台</title>
<%@include file="../common/form.jsp" %>
<meta name="description" content="浙江省科普资源共享服务平台"/>
<meta name="keywords" content="浙江省科普资源共享服务平台" />
<meta name="copyright" content="杭州融坦软件科技有限公司" />
<meta name="author" content="杭州融坦软件科技有限公司" />
<link href="${contextPath}/front/css/register.css" rel="stylesheet" type="text/css" />
<script src="${contextPath}/js/validator/formValidator-4.1.3.js" type="text/javascript" ></script>
<script src="${contextPath}/js/validator/formValidatorRegex.js" type="text/javascript"></script>
<script language="javascript">
  $(function(){
	  $.formValidator.initConfig({
		  formID:"modifypwdForm",
		  theme:"Default",
		  submitOnce:true
		});
	  $("#user_pwd")
	    .formValidator({
      	  onShow:"",
      	  onFocus:"新密码长度为6-20个字符",
      	  onCorrect:"输入新密码正确"
      	})
      .inputValidator({
      	  min:6,
      	  max:20,
      	  empty:{leftEmpty:false,rightEmpty:false,emptyError:"新密码两边不能有空符号"},
      	  onErrorMin:"新密码长度至少为6",
      	  onErrorMax:"新密码长度不能超过20"
      	});
	   $("#validate_user_pwd")
	      .formValidator({
     	  onShow:"",
     	  onFocus:"确认新密码长度为6-20个字符",
     	  onCorrect:"确认新密码正确"
     	})
     .inputValidator({
    	  min:6,
     	  max:20,
     	  empty:{leftEmpty:false,rightEmpty:false,emptyError:"确认新密码两边不能有空符号"},
     	  onErrorMin:"确认新密码长度至少为6",
     	  onErrorMax:"确认新密码长度不能超过20"
     	})
      .compareValidator({
     	  desID:"user_pwd",
     	  operateor:"=",
     	  onError:"两次密码输入不一致,请确认"
        });
  });
</script>
</head>

<body>
<div class="wrapper">
	<div class="top">
	  <div class="top">
	 	<jsp:include page="../common/head.jsp" />
	 </div>
	</div>
	<div class="content">
		<div class="register_banner"><img src="${contextPath }/front/images/forgot_banner.jpg" width="1000" height="153" /></div>
		<div class="video_list_main">
			<div class="list_main_top">
				<p class="tit">找回密码</p>
				<p class="dizhi">当前位置：首页 > 修改密码</p>
				<div class="register_process"></div>
				<c:if test="${flag eq true}">
					<div id="outer" class="newslist">
					<form id="modifypwdForm" action="${contextPath}/front/user/modifyPwd.rt" method="post">
						<table width="955" border="0">
						  <tr>
							<th width="100">用户名</th>
							<td width="330">
							   <input  type="hidden" id="user_id" name="user.id" value="${user.id}"/>
							  <p style="font-weight: bold;"> :  &nbsp;${user.loginName}</p>
							</td>
						  </tr>
						  <tr>
							<th width="100">新密码&nbsp;<span style="color:red;">*</span></th>
							<td>
							  <input  type="password" id="user_pwd" name="user.pwd" class="text" />
							</td>
							<td><span class="fl" id="user_pwdTip"></span></td>
						  </tr>
						  <tr>
							<th width="100">确认新密码&nbsp;<span style="color:red;">*</span></th>
							<td>
							  <input type="password" id="validate_user_pwd" name="validateuserpwd" class="text" />
							</td>
							<td><span class="fl" id="validate_user_pwdTip"></span></td>
						  </tr>
						  <tr height="100">
							<th>&nbsp;</th>
							<td colspan="3"><input name="btn" type="submit" value="修改" class="sub" /></td>
						  </tr>
						</table>
						</form>
					</div>
				</c:if>
				<c:if test="${flag eq false}">
		   		    <div class="newslist" style="margin:100px 0 70px 0;text-align:center;">
				      <p style="font-weight:bold; margin-bottom:50px;" id="errorMsg">
				         <span style="color:red;white-spacing:nowrap;">${error}</span><a href="${contextPath}/front/user/showForgotPwd.rt" style="text-decoration: underline;">重新找回</a>
				     </p>
				   </div>
				</c:if>
			</div>
		</div>
		<div class="copyright">
			<div class="fl"><a href="#">联系我们</a>&emsp;&iota;&emsp;<a href="link.html">友情链接</a>&emsp;&iota;&emsp;<a href="#">版权声明</a></div>
			<div class="fr">Copyright &copy; 2014 rongtan.com All Rights Reserved 浙ICP备1234567 技术支持：杭州融坦</div>
			<div class="cb"></div>
		</div>
	</div>
</div>
</body>
</html>

