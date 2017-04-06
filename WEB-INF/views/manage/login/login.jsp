<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>欢迎登录科协资源后台！</title>
<link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.jqtransform.js" ></script>
<script src="${contextPath }/front/js/md5.js" type="text/javascript"></script>
<script language="javascript">
  var formSubmit=function(){
  if($("#loginName").val()=="" || $("#loginName").val() == null){
     $("#loginName").focus();
     $("#msgTip").text("登录名不能为空");
     return;
  }
  var passwd = $("#passWord").val();
  if( passwd == "" || passwd == null) {
     $("#passWord").focus();
     $("#msgTip").text("密码不能为空");
     return;
  }
  var md5s = hex_md5(passwd);
  if (!md5s) {
  	return;
  }
  $.ajax({
      url:"${pageContext.request.contextPath}/manage/login/doLogin.rt",
      data:{"user.loginName":$("#loginName").val(),
            "user.pwd":md5s.toUpperCase()},
      beforeSend:function(){
         $("#msgTip").text("正在登录，请稍候...");
      },
      type:"post",
      dataType:"json",
      success:function(json){
         if(json.flag){
         	window.location="${pageContext.request.contextPath}/manage/home/index.rt";
         } else{
         	$("#msgTip").text(json.msg);
         }
      }
  });
}
$(function(){
  $("#submit_btn").click(formSubmit);
  $("#loginName").keydown(function (evt){
	 if(evt.keyCode == 13) {
		$("#passWord").focus();
	 }
  });
  $("#passWord").keydown(function (evt){
	 if(evt.keyCode == 13) {
		 formSubmit();
	 }
  });
});
</script>
</head>

<body>
<form>
<div class="wrapper1">
	<table border="0" style="margin-top: 240px;">
	  <tr>
		<th colspan="3" scope="row" height="60" valign="bottom"><img src="${pageContext.request.contextPath}/front/images/logo2.png" width="240" /></th>
	  </tr>
	  <tr style="height: 30px;">
		<td colspan="3" align="center" valign="bottom"><p id="msgTip" style="font-size:12px; color:#ff0000;"></p></td>
	  </tr>
	  <tr>
		<th scope="row" width="58">用户名:</th>
		<td colspan="2"><input name="user.loginName" id="loginName" type="text" class="name" /></td>
	  </tr>
	  <tr>
		<th scope="row">密　码:</th>
		<td colspan="2"><input name="user.pwd" id="passWord" onfocus="this.type='password'" autocomplete="off" type="text" class="pwd" /></td>
	  </tr>
	  <tr>
		<th colspan="3"><a href="javascript:void(0);" id="submit_btn" class="button"></a></th>
	  </tr>
	</table>
</div>
</form>
</body>
</html>
