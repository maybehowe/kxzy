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
<script language="javascript">
  $(function (){
	//获取验证码
	   $("#findPwd_authCode").attr("src","${contextPath}/front/user/findPwdauthCode.rt?time="+new Date().getTime());
  });
  function getLinkByCate(cateId){
	  window.location.href = "${contextPath}/front/link/linkByCate.rt?cateId="+cateId;
  }
  
  function findPwd(){
	  if($("#user_info").val()=="" || $("#user_info").val() == null){
	     $("#user_info").focus();
	     $("#usermsgTip").text("请输入用户名或邮箱");
	     return;
	  }else{
		  $("#usermsgTip").text("");
	  }
	  if($("#findPwdauthCode").val() == "" || $("#findPwdauthCode").val() == null) {
	     $("#findPwdauthCode").focus();
	     $("#authmsgTip").text("验证码不能为空");
	     return;
	  }else{
		  var flag = validateAuth($("#findPwdauthCode").val());
		  if(!flag){
			  $("#authmsgTip").text("验证码输入有误");
			  return;
		  }
	  }
	  window.location.href="${contextPath}/front/user/showFindPwdTips.rt?userInfo="+$("#user_info").val();
	}
  
  //验证输入的验证码
  function validateAuth(auth){
	  var flag;
	  $.ajax({
	      url:"${contextPath}/front/user/validatefindPwdAuthCode.rt",
	      data:{"authCode":auth},
	      type:"post",
	      dataType:"json",
	      async:false,
	      success:function(result){
	         if(result){
	        	 flag = true;
	         } else{
	        	 flag = false;
	         }
	      }
	  });
	  return flag;
  }
  //获取验证码(换一张)
  function findPwdchangeAuth(){
	  $("#findPwd_authCode").attr("src","${contextPath}/front/user/findPwdauthCode.rt?time="+new Date().getTime());
  }
</script>
</head>

<body>
<div class="wrapper">
	<div class="top">
		<jsp:include page="../common/head.jsp" />
	</div>
	<div class="content">
		<div class="register_banner"><img src="${contextPath }/front/images/forgot_banner.jpg" width="1000" height="153" /></div>
		<div class="video_list_main">
			<div class="list_main_top">
				<p class="tit">找回密码</p>
				<p class="dizhi">当前位置：首页 > 找回密码</p>
				<div class="register_process"></div>
				<div id="outer" class="newslist">
					<table width="955" border="0">
					  <tr>
						<th width="100">用户名/邮箱&nbsp;<span style="color:red;">*</span></th>
						<td width="330">
						  <input id="user_info" name="userinfo" type="text" class="text" />
						</td>
						<td><p id="usermsgTip" style="font-size:12px; color:#ff0000;"></p></td>
					  </tr>
					  <tr>
						<th>验证码&nbsp;<span style="color:red;">*</span></th>
						<td>
							<p class="fl"><input name="findPwdauthCode" id="findPwdauthCode" type="text" class="text" style="width: 100px" maxlength="4" class="yzm" /></p>
							<p class="fl ml15"><a href="javascript:findPwdchangeAuth()"><img src="${contextPath}/images/auth.gif" id="findPwd_authCode" width="72" height="32" /></a></p>
							<a class="ml15" href="javascript:findPwdchangeAuth()" style="text-decoration:underline; line-height:32px;">看不清，换一张</a>
						</td>
						<td><span class="fl" id="teamauthCodeTip"></span><p id="authmsgTip" style="font-size:12px; color:#ff0000;"></p></td>
						<td></td>
					  </tr>
					  <tr height="100">
						<th>&nbsp;</th>
						<td colspan="3"><input name="" type="button" value="下一步" class="sub" onclick="findPwd()"/></td>
					  </tr>
					</table>
				</div>
			</div>
		</div>
		<jsp:include page="../common/foot.jsp" />
	</div>
</div>
</body>
</html>

