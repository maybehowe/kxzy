<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.roots.kxzy.system.common.constant.JudgeStatus"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科协资源</title>
<%@include file="../common/form.jsp" %>
<link href="${contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(function(){
	//按状态查询
	$("#user_status").change(function(){
		$("#curPage").val(1);
		$("#searchForm").submit();
	});
});
	//搜索
	function searchSubmit(){
		var searchName = $("#searchName").val();
		if(searchName=='输入搜索的关键词'){
			$("#searchName").val('');
		}
		$("#curPage").val(1);
		$("#searchForm").submit();
	}
	
	//同意
	function agree(userId){
		auditTeamUser(userId,<%=JudgeStatus.YES%>);
	}
	//不同意
	function disagree(userId){
		auditTeamUser(userId,<%=JudgeStatus.NO%>);
	}
	
	//审核(批准)
	function auditTeamUser(userId,auditStatus){
		var url = "${contextPath }/manage/work/auditTeamUser.rt";
		var params = {
			"userId" : userId,
			"auditStatus":auditStatus
		};
		if(confirm("确定提交吗？")){
			$.post(url,params,function(result) {
				if (result.flag){
					 $("#searchForm").attr("action","${contextPath }/manage/work/auditTeamUserList.rt");
					 $("#searchForm").submit();
				} else {
					alert("操作失败！");
				}
			});
		}
	}
	
	//详情
	function detail(id){
		$("#searchForm").attr("action","${contextPath }/manage/work/showTeamUserDetail.rt?userId="+id);
		$("#searchForm").submit();
	}
	
   //查看附件
   function checkAffix(affixId){
	   window.location.href="${contextPath}/manage/work/download.rt?affixId="+affixId;
   }
</script>
</head>
<body>
<div class="wrapper">
	<jsp:include page="../common/head.jsp" />
	<div class="content">
		<jsp:include page="../common/left.jsp" />
		<div class="right">
			<form id="searchForm" action="${contextPath}/manage/work/auditTeamUserList.rt" method="post">
			 <input type="hidden" name="curPage" id="curPage" value="${curPage}"/>
			 <input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			 <input type="hidden" name="viewId" value="${viewId }" />
			 <input type="hidden" name="leftId" value="${leftId }" />
			<fieldset class="search">
				<legend style="border:0px;background-color:white;">条件查询</legend>
				<div>
					登录名：
					<input name="searchName" id="searchName" type="text" class="text" value="${rt:escapeHtml(searchName)}" />
					<input type="submit" value="搜 索" class="sub" onclick="searchSubmit()"/>
				</div>
			</fieldset>
			<div class="main">
				<table width="100%" border="0" id="At_table">
				  <tr>
					<th scope="col" width="5%"><input name="c0" type="checkbox" value="check" onclick="selectAll(this)" /></th>
					<th scope="col" width="15%">登录名</th>
					<th scope="col" width="15%">真实姓名</th>
					<th scope="col" width="20%">所属团体</th>
					<th scope="col" width="20%">附件</th>
					<th scope="col" width="25%">操作</th>
				  </tr>
				  <c:forEach items="${page.results}" var="user">
				  	 <tr>
						<td><input name="idList" id="idList" type="checkbox" value="${user.id}" /></td>
						<td>${user.loginName}</td>
						<td>${user.realName}</td>
						<td>
						   <c:forEach items="${teamMap}" var="tm" >
						      ${user.id eq tm.key ? tm.value : ''}
						   </c:forEach>
						</td>
						<td>
						   <c:forEach items="${affixMap}" var="am" >
						      ${user.id eq am.key ? am.value : ''}
						   </c:forEach>
						</td>
						<td>
						  <a href="javascript:void(0);" onclick="detail(${user.id});">详情</a><span> -</span>
						  <a href="javascript:void(0);" onclick="checkAffix(${user.affixId});">查看附件</a><span> -</span>
						  <a href="javascript:void(0);" onclick="agree(${user.id});">同意</a><span> -</span>
						  <a href="javascript:void(0);" onclick="disagree(${user.id});">不同意</a>
						</td>
					  </tr>
				  </c:forEach>
				</table>
				<div class="page">
					<jsp:include page="../common/page.jsp" >
					<jsp:param value="${contextPath}/manage/work/auditTeamUserList.rt" name="pageUrl"/>
					<jsp:param value="searchForm" name="formName"/>
					</jsp:include>
				</div>
			</div>
			<!--数据列表.end-->
			</form>
		</div>
		<div class="cb"></div>
	</div>
</div>
<script src="${contextPath}/js/checkbox.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	var Ptr=document.getElementById("At_table").getElementsByTagName("tr");
    for (i=1;i<Ptr.length+1;i++) { 
    	Ptr[i-1].className = (i%2>0)?"t1":"t2"; 
    }
</script>
<script src="${contextPath}/js/checkbox.js" type="text/javascript" charset="utf-8"></script>
</script>
</body>
</html>
