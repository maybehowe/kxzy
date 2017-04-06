<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>浙江省科普资源共享服务平台</title>
<%@include file="/WEB-INF/views/front/common/form.jsp" %>
<meta name="description" content="浙江省科普资源共享服务平台"/>
<meta name="keywords" content="浙江省科普资源共享服务平台" />
<meta name="copyright" content="杭州融坦软件科技有限公司" />
<meta name="author" content="杭州融坦软件科技有限公司" />
<link href="${contextPath}/front/css/register.css" rel="stylesheet" type="text/css" />
<script src="${contextPath}/front/js/tab.js" type="text/javascript"></script>
<link rel="stylesheet" href="${contextPath }/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css" />
<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.exedit-3.5.js"></script>
<script type="text/javascript" src="${contextPath}/js/ztree/jquery.ztree.excheck-3.5.js"></script>
<script src="${contextPath}/js/validator/formValidator-4.1.3.js" type="text/javascript" ></script>
<script src="${contextPath}/js/validator/formValidatorRegex.js" type="text/javascript"></script>
<script type="text/javascript" src="${contextPath }/js/jquery.divbox.js"></script>
<style type="text/css">
.ztree {
	overflow: auto; height: 183px;
}

#divSCA{
	width: 200px;
	height: 235px;
	font-size: 12px;
	background: #fff;
	border: 1px solid #CECECE;
	z-index: 10001;
	display: none;
  }
  #divSCA a.team_div_btn{ background:#379DD5; padding:0 1px;}
