<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${sessionScope.loginName==null }">
	<div class="login">
	<input id="loginName" type="text" class="login_name" />
	<input id="passWord" type="password" class="login_pwd" />
	<input id="submit_btn" type="button" value="" class="login_sub" />
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
