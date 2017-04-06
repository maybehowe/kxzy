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
		  formID:"museum_Form",
		  theme:"Default",
		  submitOnce:true
		});
	 $("#museum_name")
	        .formValidator({
	        	onShowText:"请输入科普场馆名称",
	        	onShow:"请输入科普场馆名称",
	        	onFocus:"场馆名称至少1个字符,最多50个字符",
	        	onCorrect:"该场馆名称可以使用"
	        	})
	        .inputValidator({
	        	min:1,
	        	max:50,
	        	empty:{leftEmpty:false,rightEmpty:false,emptyError:"标题两边不能有空符号"},
	        	onErrorMax:"科普图集名称长度不能超过50个字符",
		        onError:"科普图集名称不能为空,请确认"
	        	});
	 $("#museum_link")
		      .formValidator({
		         onShow:"请输入场馆链接",
		         onFocus:"链接地址的格式如：http://+******",
		         onCorrect:"输入正确"
		        })
		     .inputValidator({
		     	 max:200,
		     	 onErrorMax:"链接地址长度不能超过200个字符",
		     	})
		     .regexValidator({
		    	 regExp:"url",
		    	 dataType:"enum",
		    	 onError:"链接地址不正确 " 
		       });
	 
	   $("#museum_type")
	         .formValidator({
		         onShow:"请选择分类",
		         onFocus:"分类必须选择",
		         onCorrect:"选择正确"
		        })
		     .inputValidator({
		    	 min:1,
		    	 onError: "请选择分类"
		       });
	    $("#museum_descript")
		       .formValidator({
			         onShow:"请输入场馆简介",
			         onFocus:"请输入场馆简介，字数不超过2000个字符",
			         onCorrect:"输入正确",
			        })
			  .inputValidator({
			    	 min:1,
			         max:2000,
			         onErrorMax:"场馆简介不超过2000个字符",
			         onError:"场馆简介不能为空,请确认"
			    	})
			   .regexValidator({
				   regExp:"allspace",
				   dataType:"enum",
				   onError:"场馆简介不能为空,请确认"
				   });
	   
	    $("#linkRow").hide();
		$("#museum_type").change(onTypeChange);
    });
 
 	function onTypeChange() {
		var type = $("#museum_type").val();
		if(type == 1) {//省内
			$("#cityNameRow").show();
			$("#linkRow").hide();
		} else if(type == 2){
			$("#cityNameRow").hide();
			$("#linkRow").show();
		} else{
			$("#cityNameRow").show();
			$("#linkRow").hide();
		}
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
					<div class="tit">添加科普场馆</div>
					<div class="line">科普场馆详情：</div>
					<form id="museum_Form"  action="${contextPath}/manage/museum/submitAdd.rt" method="post">
					     <input type="hidden" name="viewId" value="${viewId }" />
					     <input type="hidden" name="leftId" value="${leftId }" />
	   				     <input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
				         <input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
				         <input type="hidden" name="searchName" id="searchName" value="${rt:escapeHtml(searchName)}"/>
				         <input type="hidden" name="channelId" id="channelId" value="${channelId }"/>
						 <table width="96%" border="0" class="data">
						 	<tr>
								<th scope="row" width="110">
									<span style="color:red;">*</span> 场馆名称：
								</th>
								<td>
									<input type="text"  class="text" id="museum_name" name="museum.name" />
								</td>
								<td>
									<span class="fl" id="museum_nameTip"></span>
								</td>
							</tr>
						  	<tr>
								<th scope="row" width="110">
									<span style="color:red;">*</span> 场馆类别：
								</th>
								<td width="330">
									<select name="museum.type" id="museum_type">
										<option value="">--请选择--</option>
										<option value="1">省内场馆</option>
										<option value="2">国内场馆</option>
									</select>
								</td>
								<td colspan="2">
									<span class="fl" id="museum_typeTip"></span>
								</td>
						  	</tr>
						  	<tr id="cityNameRow">
								<th scope="row" width="110">
									<span style="color:red;">*</span> 场馆城市：
								</th>
								<td width="330">
									<select name="museum.cityName" id="museum_cityName">
										<option value="杭州市">杭州市</option>
										<option value="湖州市">湖州市</option>
										<option value="嘉兴市">嘉兴市</option>
										<option value="舟山市">舟山市</option>
										<option value="绍兴市">绍兴市</option>
										<option value="宁波市">宁波市</option>
										<option value="衢州市 ">衢州市</option>
										<option value="金华市">金华市</option>
										<option value="台州市">台州市</option>
										<option value="丽水市">丽水市</option>
										<option value="温州市">温州市</option>
									</select>
								</td>
								<td colspan="2">
									<span class="fl" id="museum_cityNameTip"></span>
								</td>
						  	</tr>
							<tr id="linkRow">
								<th scope="row" width="110">
									<span style="color:red;">*</span> 场馆链接：
								</th>
								<td>
									<input type="text"  class="text" id="museum_link" name="museum.link" value="http://www.example.com"/>
								</td>
								<td>
									<span class="fl" id="museum_linkTip"></span>
								</td>
							</tr>
							   
						  	<tr>
								<th scope="row" align="right">
									<span style="color:red;">*</span> 简介：
								</th>
								<td>
									<textarea name="museum.descript" id="museum_descript" cols="40" rows="19"></textarea>
								</td>
								<td colspan="2">
									<span class="fl" id="museum_descriptTip"></span>
								</td>
						  	</tr>
						  	<tr class="buttom">
								<th scope="row" align="right"></th>
								<td colspan="2">
									<input type="submit" id="submit_btn" value="提交" class="add_but fl" />
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