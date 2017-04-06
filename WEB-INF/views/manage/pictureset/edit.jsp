<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.roots.kxzy.system.common.constant.EnableStatus"%>
<%@page import="com.roots.kxzy.system.common.constant.JudgeStatus"%>
<%
	request.setAttribute("yes",JudgeStatus.YES);
	request.setAttribute("no",JudgeStatus.NO);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科协资源</title>
<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${contextPath }/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css" />
<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.exedit-3.5.js"></script>
<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.excheck-3.5.js"></script>
<script src="${contextPath}/js/validator/formValidator-4.1.3.js" type="text/javascript" ></script>
<script src="${contextPath}/js/validator/formValidatorRegex.js" type="text/javascript"></script>
<script src="${contextPath}/js/xheditor/xheditor-1.1.14-zh-cn.min.js"  type="text/javascript" ></script>
<script src="${contextPath}/js/jquery.divbox.js" type="text/javascript"></script>
<style type="text/css">
.ztree {
	overflow: auto; height: 183px;
	margin-bottom:10px;
}
#divSCA{
	width: 202px;
	height: 245px;
	font-size: 12px;
	background: #fff;
	border: 1px solid #B8CAE0;
	z-index: 10001;
	display: none;
	padding-top:10px;
  }
#divSCA a.channel_div_btn{ background:#379DD5; padding:0 6px;font-size: 14px;color: white;font-family: "微软雅黑"}
</style>
 <script type="text/javascript" language="javascript">
 $(function() {
	  $.formValidator.initConfig({
		  formID:"pictureset_Form",
		  theme:"Default",
		  submitOnce:true
		});
	 $("#pictureset_channelId")
       .formValidator({
	         onShow:"请选择所属分类",
	         onFocus:"所属分类必须选择",
	         onCorrect:"选择正确"
	        })
	     .inputValidator({
	    	 min:1,
	    	 onError: "请选择所属分类"
	       });
	 $("#pictureset_name")
	        .formValidator({
	        	onShowText:"请输入科普图集标题",
	        	onShow:"请输入科普图集标题",
	        	onFocus:"图集标题至少1个字符,最多48个字符",
	        	onCorrect:"该图集标题可以使用"
	        	})
	        .inputValidator({
	        	min:1,
	        	max:48,
	        	empty:{leftEmpty:false,rightEmpty:false,emptyError:"标题两边不能有空符号"},
	        	onErrorMax:"科普图集名称长度不能超过48个字符",
		        onError:"科普图集名称不能为空,请确认"
	        	});
	   $("#pictureset_disciplineCateId")
	         .formValidator({
		         onShow:"请选择学科分类",
		         onFocus:"学科分类必须选择",
		         onCorrect:"选择正确"
		        })
		     .inputValidator({
		    	 min:1,
		    	 onError: "请选择学科分类"
		       });
	   $("#pictureset_sourceId")
           .formValidator({
        	 empty:true,
	         onShow:"请选择图集来源",
	         onFocus:"请选择图集来源",
	         onCorrect:"选择正确",
	         onEmpty:"图集来源可为空"
	        })
	     .inputValidator({
	    	 min:1,
	    	 onError: "请选择图集来源"
	       });
	   $("#pictureset_description")
		       .formValidator({
			         onShow:"请输入图集简介",
			         onFocus:"请输入图集简介,字数不超过160个字符",
			         onCorrect:"输入正确",
			        })
			   .inputValidator({
			    	 min:1,
			         max:160,
			         onErrorMax:"图集简介不超过160个字符",
			         onError:"图集简介不能为空,请确认"
			    	})
			    .regexValidator({
				   regExp:"allspace",
				   dataType:"enum",
				   onError:"图集简介不能为空,请确认"
				   });
	   loadTree();
    });
 
	//树
	var channelTree;
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
				selectedMulti : true
			},
			check: {
				enable: true,
				chkStyle: "radio",
				radioType : "all"
			}
		};
		var url = "${contextPath}/manage/pictureset/getTreeData.rt";
		$.post(url, function(result) {
			initTree(result)
			for(var i = 0; i < result.length; i++) {
				result[i].icon = "${contextPath}/images/7.png";
			}
			channelTree = $.fn.zTree.init($("#channelTree"), setting, result);
			channelTree.expandAll(true);
			selectedPicturesetChannel();
		});
	};
	
	//初始化树
	function initTree(nodes){
		for (var i = 0; i < nodes.length ; i++) {
			var parentId =  nodes[i].parentId;
			if(parentId == 28){
				nodes[i].nocheck = true;
			}else{
				nodes[i].nocheck = false;
			}
		}
	}
	//加载已选项
	function selectedPicturesetChannel(){
		var channelIds= new Array(); 
		var channelId = $("#pictureset_channelId").val();
		channelIds = channelId.split(',');
		for(var i = 0 ; i < channelIds.length ; i ++){
			channelTree = $.fn.zTree.getZTreeObj("channelTree");
			if(channelIds[i] && channelIds[i]!=""){
				var node = channelTree.getNodeByParam("id", channelIds[i], null);
				channelTree.checkNode(node, true, true);
			}
		}
	}
	
	//展开收起
	function treeExpandAll(type) {
		channelTree = $.fn.zTree.getZTreeObj("channelTree");
		channelTree.expandAll(type);
	};
	//刷新
	function reFresh() {
			loadTree();
	};
	//选择分类
	function selectchannel(){
		channelTree = $.fn.zTree.getZTreeObj("channelTree");
		var nodes  = channelTree.getCheckedNodes(true);
		var id="";
		var name = "";
		 for (var i = 0; i < nodes.length; i++) {
		 	id += nodes[i].id + ",";
		     name +=  nodes[i].name + ",";
			}
		id = id.substring(0, id.length -1);
		name = name.substring(0, name.length -1);
		$("#pictureset_channelId").val(id);
		$("#picturesetName").val(name);
		$("#divSCA").CloseDiv();
	}
	
	function openDiv() {
		$("#divSCA").OpenDiv();
	}
	function closeDiv() {
		$("#divSCA").CloseDiv();
	}
 </script>
