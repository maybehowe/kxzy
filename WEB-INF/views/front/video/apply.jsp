<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <%@include file="../common/form.jsp" %>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="x-ua-compatible" content="ie=7" />
    <title>填写所有权仲裁申请-信息管理</title>
  </head>
  
  <body>
	<div class="spMain arb">
		<div class="mtit"><strong>填写所有权仲裁申请</strong></div>
		<div class="con">
			<div class="part1">
				<div class="ctit"><strong>品牌名称：</strong><div><span class="redb"></span>&nbsp;<span class="grey">（当前所有者：）</span></div></div>
			</div>
			<div class="part2">
				<div class="ctit"><strong>我的申请信息：</strong><em>加<span class="red">*</span>为必填信息</em></div>
				<div class="form">
					<form id="contentForm" action="brand_member/arbitration/saveArbitration.shtml" method="post">
						<ul>
							<li class="edi">
								<label><span class="red">*</span>申请说明：</label>
								<div class="ediBox"><textarea id="applDes" name="arbitration.applDes" cols="" rows="8"></textarea></div>
							</li>
							<li class="edi">
								<label><span class="red">*</span>证明材料：</label>
								<div class="ediBox">
									<div class="ip">
										<div class="uptp">
											<div class="con">
												<div class="clew">
													<ul>
														<li>只支持<span class="red">gif、jpeg、jpg、bmp、png</span>格式图片。</li>
														<li>最多可上传<span class="red">5张</span>，单张最大<span class="red">500KB</span>，按住Ctrl或Shift键可同时选择多张。</li>
													</ul>
												</div>
												<div class="tabli uppic">
													<table id="brand_arbitration_picture_target">
														<tr>
															<th>文件名</th>
															<th class="w100">文件大小</th>
															<th class="w175">状态</th>
															<th class="w60">操作</th>
														</tr>
													</table>
													<div class="tb_n">
														<div class="but4">
															<a href="javascript:;" title="添加图片"><span id="brand_arbitration_picture"></span></a>
															<a id="btnClear" href="javascript:;" title="清空图片">清空图片</a>
															<a id="btnCancel" href="javascript:;" title="取消上传">取消上传</a>
														</div>
													</div>
												</div>
											</div>											
										</div>
										<div class="clear"></div>
									</div>
								</div>	
							</li>
						</ul>
						<input type="hidden" name="arbitration.ownerUserId" value="" />
						<input type="hidden" name="arbitration.brandId" value="" />
						<div class="sbbar">
							<div class="sbut" style="width:220px;">
								<div class="sbBox"><span><input type="submit" value="提交保存" /></span></div>
								<div class="sbBox"><span><input type="button" onclick="window.close();" value="关闭页面" /></span></div>
							</div>
						</div>
						<s:token></s:token>
					</form>
					<div class="clear"></div>
				</div>
			</div>
		</div>
<%--	</div>--%>
<%--	<script type="text/javascript" src="plugin/jquery/jquery.js"></script>--%>
<%--	<script type="text/javascript" src="common/js/ajaxInterceptor.js"></script>--%>
<%--	<script type="text/javascript" src="plugin/jquery/jquery.form.js"></script>--%>
	<!-- SWFUpload -->
	<script type="text/javascript" src="${contextPath }/front/SWFUpload/swfupload.js"></script>
	<script type="text/javascript" src="${contextPath }/front/SWFUpload/swfupload.swfobject.js"></script>
	<script type="text/javascript" src="${contextPath }/front/SWFUpload/swfupload.speed.js"></script>
	<script type="text/javascript" src="${contextPath }/front/SWFUpload/swfupload.fileUtil.js"></script>
	<script type="text/javascript" src="${contextPath }/front/SWFUpload/swfupload.queue.js"></script>
	<script type="text/javascript" src="${contextPath }/front/SWFUpload/swfupload.handler.queue.js"></script>
