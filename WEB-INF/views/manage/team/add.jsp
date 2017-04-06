<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.roots.kxzy.system.common.constant.EnableStatus"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科协资源-编辑友情团体类别</title>
<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<script src="${contextPath}/js/validator/formValidator-4.1.3.js" type="text/javascript" ></script>
<script src="${contextPath}/js/validator/formValidatorRegex.js" type="text/javascript"></script>
 <script type="text/javascript" language="javascript">
 $(function() {
	  $.formValidator.initConfig({
		  formID:"team_Form",
		  theme:"Default",
		  submitOnce:true
		});
	 $("#team_name")
	        .formValidator({
	        	onShowText:"请输入科普团体名称",
	        	onShow:"请输入科普团体名称",
	        	onFocus:"名称至少1个最多20个中文或英文字符",
	        	onCorrect:"该科普团体正确"
	        	})
	        .inputValidator({
	        	min:1,
	        	max:20,
	        	onErrorMax:"科普团体名称长度不能超过20个字符",
		        onError:"科普团体名称不能为空"
	        	})
	        .regexValidator({
	        	regExp:"chineseenglish",
	        	dataType:"enum",
	        	onError:"科普团体名只能包含中文或英文"
	        	})
		    .ajaxValidator({
				dataType : "json",
				async : true,
				type : "post",
				url : "${contextPath}/manage/team/validateTeamName.rt?team.parentId="+"${pTeam.id}",
				data:{"add_team":true},
				success : function(result){
		            if(result) return true;
					return "该科普团体名已存在，请更换科普团体名";
				},
				buttons: $("#button"),
				error: function(jqXHR, textStatus, errorThrown){
					alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);
					},
				onError : "该科普团体名已存在，请更换科普团体名"
			  });
	   $("#team_teamAddress")
	         .formValidator({
		         onShow:"请输入团体地址",
		         onFocus:"请输入团体地址",
		         onCorrect:"输入正确"
		        })
		     .inputValidator({
	        	min:1,
	        	max:500,
	        	onErrorMax:"科普团体名称长度不能超过500个字符",
		        onError:"科普团体地址不能为空"
	          });
	   $("#team_contact")
	         .formValidator({
	        	 empty:true,
		         onShow:"请输入联系方式",
		         onFocus:"联系号码格式如：0571-+7/8位数",
		         onCorrect:"输入正确",
		         onEmpty:"联系方式可为空"
		        })
		    .regexValidator({
		    	 regExp:"tel",
		    	 dataType:"enum",
		    	 onError:"你输入的联系号码格式不正确"
		       });
	   $("#team_image_path")
	         .formValidator({
	        	 empty:true,
		         onShow:"请选择 330px*300px 图片",
		         onFocus:"请选择 330px*300px 图片",
		         onCorrect:"选择正确",
		         onEmpty:"图片可为空"
		        })
		     .inputValidator({
	        	max:100,
	        	onErrorMax:"图片名称长度不能超过100个字符",
	        	})
		     .regexValidator({
		    	 regExp:"picture",
		    	 dataType:"enum",
		    	 onError:"图片格式不正确 " 
		    	 });
	   $("#team_linkUrl")
	         .formValidator({
	        	 empty:true,
		         onShow:"请输入链接地址",
		         onFocus:"链接地址的格式如：http://+****",
		         onCorrect:"输入正确",
		         onEmpty:"链接地址可为空"
		        })
		     .inputValidator({
	        	 max:100,
	        	 onErrorMax:"链接地址长度不能超过100个字符",
	        	});
	   $("#team_shortName")
		       .formValidator({
		    	     empty:true,
			         onShow:"请输入简介",
			         onFocus:"请输入简介",
			         onCorrect:"输入正确",
			         onEmpty:"简介内容可为空"
			        })
			    .inputValidator({
			         min:0,
			         onError:"你输入的简介非法,请确认"
	        	});
	   $("#team_remark")
		       .formValidator({
		    	     empty:true,
			         onShow:"请输入备注",
			         onFocus:"请输入备注",
			         onCorrect:"输入正确",
			         onEmpty:"备注内容可为空"
			        })
			    .inputValidator({
			         min:0,
			         onError:"你输入的备注非法,请确认"
			    });
   });
 </script>
 <style>
table.data td input.text{ width:200px;}
table.data td textarea.text_beiz{ width:200px;}
</style>
</head>
<body>
<div class="wrapper" style="min-width:100%;">
	<div class="content" style="min-width:100%;">
			<!--[if lt IE 8]><div class="both"></div><![endif]-->
			<div class="main" style="min-height:100%;">
			<div class="tit">科普团体-添加</div>
		  <form id="team_Form" action="${contextPath}/manage/team/submitAdd.rt" enctype="multipart/form-data" method="post">
		     <input type="hidden" class="text" id="team_parentId" name="team.parentId" value="${pTeam.id}"/>
			 <table width="96%" border="0" class="data">
			  <tr>
				<th scope="row" width="110"><span style="color:red;">*</span> 团体名称：</th>
				<td width="210"><input type="text" class="text" id="team_name" name="team.teamName" /></td>
				<td><span class="fl" id="team_nameTip"></span></td>
			  </tr>
			  <tr>
				<th scope="row" width="110"><span style="color:red;">*</span> 团体地址：</th>
				<td><input type="text" class="text" id="team_teamAddress" name="team.teamAddress" /></td>
				<td><span class="fl" id="team_teamAddressTip"></span></td>
			  </tr>
			  <tr>
				<th scope="row" width="110">联系方式：</th>
				<td><input type="text" class="text" id="team_contact" name="team.contact" /></td>
				<td><span class="fl" id="team_contactTip"></span></td>
			  </tr>
			  <tr>
				<th scope="row" width="110">上传图片：</th>
				<td>
				   <input type="file" class="text" id="team_image_path" name="teamImagePath"/>
				</td>
				<td><span class="fl" id="team_image_pathTip"></span></td>
			  </tr>
			   <tr>
				<th scope="row" width="110">访问链接：</th>
				<td><input type="text" class="text" id="team_linkUrl" value="http://" name="team.linkUrl"/></td>
				<td><span class="fl" id="team_linkUrlTip"></span></td>
			  </tr>
			  <tr>
				<th scope="row">团体简介：</th>
				<td>
                    <textarea rows="8" cols="39" id="team_shortName" name="team.shortName" style="overflow-y:auto" class="text_beiz" ></textarea>
                </td>
                <td><span class="fl" id="team_shortNameTip"></span></td>
			  </tr>
			  <tr>
				<th scope="row">备注：</th>
				<td>
                    <textarea rows="8" cols="39" id="team_remark" name="team.remark" style="overflow-y:auto" class="text_beiz" ></textarea>
                </td>
                <td><span class="fl" id="team_remarkTip"></span></td>
			  </tr>
			  <tr class="buttom">
				<th scope="row" align="right"></th>
				<td colspan="2">
					<input type="submit" id="submit_btn" value="提 交" class="add_but fl" />
					<input id="team_reset" type="reset" value="重 置" class="add_but fl" />
					<a href="${contextPath}${returnUrl}" class="but_fanhui fl" style="height:24px;border:0px;font-size:14px;color:white;font-weight:bold;" target="_top">返 回</a>
				</td>
			  </tr>
			  </table>
		  </form>
		</div>
	</div>
</div>
</body>
</html>