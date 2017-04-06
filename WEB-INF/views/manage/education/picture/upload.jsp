<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="rt" uri="http://www.roots.com/tags/commons"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>${page.title}</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/sco.message.css" type="text/css"></link>
<link rel="stylesheet" href="${contextPath}/bootstrap.sco/css/scojs.css" type="text/css"></link>
<script type="text/javascript" src="${contextPath}/bootstrap.sco/js/sco.message.js"></script>
<script type="text/javascript" src="${contextPath}/js/ueditor1_3_6/ueditor.all.js"></script>
<script type="text/javascript" src="${contextPath}/js/ueditor1_3_6/dialogs/tangram.js"></script>
<script type="text/javascript" src="${contextPath}/js/ueditor1_3_6/dialogs/attachment/callbacks.js"></script>
<script type="text/javascript" src="${contextPath}/js/ueditor1_3_6/dialogs/image/image.js"></script>
<style type="text/css">
.glyphicon-hide{
	display: none;
}
.upload-button {
	display: block;
	background-image: url("${contextPath}/js/ueditor1_3_6/lang/zh-cn/images/upload.png");
	background-repeat: no-repeat;
	width: 100px;
	height: 28px;
}
.upload-enable:hover {
	background-position: 0 0;
	cursor: pointer;
}
.upload-disable {
	background-position: -100px 0;
}
</style>
<script type="text/javascript">
/*-=-=-=-=-=-=-=全局变量模块-=-=-=-=-=-=-*/
var imageUrls = []; //从服务器返回的上传成功图片数组
var selectedCount = 0; //预览框中的图片数量，初始为0
$(function(){
	var containerWidth = $("#flashUploadContainer").width();
	var containerHeight = 300;
	//flash初始化参数
	var flashOptions = {
		createOptions : {
			id : 'flashUpload', //flash容器id
			url : '${basepath}/js/ueditor1_3_6/dialogs/image/imageUploader.swf', //这个就是附件里面的FLASH
			width : containerWidth, //容器宽度
			height : containerHeight, //容器高度
			errorMessage : 'Flash插件初始化错误，请更新您的flashplayer版本！',
			wmode : 'window',
			ver : '10.0.0',
			// 初始化的参数就是这些，
			vars : {
				width : containerWidth - 2, //width是flash的宽
				height : containerHeight - 2, //height是flash的高
				gridWidth : 115, // gridWidth是每一个预览图片所占的宽度，应该为width的整除
				gridHeight : 120, // gridHeight是每一个预览图片所占的高度，应该为height的整除
				picWidth : 100, // 单张预览图片的宽度
				picHeight : 100, // 单张预览图片的高度
				uploadDataFieldName : 'picture.file', // POST请求中图片数据的key
				picDescFieldName : 'picture.title', // POST请求中图片描述的key
				maxSize : 20, // 文件的最大体积,单位M
				compressSize : 20, // 上传前如果图片体积超过该值，会先压缩,单位M
				maxNum : 32, // 最大上传多少个文件
				backgroundUrl : '', //背景图片,留空默认
				listBackgroundUrl : '', //预览图背景，留空默认
				buttonUrl : '', //按钮背景，留空默认
				//compressSide : 1, //等比压缩的基准，0为按照最长边，1为按照宽度，2为按照高度
				compressLength : 2000, // 能接受的最大边长，超过该值Flash会自动等比压缩
				ext : '{}', //可向服务器提交的自定义参数列表
				fileType : '{"description":"图片", "extension":"*.jpeg;*.png;*.jpg"}', //上传文件格式限制
				url: "${contextPath}/manage/education/picture/submitUpload.rt"// 上传处理页面的url地址
			},
			container : 'flashUploadContainer' //flash容器id，对应页面上面的DIV
		},
		selectFileCallback : function(selectFiles){
			selectedCount += selectFiles.length;
	         if(selectedCount) {
	        	 $("#upload_button").removeClass("upload-disable").addClass("upload-enable");
	         }
		}, // 选择文件的回调
		exceedFileCallback : 'exceedFileCallback', // 文件超出限制的最大体积时的回调
		deleteFileCallback : function(delFiles){
			selectedCount -= delFiles.length;
	        if (!selectedCount) {
	        	 $("#upload_button").removeClass("upload-enable").addClass("upload-disable");
	        }
		}, // 删除文件的回调
		startUploadCallback : function(index){// 开始上传某个文件时的回调
        }, 
		uploadCompleteCallback : 'uploadCompleteCallback', // 某个文件上传完成的回调
		uploadErrorCallback : function(data) {
			if (!data.info) {
				alert(data.info);
			}
		}, // 某个文件上传失败的回调
		allCompleteCallback : function(){ // 全部上传完成时的回调
			 $.scojs_message('上传完毕,点击关闭窗口', $.scojs_message.TYPE_OK);
			 $("#upload_button").removeClass("upload-enable").addClass("upload-disable");
		} 
	//changeFlashHeight: 'changeFlashHeight' // 改变Flash的高度，mode==1的时候才有用
	};
	var flashObj = new baidu.flash.imageUploader(flashOptions);
	
	
	$("#upload_button").click(function() {
		if($("#picture_set").val() == '' || $("#picture_set").val() == null){
			 $.scojs_message('您还没有图集，请先创建图集', $.scojs_message.TYPE_ERROR);
			 return;
		}
			if (selectedCount <= 0) {
				return;
			}
			/**
			 * 接口imageUploader.setPostParams()可以在提交时设置本次上传提交的参数（包括所有图片）
			 * 参数为json对象{"key1":"value1","key2":"value2"}，其中key即为向后台post提交的name，value即为值。
			 * 其中有一个特殊的保留key值为action，若设置，可以更改本次提交的处理地址
			 */
			var params = {
				"picture.set" : $("#picture_set").val()
			};
			//给每个图片设置参数
			for ( var i = 0; i < selectedCount; i++) {
				flashObj.addCustomizedParams(i, params);
			}
			flashObj.upload();
		});
	});
</script>
</head>

<body>
<div style="height: 30px">
  <span style="font-size: 14px ;font-family: 微软雅黑;color: gray">上传到：</span>
  <select id="picture_set" name="pictureSet"> 
    <c:forEach items="${picturesetList}" var="psl">
        <option value="${psl.id}"
         <c:if test="${psl.id eq pictureset.id}"> selected = 'selected'</c:if>
        >${rt:escapeHtml(psl.name)}</option>
    </c:forEach>
  </select>
</div>
	  	<div id="flashUploadContainer" ></div>
		<a id="upload_button" class="upload-button upload-disable"></a>
</body>
</html>