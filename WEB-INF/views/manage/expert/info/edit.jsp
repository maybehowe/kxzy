<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.roots.kxzy.system.common.constant.EnableStatus"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科协资源</title>
<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<script src="${contextPath}/js/validator/formValidator-4.1.3.js" type="text/javascript" ></script>
<script src="${contextPath}/js/validator/formValidatorRegex.js" type="text/javascript"></script>
<script src="${contextPath}/js/xheditor/xheditor-1.1.14-zh-cn.min.js" type="text/javascript"></script>
 <script type="text/javascript" language="javascript">
  $(function() {
	  $.formValidator.initConfig({
		  formID:"expert_Form",
		  theme:"Default",
		  submitOnce:true
		});
	 $("#expert_userName")
	        .formValidator({
	        	onShowText:"请输入专家名称",
	        	onShow:"请输入专家名称",
	        	onFocus:"名称至少1个最多20个中文或英文字符",
	        	onCorrect:"该专家正确"
	        	})
	        .inputValidator({
	        	min:1,
	        	max:20,
	        	onErrorMax:"专家名称长度不能超过20个字符",
		        onError:"专家名称不能为空,请确认"
	        	})
	        .regexValidator({
	        	regExp:"chineseenglish",
	        	dataType:"enum",
	        	onError:"专家名只能包含中文或英文"
	        	})
	   $("#expert_cateId")
	         .formValidator({
		         onShow:"请选择专家类型",
		         onFocus:"专家类型必须选择",
		         onCorrect:"选择正确"
		        })
		     .inputValidator({
		    	 min:1,
		    	 onError: "请选择专家类型"
		       });
	   $("#expert_image_path")
	         .formValidator({
	        	 empty:true,
		         onShow:"请选择 225px*80px 图片",
		         onFocus:"请选择 225px*80px 图片",
		         onCorrect:"选择正确",
		         onEmpty:""
		        })
		     .inputValidator({
		    	 min:1,
		    	 onError: "请选择 225px*80px 图片",
		      })
		     .regexValidator({
		    	 regExp:"picture",
		    	 dataType:"enum",
		    	 onError:"图片格式不正确 " 
		    	 });
	   $("#expert_introduction")
		       .formValidator({
			         onShow:"请输入专家简介",
			         onFocus:"请输入专家简介，字数不超过2000个字符",
			         onCorrect:"输入正确",
			        })
			  .inputValidator({
			    	 min:1,
			         max:2000,
			         onErrorMax:"专家简介不超过2000个字符",
			         onError:"专家简介不能为空,请确认"
			    	})
			   .regexValidator({
				   regExp:"allspace",
				   dataType:"enum",
				   onError:"专家简介不能为空,请确认"
				   });
    });
 </script>
</head>
<body>
<div class="wrapper">
    <jsp:include page="/WEB-INF/views/manage/common/head.jsp" />
	<div class="content">
	<jsp:include page="/WEB-INF/views/manage/common/left.jsp" />
		<div class="right">
			<div class="main">
				<div class="tit">专家</div>
				<div class="line">专家详情：</div>
				  <form id="expert_Form" action="${contextPath}/manage/expert/info/submitEdit.rt" enctype="multipart/form-data" method="post">
					 <input type="hidden" name="expert.id" id="expert_id" value="${expert.id }" />
				     <input type="hidden" name="viewId" value="${viewId }" />
				     <input type="hidden" name="leftId" value="${leftId }" />
				     <input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			         <input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			         <input type="hidden" name="searchName" id="searchName" value="${searchName }"/>
					 <table width="96%" border="0" class="data">
					  <tr>
						<th scope="row" width="110"><span style="color:red;">*</span> 专家名称：</th>
						<td width="330"><input type="text" class="text" id="expert_userName" name="expert.userName" value="${expert.userName}"/></td>
						<td><span class="fl" id="expert_userNameTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row" width="110"><span style="color:red;">*</span> 专家类型：</th>
						<td>
						 <select name="expert.cateId" id="expert_cateId" class="mr40" style="width: 150px;">
						   <option value="">--请选择--</option>
						   <c:forEach items="${cateList}" var="c">
						      <option value="${c.id}"
						      <c:if test="${c.id eq expert.cateId }">
						         selected = 'selected'
						      </c:if>
						      >${c.cateName}</option>
						   </c:forEach>
						 </select>
						</td>
						<td><span class="fl" id="expert_cateIdTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row" width="110">上传图片：</th>
						<td>
						    <input type="file" class="text" id="expert_image_path" name="expertImagePath"/>
						</td>
						<td><span class="fl" id="expert_image_pathTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row" width="110">图片预览：</th>
						<td>
						  <c:choose>
						      <c:when test="${expert.pictureUrl != null}">
						         <img src="${contextPath}${expert.pictureUrl}" alt="" width="225px" height="80px"/>
						      </c:when>
						      <c:otherwise>
						          <img src="${contextPath}/images/load.jpg" alt="" width="225px" height="80px" />
						      </c:otherwise>
						    </c:choose>
						</td>
						<tr>
						<th scope="row" width="110"> 专家介绍：</th>
						<td>
						   <textarea name="expert.introduction" id="expert_introduction" cols="40" rows="19">${rt:escapeHtml(pictureset.description)}</textarea> 
						</td>
						<td><span class="fl" id="expert_introductionTip"></span></td>
					  </tr>
					  </tr>
					  <tr class="buttom">
						<th scope="row" align="right"></th>
						<td colspan="2">
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