<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="../common/form.jsp" %>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="edge" />
	<title>浙江省科普资源共享服务平台-角色添加</title>
	<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
	<!--<link rel="stylesheet" href="${contextPath}/js/ztree/css/demo.css" type="text/css">-->
	<link rel="stylesheet" href="${contextPath}/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.excheck-3.5.js"></script>
	<link rel="stylesheet" href="${contextPath}/css/easydialog.css" type="text/css">
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

	var list = ${resouces};
	var zNodes =[];
	for(var i=0;i<list.length;i++){
		var node = {};
		node.name=list[i].resName;
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
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		type = { "Y" : "ps", "N" : "ps" };
		zTree.setting.check.chkboxType = type;
	}
	
	function roleResForm(){
		var treeObj=$.fn.zTree.getZTreeObj("treeDemo");
           var nodes=treeObj.getCheckedNodes(true);
           var resIds='';
           for(var i=0;i<nodes.length;i++){
           	resIds +=nodes[i].id+",";
           }
           $.ajax({
		   type: "POST",
		   async: false,
		   url: "${contextPath}/manage/role/roleRes/save.rt",
		   data: {resIds:resIds,roleId:${roleId }},
		   success: function(json){
		    	if(json.flag){
					success();
		    		//window.location.href="${contextPath}/role/resAllo.rt?roleId=${roleId }&leftId=${leftId}&viewId=${viewId}";
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
		$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		setCheck();
	});
	/*]]>*/
	</script>
	<style>
	table.data td span{ padding-left:0px;}
	</style>
</head>

<body>

<div class="wrapper">
<jsp:include page="../common/head.jsp" />
	<div class="content">
		<jsp:include page="../common/left.jsp"/>
		<div class="right">
			<!--[if lt IE 8]><div class="both"></div><![endif]-->
			<div class="main">
				<div class="tit">资源分配</div>
				<div class="line">资源详情：</div>
				<table width="96%" border="0" class="data" >
				  <tr style="height: 10px;">
					<td colspan="2" id="msg"></td>
				  </tr>
				  <tr>
					<td colspan="2">
						<ul id="treeDemo" class="ztree"></ul>
					</td>
				  </tr>
				  <tr class="buttom">
					<th scope="row" align="right" width="110"></th>
					<td>
						<input name="" type="submit" value="提 交" class="add_but fl" onclick="roleResForm();" id="demoBtn2" />
						<a href="javascript:window.history.back();" class="but_fanhui fl" style="height:24px;border:0px;font-size:14px;color:white;font-weight:bold;">返 回</a>
					</td>
				  </tr>
				</table>
				
			</div>
		</div>
		<div class="cb"></div>
	</div>
</div>
<script src="${contextPath}/js/checkbox.js" type="text/javascript" charset="utf-8"></script>
</body>
</html>

