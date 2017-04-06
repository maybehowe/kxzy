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
 <script type="text/javascript" language="javascript">
  $(function() {
	  $.formValidator.initConfig({
		  formID:"link_Form",
		  theme:"Default",
		  submitOnce:true
		});
	 $("#link_name")
	        .formValidator({
	        	onShowText:"请输入友情链接名称",
	        	onShow:"请输入友情链接名称",
	        	onFocus:"名称至少1个最多20个中文或英文字符",
	        	onCorrect:"该友情链接正确"
	        	})
	        .inputValidator({
	        	min:1,
	        	max:20,
	        	onErrorMax:"友情链接名称长度不能超过20个字符",
		        onError:"友情链接名称不能为空,请确认"
	        	})
	        .regexValidator({
	        	regExp:"chineseenglish",
	        	dataType:"enum",
	        	onError:"友情链接名只能包含中文或英文"
	        	})
		    .ajaxValidator({
				dataType : "json",
				async : true,
				type : "post",
				url : "${contextPath}/manage/link/info/validateLinkinfoName.rt",
				data:{"editLink":"${link.linkName}","add_link":false},
				success : function(result){
		            if(result) return true;
					return "该友情链接名已存在，请更换友情链接名";
				},
				buttons: $("#button"),
				error: function(jqXHR, textStatus, errorThrown){
					alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);
					},
				onError : "该友情链接名已存在，请更换友情链接名"
			  });
	   $("#link_cateId")
	         .formValidator({
		         onShow:"请选择链接类型",
		         onFocus:"链接类型必须选择",
		         onCorrect:"选择正确"
		        })
		     .inputValidator({
		    	 min:1,
		    	 onError: "请选择链接类型"
		       });
	   $("#link_image_path")
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
	   $("#link_address")
		      .formValidator({
		     	 empty:true,
		         onShow:"请输入域名地址",
		         onFocus:"域名地址的格式如：http://+******",
		         onCorrect:"输入正确"
		        })
		     .inputValidator({
		     	 max:100,
		     	 onErrorMax:"域名地址长度不能超过100个字符",
		     	});
	   /*$("#link_organizer")
	         .formValidator({
	        	 empty:true,
		         onShow:"请输入主办单位",
		         onFocus:"单位名称：地区名 + 单位名",
		         onCorrect:"名称正确"
		        })
		     .inputValidator({
		    	 min:1,
		         max:100,
		         onError:"你输入的友情链接名非法,请确认"
		       })
		      .regexValidator({
	        	 regExp:"chineseenglish",
	        	 dataType:"enum",
	        	 onError:"主办单位名只能包含中文或英文"
	        	});
	   $("#link_introduction")
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
			       });*/
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
				<div class="tit">友情链接</div>
				<div class="line">友情链接详情：</div>
				  <form id="link_Form" action="${contextPath}/manage/link/info/submitEdit.rt" enctype="multipart/form-data" method="post">
					 <input type="hidden" name="link.id" id="link_id" value="${link.id }" />
				     <input type="hidden" name="viewId" value="${viewId }" />
				     <input type="hidden" name="leftId" value="${leftId }" />
				     <input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
			         <input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
			         <input type="hidden" name="searchName" id="searchName" value="${searchName }"/>
					 <table width="96%" border="0" class="data">
					  <tr>
						<th scope="row" width="110"><span style="color:red;">*</span> 链接名称：</th>
						<td width="330"><input type="text" class="text" id="link_name" name="link.linkName" value="${link.linkName}"/></td>
						<td><span class="fl" id="link_nameTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row" width="110"><span style="color:red;">*</span> 链接类型：</th>
						<td>
						 <select name="link.cateId" id="link_cateId" class="mr40" style="width: 150px;">
						   <option value="">--请选择--</option>
						   <c:forEach items="${cateList}" var="c">
						      <option value="${c.id}"
						      <c:if test="${c.id eq link.cateId }">
						         selected = 'selected'
						      </c:if>
						      >${c.cateName}</option>
						   </c:forEach>
						 </select>
						</td>
						<td><span class="fl" id="link_cateIdTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row" width="110">上传图片：</th>
						<td>
						    <input type="file" class="text" id="link_image_path" name="linkImagePath"/>
						</td>
						<td><span class="fl" id="link_image_pathTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row" width="110">图片预览：</th>
						<td>
						  <c:choose>
						      <c:when test="${link.pictureUrl != null}">
						         <img src="${contextPath}${link.pictureUrl}" alt="" width="225px" height="80px"/>
						      </c:when>
						      <c:otherwise>
						          <img src="${contextPath}/images/load.jpg" alt="" width="225px" height="80px" />
						      </c:otherwise>
						    </c:choose>
						</td>
						<td></td>
					  </tr>
					  <tr>
						<th scope="row" width="110"><span style="color:red;">*</span> 域名地址：</th>
						<td><input type="text" class="text" id="link_address" name="link.address" value="${link.address}"/></td>
						<td><span class="fl" id="link_addressTip"></span></td>
					  </tr>
					  <!--  <tr>
						<th scope="row" width="110">主办单位：</th>
						<td><input type="text" class="text" id="link_organizer" name="link.organizer" value="${link.organizer}"/></td>
						<td><span class="fl" id="link_organizerTip"></span></td>
					  </tr>
					  <tr>
						<th scope="row">简介：</th>
						<td>
                            <textarea rows="8" cols="39" id="link_introduction" name="link.introduction" style="overflow-y:auto" class="text_beiz" >${link.introduction}</textarea>
                        </td>
                        <td><span class="fl" id="link_introductionTip"></span></td>
					  </tr> -->
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