</head>
<body>
<div class="wrapper">
    <jsp:include page="/WEB-INF/views/manage/common/head.jsp" />
	<div class="content">
	<jsp:include page="/WEB-INF/views/manage/common/left.jsp" />
		<div class="right">
			<div class="main">
				<div class="tit">编辑科普图集</div>
				<div class="line">科普图集详情：</div>
				  <form id="pictureset_Form"  action="${contextPath}/manage/pictureset/submitEdit.rt" enctype="multipart/form-data" method="post">
				     <input type="hidden" name="viewId" value="${viewId }" />
				     <input type="hidden" name="leftId" value="${leftId }" />
				     <input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			         <input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			         <input type="hidden" name="searchName" id="searchName" value="${rt:escapeHtml(searchName)}"/>
			         <input type="hidden" name="channelId" id="channelId" value="${channelId }"/>
				     <input type="hidden" name="pictureset.id" value="${pictureset.id}" />
					 <table width="96%" border="0" class="data">
					  <tr>
						<th scope="row" width="110"><span style="color:red;">*</span> 所属分类：</th>
						<td width="330">
						  <input type="hidden" class="text" id="pictureset_channelId" name="pictureset.channelId" value="${pictureset.channelId}"/>
						  <input type="text" class="text" id="picturesetName" name="picturesetName" value="${channele.name}" style="width: 190px" onfocus="this.blur()"/>
						  <input type="button" value="选择" onclick="openDiv()"/>
						  <div id="divSCA">
							<div>
								<span style="padding-left: 35px;">
									<a class="channel_div_btn" id="treeFresh" href="javascript:reFresh();">刷新</a>
									<a class="channel_div_btn" id="treeExpandAll" href="javascript:treeExpandAll(true)">展开</a>
									<a class="channel_div_btn" id="treeCollapseAll" href="javascript:treeExpandAll(false)">收起</a>
								</span>
							</div>
						    <ul id="channelTree" class="ztree"></ul>
						    <span style="padding-left: 55px;">
						      <a class="channel_div_btn" id="treeCollapseAll" href="javascript:selectchannel();">选择</a>
						      <a class="channel_div_btn" id="treeCollapseAll" href="javascript:closeDiv();">取消</a>
						    </span>
					   	  </div>
						</td>
						<td colspan="2"><span class="fl" id="pictureset_channelIdTip"></span></td>
					  </tr>
						<th scope="row" width="110"><span style="color:red;">*</span> 图集标题：</th>
						<td><input  class="text" id="pictureset_name" name="pictureset.name" value="${rt:escapeHtml(pictureset.name)}"/></td>
						<td><span class="fl" id="pictureset_nameTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row" width="110"><span style="color:red;">*</span> 学科分类：</th>
						<td width="330">
							<select name="pictureset.disciplineCateId" id="pictureset_disciplineCateId">
								<option value="">--请选择--</option>
								<c:forEach items="${subList}" var="sl">
								<option value="${sl.id }" ${(pictureset.disciplineCateId eq sl.id) ? "selected='selected'":"" }>${sl.name }</option>
								</c:forEach>
							</select>
						</td>
						<td colspan="2"><span class="fl" id="pictureset_disciplineCateIdTip"></span></td>
					  </tr>
   				 	  <tr>
					    <th scope="row" width="110"> 来源：</th>
					    <td>
						  <select name="pictureset.sourceId" id="pictureset_sourceId">
						    <option value="1"  ${(pictureset.sourceId eq 1) ? "selected='selected'":"" }>--请选择--</option>
							<option value="2"  ${(pictureset.sourceId eq 2) ? "selected='selected'":"" }>原创</option>
							<option value="3"  ${(pictureset.sourceId eq 3) ? "selected='selected'":"" }>转载</option>
							<option value="4"  ${(pictureset.sourceId eq 4) ? "selected='selected'":"" }>购买版权</option>
						  </select>
					    </td>
					   <td colspan="2"><span class="fl" id="pictureset_sourceIdTip"></span></td>
				      </tr>
				     </tr>
					   </tr>
						<th scope="row" width="110">默认为图片简介：</th>
						<td>
						  <input type="radio" id="pictureset_isPictureDesc"  name="pictureset.isPictureDesc" ${(pictureset.isPictureDesc eq yes) ? "checked='checked'":"" } value="${yes}"/>是&nbsp;
						  <input type="radio" id="pictureset_isPictureDesc" name="pictureset.isPictureDesc" ${(pictureset.isPictureDesc eq no) ? "checked='checked'":"" } value="${no}"/>否
						</td>
						<td><span class="fl" id="pictureset_isPictureDescTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row" align="right"> <span style="color:red;">*</span> 简介：</th>
						<td><textarea name="pictureset.description" id="pictureset_description" cols="40" rows="9">${rt:escapeHtml(pictureset.description)}</textarea></td>
						<td><span class="fl" id="pictureset_descriptionTip"></span></td>
					  </tr>
					  <tr class="buttom">
						<th scope="row" align="right"></th>
						<td colspan="2">
							<input type="submit" id="submit_btn" value="提 交" class="add_but fl" />
							<input name="" type="reset" value="重 置" class="add_but fl" />
							<a href="javascript:window.history.back();" class="but_fanhui fl" style="height:24px;border:0px;font-size:14px;color:white;font-weight:bold;">返 回</a>
						</td>
					  </tr>
					  </table>
				  </form>
			</div>
		</div>
	</div>
</div>
</body>
</html>