<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="../common/form.jsp" %>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="edge" />
	<title>科协资源管理平台</title>
	<link href="${contextPath }/css/style_add.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath }/js/jquery.divbox2.js"></script>	
	<script type="text/javascript">
	/*<![CDATA[*/
	$(function(){
		var searchName = $("#searchName").val();
		if(searchName==''){
			$("#searchName").val('输入搜索的帐号');
		}
		$("#delSelected").click(function(){
			var arrayId = new Array();
			$("input[name='userIds']:checked").each(function(){
				arrayId.push($(this).val());
			});
			if(arrayId.length > 0){
				if(confirm("确定删除？")){
					$("#searchForm").attr("action","${contextPath}/manage/role/rurelation/delSelected.rt?id=${id }");
					$("#searchForm").submit();
				}
			} else{
				alert("请至少选择一行数据");
			}
		});
	});
	
	function selected(obj,id){
		if($(obj).parent().attr("class")==undefined || $(obj).parent().attr("class")==''){
			$(obj).parent().addClass("hover");
			$(obj).parent().find("input").val(id);
		} else{
			$(obj).parent().removeClass("hover");
			$(obj).parent().find("input").val('');
		}
	}
	
	function clearAll(){
		$("#myuser").empty();
	}
	
	function removeUser(obj){
		$(obj).parent().remove();
	}
	
	function addUserToList(){
		var html = '';
		$("#userList li").each(function(i){
			if($(this).attr("class")=="hover"){
				var id = $(this).find("input").val();
				var u = $(this).find("a").html();
				if($("#myuser li").length > 0){
					var bool= false;
					$("#myuser li").each(function(j){
						if(u==$(this).find("span").html()){
							bool= false;
							return false;
						} else{
							bool= true;
							return true;
						}
					});
					if(bool){
						html += '<li><input type="hidden" name="userIds" id="userIds" value="'+id+'"/><span>'+u+'</span><a href="javascript:void(0);" onclick="removeUser(this);"><img src="${contextPath }/images/role_02.jpg" /></a></li>';
					}
				} else{
					html += '<li><input type="hidden" name="userIds" id="userIds" value="'+id+'" /><span>'+u+'</span><a href="javascript:void(0);" onclick="removeUser(this);"><img src="${contextPath }/images/role_02.jpg" /></a></li>';
				}
			}
		});
		$("#myuser").append(html);
	}
	
	function openDiv() {
		$.ajax({
		   type: "POST",
		   dataType: "json",
		   url: "${contextPath }/manage/user/findAll.rt",
		   data: "",
		   success: function(json){
		     var html = '';
		     $(json).each(function(i,user){
		     	html+='<li><input type="hidden" id="'+user.id+'" /><a href="javascript:void(0);" onclick="selected(this,'+user.id+');">'+user.loginName+'</a></li>';
		     });
		     $("#userList").html(html);
		   }
		}); 
		$("#divSCA").OpenDiv();
	}

	function closeDiv() {
		$("#divSCA").CloseDiv();
		clearAll();
	}
	function addUser(){
		formSubmit();
		closeDiv();
	}
	
	function formSubmit(){
		$("#myuserForm").submit();
	}
	function del(id,roleId){
		if(confirm("确定删除？")){
			$("#searchForm").attr("action","${contextPath}/manage/role/rurelation/delete.rt?ruId="+id+"&id="+roleId);
			$("#searchForm").submit();
		}
	}
	function searchSubmit(){
		$("#curPage").val(1);
		$("#searchForm").submit();
	}
	/*]]>*/
	</script>
