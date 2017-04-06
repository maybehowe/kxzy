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
<title>科协资源-关于添加</title>
<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<script src="${contextPath}/js/validator/formValidator-4.1.3.js" type="text/javascript" ></script>
<script src="${contextPath}/js/validator/formValidatorRegex.js" type="text/javascript"></script>
<script src="${contextPath}/js/xheditor/xheditor-1.1.14-zh-cn.min.js" type="text/javascript"></script>
<style type="text/css">
   .tabs {
	float:left;
    width:100%;
	margin-left:140px;
	}
	.tabs ul 
	{
	    list-style: none outside none;
	    margin: 0;
	    padding: 0;
	}
	.tabs ul li
	{
	    float: left;
	    line-height: 24px;
	    margin: 0;
	    padding: 2px 20px 0 15px;
		margin-right:5px;
	}
	.tab-nav{
		 background:#eee;
		 cursor:pointer;
		 color: #6D6D6D;
	}
	.tab-nav-action{
		background:#379DD5;
		cursor:pointer;
		color:#fff;
	}
	.tabs-body
	{
	    /*border-bottom: 1px solid #B4C9C6;
	    border-left: 1px solid #B4C9C6;
	    border-right: 1px solid #B4C9C6;*/
	    float: left;
	    padding: 5px 0 0;
	    width: 100%;
	}
	.tabs-body div 
	{
	    padding:10px;
	}
	
	table.data .xheLayout{height:350px !important;}
    .xheIframeArea{height:350px !important;}
</style>
<script type="text/javascript" language="javascript">
<%--
    $(function() {
    	  //网站简介
		  $.formValidator.initConfig({
			  formID:"",
			  theme:"Default",
			  submitOnce:true
			});
		   $("#wzjj_about_content")
			       .formValidator({
				         onShow:"请输入内容",
				         onFocus:"请输入内容",
				         onCorrect:"输入正确"
				        })
				    .inputValidator({
				         min:0,
				         onError:"你输入的内容非法,请确认"
				       });
		   //版权声明
		   $.formValidator.initConfig({
			      validatorGroup:"2",
				  formID:"bqsm_Form",
				  theme:"Default",
				  submitOnce:true
				});
			   $("#bqsm_about_content")
				       .formValidator({
				    	     validatorGroup:"2",
					         onShow:"请输入内容",
					         onFocus:"请输入内容",
					         onCorrect:"输入正确"
					        })
					    .inputValidator({
					         min:0,
					         onError:"你输入的内容非法,请确认"
					       });
		   //联系我们
		   $.formValidator.initConfig({
			      validatorGroup:"3",
				  formID:"lxwm_Form",
				  theme:"Default",
				  submitOnce:true
				});
			   $("#lxwm_about_content")
				       .formValidator({
				    	     validatorGroup:"3",
					         onShow:"请输入内容",
					         onFocus:"请输入内容",
					         onCorrect:"输入正确"
					        })
					    .inputValidator({
					         min:0,
					         onError:"你输入的内容非法,请确认"
					       });
			   
	    });--%>
    
    function resetForm(obj){
    	 $(obj).closest("form").find("textarea").text("");
    }
    
    $(document).ready(function () {
        $("#tabs li").bind("click", function () {
            var index = $(this).index();
            var divs = $("#tabs-body > div");
            $(this).parent().children("li").attr("class", "tab-nav");//将所有选项置为未选中
            $(this).attr("class", "tab-nav-action"); //设置当前选中项为选中样式
            divs.hide();//隐藏所有选中项内容
            divs.eq(index).show(); //显示选中项对应内容
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
				<div class="tit">添加关于</div>
				<div class="line">关于详情：</div>
				    <div class="tabs">
			        <ul id="tabs">
			            <li class="tab-nav-action">网站简介</li>
			            <li class="tab-nav">版权声明</li>
			            <li class="tab-nav">联系我们</li>
			        </ul>
			       </div>
			        <div id="tabs-body" class="tabs-body">
			        <div style="display:block">
			         <form id="wzjj_Form"  action="${contextPath}/manage/about/submitOperate.rt" method="post">
				     <input type="hidden" name="viewId" id="viewId" value="${viewId }"/>
                     <input type="hidden" name="leftId" id="leftId" value="${leftId }"/>
					 <table width="96%" border="0" class="data">
					  <tr>
						<th scope="row" width="110">内容：</th>
						<td>
						   	<input type="hidden" class="text" id="wzjj_about_id" name="about.id" value="${wzjjabout.id}"/>
                            <input type="hidden" name = "about.cateId" value="${wzjj}"/>
                            <textarea name="about.content" id="wzjj_about_content" class="xheditor {tools:'mfull',width:655}" cols="60" rows="20">${wzjjabout.content}</textarea> 
                        </td>
                        <td><span class="fl" id="wzjj_about_contentTip"></span></td>
					  </tr>
					  <tr class="buttom">
						<th scope="row" align="right"></th>
						<td colspan="2">
							<input type="submit" id="submit_btn" value="提 交" class="add_but fl" />
						</td>
					  </tr>
					  </table>
				  </form>
			    </div>
			       <div style="display:none">
			         <form id="bqsm_Form"  action="${contextPath}/manage/about/submitOperate.rt" method="post">
				     <input type="hidden" name="viewId" id="viewId" value="${viewId }"/>
                     <input type="hidden" name="leftId" id="leftId" value="${leftId }"/>
					 <table width="96%" border="0" class="data">
					  <tr>
						<th scope="row" width="110">内容：</th>
						<td>
							 <input type="hidden" class="text" id="bqsm_about_name" name="about.id" value="${bqsmabout.id}"/>
                            <input type="hidden" name = "about.cateId" value="${bqsm}"/>
                            <textarea name="about.content" id="bqsm_about_content" class="xheditor {tools:'mfull',width:655}" cols="60" rows="20">${bqsmabout.content}</textarea> 
                        </td>
                        <td><span class="fl" id="bqsm_about_contentTip"></span></td>
					  </tr>
					  <tr class="buttom">
						<th scope="row" align="right"></th>
						<td colspan="2">
							<input type="submit" id="submit_btn" value="提 交" class="add_but fl" />
						</td>
					  </tr>
					  </table>
				  </form>
			    </div>
			      <div style="display:none">
			       <form id="lxwm_Form"  action="${contextPath}/manage/about/submitOperate.rt" method="post">
				     <input type="hidden" name="viewId" id="viewId" value="${viewId }"/>
                     <input type="hidden" name="leftId" id="leftId" value="${leftId }"/>
					 <table width="96%" border="0" class="data">
					  <tr>
						<th scope="row" width="110">内容：</th>
						<td>
							<input type="hidden" class="text" id="lxwm_about_name" name="about.id" value="${lxwmabout.id}"/>
                            <input type="hidden" name = "about.cateId" value="${lxwm}"/>
                            <textarea name="about.content" id="lxwm_about_content" class="xheditor {tools:'mfull',width:655}" cols="60" rows="20">${lxwmabout.content}</textarea> 
                        </td>
                        <td><span class="fl" id="lxwm_about_contentTip"></span></td>
					  </tr>
					  <tr class="buttom">
						<th scope="row" align="right"></th>
						<td colspan="2">
							<input type="submit" id="submit_btn" value="提 交" class="add_but fl" />
						</td>
					  </tr>
					  </table>
				  </form>
			    </div>
			</div>
			<div class="cb"></div>
		</div>
	</div>
	</div>
</div>
</body>
</html>