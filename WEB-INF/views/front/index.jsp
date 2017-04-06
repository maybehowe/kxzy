<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>浙江省科普资源共享服务平台</title>
<%@include file="common/form.jsp" %>
<meta name="description" content="浙江省科普资源共享服务平台"/>
<meta name="keywords" content="浙江省科普资源共享服务平台" />
<meta name="copyright" content="杭州融坦软件科技有限公司" />
<meta name="author" content="杭州融坦软件科技有限公司" />
<link href="${contextPath }/front/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/js/jquery.cookie.js"></script>
<script type="text/javascript">
var isCookieSubmit = true;//判断是否cookie提交

window.onload = function (){
	var oSelect = document.getElementById("spana");
	var oSub = document.getElementById("ula");
	var aLi = oSub.getElementsByTagName("li");
	var i = 0;
	
	oSelect.onclick = function (event){
		var style = oSub.style;
		style.display = style.display == "block" ? "none" : "block";
		//阻止事件冒泡
		(event || window.event).cancelBubble = true;
	};
	
	for (i = 0; i < aLi.length; i++){
		//鼠标划过
		aLi[i].onmouseover = function (){
			this.className = "hover";
		};
		//鼠标离开
		aLi[i].onmouseout = function (){
			this.className = "";
		};
		//鼠标点击
		aLi[i].onclick = function (){
			oSelect.innerHTML = this.innerHTML;
			oSelect.title = this.id;
			$("#scope").val(this.id);
		};
	}
	document.onclick = function (){
		oSub.style.display = "none";	
	};
	
	//读取kookie(密码)
	if($.cookie("rmb_pwd")){
		$("#loginName").val($.cookie("userName"));
		$("#cookie_pwd").val($.cookie("userPwd"));
		$("#passWord").val("123456");
		$("#checkbox").attr("checked","checked");
		$("#lab_rmbpwd").addClass("hover");
		showAndHide("spt","hide");
	}
};
//添加收藏夹
function AddFavorite(sURL, sTitle) {
	try {
		window.external.addFavorite(sURL, sTitle);
	} catch (e) {
		try {
			window.sidebar.addPanel(sTitle, sURL, "");
		} catch (e) {
			alert("加入收藏失败，请使用Ctrl+D进行添加");
		}
	}
}
//设为首页
function setHomepage() {
	try {
		document.body.style.behavior = 'url(#default#homepage)';
		document.body.setHomePage('http://www.zast.org.cn/');
	} catch (e) {
		try {
			netscape.security.PrivilegeManager
					.enablePrivilege("UniversalXPConnect");
		} catch (e) {
			alert("该操作被浏览器拒绝，请手工设置为首页");
		}
//			var prefs = Components.classes['@mozilla.org/preferences-service;1']
//					.getService(Components.interfaces.nsIPrefBranch);
//			prefs.setCharPref('browser.startup.homepage', document.URL);
	}
}

function showAndHide(obj,types){
	var Layer=window.document.getElementById(obj);
	switch(types){
	case "show":
	Layer.style.display="block";
	break;
	case "hide":
	Layer.style.display="none";
	break;
	}
}
function getValue(obj,str){
	var input=window.document.getElementById(obj);
	input.value=str;
}

function setRmbPwdChecked(obj){
	if($(obj).attr("class") == null || $(obj).attr("class") == ""){
		$("#checkbox").attr("checked","checked");
		$(obj).addClass("hover");
	}else{
		$("#checkbox").removeAttr("checked");
		$(obj).removeClass("hover");
	}
}

//记住密码
function setRemenberPwd(login_name,md5_pwd){
	if($("#checkbox").attr("checked") == "checked"){
		var pwd = md5_pwd;
		var name = $("#")
		$.cookie("rmb_pwd","true",{expires:30});
		$.cookie("userPwd",pwd,{expires:30});
		$.cookie("userName",login_name,{expires:30});
	}else{
		$.cookie("rmb_pwd","false",{expires:-1});
		$.cookie("userPwd","",{expires:-1});
		$.cookie("userName","",{expires:-1});
	}
}

//判断提交类型
function isChanged(){
	isCookieSubmit = false;//非cookie提交
	$("#passWord").val("");
}

//登录提交
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
	  var md5s = "";
	  if(!isCookieSubmit){
		  md5s = hex_md5(passwd);
		  if (!md5s) {
		  	return;
		  }
	  }else{
		  md5s = $("#cookie_pwd").val();
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
	        	setRemenberPwd($("#loginName").val(),md5s)
	        	window.location.reload();
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
	$("#searchName").keydown(function (evt){
		if(evt.keyCode == 13){
			search();
		}
	});
});

function loginout(){
	  $.ajax({
	      url:contextPath+"/front/login/loginout.rt",
	      beforeSend:function(){
	         $("#msgTip").text("正在注销，请稍候...");
	      },
	      type:"post",
	      dataType:"json",
	      success:function(json){
	         window.location.reload();
	      }
	  });
}