<style>
.page .page_div input.text{ width:21px; height:21px; margin:0px; padding:0px; background:url("${contextPath }/images/input_go.jpg") no-repeat scroll 0 0 rgba(0, 0, 0, 0); border:0px; color:#5F5F5F;}
</style>
</head>

<body>
<!--弹出层-->
<div id="divSCA">
	<div class="tit">
		<div class="fl">添加账号</div>
		
		<div class="fr"><a href="javascript:void(0);" onClick="closeDiv()">X</a></div>
	</div>
	<div class="divSCA_main">
		<div class="open_left fl">
			<div class="nr">
				<ul id="userList"></ul>
			</div>
		</div>
		<div class="open_main fl">
			<p><a href="javascript:void(0);" onclick="addUserToList();"><img src="${contextPath }/images/but_tj.jpg" /></a></p>
			<p><a href="javascript:void(0);" onclick="clearAll();"><img src="${contextPath }/images/but_qk.jpg" /></a></p>
			<p><a href="javascript:void(0);" onClick="addUser();"><img src="${contextPath }/images/but_bc.jpg" /></a></p>
		</div>
		<div class="open_right fl">
			<form id="myuserForm" name="myuserForm" action="${contextPath }/manage/role/rurelation/save.rt" method="post">
			<input type="hidden" name="id" id="id" value="${id }"/>
			<input type="hidden" name="viewId" id="viewId" value="${viewId }"/>
			<input type="hidden" name="leftId" id="leftId" value="${leftId }"/>
			<div class="nr">
				<ul id="myuser">
				</ul>
			</div>
			</form>
		</div>
		<div class="cb"></div>
	</div>
</div>
<!--弹出层.end-->
<div class="wrapper">
	<jsp:include page="../common/head.jsp" />
	<div class="content">
		<jsp:include page="../common/left.jsp"/>
		<div class="right">
			<!--[if lt IE 8]><div class="both"></div><![endif]-->
			<div class="main">
				<div class="tit">人员分配</div>
				<div class="line">人员详情：</div>
				<div class="main2">
					<form name="searchForm" id="searchForm" action="${contextPath}/manage/role/allocation.rt?id=${id }" method="post">
					<input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
					<input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
					<input type="hidden" name="viewId" id="viewId" value="${viewId }"/>
					<input type="hidden" name="leftId" id="leftId" value="${leftId }"/>
					<div class="fl mr40"><a href="javascript:void(0);" class="tianjia" onClick="openDiv()">添加帐号</a></div>
					<input name="relation.user.loginName" id="searchName" type="text" class="text" value="<c:out value="${relation.user.loginName }" escapeXml="true"/>" onfocus="if(this.value=='输入搜索的帐号'){this.value=''}" onblur="if(this.value==''){this.value='输入搜索的帐号'}" />
					<input name="" type="button" onclick="searchSubmit();" value="搜 索" class="sub" />
					<!--数据列表-->
					<div class="all_table">
						<table width="100%" border="0" id="At_table2">
						  <tr>
							<th scope="col" width="7%"><!--<input name="c0" type="checkbox" value="check" /> --></th>
							<th scope="col" width="31%">帐号</th>
							<th scope="col" width="31%">状态</th>
							<th scope="col" width="31%">操作</th>
						  </tr>
						  <c:forEach items="${page.results }" var="relation">
						  	 <tr>
								<td><input name="userIds" type="checkbox" value="${relation.id }" /></td>
								<td>${relation.user.loginName }</td>
								<td>
									<c:if test="${relation.user.activation==0 }"><span class="no">禁用</span></c:if>
									<c:if test="${relation.user.activation==1 }"><span class="ok">启用</span></c:if>
								</td>
								<td>
									<a href="javascript:void(0);" onclick="del(${relation.id},${id});">删除</a>
								</td>
							  </tr>
						  </c:forEach>
						</table>
						<div class="page">
							<div class="page_all"><input name="cc" type="checkbox" value="all" id="All" onClick="selectAll(this);" /></div>
							<div class="quanx fl"><label for="All">全选/反选</label></div>
							<div class="fl"><input type="button" id="delSelected" value="删除选中用户" class="sub2 ml25" /></div>
							<jsp:include page="../common/page.jsp">
							<jsp:param value="${contextPath}/manage/role/allocation.rt?id=${id }" name="pageUrl"/>
							<jsp:param value="searchForm" name="formName"/>
							</jsp:include>
							<div class="cb"></div>
						</div>
					</div>
					<!--数据列表.end-->
					<div class="mt26"><a onclick="addLeft(80,82,'${contextPath }/manage/role/list.rt');" href="javascript:void(0);" class="but_fanhui">返 回</a></div>
				</form>
				</div>
			</div>
		</div>
		<div class="cb"></div>
	</div>
</div>
<script type="text/javascript">
	var Ptr=document.getElementById("At_table2").getElementsByTagName("tr");
    for (i=1;i<Ptr.length+1;i++) { 
    	Ptr[i-1].className = (i%2>0)?"t1":"t2"; 
    }
</script>
<script src="${contextPath }/js/checkbox.js" type="text/javascript"></script>
</body>
</html>

