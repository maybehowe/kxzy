<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>科协资源管理平台</title>
<%@include file="../common/form.jsp" %>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<script src="${contextPath}/js/validator/formValidator-4.1.3.js" type="text/javascript" ></script>
<script src="${contextPath}/js/validator/formValidatorRegex.js" type="text/javascript"></script>
<script type="text/javascript">
/*<![CDATA[*/
$(document).ready(function(){
	$.formValidator.initConfig({formID:"subjectForm",theme:"Default",submitOnce:true});
 $("#name").formValidator({onShowText:"请输入学科名称",onShow:"请输入学科名称",onFocus:"学科名称至少1个字符,最多20个字符",onCorrect:"该学科名称可以使用"}).inputValidator({min:1,max:20,onError:"你输入的学科名称非法,请确认"}).regexValidator({regExp:"chineseenglish",dataType:"enum",onError:"学科名称格式不正确"})
	    .ajaxValidator({
		dataType : "json",
		async : true,
		type : "post",
		url : "${contextPath}/manage/subject/validateName.rt",
		success : function(json){
            if(json.flag) return true;
			return "该学科名称已存在，请更换学科名称";
		},
		buttons: $("#button"),
		error: function(jqXHR, textStatus, errorThrown){alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);},
		onError : "该学科名称已存在，请更换学科名称"
	}).defaultPassed();
	$("#txtremark").formValidator({empty:true,onShow:"请输入备注",onFocus:"请输入100个字符或者50个汉字",onCorrect:"输入正确"}).inputValidator({max:100,onError:"输入的描述长度不正确，请确认"}); 
}); 
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
				<div class="tit">编辑学科</div>
				<div class="line">学科详情：</div>
				<form id="subjectForm" action="${contextPath}/manage/subject/save.rt" method="post">
				<input type="hidden" name="viewId" value="${viewId }" />
				<input type="hidden" name="leftId" value="${leftId }" />
				<input type="hidden" name="subject.id" value="${subject.id }" />
				<table width="96%" border="0" class="data">
				  <tr>
					<th scope="row" width="110"><span style="color:red;">*</span> 学科名称：</th>
					<td width="330"><input name="subject.name" type="text" class="text" id="name" value="${subject.name }"/></td>
					<td><span class="fl" id="nameTip"></span></td>
				  </tr>
				  <tr>
					<th scope="row" align="right">备注：</th>
					<td><input name="subject.des" type="text" class="text" id="txtremark" value="<c:out value="${subject.des }" escapeXml="true"/>"/></td>
					<td><span class="fl" id="txtremarkTip"></span></td>
				  </tr>
				  <tr class="buttom">
					<th scope="row" align="right"></th>
					<td colspan="2">
						<input name="" type="submit" value="提 交" class="add_but fl" />
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
