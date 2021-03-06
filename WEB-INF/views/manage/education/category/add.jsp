<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.roots.kxzy.system.common.constant.EnableStatus"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科协资源-教育基地类别添加</title>
<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<script src="${contextPath}/js/validator/formValidator-4.1.3.js" type="text/javascript" ></script>
<script src="${contextPath}/js/validator/formValidatorRegex.js" type="text/javascript"></script>
 <script type="text/javascript" language="javascript">
    $(function() {
		  $.formValidator.initConfig({
			  formID:"cate_Form",
			  theme:"Default",
			  submitOnce:true
			  });
		 $("#cate_name")
		        .formValidator({
		        	onShowText:"请输入教育基地类别名称",
		        	onShow:"请输入教育基地类别名称",
		        	onFocus:"名称至少1个最多20个中文或英文字符",
		        	onCorrect:"该教育基地类别正确"
		        	})
		        .inputValidator({
		        	min:1,
		        	max:20,
		        	onErrorMax:"教育基地类别长度不能超过20个字符",
			        onError:"教育基地类别不能为空,请确认"
		        	})
		        .regexValidator({
		        	regExp:"chineseenglish",
		        	dataType:"enum",
		        	onError:"教育基地类别名只能包含中文或英文"
		        	})
			    .ajaxValidator({
					dataType : "json",
					async : true,
					type : "post",
					url : "${contextPath}/manage/education/category/validateEducationCategoryName.rt",
					data:{"add_educationCate":true},
					success : function(result){
			            if(result) return true;
						return "该教育基地类别名已存在，请更换教育基地类别名";
					},
					buttons: $("#button"),
					error: function(jqXHR, textStatus, errorThrown){
						alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);
						},
					onError : "该教育基地类别名已存在，请更换教育基地类别名"
				  });
		   $("#cate_description")
			       .formValidator({
			    	     empty:true,
				         onShow:"请输入描述",
				         onFocus:"请输入描述",
				         onCorrect:"输入正确",
				         onEmpty:"类别描述可为空"
				        })
				    .inputValidator({
				         min:1,
				         onError:"你输入的描述非法,请确认"
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
				<div class="tit">教育基地类别</div>
				<div class="line">教育基地类别详情：</div>
				  <form id="cate_Form"  action="${contextPath}/manage/education/category/submitAdd.rt" method="post">
				     <input type="hidden" name="viewId" id="viewId" value="${viewId }"/>
                     <input type="hidden" name="leftId" id="leftId" value="${leftId }"/>
					 <table width="96%" border="0" class="data">
					  <tr>
						<th scope="row" width="110"><span style="color:red;">*</span> 名称：</th>
						<td width="330"><input type="text" class="text" id="cate_name" name="cate.cateName" /></td>
						<td><span class="fl" id="cate_nameTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row">描述：</th>
						<td>
                            <textarea rows="8" cols="39" id="cate_description" name="cate.description" style="overflow-y:auto" class="text_beiz" ></textarea>
                        </td>
                        <td><span class="fl" id="cate_descriptionTip"></span></td>
					  </tr>
					  <tr class="buttom">
						<th scope="row" align="right"></th>
						<td colspan="2">
							<input type="submit" id="submit_btn" value="提 交" class="add_but fl" />
							<input id="reset_form" type="reset" value="重 置" class="add_but fl" />
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