<%--	<script type="text/javascript" src="common/js/String.prototype.js"></script>--%>
<%--	<script src="plugin/jquery/lhgdialog/lhgdialog.js" type="text/javascript"></script>--%>
<%--	<script src="plugin/jquery/lhgdialog/lhgdialog.ui.js" type="text/javascript"></script>--%>
	<script type="text/javascript">
		//<![CDATA[
		var swfu_arbitrationFile;
		$(function() {
			var settings_arbitrationFile = {
				flash_url : "${contextPath }/front/SWFUpload/swfupload.swf",
				upload_url : "${contextPath }/brand_member/arbitration/uploadAccessories.shtml;jsessionid=<%=session.getId()%>",
				use_query_string : false,
				file_post_name : "fileOptions.file",
				file_size_limit : "500 KB",
				file_types : "*.gif;*.jpeg;*.jpg;*.bmp;*.png;",
				file_types_description : "图片",
				file_upload_limit : 5,
				file_queue_limit : 0,
				debug : false,
				auto_upload : false,
				button_placeholder_id : "brand_arbitration_picture",
				button_width : 70,
				button_height : 25,
				button_text : '添加图片',
				button_text_top_padding : 3,
				button_text_left_padding : 10,
				button_cursor : SWFUpload.CURSOR.HAND,
				button_action : SWFUpload.BUTTON_ACTION.SELECT_FILES,
				swfupload_loaded_handler : queueSWFLoaded,
				file_queued_handler : fileQueued,
				file_queue_error_handler : fileQueueError,
				file_dialog_complete_handler : queueFileDialogComplete,
				upload_start_handler : queueFileUploadStart,
				upload_progress_handler : queueFileUploadProgress,
				upload_error_handler : queueFileuploadError,
				upload_success_handler : queueFileUploadSuccess,
				upload_complete_handler : queueFileUploadComplete,
				queue_complete_handler : queueComplete,
				swfupload_pre_load_handler : queueSWFPreLoad,
				swfupload_load_failed_handler : queueSWFLoadFailed,
				custom_settings : {
					cancelButtonId : "btnCancel",
					clearButtonId : "btnClear",
					myFileListTarget : "brand_arbitration_picture_target",
					targetProcessClassName : "blue",
					targetErrorClassName : "red",
					targetSuccessClassName : "green",
					targetSuccessInnerHTML : "上传成功",
					onCompleteFunction : startUpload
				}
			};
			swfu_arbitrationFile = new SWFUpload(settings_arbitrationFile);
		});
		function showResponse(responseText, statusText, xhr, $form) {
    		if(checkAjaxRequestValidity(responseText)){
			    if(responseText && responseText != null){
			    	$.processInfo("信息提交完毕,正在上传附件...");
			    	swfu_arbitrationFile.addPostParam("arbitration.arbiId", responseText);
			    	startUpload();
			    }else{
			    	$.errorInfo("信息提交失败!");
			    }
			}
		}
    	$(function() {
	    	var options = {
		        success:       showResponse
		    };
    		$("#contentForm").submit(function() {
		        var applDes=document.getElementById("applDes");
				if(applDes.value.trim()==""){
					$.alertInfo("请填写申请说明!", {onOk: function(){applDes.focus()}});
					return false;
				}
				if(applDes.value.len()>=1000){
					$.alertInfo("申请说明请限制在1000字符或500汉字以内!", {onOk: function(){applDes.focus()}});
					return false;
				}
				var file=null;
				try{file=swfu_arbitrationFile.getFile();}catch(e){}
				if(file==null){
					$.alertInfo("请上传证明材料!");
					return false;
				}
				$.processInfo("信息正在提交...");
		        $(this).ajaxSubmit(options); 
		        return false;
		    }); 
	    });
		function startUpload() {
			var file=null;
			try{file=swfu_arbitrationFile.getFile();}catch(e){}
			if(file != null){
				swfu_arbitrationFile.startUpload();
			}else{
				$.successInfo("申请仲裁成功!点击”确定“关闭页面", {onOk: function (){window.close()}});
			}
		}
		//]]>
	</script>
  </body>
</html>