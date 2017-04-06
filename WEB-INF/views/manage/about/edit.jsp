<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.roots.kxzy.system.common.constant.AboutCategories"%>
<%
  request.setAttribute("lxwm",AboutCategories.lxwm);
  request.setAttribute("bqsm",AboutCategories.bqsm);
  request.setAttribute("wzjj",AboutCategories.wzjj);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科协资源-编辑关于</title>
<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<script src="${contextPath}/js/validator/formValidator-4.1.3.js" type="text/javascript" ></script>
<script src="${contextPath}/js/validator/formValidatorRegex.js" type="text/javascript"></script>
<script src="${contextPath}/js/xheditor/xheditor-1.1.14-zh-cn.min.js" type="text/javascript"></script>
 <script type="text/javascript" language="javascript">
 $(function() {
	  $.formValidator.initConfig({
		  formID:"about_Form",
		  theme:"Default",
		  submitOnce:true
		});
	 $("#about_name")
	        .formValidator({
	        	onShowText:"请输入关于标题",
	        	onShow:"请输入关于标题称",
	        	onFocus:"关于标题至少1个字符,最多20个字符",
	        	onCorrect:"输入正确"
	        	})
	        .inputValidator({
	        	min:1,
	        	max:20,
	        	onErrorMax:"关于长度不能超过20个字符",
		        onError:"关于不能为空,请确认"
	        	})
	        .regexValidator({
	        	regExp:"chineseenglish",
	        	dataType:"enum",
	        	onError:"关于标题只能包含中文或英文"
	        	})
		    .ajaxValidator({
				dataType : "json",
				async : true,
				type : "post",
				url : "${contextPath}/manage/about/validateAboutName.rt",
				success : function(result){
		            if(result) return true;
					return "该关于标题已存在，请更换关于标题";
				},
				buttons: $("#button"),
				error: function(jqXHR, textStatus, errorThrown){
					alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);
					},
				onError : "该关于标题已存在，请更换关于标题"
			  });
	 $(":radio[name='about.cateId']")
	        .formValidator({
	        	tipID:"about_cateIdTip",
	        	onShowText:"请选择关于类别",
	        	onShow:"请选择关于类别",
	        	onFocus:"关于类别唯一且必选",
	        	onCorrect:"选择正确",
	        	//defaultValue:["1"]
	        	})
	        .inputValidator({
	        	min:1,max:1,onError:"请选择关于类别"
	        	});
	   $("#about_content")
		       .formValidator({
			         onShow:"请输入内容",
			         onFocus:"请输入内容",
			         onCorrect:"输入正确"
			        })
			    .inputValidator({
			         min:0,
			         onError:"你输入的内容非法,请确认"
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
				<div class="tit">编辑关于</div>
				<div class="line">关于详情：</div>
				  <form id="about_Form"  action="${contextPath}/manage/about/submitEdit.rt" method="post">
				     <input type="hidden" name="viewId" id="viewId" value="${viewId }"/>
                     <input type="hidden" name="leftId" id="leftId" value="${leftId }"/>
                     <input type="hidden" name="about.id" id="about_id" value="${about.id}"/>
                     <input type="hidden" name="searchName" id="searchName" value="${searchName }"/>
					 <table width="96%" border="0" class="data">
					  <tr>
						<th scope="row" width="110">标题：</th>
						<td><input type="text" class="text" id="about_name" name="about.aboutName" value="${about.aboutName}"/></td>
						<td><span class="fl" id="about_nameTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row" width="110">关于分类：</th>
						<td>
                           <input type="radio" name = "about.cateId" value="${wzjj}"
                             <c:if test="${about.cateId eq wzjj}">
                                checked = 'checked'
                              </c:if>
                           />网站简介&nbsp;
                           <input type="radio" name = "about.cateId" value="${bqsm}"
                               <c:if test="${about.cateId eq bqsm}">
                                checked = 'checked'
                               </c:if>
                            />版权声明&nbsp;
                           <input type="radio" name = "about.cateId" value="${lxwm}"
                             <c:if test="${about.cateId eq lxwm}">
                                checked = 'checked'
                              </c:if>
                           />联系我们&nbsp;
                        </td>
						<td><span class="fl" id="about_cateIdTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row">内容：</th>
						<td>
                            <textarea name="about.content" id="about_content" class="xheditor {tools:'mfull',width:635}" cols="60" rows="20">${about.content}</textarea> 
                        </td>
                        <td><span class="fl" id="about_contentTip"></span></td>
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