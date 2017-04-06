<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript" src="${contextPath}/js/swfupload/swfupload.js"></script>
<script type="text/javascript" src="${contextPath}/js/swfupload/js/handlers.js"></script>
<script type="text/javascript" src="${contextPath}/js/swfupload/swfupload.swfobject.js"></script>
<script type="text/javascript" src="${contextPath}/js/swfupload/swfupload.speed.js"></script>
<script type="text/javascript" src="${contextPath}/js/swfupload/swfupload.fileUtil.js"></script>
<script type="text/javascript" src="${contextPath}/js/swfupload/swfupload.queue.js"></script>
<script type="text/javascript" src="${contextPath}/js/swfupload/js/swfupload.handler.file.js"></script>
<script type="text/javascript" src="${contextPath}/js/swfupload/js/swfupload.handler.queue.js"></script>
<script type="text/javascript">
	//<![CDATA[
	var swfu_certificationFile;
	$(function() {
		var settings_certificationFile = {
			flash_url : "${contextPath}/js/swfupload/swfupload.swf",
			upload_url : "${contextPath}/manage/upload/museumUpload.rt?time="+ new Date().getTime(),
			use_query_string : true,
			post_params: {"id" : "${id}","jsessionid":"<%=session.getId()%>"},
			file_post_name : "fileOptions.file",
			file_size_limit : "1 GB",
			file_types : "*.mp4;*.rmvb;*.avi;*.wmv;*.mpg",
			file_types_description : "视频",
			file_upload_limit : 1,
			file_queue_limit : 0,
			debug : false,
			auto_upload : false,
			button_placeholder_id : "certification_picture",
			button_width : 70,
			button_height : 25,
			button_text : '添加文件',
			button_text_top_padding : 8,
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
				cancelButtonId : "certification_btnCancel",
				clearButtonId : "certification_btnClear",
				myFileListTarget : "certification_picture_target",
				targetProcessClassName : "blue",
				targetErrorClassName : "red",
				targetSuccessClassName : "green",
				targetSuccessInnerHTML : "上传成功"
			}
		};
		swfu_certificationFile = new SWFUpload(settings_certificationFile);
	});
	function checkCertificationFile(){
		//浏览了图片就通过
		var file = null;
   		try{file = swfu_certificationFile.getFile();}catch(e){}
   		if(file!=null)return true;
   		//验证
		if(certId==null||certId==""){
    		return (file==null)? false : true;
		}else{
			var bool = true;
			$.ajax({
		         type: "POST",
		         url: "brand_sys/certification/getAccessoriesCount.shtml",
		         data: {"certification.certId":certId},
		         async: false,
		         success:function(result){
		         	if(checkAjaxRequestValidity(result)){
		         		bool = (result>0)?true:false;
		         	}
		         }
		    });
			return bool;
		}
		return true;
	}
	$(function(){
		//Default Action
		$("#pictureView_certification .tab_con").hide(); //Hide all content
		$("#pictureView_certification div.tabs li:first").addClass("active").show(); //Activate first tab
		$("#pictureView_certification .tab_con:first").show(); //Show first tab content
		//On Click Event
		$("#pictureView_certification div.tabs li").click(function() {
			var self = $(this);
			var _switchTab = function(){
				$("#pictureView_certification div.tabs li").removeClass("active"); //Remove any "active" class
				self.addClass("active"); //Add "active" class to selected tab
				$("#pictureView_certification .tab_con").hide(); //Hide all tab content
				var activeTab = self.find("a").attr("rel"); //Find the rel attribute value to identify the active tab + content
				$(activeTab).fadeIn(0); //Fade in the active content
			}
			if($("#certification_tab2").is(":visible")){
				var file = swfu_certificationFile.getFile();
				if(file!=null){
					$.confirmInfo("您还有未上传的文件,切换或者刷新选项卡将丢失待上传的文件,确定要切换吗？",{onOk:function(){
						$("#certification_btnClear").click();
						_switchTab();
					}});
				}else{
					_switchTab();
				}
			}else{
				_switchTab();
			}
		});
	});
	function certificationPictureStartUpload(){
		swfu_certificationFile.customSettings.onCompleteFunction="";
		swfu_certificationFile.startUpload();
	}
	//]]>
</script>
<style>
.red{ color: red;}
.green{color:green;}
.blue{ color:blue;}
#certification_picture_target th{ padding:5px; font-weight:700;}
#certification_picture_target td{ padding:5px;}
</style>
<div id="pictureView_certification" class="ip">
	<div class="tabBox" style="width: 100%;">
		<div class="tabs">
			<ul>
				<li><span><a rel="#certification_tab2" title="上传图片">上传视频</a></span></li>
			</ul>
		</div>
		<div class="con">
			<div id="certification_tab2" class="tab_con tabli uppic">
				<div class="clew" style=" margin-top: 10px;">
					<ul>
						<input type="hidden" id="sessionid" name="sessionid" value="<%=session.getId()%>"/>
						<li>只支持<span class="red">mp4、rmvb、avi、wmv、mpg</span>格式视频。</li>
						<li>最多可上传<span class="red">1个</span>，单个最大<span class="red">1GB</span></li>
						<li>在文件大于1G的时候会有延时，请稍等...</li>
					</ul>
				</div> 
				<table id="certification_picture_target" width="60%" style=" margin-top: 10px;" border="1">
					<tr>
						<th style="text-align: left;" width="40%">文件名</th>
						<th style="text-align: left;" class="w100" width="15%">文件大小</th>
						<th style="text-align: left;" class="w175" width="35%">状态</th>
						<th style="text-align: left;" class="w60" width="10%">操作</th>
					</tr>
				</table>
				<div class="tb_n">
					<div class="but4">
						<span id="certification_picture" class="add_but"></span>
						<a id="certification_btnClear" href="javascript:;" title="清空图片">清空视频</a>
						<a href="javascript:;" onclick="certificationPictureStartUpload();return false;" title="开始上传">开始上传</a>
						<a id="certification_btnCancel" href="javascript:;" title="取消上传">取消上传</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="clear"></div>
</div>