</style>
<script type="text/javascript">
$(function() {
	  //表单验证(公众)
	  $.formValidator.initConfig({
		  formID:"user_form",
		  theme:"Default",
		  submitOnce:true
		});
	 $("#user_name")
	        .formValidator({
	        	onShowText:"请输入用户名",
	        	onShow:"请输入用户名",
	        	onFocus:"用户名至少5个字符,最多20个字符",
	        	onCorrect:"该用户名可以注册"
	        	})
	        .inputValidator({
	        	min:5,
	        	max:20,
	        	onErrorMin:"用户名至少5个字符，请确认",
	        	onErrorMax:"用户名最多20个字符,请确认"
	        	})
	        .regexValidator({
	        	regExp:"digitalletter",
	        	dataType:"enum",
	        	onError:"用户名必须是以字母开头的字母和数字的组合"
	        	})
		    .ajaxValidator({
				dataType : "json",
				async : true,
				type : "post",
				url : "${contextPath}/front/user/validateloginName.rt",
				success : function(result){
		            if(result) return true;
					return "该用户名已存在，请更换用户名";
				},
				buttons: $("#button"),
				error: function(jqXHR, textStatus, errorThrown){
					alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);
					},
				onError : "该用户名已存在，请更换用户名"
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
	   $("#user_pwd")
		    .formValidator({
	        	  onShow:"请输入密码",
	        	  onFocus:"密码长度至少为6-20个字符",
	        	  onCorrect:"输入密码正确"
	        	})
	        .inputValidator({
	        	  min:6,
	        	  max:20,
	        	  empty:{leftEmpty:false,rightEmpty:false,emptyError:"密码两边不能有空符号"},
	        	  onErrorMin:"密码长度至少为6",
	        	  onErrorMax:"密码长度不能超过20"
	        	});
	   $("#validate_user_pwd")
		      .formValidator({
	        	  onShow:"再次输入密码",
	        	  onFocus:"确认密码长度为6-20个字符",
	        	  onCorrect:"确认密码正确"
	        	})
	        .inputValidator({
	        	  min:1,
	        	  max:20,
	        	  empty:{leftEmpty:false,rightEmpty:false,emptyError:"确认密码两边不能有空符号"},
	        	  onErrorMax:"确认密码长度不能超过20",
		          onError:"确认密码不能为空,请确认"
	        	})
	         .compareValidator({
	        	  desID:"user_pwd",
	        	  operateor:"=",
	        	  onError:"两次密码输入不一致,请确认"
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
				url : "${contextPath}/front/user/validateEmail.rt",
				success : function(result){
		            if(result) return true;
					return "邮箱已存在，请更换邮箱";
				},
				buttons: $("#button"),
				error: function(jqXHR, textStatus, errorThrown){
					alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);
					},
				onError : "该邮箱已存在，请更换邮箱"
			  });
	   $("#authCode")
	         .formValidator({
	        	 onShow:"",
		         onFocus:"验证码为4位数字",
		         onCorrect:"输入验证码正确"
		        })
		     .inputValidator({
		    	 min:1,
		    	 onError:"验证码不能为空"
		      })
		   .ajaxValidator({
				dataType : "json",
				async : true,
				type : "post",
				url : "${contextPath}/front/user/validateAuthCode.rt",
				success : function(result){
		            if(result) return true;
					return "输入的验证码不正确";
				},
				buttons: $("#button"),
				error: function(jqXHR, textStatus, errorThrown){
					alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);
					},
				onError : "输入的验证码不正确",
				onWait : "正在对验证码进行合法性校验，请稍候..."
			  });
	   
	     //表单验证(科普团体)
		 $.formValidator.initConfig({
			  validatorGroup:"2",
			  formID:"team_user_form",
			  theme:"Default",
			  submitOnce:true
			});
		 $("#team_user_name")
		        .formValidator({
		        	validatorGroup:"2",
		        	onShowText:"请输入用户名",
		        	onShow:"请输入用户名",
		        	onFocus:"用户名至少5个字符,最多20个字符",
		        	onCorrect:"该用户名可以注册"
		        	})
		        .inputValidator({
		        	min:5,
		        	max:20,
		        	onErrorMin:"用户名至少5个字符，请确认",
		        	onErrorMax:"用户名最多20个字符,请确认"
		        	})
		        .regexValidator({
		        	regExp:"digitalletter",
		        	dataType:"enum",
		        	onError:"用户名必须是以字母开头的字母和数字的组合"
		        	})
			    .ajaxValidator({
					dataType : "json",
					async : true,
					type : "post",
					url : "${contextPath}/front/user/validateloginName.rt",
					success : function(result){
			            if(result) return true;
						return "该用户名已存在，请更换用户名";
					},
					buttons: $("#button"),
					error: function(jqXHR, textStatus, errorThrown){
						alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);
						},
					onError : "该用户名已存在，请更换用户名"
				  });
		  $("#team_user_nickName")
			     .formValidator({
			    	 validatorGroup:"2",
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
		   $("#team_user_realName")
			     .formValidator({
			    	 validatorGroup:"2",
			         onShow:"请输入用户姓名",
			         onFocus:"姓名长度不能超过12个字符",
			         onCorrect:"用户姓名正确"
			        })
			     .inputValidator({
			    	 min:1,
			         max:12,
			         onErrorMax:"姓名长度不能超过12个字符(6个汉字)",
				     onError:"姓名不能为空,请确认"
			       })
			      .regexValidator({
			    	  regExp:"chinese",
			          dataType:"enum",
			          onError:"姓名只能包含中文"
			    	});
		   $("#team_user_pwd")
			    .formValidator({
			    	  validatorGroup:"2",
		        	  onShow:"请输入密码",
		        	  onFocus:"密码长度至少为6-20个字符",
		        	  onCorrect:"输入密码正确"
		        	})
		        .inputValidator({
		        	  min:6,
		        	  max:20,
		        	  empty:{leftEmpty:false,rightEmpty:false,emptyError:"密码两边不能有空符号"},
		        	  onErrorMin:"密码长度至少为6",
		        	  onErrorMax:"密码长度不能超过20"
		        	});
		   $("#team_validate_user_pwd")
			      .formValidator({
			    	  validatorGroup:"2",
		        	  onShow:"再次输入密码",
		        	  onFocus:"确认密码长度为6-20个字符",
		        	  onCorrect:"确认密码正确"
		        	})
		        .inputValidator({
		        	  min:1,
		        	  max:20,
		        	  empty:{leftEmpty:false,rightEmpty:false,emptyError:"确认密码两边不能有空符号"},
		        	  onErrorMax:"确认密码长度不能超过20",
			          onError:"确认密码不能为空,请确认"
		        	})
		         .compareValidator({
		        	  desID:"team_user_pwd",
		        	  operateor:"=",
		        	  onError:"两次密码输入不一致,请确认"
		           });
		   $("#team_user_teamId")
			      .formValidator({
			    	     validatorGroup:"2",
				         onShow:"请选择团体",
				         onFocus:"请选择团体",
				         onCorrect:"选择团体正确"
				        })
				     .inputValidator({
				    	 min:1,
				    	 onError: "请选择团体"
				       });
		   $("#team_user_email")
		         .formValidator({
	        	     validatorGroup:"2",
	        	     onShow:"请输入邮箱",
			         onFocus:"邮箱格式例如：******@163.com",
			         onCorrect:"输入邮箱正确",
			         defaultVale:"@"
			        })
			     .inputValidator({
			    	 min:1,
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
					url : "${contextPath}/front/user/validateEmail.rt",
					success : function(result){
			            if(result) return true;
						return "邮箱已存在，请更换邮箱";
					},
					buttons: $("#button"),
					error: function(jqXHR, textStatus, errorThrown){
						alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);
						},
					onError : "该邮箱已存在，请更换邮箱"
				  });
		   $("#team_user_mobile")
		         .formValidator({
		        	 validatorGroup:"2",
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
			    	 onError:"你输入的联系手机号码格式不正确"
			       })
			 .ajaxValidator({
				dataType : "json",
				async : true,
				type : "post",
				url : "${contextPath}/front/user/validateMobile.rt",
				data:{"add_mobile":true},
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
		   $("#team_user_telphone")
		         .formValidator({
		        	 empty:true,
			         onShow:"请输入电话号码",
			         onFocus:"电话号码格式如：0571-+7/8位数",
			         onCorrect:"输入正确",
		        	 onEmpty : "电话可为空"
			        })
			     .regexValidator({
			    	 regExp:"tel",
			    	 dataType:"enum",
			    	 onError:"你输入的电话号码格式不正确"
			       });
		   $("#team_file")
		         .formValidator({
		        	 validatorGroup:"2",
			         onShow:"请添加附件",
			         onFocus:"请添加附件",
			         onCorrect:"添加正确",
			        })
			     .inputValidator({
			    	  min:1,
		        	  max:100,
		        	  onErrorMin:"附件不能为空",
		        	  onErrorMax:"文件名长度不能超过100个字符",
		        	});
		   $("#teamauthCode")
		         .formValidator({
		        	 validatorGroup:"2",
		        	 onShow:"",
			         onFocus:"验证码为4位数字",
			         onCorrect:"输入验证码正确"
			        })
			     .inputValidator({
			    	 min:1,
			    	 onError:"验证码不能为空"
			      })
			   .ajaxValidator({
					dataType : "json",
					async : true,
					type : "post",
					url : "${contextPath}/front/user/validateTeamAuthCode.rt",
					success : function(result){
			            if(result) return true;
						return "输入的验证码不正确";
					},
					buttons: $("#button"),
					error: function(jqXHR, textStatus, errorThrown){
						alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);
						},
					onError : "输入的验证码不正确"
				  });
		   
	   //获取验证码
	   $("#auth_code").attr("src","${contextPath}/front/user/authCode.rt?time="+new Date().getTime());
	   $("#team_authCode").attr("src","${contextPath}/front/user/teamauthCode.rt?time="+new Date().getTime());
	   //加载团体树
	   loadTree();
  });
  //获取验证码(换一张)
  function changeAuth(){
	  $("#auth_code").attr("src","${contextPath}/front/user/authCode.rt?time="+new Date().getTime());
  }
  //获取团体验证码(换一张)
  function teamchangeAuth(){
	  $("#team_authCode").attr("src","${contextPath}/front/user/teamauthCode.rt?time="+new Date().getTime());
  }
  
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
		var url = "${contextPath}/front/team/getTreeData.rt";
		$.post(url, function(result) {
			for(var i = 0; i < result.length; i++) {
				result[i].icon = "${contextPath}/images/7.png";
			}
			teamTree = $.fn.zTree.init($("#teamTree"), setting, result);
			teamTree.expandAll(true);
		});
	};
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
		$("#team_user_teamId").val(id);
		$("#teamName").val(name);
		$("#divSCA").CloseDiv();
	}
	
	function openDiv() {
		$("#divSCA").appendTo("#team_td");
		$("#divSCA").OpenDiv();
	}
	function closeDiv() {
		$("#divSCA").CloseDiv();
	}
