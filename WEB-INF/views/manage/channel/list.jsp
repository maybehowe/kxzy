<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.roots.kxzy.system.common.constant.EnableStatus"%>
<%@page import="com.roots.kxzy.system.common.constant.JudgeStatus"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科协资源-科普团体</title>
<%@include file="../common/form.jsp" %>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/css/ligerUI/ligerui-all.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="${contextPath }/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css" />
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/sco.message.css" type="text/css"></link>
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/scojs.css" type="text/css"></link>
<script type="text/javascript" src="${contextPath}/bootstrap.sco/js/sco.message.js"></script>
<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.exedit-3.5.js"></script>
<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="${contextPath}/js/ztree/ligerui.min.js"></script>

 <script type="text/javascript">
	var rootId=0;//顶级节点	
	var foldMenu;
	var leafMenu;
	var enableRefreshTree = false;
	$(function(){
		//菜单
		loadMenu();
		//$("#listFrame").attr("src", "${contextPath}/manage/channel/detail.rt?id=1");
		//加载树
		loadTree();
	});
	
	//菜单
	function loadMenu() {
		foldMenu = $.ligerMenu({
			top : 100,
			left : 100,
			width : 120,
			items : [ {
				id : 'pop_add',
				text : '增加子级',
				click : addNode
			}, {
				id : 'pop_edit',
				text : '编辑',
				click : editNode
			}, {
				id : 'pop_delete',
				text : '删除',
				click : delNode
			} ,{
				id : 'pop_up',
				text : '上移',
				click : upNode
			}, {
				id : 'pop_down',
				text : '下移',
				click : downNode
			}/*, {
				id : 'pop_showIndex',
				text : '首页展示',
				click : showIndexNode
			}, {
				id : 'pop_removeIndex',
				text : '取消首页展示',
				click : removeIndexNode
			} */ ]
		});
	};

	//树
	var teamTree;
	
	//加载树
	function loadTree() {
		var setting = {
			async : {
				enable : false
			},
			data : {
				key : {
					name : "name"
				},
				simpleData : {
					enable : true,
					idKey : "id",
					pIdKey : "parentId",
					rootPId : 0
				}
			},
			view : {
				selectedMulti : false
			},
			/*edit : {
				drag : {
					prev : true,
					inner : false,
					next : true,
					isMove : true
				},
				enable : true,
				showRemoveBtn : false,
				showRenameBtn : false
			},*/
			callback : {
				onClick : zTreeOnLeftClick,
				onRightClick : zTreeOnRightClick,
			}
		};
		var url = "${contextPath}/manage/channel/treeData.rt";
		$.post(url, function(result) {
			teamTree = $.fn.zTree.init($("#teamTree"), setting, result);
			teamTree.expandAll(true);
		});
	};

	//树左击事件
	function zTreeOnLeftClick(event, treeId, treeNode) {
		enableRefreshTree = false;
		var id = treeNode.id;
		if (id == rootId) {
			return;
		}
		var url = "${contextPath}/manage/channel/detail.rt?id=" + treeNode.id;
		$("#listFrame").attr("src", url);
	};
	
    //树右击事件
	function zTreeOnRightClick(e, treeId, treeNode) {
		if (treeNode) {
			teamTree.selectNode(treeNode);
			var h = $(window).height();
			var w = $(window).width();
			var menuWidth = 120;
			var menuHeight = 170;
			var menu = foldMenu;
			var x = e.pageX, y = e.pageY;
			if (e.pageY + menuHeight > h) {
				y = e.pageY - menuHeight;
			}
			if (e.pageX + menuWidth > w) {
				x = e.pageX - menuWidth;
			}
			if(treeNode.level==0){
				menu.setEnable("pop_add");
				menu.setDisable("pop_delete");
				menu.setDisable("pop_edit");
				menu.setDisable("pop_up");
				menu.setDisable("pop_down");	
				//menu.setDisable("pop_showIndex");	
				//menu.setDisable("pop_removeIndex");	
			}else{
				menu.setEnable("pop_add");
				menu.setEnable("pop_delete");
				menu.setEnable("pop_edit");
				menu.setEnable("pop_up");
				menu.setEnable("pop_down");
				//menu.setEnable("pop_showIndex");
				//menu.setEnable("pop_removeIndex");
				if(treeNode.parentId == 1){
					menu.setDisable("pop_delete");
					menu.setDisable("pop_edit");
					//if(treeNode.isShowIndex==<%=JudgeStatus.YES%>){ 
					//	menu.setDisable("pop_showIndex");
					//}else{
					//	menu.setDisable("pop_removeIndex");
					//}
				}else{
					menu.setEnable("pop_delete");
					menu.setEnable("pop_edit");
					//menu.setDisable("pop_showIndex");
					//menu.setDisable("pop_removeIndex");
				}
		    }
			menu.show({
				top : y,
				left: x
			});
	    }
    }

	//展开收起
	function treeExpandAll(type) {
		teamTree = $.fn.zTree.getZTreeObj("teamTree");
		teamTree.expandAll(type);
	};

	//添加资源
	function addNode() {
		enableRefreshTree = false;
		var selectNode = getSelectNode();
		var id = selectNode.id;
		/*var url = "${contextPath}/manage/channel/validateChannelCount.rt";
		var params = { "pid" : id};
		$.post(url,params, function(result) {
			if (!result.flag) {
				alert("同级栏目个数不能超出5个！");
				return;
			} else {
				var url = "${contextPath}/manage/channel/add.rt?pid=" + getSelectNode().id +"&viewId=${viewId}&leftId=${leftId}";
				$("#listFrame").attr("src", url);
			}
		});*/
		var url = "${contextPath}/manage/channel/add.rt?pid=" + getSelectNode().id +"&viewId=${viewId}&leftId=${leftId}";
		$("#listFrame").attr("src", url);
	};
	
	//编辑资源
	function editNode() {
		enableRefreshTree = false;
		var selectNode = getSelectNode();
		var resId = selectNode.id;
		if (resId == rootId) {
			$.ligerMessageBox.warn('提示信息', '该节点为系统节点 ,不充许该操作');
			return;
		}
		var url = "${contextPath}/manage/channel/edit.rt?id=" + selectNode.id +"&viewId=${viewId}&leftId=${leftId}";
		$("#listFrame").attr("src", url);

	};
	//删除资源
	function delNode() {
		if(confirm('确认删除吗？')){
			var selectNode = getSelectNode();
			var id = selectNode.id;
			if (id == rootId) {
				alert('该节点为系统节点 ,不充许该操作');
				return;
			}
			var url = "${contextPath}/manage/channel/delete.rt";
			var params = {
				id : id
			};
			$.post(url, params, function(result) {
				if(result.toString().indexOf('你没有权限访问') != -1){
					alert("没有权限");
				} else {
					if (result.success) {
						 $.scojs_message('删除成功',{
							 "type":$.scojs_message.TYPE_OK,
							 "delay":1000,
							 "onAfterHidden" : function(){
									teamTree.removeNode(selectNode);
									reFresh();
							 }
						 });
					} else {
						 $.scojs_message(result.message, $.scojs_message.TYPE_ERROR);
					}
				}
			});
		}
	}
	
	//上移
	function upNode() {
		var selectNode = getSelectNode();
		var id = selectNode.id;
		if (id == rootId) {
			alert('该节点为系统节点 ,不充许该操作');
			return;
		}
		var url = "${contextPath}/manage/channel/move.rt";
		var params = {
				id : id,
				"doup" : true
			};
			$.post(url, params, function(result) {
				if (result.success==true) {
					teamTree.removeNode(selectNode);
					reFresh();
				} else {
					alert("排序失败！");
				}
			});
	}
	
	//下移
	function downNode() {
		var selectNode = getSelectNode();
		var id = selectNode.id;
		if (id == rootId) {
			alert('该节点为系统节点 ,不充许该操作');
			return;
		}
		var url = "${contextPath}/manage/channel/move.rt";
		var params = {
				id : id,
				"doup" : false
			};
			$.post(url, params, function(result) {
				if (result.success==true) {
					teamTree.removeNode(selectNode);
					reFresh();
				} else {
					alert("排序失败！");
				}
			});
	}
	
	//是否首页展示
	function showIndexNode() {
		var selectNode = getSelectNode();
		var id = selectNode.id;
		if (id == rootId) {
			alert('该节点为系统节点 ,不充许该操作');
			return;
		}
		var url = "${contextPath}/manage/channel/updateShowIndex.rt";
		var params = {
				'id' : id,
				'isShowIndex':<%=JudgeStatus.YES%>
			};
			$.post(url, params, function(result) {
				if (result.success==true) {
					reFresh();
				} else {
					alert("首页展示频道个数不能超出4！");
				}
			});
	}
	
	//是否首页展示
	function removeIndexNode() {
		var selectNode = getSelectNode();
		var id = selectNode.id;
		if (id == rootId) {
			alert('该节点为系统节点 ,不充许该操作');
			return;
		}
		var url = "${contextPath}/manage/channel/updateShowIndex.rt";
		var params = {
				'id' : id,
				'isShowIndex':<%=JudgeStatus.NO%>
			};
			$.post(url, params, function(result) {
				if (result.success==true) {
					reFresh();
				} else {
					alert("操作失败！");
				}
			});
	}

	//选择资源节点。
	function getSelectNode() {
		teamTree = $.fn.zTree.getZTreeObj("teamTree");
		var nodes = teamTree.getSelectedNodes();
		var node = nodes[0];
		return node;
	}
	//刷新
	function reFresh() {
			loadTree();
	};

 </script> 
 <style type="text/css">