function search(){
	var text = $("#searchName").val();
	var scope = $("#spana").attr("title");
	var url = "${contextPath}/front/search/index.rt?scope="+scope+"&text="+text;
	window.location.href=url;
}
</script>
<style>
#spt{font-size:12px; color:#8D8D8D; position:absolute; z-index:1; margin:-48px 0 0 85px;}
</style>
</head>
<body>
<div class="wrapper">
	<div class="top">
		<a href="javascript:setHomepage();" class="index"></a>
		<a href='${contextPath }/' onclick="AddFavorite('http://www.baidu.com',document.title)" class="join"></a>
		<a href="${contextPath}/front/link/link.rt" class="link"></a>
		<a href="${contextPath}/front/about/about.rt?channelId=115" class="contact"></a>
		<a href="${contextPath}/building.jsp" target="_blank" class="tqq"></a>
		<a href="${contextPath}/building.jsp" class="sina" target="_blank"></a>
	</div>
	<div class="cb"></div>
	<div id="login">
		<c:if test="${sessionScope.loginName==null }">
		<div class="login" id="qwe">
			<p id="msgTip" style="font-size:12px; color:#ff0000; position:absolute; top:142px; text-align:center; width:270px;"></p>
			<p class="name" style=" position:relative; z-index:100;"><input id="loginName" name="user.loginName" type="text" onfocus="showAndHide('spt','hide');" onblur="if(!value){showAndHide('spt','show');}" /></p>
			<p id="spt">手机号/邮箱/用户名</p>
			<p class="pwd">
			  <input id="cookie_pwd" name="cookiepwd" type="hidden"/>
			  <input id="passWord" name="user.pwd" type="password" onfocus="isChanged()" />
			 </p>
			<p class="sub"><input type="button" id="submitBtn" /></p>
			<p class="reg"><a href="${contextPath}/front/user/showRegister.rt"></a></p>
			<p class="cb"></p>
			<p class="boxs"><input id="checkbox" name="checkbox" type="checkbox"/><label onclick="setRmbPwdChecked(this)" id="lab_rmbpwd">记住密码</label></p>
			<p class="forget"><a href="${contextPath}/front/user/showForgotPwd.rt">忘记密码？</a></p>
		</div>
		</c:if>
		<c:if test="${sessionScope.loginName!=null }">
		<div class="personal">
			<p class="zhux"><a href="javascript:loginout()">注销</a></p>
			<p class="head"><a href="#"><img src="${contextPath }/front/images/head.jpg" width="83" height="83" /></a></p>
			<p class="name">${sessionScope.loginName}</p>
			<p class="nr">所属团体：${sessionScope.team.teamName}</p>
			<p class="nr">注册时间：<fmt:formatDate pattern="yyyy-MM-dd" value="${sessionScope.user.createTime}" /></p>
			<p class="nr">ＩＰ地址：${sessionScope.IP}</p>
			<p class="wel">欢迎登录科普资源共享服务平台！</p>
			<p class="but"><a href="${contextPath}/building.jsp"></a></p>
		</div>
		</c:if>
	</div>
	
	<div class="cb"></div>
	<form action="${contextPath}/front/search/index.rt">
	<input name="scope" id="scope" type="hidden" />
	<div class="search">
		<div id="search">
			<div class="box">
				<span class="select" id="spana" title="all">全部</span>
			</div>
			<ul class="sub" id="ula">
				<c:forEach items="${scopes}" var="scp">
					<c:if test="${scp.value.enable }">
						<li id="${scp.value.value }">${scp.value.name}</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
		<div class="search_name"><input name="text" id="searchName" type="text" /></div>
		<div class="search_sub"><input name="5" id="searchBtn" onclick="search();" type="button" /></div>
	</div>
	</form>
	<div class="cb"></div>
	<div class="main">
		<c:forEach items="${channelMap}" var="ck">
		<div class="community">
			<div class="img"><img src="${contextPath}${ck.key.imgPath}" /></div>
			<ul>
			<a class="tit" href="${contextPath}${ck.key.siteUrl}">${ck.key.name}</a>
			<c:forEach items="${ck.value}" var="cv">
			  <li><a href="${contextPath}${cv.siteUrl}">${cv.name}</a></li>
			</c:forEach>
			</ul>
		</div>
		</c:forEach>
		<div class="cb"></div>
	</div>
	<div class="links">
		<div id=demo align=center>
		<table border=0 align=center cellpadding=1 cellspacing=1 cellspace=0 ><tr><td valign=top id=demo1>
			<table width='100%' border='0' cellspacing='0'><tr>
				<c:forEach items="${linkList}" var="l">
				  <td align=center><a target="_blank" href='${l.address}'>${l.linkName}</a></td>
				</c:forEach>
			</tr></table>
		</td><td id=demo2 valign=top></td></tr></table>
		</div>
	</div>
	<div class="copyright">Copyright &copy; 2014 All Rights Reserved 浙ICP备05008719号 技术支持：浙江科协</div>
</div>
<script>
	var speed=30;
	var d2=document.getElementById("demo2");
	var d1=document.getElementById("demo1");
	var d=document.getElementById("demo");
	d2.innerHTML=d1.innerHTML;
	function Marquee(){
	   if(d2.offsetWidth-d.scrollLeft<=0){
		   d.scrollLeft-=d1.offsetWidth;
	   }else{ 
 	       d.scrollLeft++;
	   }
	}
	var MyMar=setInterval(Marquee,speed);
	d.onmouseover=function(){
		clearInterval(MyMar);
		};
	d.onmouseout=function() {
		MyMar=setInterval(Marquee,speed);
		};
</script>
</body>
</html>

