<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>科协资源-图片裁剪</title>
<%@include file="/WEB-INF/views/manage/common/form.jsp" %>
<link href="${contextPath}/css/style_add.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/js/form.js"></script>
<script type="text/javascript" src="${contextPath}/js/Jcrop/js/jquery.color.js"></script>
<script type="text/javascript" src="${contextPath}/js/Jcrop/js/jquery.Jcrop.js"></script>
<link rel="stylesheet" href="${contextPath}/js/Jcrop/css/jquery.Jcrop.css">
<link rel="stylesheet" href="${contextPath}/js/Jcrop/demos/demo_files/demos.css">
<link rel="stylesheet" href="${contextPath}/js/Jcrop/demos/demo_files/main.css">
<style type="text/css">
.glyphicon-hide{
	display: none;
}

/* Apply these styles only when #preview-pane has
   been placed within the Jcrop widget */
.jcrop-holder #preview-pane {
  display: block;
  position: absolute;
  z-index: 2000;
  top: 10px;
  right: -280px;
  padding: 6px;
  border: 1px rgba(0,0,0,.4) solid;
  background-color: white;

  -webkit-border-radius: 6px;
  -moz-border-radius: 6px;
  border-radius: 6px;

  -webkit-box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
  -moz-box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
  box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
}

/* The Javascript code will set the aspect ratio of the crop
   area based on the size of the thumbnail preview,
   specified here */
#preview-pane .preview-container {
  width: 260px;
  height: 180px;
  overflow: hidden;
}
</style>
<script type="text/javascript">
function log(msg){
	try{
		if(console && console.log) {
			console.log(msg);
		}
	} catch (e) {
		//
	}
}

$(function(){
	
	var handler = setInterval(function(){
		if(document.getElementById("originalImage").complete){
			tryInitCrop();
			clearInterval(handler);
		}
	}, 200);

	function tryInitCrop(){

		// Create variables (in this scope) to hold the API and image size
		var jcrop, boundx, boundy;
	
		// Grab some information about the preview pane
		
		var $preview = $('#preview-pane');
		var $pcnt = $('#preview-pane .preview-container');
		var $pimg = $('#preview-pane .preview-container img');
		var xsize = $pcnt.width();
		var ysize = $pcnt.height();
	
		log('init', [ xsize, ysize ]);
		$('#originalImage').Jcrop({
			onChange : updatePreview,
			onSelect : updatePreview,
			aspectRatio : 76 / 57,
			allowSelect:false
		}, function() {
			// Use the API to get the real image size
			var bounds = this.getBounds();
			boundx = bounds[0];
			boundy = bounds[1];
			// Store the API in the jcrop_api variable
			jcrop = this;
			jcrop.animateTo([0,0,380,180]);
	
			// Move the preview into the jcrop container for css positioning
			//$preview.appendTo(jcrop.ui.holder);
		});
	
		function updatePreview(c) {
			if (parseInt(c.w) > 0) {
				$("#crop_x").val(parseInt(c.x));
				$("#crop_y").val(parseInt(c.y));
				$("#crop_w").val(parseInt(c.w));
				$("#crop_h").val(parseInt(c.h));
				
				var rx = xsize / c.w;
				var ry = ysize / c.h;
	
				$pimg.css({
					width : Math.round(rx * boundx) + 'px',
					height : Math.round(ry * boundy) + 'px',
					marginLeft : '-' + Math.round(rx * c.x) + 'px',
					marginTop : '-' + Math.round(ry * c.y) + 'px'
				});
			}
		 }
	 };
});
</script>
</head>
<body>
<div class="wrapper">
	<jsp:include page="/WEB-INF/views/manage/common/head.jsp" />
	<div class="content">
		  <jsp:include page="/WEB-INF/views/manage/common/left.jsp"/>
		<div class="right">
			<!--[if lt IE 8]><div class="both"></div><![endif]-->
			<div class="main">
				<div class="tit">图片裁剪</div>
				<div class="line">裁剪--科普专家：</div>
				   <div>
	    			<img id="originalImage" src="${contextPath}/${expert.pictureUrl}" alt="..." style="max-width:1215px">
	    		  </div>
				  <div id="preview-pane" style="margin-top:3px;">
					<div class="preview-container">
						<img src="${contextPath}/${expert.pictureUrl}" class="jcrop-preview" alt="Preview" />
					</div>
				</div>
		    	<div style="margin-top: 10px;">
		    		<div>
		    			<form action="${contextPath}/manage/expert/info/submitExpertCrop.rt" method="post">
							<input id="crop_x" name="crop.x" type="hidden" >
							<input id="crop_y" name="crop.y" type="hidden" >
							<input id="crop_w" name="crop.w" type="hidden" >
							<input id="crop_h" name="crop.h" type="hidden">
							<input name="expert.id" type="hidden" value="${expert.id}">
							<input type="hidden" name="viewId" value="${viewId }" />
						    <input type="hidden" name="leftId" value="${leftId }" />
						    <input type="hidden" name="curPage" id="curPage" value="${curPage }"/>
					        <input type="hidden" name="pageSize" id="pageSize" value="${pageSize }"/>
					        <input type="hidden" name="searchName" id="searchName" value="${rt:escapeHtml(searchName)}"/>
					         <input type="hidden" name="channelId" id="channelId" value="${channelId }"/>
							<button id="submitButton"  value="确定"  class="but_fanhui" style="height:24px;border:0px;font-size:14px;color:white;font-weight:bold;float: left;">确定</button>
							<a href="javascript:window.history.back();" class="but_fanhui" style="height:24px;border:0px;font-size:14px;color:white;font-weight:bold;margin-left:100px;">返 回</a>
						</form>
		    		</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>