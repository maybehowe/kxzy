<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>浙江省科普资源共享服务平台</title>
<%@include file="/WEB-INF/views/front/common/form.jsp" %>
<meta name="description" content="浙江省科普资源共享服务平台"/>
<meta name="keywords" content="浙江省科普资源共享服务平台" />
<meta name="copyright" content="杭州融坦软件科技有限公司" />
<meta name="author" content="杭州融坦软件科技有限公司" />
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<link href="${contextPath }/front/css/video.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
var formSubmit=function(){
	  if($("#loginName").val()=="" || $("#loginName").val() == null){
	     $("#loginName").focus();
	     $("#msgTip").text("登录名不能为空");
	     return;
	  }
	  var passwd = $("#passWord").val();
	  if(passwd == "" || passwd == null) {
	     $("#passWord").focus();
	     $("#msgTip").text("密码不能为空");
	     return;
	  }
	  var md5s = hex_md5(passwd);
	  if (!md5s) {
	  	return;
	  }
	  $.ajax({
	      url:contextPath+"/front/login/doLogin.rt",
	      data:{"loginName":$("#loginName").val(),
	            "pwd":md5s},
	      beforeSend:function(){
	         $("#msgTip").text("正在登录，请稍候...");
	      },
	      type:"post",
	      dataType:"json",
	      success:function(json){
        	 if(json.flag){
	        	 var html='<div class="login" style="background:none;">';
	        	 html+='<a>欢迎 '+json.loginName+' 登录浙江省科普资源共享服务平台！</a>';
	        	 html+='<a href="javascript:loginout()">注销</a>';
	        	 html+='</div>';
	         	$("#login").html(html);
	         } else{
	         	$("#msgTip").text(json.msg);
	         }
	      }
	  });
	};
	
$(function(){
	$("#submitBtn").click(formSubmit);
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
<div class="wrapper">
	<div class="top">
		<div class="content">
			<a href="${contextPath }/" class="logo"><img src="${contextPath }/front/images/logo.jpg" width="312" height="101" /></a>
			<div class="top_right">
				<div id="login" >
				<c:if test="${sessionScope.loginName==null }">
					<div class="login">
					
					<input name="loginName" type="text" id="loginName" class="login_name" />
					<input name="passWord" type="password" id="passWord" class="login_pwd" />
					<input name="" type="button" value="" id="submitBtn" class="login_sub" />
					<a target="_blank" href="${pageContext.request.contextPath}/front/user/showRegister.rt">注册</a>
					<a target="_blank" href="${pageContext.request.contextPath}/front/user/showForgotPwd.rt">忘记密码？</a>
					</div>
				</c:if>
					<c:if test="${sessionScope.loginName!=null }">
					<div class="login" style="background:none;">
						<a>欢迎 ${sessionScope.loginName } 登录浙江省科普资源共享服务平台！</a>
						<a href="javascript:loginout()">注销</a>
					</div>
					</c:if>
					<p id="msgTip" style="font-size:12px; position: absolute; text-align:center; width:285px; color:red; top:55px;"></p>
				</div>
				
				
				<div class="weibo">
					<a href="${contextPath}/building.jsp" target="_blank" class="txweibo" title="腾讯微博"></a>
					<a href="http://weibo.com/zikp" class="xlweibo" target="_blank" title="新浪微博"></a>
				</div>
				<div class="nav">
					<a href="${contextPath }/front/video/index.rt?columnId=27">科普多媒体中心</a>
					<a href="${contextPath }/building.jsp">科普图书馆</a>
					<a href="${contextPath }/front/museum/index.rt">科普资源中心</a>
					<a href="${contextPath }/building.jsp">互动社区</a>
					<a href="${contextPath }/front/about/about.rt?channelId=38">关于我们</a>
				</div>
			</div>
		</div>
	</div>
	<div style="width:1050px; margin:0 auto;">
		<div class="building">
			<p class="tit">该栏目正在建设中，敬请谅解！</p>
			<p>您可以：</p>
			<p>1.直接访问浙江省科普资源共享服务平台首页 <a href="${contextPath }/"> www.kxzy.com</a></p>
			<p>2.BUG反馈，请致电：0571-85300589</p>
			<p><a href="javascript:history.back(-1)">&lt;&lt;&nbsp;返回上一页</a></p>
		</div>
	</div>
	<div class="content">
		<jsp:include page="/WEB-INF/views/front/common/foot.jsp" />
	</div>
</div>
<!--<div class="bottom_png"></div>-->
</body>
</html>

