<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.roots.kxzy.system.common.constant.EnableStatus"%>
<%
	request.setAttribute("enable",EnableStatus.ENABLE);
	request.setAttribute("disable",EnableStatus.DISABLE);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科协资源</title>
<%@include file="../common/form.jsp" %>
<link href="${contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/sco.message.css" type="text/css"></link>
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/scojs.css" type="text/css"></link>
<script type="text/javascript" src="${contextPath}/bootstrap.sco/js/sco.message.js"></script>
<script type="text/javascript">
$(function(){
	//批量删除
	$("#delSelected").click(function(){
		var arrayId = new Array();
		$("input[name='idList']:checked").each(function(){
			arrayId.push($(this).val());
		});
		if(arrayId.length > 0){
			var ids = "";
			for ( var i = 0; i < arrayId.length; i++) {
				ids += arrayId[i] + ",";
			}
			ids = ids.substring(0, ids.length - 1);
			if(confirm("确定删除？")){
				var url = "${contextPath }/manage/user/delete.rt";
				var params = {
					"ids" : ids,
				};
				$.post(url,params,function(result) {
					if (result.flag){
						 $.scojs_message('删除成功',{
							 "type":$.scojs_message.TYPE_OK,
							 "delay":1000,
							 "onAfterHidden" : function(){
								 $("#searchForm").attr("action","${contextPath }/manage/user/list.rt");
								 $("#searchForm").submit();
							 }
						 });
					} else {
						 $.scojs_message('删除失败', $.scojs_message.TYPE_ERROR);
					}
				});
			}else{
				return false;
			}
		} else{
			 $.scojs_message('请至少选择一行数据！', $.scojs_message.TYPE_ERROR);
		}
	});
	
	loadTeam(null,[${teamId}]);
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
	//编辑
	function edit(id){
		$("#searchForm").attr("action","${contextPath }/manage/user/showEdit.rt?userId="+id);
		$("#searchForm").submit();
	}
	//删除
	function del(cateId){
		if(confirm("确定删除？")){
				var url = "${contextPath }/manage/user/delete.rt";
				var params = {
					"ids" : cateId,
				};
				$.post(url,params,function(result) {
					if (result.flag){
						 $.scojs_message('删除成功',{
							 "type":$.scojs_message.TYPE_OK,
							 "delay":1000,
							 "onAfterHidden" : function(){
								 $("#searchForm").attr("action","${contextPath }/manage/user/list.rt");
								 $("#searchForm").submit();
							 }
						 });
					} else {
						 $.scojs_message('删除失败', $.scojs_message.TYPE_ERROR);
					}
				});
			}else{
				return false;
			}
	}
	
	//设置用户状态
	function disabledOrEnable(userId,activation){
		var url = "${contextPath }/manage/user/setActivation.rt";
		var params = {
			"userId" : userId,
			"activation" : activation
		};
		$.post(url,params,function(result) {
			if (result.flag){
				 $("#searchForm").attr("action","${contextPath }/manage/user/list.rt");
				 $("#searchForm").submit();
			} else {
				$.scojs_message('操作失败', $.scojs_message.TYPE_ERROR);
			}
		});
	}
	
	//详情
	function detail(id){
		$("#searchForm").attr("action","${contextPath }/manage/user/showDetail.rt?userId="+id);
		$("#searchForm").submit();
	}
	
	function loadTeam(obj,nextPath){
		$(obj).nextAll().remove();
		var id;
		if(obj == null){
			id = 0;
		} else {
			id = $(obj).val();
		}
		$.ajax({
		   type: "POST",
		   url: "${contextPath}/manage/team/loadTeam.rt?parentId="+id,
		   success: function(json){
			   if(json != null && json != ''){
				    var html='';
			     	html +='<select name="teamId" onchange="loadTeam(this);">';
			     	html +='<option value="">--请选择--</option>';
			     	$(json).each(function(i,item){
			    		 html +='<option value="'+item.id+'">'+item.teamName+'</option>';
			     	});
			     	html +='</select>';
			     	var newSelect = $(html);
			     	newSelect.appendTo("#teames");
			    	if(nextPath && nextPath.length > 0){
			    		$(newSelect).find("option[value="+ nextPath[0] +"]").attr("selected","selected");
			    		if(nextPath.length>1){
			    			loadTeam(newSelect,nextPath.slice(1,nextPath.length));
			    		}
			    	}
			   }
		   }
		});
	}
</script>
<style>
#teames select{ margin-right:5px;}
</style>
</head>
<body>
<div class="wrapper">
	<jsp:include page="../common/head.jsp" />
	<div class="content">
		<jsp:include page="../common/left.jsp" />
		<div class="right">
			<div class="buts">
				<a href="${contextPath}/manage/user/showAdd.rt?viewId=${viewId}&leftId=${leftId}">添加用户</a>
			</div>
			<form id="searchForm" action="${contextPath}/manage/user/list.rt" method="post">
			 <input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			 <input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			 <input type="hidden" name="viewId" value="${viewId }" />
			 <input type="hidden" name="leftId" value="${leftId }" />
			<fieldset class="search">
				<legend style="border:0px;background-color:white;">条件查询</legend>
				<div>
					<p class="fl">状态查询：</p>
					<p class="fl"><select class="mr15" name="activation">
					  <option value="">--请选择--</option>
					  <option value="${enable}" ${(activation eq enable)? "selected='selected'":""}>激活</option>
					  <option value="${disable}" ${(activation eq disable)? "selected='selected'":""}>禁用</option>
					</select></p>
					<p class="fl">团体：</p>
					<u id="teames" class="mr15 fl"></u>
					<p class="fl">登录名：</p>
					<p class="fl"><input name="searchName" id="searchName" type="text" class="text mr15" value="<c:out value="${searchName}" escapeXml="true"/>" style="width:90px;" /></p>
					<p class="fl">角色：</p>
					<p class="fl"><select id="role_id" name="roleId" class="mr15">
					  <option value="">--请选择--</option>
					  <c:forEach items="${roleList}" var="rl">
					   <option value="${rl.id}"
					    <c:if test="${rl.id eq roleId}">selected='selected'</c:if>
					   >${rl.roleName}</option>
					  </c:forEach>
					</select></p>
					<p><input type="submit" value="搜 索" class="sub" onclick="searchSubmit()"/></p>
				</div>
			</fieldset>
			<div class="main">
				<table width="100%" border="0" id="At_table">
				  <tr>
					<th scope="col" width="5%"><input name="c0" type="checkbox" value="all" id="All" onclick="selectAll(this)" /></th>
					<th scope="col" width="15%">登录名</th>
					<th scope="col" width="15%">真实姓名</th>
					<th scope="col" width="15%">所属角色</th>
					<th scope="col" width="15%">所属团体</th>
					<th scope="col" width="10%">状态</th>
					<th scope="col" width="25%">操作</th>
				  </tr>
				  <c:forEach items="${page.results}" var="user">
				  	 <tr>
						<td><input name="idList" id="idList" type="checkbox" value="${user.id}" /></td>
						<td>${user.loginName}</td>
						<td>${user.realName}</td>
						<td>
                           <c:forEach items="${roleMap}" var="rm" >
						      ${user.id eq rm.key ? rm.value.roleName : ''}
						   </c:forEach>
                        </td>
						<td>
						   <c:forEach items="${teamMap}" var="tm" >
						      ${user.id eq tm.key ? tm.value : ''}
						   </c:forEach>
						</td>
						<td>
							<c:if test="${user.activation == enable }"><span class="ok">激活</span></c:if>
							<c:if test="${user.activation == disable }"><span class="no">禁用</span></c:if>
						</td>
						<%--<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${user.createTime }" /></td>--%>
						<td>
						     <c:forEach items="${roleMap}" var="rm" >
						      <c:if test="${user.id eq rm.key}">
					              <c:choose>
					                <c:when test="${(rm.value.sortId > role.sortId)}">
					                    <a href="javascript:void(0);" onclick="edit(${user.id});">编辑</a><span> -</span>
	              					    <c:choose>
										   <c:when test="${user.activation == disable}">
										     <a href="javascript:void(0);" onclick="disabledOrEnable(${user.id},${enable});"><span class="ok">激活</span></a>
										   </c:when>
										   <c:when test="${user.activation == enable}">
										     <a href="javascript:void(0);" onclick="disabledOrEnable(${user.id},${disable});"><span class="no">禁用</span></a>
										   </c:when>
										 </c:choose>
						                 <span> - </span><a href="javascript:void(0);" onclick="javascript:del(${user.id});">删除</a>
					                </c:when>
					                 <c:otherwise>
					                  <a href="javascript:void(0);" style="color: #B4B4B4; text-decoration:none;">编辑</a><span> -</span>
					                   <c:choose>
										   <c:when test="${user.activation == disable}">
										     <a href="javascript:void(0);" style="color: #B4B4B4; text-decoration:none;">激活</span></a>
										   </c:when>
										   <c:when test="${user.activation == enable}">
										     <a href="javascript:void(0);" style="color: #B4B4B4; text-decoration:none;">禁用</span></a>
										   </c:when>
									   </c:choose>
					                  <span> - </span><a href="javascript:void(0);" style="color: #B4B4B4; text-decoration:none;">删除</a>
					                </c:otherwise>
					              </c:choose>
					            </c:if>
						     </c:forEach>
						     <span> - </span><a href="javascript:void(0);" onclick="detail(${user.id});">详情</a>
						</td>
					  </tr>
				  </c:forEach>
				</table>
				<div class="page">
					<div class="fl"><input id="delSelected" type="button" value="删除选中用户" class="sub2" style="*margin-left:-170px;" /></div>
					<jsp:include page="../common/page.jsp" >
					<jsp:param value="${contextPath}/manage/user/list.rt" name="pageUrl"/>
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

</body>
</html>
