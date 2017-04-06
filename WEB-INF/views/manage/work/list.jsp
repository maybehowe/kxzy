<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>科协资源管理平台</title>
<%@include file="../common/form.jsp" %>
<link href="${contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
/*<![CDATA[*/
/*]]>*/
</script>
</head>
<body>
<div class="wrapper">
	<jsp:include page="../common/head.jsp" />
	<div class="content">
		<jsp:include page="../common/left.jsp" />
		<div class="right">
			<!--查询-->
			<form name="searchForm" id="searchForm" action="${contextPath}/manage/work/list.rt" method="post">
			<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			<input type="hidden" name="viewId" value="${viewId }" />
			<input type="hidden" name="leftId" value="${leftId }" />
			
			<!--查询.end-->
			<!--数据列表-->
			<div class="main">
				<table width="100%" border="0" id="At_table">
				  <tr>
					<th scope="col" width="7%">序号</th>
					<th scope="col" width="15%">所属机构</th>
					<th scope="col" width="15%">视频名称</th>
					<th scope="col" width="10%">视频类别</th>
					<th scope="col" width="21%">审核状态</th>
					<th scope="col" width="10%">转码状态</th>
					<th scope="col" width="15%">创建时间</th>
					<th scope="col" width="34%">操作</th>
				  </tr>
				  <c:forEach items="${page.results }" var="v" varStatus="index">
				  	<tr>
						<td>${index.index+1 }</td>
						<td>${v.agencyName }</td>
						<td>${v.videoTitle }</td>
						<td>${v.resource }</td>
						<td>
							<c:if test="${v.status==1 }">待审核</c:if>
						</td>
						<td>
							<c:if test="${v.transcodeState==1 }">未转码</c:if>
							<c:if test="${v.transcodeState==2 }">正在转码</c:if>
							<c:if test="${v.transcodeState==3 }">已完成</c:if>
							<c:if test="${v.transcodeState==4 }">转码异常</c:if>
						</td>
						<td><fmt:formatDate value="${v.uploadTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td>
						
							<c:if test="${v.status==0 }">
							</c:if>
							<a href="${contextPath }/manage/work/audit.rt?id=${v.id}&viewId=${viewId}&leftId=${leftId}">审核</a>
							
<%--							<c:if test="${v.status==1 }">--%>
<%--								<span> -</span>--%>
<%--								<a href="javascript:void(0);" onclick="del(${v.id});">删除</a>--%>
<%--							</c:if>--%>
						</td>
					  </tr>
				  </c:forEach>
				</table>
				<div class="page">
<%--					<div class="page_all"><input name="cc" type="checkbox" value="all" id="All" onClick="selectAll(this);" /></div>--%>
<%--					<div class="quanx fl"><label for="All">全选/反选</label></div>--%>
<%--					<div class="fl"><input type="button" id="delSelected" value="删除选中视频" class="sub2 ml25" style="*margin-left:-170px;" /></div>--%>
					<jsp:include page="../common/page.jsp" >
					<jsp:param value="${contextPath}/manage/work/list.rt" name="pageUrl"/>
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
<script type="text/javascript">
	var Ptr=document.getElementById("At_table").getElementsByTagName("tr");
    for (i=1;i<Ptr.length+1;i++) { 
    	Ptr[i-1].className = (i%2>0)?"t1":"t2"; 
    }
</script>
<script src="${contextPath}/js/checkbox.js" type="text/javascript" charset="utf-8"></script>
</body>
</html>

