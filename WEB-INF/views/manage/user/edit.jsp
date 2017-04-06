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
<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${contextPath }/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css" />
<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.exedit-3.5.js"></script>
<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.excheck-3.5.js"></script>
<script src="${contextPath}/js/validator/formValidator-4.1.3.js" type="text/javascript" ></script>
<script src="${contextPath}/js/validator/formValidatorRegex.js" type="text/javascript"></script>
<script src="${contextPath}/js/jquery.divbox.js" type="text/javascript"></script>
<style type="text/css">
.ztree {
	overflow: auto; height: 183px;
	margin-bottom:10px;
}
#divSCA{
	width: 202px;
	height: 251px;
	font-size: 12px;
	background: #fff;
	border: 1px solid #B8CAE0;
	z-index: 10001;
	display: none;
	padding-top:10px;
  }
#divSCA a.team_div_btn{ background:#379DD5; padding:0 3px;}
</style>
 <script type="text/javascript" language="javascript">
 $(function() {
	  $.formValidator.initConfig({
		  formID:"user_Form",
		  theme:"Default",
		  submitOnce:true
		});
	 /*$("#user_name")
	        .formValidator({
	        	onShow:"请输入登录名",
	        	onFocus:"登录名至少5个字符,最多20个字符",
	        	onCorrect:"该登录名可用"
	        	})
	        .inputValidator({
	        	min:5,
	        	max:20,
	        	onErrorMin:"登录名至少5个字符，请确认",
	        	onErrorMax:"登录名最多20个字符,请确认"
	        	})
	        .regexValidator({
	        	regExp:"digitalletter",
	        	dataType:"enum",
	        	onError:"登录名必须是以字母开头的字母和数字的组合"
	        	})
		    .ajaxValidator({
				dataType : "json",
				async : true,
				type : "post",
				url : "${contextPath}/manage/user/validateloginName.rt",
				success : function(result){
		            if(result) return true;
					return "该登录名已存在，请更换登录名";
				},
				buttons: $("#button"),
				error: function(jqXHR, textStatus, errorThrown){
					alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);
					},
				onError : "该登录名已存在，请更换登录名"
			  });*/
	   $("#user_pwd")
		      .formValidator({
	        	  onShow:"请输入密码",
	        	  onFocus:"密码长度至少为6",
	        	  onCorrect:"该密码接正确"
	        	})
	        .inputValidator({
	        	  min:1,
	        	  max:20,
	        	  empty:{leftEmpty:false,rightEmpty:false,emptyError:"密码两边不能有空符号"},
	        	  onErrorMax:"密码长度不能超过20",
		          onError:"密码不能为空,请确认"
	        	});
	   $("#user_nickName")
		     .formValidator({
		    	 empty:true,
		         onShow:"请输入昵称，可为空",
		         onFocus:"昵称长度不能超过12个字符",
		         onCorrect:"输入昵称正确",
		         onEmpty:"昵称可为空"
		        })
		     .inputValidator({
		    	 min:1,
		         max:12,
		         onErrorMax:"昵称长度不能超过12个字符",
			     onError:"昵称不能为空,请确认"
		       })
		     .regexValidator({
		    	  regExp:"chineseenglish",
		          dataType:"enum",
		          onError:"昵称只能包含中文或英文"
		    	});
	   $("#user_realName")
		     .formValidator({
		         onShow:"请输入用户姓名",
		         onFocus:"姓名长度不能超过12个字符(6个汉字)",
		         onCorrect:"用户姓名正确"
		        })
		     .inputValidator({
		    	 min:1,
		         max:12,
		         onErrorMax:"姓名长度不能超过12个字符",
			     onError:"姓名不能为空,请确认"
		       })
		      .regexValidator({
		    	  regExp:"chinese",
		          dataType:"enum",
		          onError:"姓名只能包含中文"
		    	});
	   $("#user_rel_role")
	         .formValidator({
		         onShow:"请选择角色",
		         onFocus:"请选择角色",
		         onCorrect:"选择角色正确",
		        })
		     .inputValidator({
		    	 min:1,
		    	 onError: "请选择角色"
		       });
	   $("#user_teamId")
	         .formValidator({
		         onShow:"请选择团体",
		         onFocus:"请选择团体",
		         onCorrect:"选择团体正确"
		        })
		     .inputValidator({
		    	 min:1,
		    	 onError: "请选择团体"
		       });
	   $("#user_email")
		       .formValidator({
			         onShow:"请输入邮箱",
			         onFocus:"邮箱格式例如：******@163.com",
			         onCorrect:"输入邮箱正确",
			         defaultVale:"@"
			        })
			     .inputValidator({
			    	 min:1,
			    	 max:50,
			         onErrorMax:"邮箱长度不能超过50个字符",
			    	 onError:"邮箱不能为空,请确认",
			      })
			     .regexValidator({
			    	 regExp:"email",
			    	 dataType:"enum",
		      	     onError:"邮箱格式不正确" 
			       })
			  .ajaxValidator({
				dataType : "json",
				async : true,
				type : "post",
				url : "${contextPath}/manage/user/validateEmail.rt",
				data:{"editEmail":"${user.email}","add_email":false},
				success : function(result){
		            if(result) return true;
					return "该邮箱已存在，请更换邮箱";
				},
				buttons: $("#button"),
				error: function(jqXHR, textStatus, errorThrown){
					alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);
					},
				onError : "该邮箱已存在，请更换邮箱"
			  });
	   
	   $("#user_mobile")
	         .formValidator({
		         onShow:"请输入手机号码",
		         onFocus:"手机号码格式如：151********",
		         onCorrect:"输入手机号码正确",
		        })
		     .inputValidator({
		    	 min:11,
		    	 max:11,
		    	 onError: "手机号码必须是11位，请确认"
		      })
		     .regexValidator({
		    	 regExp:"mobile",
		    	 dataType:"enum",
		    	 onError:"你输入的手机号码格式不正确"
		       })
		     .ajaxValidator({
				dataType : "json",
				async : true,
				type : "post",
				data:{"editMobile":"${user.mobile}","add_mobile":false},
				url : "${contextPath}/manage/user/validateMobile.rt",
				success : function(result){
		            if(result) return true;
					return "该手机号码已存在，请更换手机号码";
				},
				buttons: $("#button"),
				error: function(jqXHR, textStatus, errorThrown){
					alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);
					},
				onError : "该手机号码已存在，请更换手机号码"
			  });
	   $("#user_telphone")
	         .formValidator({
	        	 empty:true,
		         onShow:"请输入电话号码",
		         onFocus:"电话号码格式如：0571-+7位数",
		         onCorrect:"输入电话正确",
	        	 onEmpty : "电话可为空"
		        })
		     .regexValidator({
		    	 regExp:"tel",
		    	 dataType:"enum",
		    	 onError:"你输入的电话号码格式不正确"
		       });
	   loadTree();
   });
	//树
	var teamTree;
	function loadTree() {
		var setting = {
			async : {
				enable : false
			},
			data : {
				key : {
					name : "teamName"
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
		var url = "${contextPath}/manage/team/getTreeData.rt";
		$.post(url, function(result) {
			for(var i = 0; i < result.length; i++) {
				result[i].icon = "${contextPath}/images/7.png";
			}
			teamTree = $.fn.zTree.init($("#teamTree"), setting, result);
			teamTree.expandAll(true);
			selectedTeam();
		});
	};
	//加载已选项
	function selectedTeam(){
		var cateIds= new Array(); 
		var cateId = $("#user_teamId").val();
		cateIds = cateId.split(',');
		for(var i = 0 ; i < cateIds.length ; i ++){
			cateTree = $.fn.zTree.getZTreeObj("teamTree");
			if(cateIds[i] && cateIds[i]!=""){
				var node = cateTree.getNodeByParam("id", cateIds[i], null);
				cateTree.checkNode(node, true, true);
			}
		}
	}
	//展开收起
	function treeExpandAll(type) {
		teamTree = $.fn.zTree.getZTreeObj("teamTree");
		teamTree.expandAll(type);
	};
	//刷新
	function reFresh() {
			loadTree();
	};
	//选择团体
	function selectTeam(){
		cateTree = $.fn.zTree.getZTreeObj("teamTree");
		var nodes  = cateTree.getCheckedNodes(true);
		var id="";
		var name = "";
     for (var i = 0; i < nodes.length; i++) {
     	id += nodes[i].id + ",";
         name +=  nodes[i].teamName + ",";
		}
		id = id.substring(0, id.length -1);
		name = name.substring(0, name.length -1);
		$("#user_teamId").val(id);
		$("#teamName").val(name);
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
				<div class="tit">编辑用户</div>
				<div class="line">用户详情：</div>
				  <form id="user_Form" action="${contextPath}/manage/user/submitEdit.rt" method="post">
					 <input type="hidden" name="user.id" id="user_id" value="${user.id}" />
                     <input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
		             <input type="hidden" name="pageSize" id="pageSize" value="${pageSize}"/>
				     <input type="hidden" name="viewId" value="${viewId }" />
				     <input type="hidden" name="leftId" value="${leftId }" />
				     <input type="hidden" name="activation" value="${activation }" />
				     <input type="hidden" name="teamId" value="${teamId }" />
				     <input type="hidden" name="roleId" value="${roleId }" />
				     <input type="hidden" name="searchName" value="${searchName }" />
					 <table width="96%" border="0" class="data">
					 <tr>
						<th scope="row" width="110">登录名：</th>
						<td  width="330">
						   ${user.loginName}
						   <input type="hidden" class="text" id="user_name" name="user.loginName" value="${user.loginName}"/>
						</td>
					  </tr>
					  <tr>
						<th scope="row">昵称：</th>
						<td><input type="text" class="text" id="user_nickName" name="user.nickName" value="${user.nickName}"/></td>
						<td><span class="fl" id="user_nickNameTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row"><span style="color:red;">*</span> 用户姓名：</th>
						<td><input type="text" class="text" id="user_realName" name="user.realName" value="${user.realName}"/></td>
						<td><span class="fl" id="user_realNameTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row"><span style="color:red;">*</span> 关联角色：</th>
						<td>
						   <select name="rolereluser.role.id" id="user_rel_role" class="mr40" style="width: 204px;">
						      <option value="">--请选择--</option>
						      <c:forEach items="${roleList}" var="r">
						           <option value="${r.id}"
						             <c:if test="${r.id eq roelReluser.role.id }">
						                selected = 'selected'
						             </c:if>
						           >${r.roleName}</option>
						      </c:forEach>
						    </select>
						</td>
						<td><span class="fl" id="user_rel_roleTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row"><span style="color:red;">*</span> 所属团体：</th>
						<td>
						  <input type="hidden" class="text" id="user_teamId" name="user.teamId" value="${user.teamId}"/>
						  <input type="text" class="text" id="teamName" name="teamName" value="${t.teamName}"  style="width: 190px" onfocus="this.blur()"/>
						  <input type="button" value="选择" onclick="openDiv()"/>
						   <div id="divSCA">
							<div>
								<span style="padding-left: 20px;">
									<a class="team_div_btn" id="treeFresh" href="javascript:reFresh();">刷新</a>
									<a class="team_div_btn" id="treeExpandAll" href="javascript:treeExpandAll(true)">展开</a>
									<a class="team_div_btn" id="treeCollapseAll" href="javascript:treeExpandAll(false)">收起</a>
								</span>
							</div>
						    <ul id="teamTree" class="ztree"></ul>
						    <span style="padding-left: 50px;">
						      <a class="team_div_btn" id="treeCollapseAll" href="javascript:selectTeam();">选择</a>
						      <a class="team_div_btn" id="treeCollapseAll" href="javascript:closeDiv();">取消</a>
						    </span>
					   	  </div>
						</td>
						<td><span class="fl" id="user_teamIdTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row">当前状态：</th>
						<td>
						   <select name="user.activation" id="user_activation" class="mr40" style="width: 204px;">
						      <option value="${enable}"
						         <c:if test="${user.activation eq enable}">
						                selected = 'selected'
						         </c:if>
						      >激活</option>
						      <option value="${disable}"
						         <c:if test="${user.activation eq disable}">
						                selected = 'selected'
						         </c:if>
						      >禁用</option>
						    </select>
						</td>
						<td><span class="fl" id="user_activationTip"></span></td>
					  </tr>
					   <tr>
						<th scope="row"><span style="color:red;">*</span> E-mail：</th>
						<td><input type="text" class="text" id="user_email"  name="user.email" value="${user.email}"/></td>
						<td><span class="fl" id="user_emailTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row"><span style="color:red;">*</span> 手机：</th>
						<td><input type="text" class="text" id="user_mobile"   name="user.mobile" value="${user.mobile}"/></td>
						<td><span class="fl" id="user_mobileTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row">电话：</th>
						<td><input type="text" class="text" id="user_telphone"  name="user.telphone" value="${user.telphone}"/></td>
						<td><span class="fl" id="user_telphoneTip"></span></td>
					  </tr>
					  <tr class="buttom">
						<th scope="row" align="right"></th>
						<td>
							<input type="submit" id="submit_btn" value="提 交" class="add_but fl" />
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