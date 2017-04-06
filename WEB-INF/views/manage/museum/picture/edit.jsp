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
<script src="${contextPath}/js/xheditor/xheditor-1.1.14-zh-cn.min.js"  type="text/javascript" ></script>
<style type="text/css">
 .fengmian{
position:absolute;margin-left: -34px;margin-left: -40px\0; margin-top: 0px;background: #379DD5; font-size: 12px; color: #fff; display: inline; padding:2px 5px;
}
@media screen and (-webkit-min-device-pixel-ratio:0) {.fengmian{margin-left: 150px;margin-top: -142px;}}
</style>
 <script type="text/javascript" language="javascript">
  $(function() {
	  $.formValidator.initConfig({
		  formID:"picture_Form",
		  theme:"Default",
		  submitOnce:true
		});
	 $("#picture_name")
	        .formValidator({
	        	onShowText:"请输入图片名称",
	        	onShow:"请输入图片名称",
	        	onFocus:"名称至少1个最多50个字符",
	        	onCorrect:"该图片名称正确"
	        	})
	        .inputValidator({
	        	min:1,
	        	max:50,
	        	empty:{leftEmpty:false,rightEmpty:false,emptyError:"图片名称两边不能有空符号"},
	        	onErrorMax:"图片名称长度不能超过50个字符",
		        onError:"图片名称不能为空,请确认"
	        	})
	   $("#picture_picDescription")
	       .formValidator({
	    	     empty:true,
		         onShow:"请输入图片简介",
		         onFocus:"请输入图片简介，字数不超过160个字符",
		         onCorrect:"输入正确",
		         onEmpty:"图片简介可为空"
		        })
		    .inputValidator({
		         max:160,
		         onErrorMax:"图片简介不超过160个字符",
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
				<div class="tit">图片编辑信息</div>
				<div class="line">图片编辑</div>
				  <form id="picture_Form" action="${contextPath}/manage/museum/picture/submitEdit.rt" method="post">
					 <input type="hidden" name="picture.id" id="picture_id" value="${picture.id }" />
				     <input type="hidden" name="viewId" value="${viewId }" />
				     <input type="hidden" name="leftId" value="${leftId }" />
				     <input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			         <input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			         <input type="hidden" name="searchName" id="searchName" value="${rt:escapeHtml(searchName)}"/>
			          <input type="hidden" name="returnUrl" id="returnUrl" value="${rt:escapeHtml(returnUrl)}"/>
					 <table width="96%" border="0" class="data">
					  <tr>
						<th scope="row" width="110"></th>
						<td width="210">
						  <img src="${contextPath}/manage/museum/picture/image.rt?picId=${picture.id}" alt="..." style="max-width: 330px;max-height: 230px"/>
    					  <c:if test="${pictureset.isCover == picture.id}">
					        <div class="fengmian">封面</div>
					      </c:if>
						</td>
					  </tr>
					  <th>所属图集：</th>
						<td>${rt:escapeHtml(pictureset.name)}</td>
					  <tr>
						<th><span style="color:red;">*</span> 图片名称：</th>
						<td><input type="text" class="text" id="picture_name" name="picture.picName" value="${rt:escapeHtml(picture.picName)}"/></td>
						<td><span class="fl" id="picture_nameTip"></span></td>
					  </tr>
					  <tr>
					    <th>图片简介：</th>
					    <td><textarea name="picture.picDescription" id="picture_picDescription" cols="40" rows="9">${rt:escapeHtml(picture.picDescription)}</textarea></td>
					    <td><span class="fl" id="picture_picDescriptionTip"></span></td>
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