html,body {
	padding: 0px;
	margin: 0;
	width: 100%;
	height: 100%;
	font-family:"宋体";
}
.ztree {
	overflow: auto;
	height: 573px;
}
</style>
</head>
<body>
<div class="wrapper">
    <jsp:include page="../common/head.jsp" />
	<div class="content">
	<jsp:include page="../common/left.jsp" />
		<div class="right">
			<div class="main">
				<div class="tit">频道</div>
				  <table>
				    <tr>
				      <td>
				        <div class="sms_lxr" style=" margin-top:15px; height: 610px">
						<div class="tree-toolbar tree-title" id="pToolbar">
							<span>
								<a class="but_fanhui fl" id="treeFresh" href="javascript:reFresh();">刷新</a>
								<a class="but_fanhui fl" id="treeExpandAll" href="javascript:treeExpandAll(true)" style="padding-left: 3.5px">展开</a>
								<a class="but_fanhui fl" id="treeCollapseAll" href="javascript:treeExpandAll(false)">收起</a>
							</span>
						</div>
					    <ul id="teamTree" class="ztree"></ul>
				   	    </div>
				      </td>
				      <td width="100%">
				        <div style="width: 100%;height: 600px; margin-top:15px;">
				           <iframe id="listFrame" src="" frameborder="no" width="100%" height="100%"></iframe>
				        </div>
				      </td>
				    </tr>
				  </table>
			</div>
		</div>
	</div>
</div>
</body>
</html>