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
$(function(){
	if("${email}"!=null&&"${email}"!=""){
		requireFindPwdByEmail("${email}");
	}else{
		$("#errorMsg").text("操作异常，请检查！");
	}
});

function requireFindPwdByEmail(emial){
	  var emial = "${email}";
	  $.ajax({
	      url:"${contextPath}/front/user/requireFindPwdByEmail.rt",
	      data:{"email":emial},
	      type:"post",
	      dataType:"json",
	      success:function(result){
	         if(result.flag){
	        	 return;
	         } else{
	        	 return;
	         }
	      }
	  });
}
function closeWin(){
	window.open('','_parent','');
	window.opener = window;
	window.close();
}

</script>
</head>  
<body>
<form>
<div class="wrapper">
	<div class="top">
	  <div class="top">
		<jsp:include page="../common/head.jsp" />
	  </div>
	</div>
	<div class="content">
		<div class="register_banner"><img src="${contextPath}/front/images/forgot_banner.jpg" width="1000" height="153" /></div>
		<div class="video_list_main">
			<div class="list_main_top">
				<p class="tit">找回密码</p>
				<p class="dizhi">当前位置：首页 > 找回密码</p>
			</div>
			<div class="newslist" style="margin:100px 0 70px 0;text-align:center;">
			     <p style="font-weight:bold; margin-bottom:50px;" id="errorMsg">
			        您的申请已提交成功，请查看您的
			         <c:if test="${not empty email}">
			          <span style="color:#1E5DA2;white-spacing:nowrap;">${fn:substring(email,0,4)}******${fn:substring(email,fn:indexOf(email,'@'),-1)}</span>
			         </c:if>
			        邮箱
			     </p>
				<p><input name="" type="button" value="关闭此页" class="sub" onClick="closeWin()"/><p>
			</div>
		</div>
		<jsp:include page="../common/foot.jsp" />
	</div>
</div>
<!--<div class="bottom_png"></div>-->
</form>
</body>
</html>
