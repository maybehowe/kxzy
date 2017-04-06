<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>科协资源管理平台</title>
<%@include file="../common/form.jsp" %>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${contextPath}/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.excheck-3.5.js"></script>
<link rel="stylesheet" href="${contextPath}/css/easydialog.css" type="text/css"/>
<script type="text/javascript" src="${contextPath}/js/easydialog.min.js"></script>
<script type="text/javascript">
/*<![CDATA[*/
var setting = {
	check: {
		enable: true
	},
	data: {
		simpleData: {
			enable: true
		}
	}
};

var list = ${array};
var zNodes =[];
for(var i=0;i<list.length;i++){
	var node = {};
	node.name=list[i].permName;
	node.id=list[i].id;
	node.pId=list[i].pId;
	if(list[i].pId==0){
		node.open = true;
	}
	if(list[i].checked==true){
		node.checked = true;
	}
	zNodes.push(node);
}

function setCheck() {
	var zTree = $.fn.zTree.getZTreeObj("tree");
	type = { "Y" : "ps", "N" : "ps" };
	zTree.setting.check.chkboxType = type;
}

function roleResForm(){
	var treeObj=$.fn.zTree.getZTreeObj("tree");
          var nodes=treeObj.getCheckedNodes(true);
          var perIds='';
          for(var i=0;i<nodes.length;i++){
        	  perIds +=nodes[i].id+",";
          }
          $.ajax({
		   type: "POST",
		   async: false,
		   url: "${contextPath}/manage/role/savePermission.rt",
		   data: {perIds:perIds,id:${role.id },viewId:${viewId},leftId:${leftId}},
		   success: function(json){
		    	if(json.flag){
					success();
		    	} else{
		    		fail();
		    	}
		   }
		}); 
}
function success(){
	easyDialog.open({
		container : {
			content : '<span style="color:green">保存成功!</span>'
		},
		autoClose : 2000
	});
};
function fail(){
	easyDialog.open({
		container : {
			content : '<span style="color:green">保存失败!</span>'
		},
		autoClose : 2000
	});
};
$(function(){
	$.fn.zTree.init($("#tree"), setting, zNodes);
	setCheck();
});

function selectAllKey(obj){
	var treeObj = $.fn.zTree.getZTreeObj("tree");
	if(obj.checked){
		treeObj.checkAllNodes(true);
	} else{
		treeObj.checkAllNodes(false);
	}
	
}
/*]]>*/
</script>
</head>
<body>
<div class="wrapper">
	<jsp:include page="../common/head.jsp" />
	<div class="content">
		<jsp:include page="../common/left.jsp" />
		<div class="right">
			<!--[if lt IE 8]><div class="both"></div><![endif]-->
			<div class="main">
				<div class="tit">分配权限</div>
				<div class="line">角色：</div>
				<form id="roleForm" action="${contextPath}/manage/role/save.rt" method="post">
				<input type="hidden" name="viewId" value="${viewId }" />
				<input type="hidden" name="leftId" value="${leftId }" />
				<table width="96%" border="0" class="data">
				  <tr>
					<th scope="row" width="110">角色名称：</th>
					<td>${role.roleName }</td>
				  </tr>
				  <tr>
					<th scope="row" align="right"></th>
					<td><ul id="tree" class="ztree"></ul>
						<input type="checkbox" name="checkAll" onclick="selectAllKey(this);" class="fl" style=" margin:20px 0 0 22px;"/><p class="fl" style=" margin:18px 0 0 6px;"><b>全选</b></p></td>
				  </tr>
				  <tr class="buttom">
					<th scope="row" align="right"></th>
					<td>
						<input name="" type="button" value="提交" onclick="roleResForm();" class="add_but fl" />
						<a href="javascript:window.history.back();" class="but_fanhui fl" style="height:24px;border:0px;font-size:14px;color:white;font-weight:bold;">返 回</a>
					</td>
				  </tr>
				</table>
				</form>
			</div>
		</div>
		<div class="cb"></div>
	</div>
</div>
</body>
</html>