</script>
</head>  
<body>
<div class="wrapper">
	<div class="top">
		<jsp:include page="/WEB-INF/views/front/common/head.jsp" />
	</div>
	  <div id="divSCA">
        <div>
	     <span style="padding-left: 30px;">
			<a id="treeFresh" class="team_div_btn" href="javascript:reFresh();">刷新</a>
			<a id="treeExpandAll" class="team_div_btn" href="javascript:treeExpandAll(true)">展开</a>
		 	<a id="treeCollapseAll" class="team_div_btn" href="javascript:treeExpandAll(false)">收起</a>
         </span>
		</div>
	    <ul id="teamTree" class="ztree"></ul>
	     <span style="padding-left: 50px;">
	      <a class="team_div_btn" id="treeCollapseAll" href="javascript:selectTeam();">选择</a>
	      <a class="team_div_btn" id="treeCollapseAll" href="javascript:closeDiv();">取消</a>
	     </span>
   	  </div>
	<div class="content">
		<div class="register_banner"><img src="${contextPath}/front/images/register_banner.jpg" width="1000" height="153" /></div>
		<div class="video_list_main">
			<div class="list_main_top">
				<p class="tit">用户注册</p>
				<p class="dizhi">当前位置：首页 > 注册</p>
				<div class="register_process"><img src="${contextPath}/front/images/register_12.jpg" width="955" height="27" /></div>
				<div id="outer">
					<p class="tit2">注册类型</p>
					<ul id="tab">
						<li class="title">公众用户注册</li>
						<li id="li_team">科普团体用户注册</li>
					</ul>
					<div class="cb"></div>
					<div id="content">
						<ul class="newslist" style="display:block;" id="tab_register"><li>
						 <form id="user_form" action="${contextPath}/front/user/register.rt" method="post">
							<table width="955" border="0">
							  <tr>
								<th width="100">用户名&nbsp;<span style="color:red;">*</span></th>
								<td width="330" ><input id="user_name" name="user.loginName"  type="text" class="text" /></td>
								<td><span class="fl" id="user_nameTip"></span></td>
							  </tr>
							  <tr>
								<th>昵称</th>
								<td><input type="text" class="text"  id="user_nickName" name="user.nickName" /></td>
								<td><span class="fl" id="user_nickNameTip"></span></td>
							  </tr>
							  <tr>
								<th>密码&nbsp;<span style="color:red;">*</span></th>
								<td><input type="password" class="text" id="user_pwd"  name="user.pwd"/></td>
								<td><span class="fl" id="user_pwdTip"></span></td>
							  </tr>
							  <tr>
								<th>确认密码&nbsp;<span style="color:red;">*</span></th>
								<td><input type="password" class="text" id="validate_user_pwd"  name="validateuserpwd"/></td>
								<td><span class="fl" id="validate_user_pwdTip"></span></td>
							  </tr>
							  <tr>
								<th>电子邮箱&nbsp;<span style="color:red;">*</span></th>
								<td><input  type="text" class="text" id="user_email"  name="user.email"/></td>
								<td><span class="fl" id="user_emailTip"></span></td>
							  </tr>
							  <tr>
								<th>验证码&nbsp;<span style="color:red;">*</span></th>	
								<td>
									<p class="fl"><input name="authCode" id="authCode" type="text" maxlength="4" class="text" style="width: 100px;" /></p>
									<p class="fl ml15"><a href="javascript:changeAuth()"><img src="${pageContext.request.contextPath}/images/auth.gif" id="auth_code" width="72" height="32" /></a></p>
									<a class="ml15" href="javascript:changeAuth()" style="line-height:44px; text-decoration:underline;">看不清，换一张</a>
								</td>							
								<td><span class="fl" id="authCodeTip"></span></td>
							  </tr>
							  <tr height="100">
								<th>&nbsp;</th>
								<td colspan="2"><input  type="submit" id="submit_btn" value="下一步" class="sub" /></td>
							  </tr>
							</table>
							</form>
						   </li>
						  </ul>
						<ul class="newslist" id="tab_register"><li>
						   <form id="team_user_form" action="${contextPath}/front/user/register.rt" enctype="multipart/form-data"  method="post">
						    <input type="hidden" name="team_reg" value="${team_reg}"/>
								<table width="955" border="0">
								  <tr>
									<th width="100">用户名&nbsp;<span style="color:red;">*</span></th>
									<td width="330"><input id="team_user_name" name="user.loginName"  type="text" class="text" /></td>
									<td><span class="fl" id="team_user_nameTip"></span></td>
								  </tr>
								  <tr>
									<th>昵称</th>
									<td><input type="text" class="text"  id="team_user_nickName" name="user.nickName" /></td>
									<td><span class="fl" id="team_user_nickNameTip"></span></td>
								  </tr>
								  <tr>
									<th>用户姓名&nbsp;<span style="color:red;">*</span></th>
									<td><input type="text" class="text"  id="team_user_realName" name="user.realName" /></td>
									<td><span class="fl" id="team_user_realNameTip"></span></td>
								  </tr>
								  <tr>
									<th>密码&nbsp;<span style="color:red;">*</span></th>
									<td><input type="password" class="text" id="team_user_pwd"  name="user.pwd"/></td>
									<td><span class="fl" id="team_user_pwdTip"></span></td>
								  </tr>
								  <tr>
									<th>确认密码&nbsp;<span style="color:red;">*</span></th>
									<td><input type="password" class="text" id="team_validate_user_pwd"  name="validateuserpwd"/></td>
									<td><span class="fl" id="team_validate_user_pwdTip"></span></td>
								  </tr>
								  <tr> 
								   <th scope="row">所属团体&nbsp;<span style="color:red;">*</span></th>
									<td id="team_td">
									  <input type="hidden" class="text" id="team_user_teamId" name="user.teamId"/>
									  <input type="text" class="text" id="teamName" name="teamName" style="width: 180px" onfocus="this.blur()"/>
									  <input type="button" value="选择" onclick="openDiv()"/>
									</td>
									<td><span class="fl" id="team_user_teamIdTip"></span></td>
								  </tr>
								  <tr>
									<th>电子邮箱&nbsp;<span style="color:red;">*</span></th>
									<td><input  type="text" class="text" id="team_user_email"  name="user.email"/></td>
									<td><span class="fl" id="team_user_emailTip"></span></td>
								  </tr>
								  <tr>
									<th scope="row">手机&nbsp;<span style="color:red;">*</span></th>
									<td><input type="text" class="text" id="team_user_mobile"   name="user.mobile"/></td>
									<td><span class="fl" id="team_user_mobileTip"></span></td>
								  </tr>
  								  <tr>
									<th scope="row">电话&nbsp;</th>
									<td><input type="text" class="text" id="team_user_telphone"   name="user.telphone"/></td>
									<td><span class="fl" id="team_user_telphoneTip"></span></td>
								  </tr>
								  <tr>
									<th>添加附件&nbsp;<span style="color:red;">*</span></th>
									<td><input  type="file" class="file" id="team_file" name="teamFile"/></td>
									<td><span class="fl" id="team_fileTip"></span></td>
								  </tr>
								  <tr>
									<th>验证码&nbsp;<span style="color:red;">*</span></th>	
									<td>
										<p class="fl"><input name="teamauthCode" id="teamauthCode" type="text" maxlength="4" class="text" style="width: 100px;"/></p>
										<p class="fl ml15"><a href="javascript:teamchangeAuth()"><img src="${contextPath}/images/auth.gif" id="team_authCode" width="72" height="32" /></a></p>
										<a class="ml15" href="javascript:teamchangeAuth()" style="line-height:44px; text-decoration:underline;">看不清，换一张</a>
									</td>							
									<td><span class="fl" id="teamauthCodeTip"></span></td>
								  </tr>
								  <tr height="100">
									<th>&nbsp;</th>
									<td colspan="2"><input  type="submit" id="team_submit_btn" value="下一步" class="sub" /></td>
								  </tr>
								</table>
								</form>
							</li>
						  </ul>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../common/foot.jsp" />
	</div>
</div>
<!--<div class="bottom_png"></div>-->
</body>
</html>
