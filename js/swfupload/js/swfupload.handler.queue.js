var basePath = (document.getElementsByTagName("base")[0]) ? document
		.getElementsByTagName("base")[0].href : "/";
function queueSWFPreLoad() {
}
function queueSWFLoaded() {
	var self = this;
	if (this.customSettings.cancelButtonId) {
		document.getElementById(this.customSettings.cancelButtonId).onclick = function() {
			self.cancelQueue();
			return false
		}
	}
	if (this.customSettings.clearButtonId) {
		document.getElementById(this.customSettings.clearButtonId).onclick = function() {
			self.clearQueue();
			return false
		}
	}
}
function queueSWFLoadFailed() {
	window.location.href = basePath + "common/prompt/unInstallFlash.jsp"
}
function fileQueued(file) {
	try {
		queueProgress(file, this.customSettings.myFileListTarget, this)
	} catch (ex) {
		this.debug(ex)
	}
}
function fileQueueError(file, errorCode, message) {
	try {
		if (errorCode == SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED) {
			var errMsg = "您的上传队列中有太多的文件！"
					+ (message == 0 ? "您已达到上传限制！" : "您最多可以"
							+ (message > 1 ? "上传" + message + "个文件." : "1个文件."));
			alert(errMsg);
			return false
		}
		queueProgress(file, this.customSettings.myFileListTarget, this);
		var tr = document.getElementById(file.id);
		tr.className = this.customSettings.targetErrorClassName;
		var status = document.getElementById(file.id + "_status");
		status.className = this.customSettings.targetErrorClassName;
		var errInfo = getFileValidateErrorInfo(file, errorCode, message, this);
		status.innerHTML = errInfo;
		this.cancelUpload(file.id)
	} catch (ex) {
		this.debug(ex)
	}
}
function queueProgress(file, fileListID, swfUploadInstance) {
	if (swfUploadInstance) {
		var fileId = file.id;
		var stats = swfUploadInstance.getStats();
		if (!document.getElementById(fileId)) {
			if (document.getElementById(fileListID + "Count"))
				document.getElementById(fileListID + "Count").innerHTML = stats.files_queued;
			var tb = document.getElementById(fileListID);
			var tr = tb.insertRow(-1);
			tr.setAttribute("id", fileId);
			var td;
			td = tr.insertCell(-1);
			td.className = 'tit';
			td.innerHTML = file.name.sub(20, '...');
			td = tr.insertCell(-1);
			if (file.size) {
				td.innerHTML = getFormatFileSize(file.size)
			} else {
				td.innerHTML = "0B"
			}
			td = tr.insertCell(-1);
			td.setAttribute("id", fileId + "_status");
			td.innerHTML = "<span id='" + fileId + "_msg'>等待上传</span>"
					+ "<div class=\"pbBox\">"
					+ "<div class=\"pbar\"><span style=\"width:0px;\" id='"
					+ fileId + "_bar'>&nbsp;</span></div>" + "<cite id='"
					+ fileId + "_singleFilePercent'>0.00%</cite>" + "</div>";
			td = tr.insertCell(-1);
			td.innerHTML = "<a id='" + fileId
					+ "_del' href=\"javascript:;\" title=\"移除\">移除</a>";
			var delObject = document.getElementById(fileId + "_del");
			delObject.onclick = function() {
				swfUploadInstance.cancelUpload(fileId);
				if (document.getElementById(fileListID + "Count"))
					document.getElementById(fileListID + "Count").innerHTML = swfUploadInstance
							.getStats().files_queued;
				var table = tr.parentNode;
				table.deleteRow(tr.rowIndex)
			}
		}
	}
}
function queueFileDialogComplete(numFilesSelected, numFilesQueued) {
	try {
		if (this.settings.auto_upload) {
			this.startUpload()
		}
	} catch (ex) {
		this.debug(ex)
	}
}
function queueFileUploadStart(file) {
	try {
		var fileId = file.id;
		if (this.customSettings.waterCheckId) {
			if (document.getElementById(this.customSettings.waterCheckId)) {
				var withWater = (document
						.getElementById(this.customSettings.waterCheckId).checked == true) ? true
						: false;
				this.addPostParam("fileOptions.withWater", withWater)
			}
		}
		if (this.customSettings.waterTypeSelectId) {
			var waterType = document
					.getElementById(this.customSettings.waterTypeSelectId);
			if (waterType) {
				this.addPostParam("fileOptions.waterType", waterType.value)
			}
		}
		if (this.customSettings.waterLocationSelectId) {
			var waterLocation = document
					.getElementById(this.customSettings.waterLocationSelectId);
			if (waterLocation) {
				this.addPostParam("fileOptions.waterLocation",
						waterLocation.value)
			}
		}
		var tr = document.getElementById(fileId);
		tr.className = this.customSettings.targetProcessClassName
	} catch (ex) {
		this.debug(ex)
	}
	return true
}
function queueFileUploadProgress(file, bytesLoaded, bytesTotal) {
	try {
		var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);
		var msg = document.getElementById(file.id + "_msg");
		msg.innerHTML = "上传中...";
		var bar = document.getElementById(file.id + "_bar");
		bar.style.width = percent + "px";
		var delObject = document.getElementById(file.id + "_del");
		if (delObject) {
			delObject.parentNode.innerHTML = "&nbsp;"
		}
		document.getElementById(file.id + "_singleFilePercent").innerHTML = SWFUpload.speed
				.formatPercent(file.percentUploaded);
		updateQueueFileDisplay.call(this, file)
	} catch (ex) {
		this.debug(ex)
	}
}
function queueFileUploadSuccess(file, serverData) {
	try {
		var fileId = file.id;
		if (serverData == "success") {
			var tr = document.getElementById(fileId);
			tr.className = this.customSettings.targetSuccessClassName;
			var status = document.getElementById(fileId + "_status");
			status.innerHTML = "上传成功";
			status.className = this.customSettings.targetSuccessClassName;
			var delObject = document.getElementById(fileId + "_del");
			if (delObject) {
				delObject.parentNode.innerHTML = "&nbsp;"
			}
		} else {
			this.cancelUpload(fileId, false);
			var stats = this.getStats();
			if (stats.successful_uploads > 0) {
				stats.successful_uploads--;
				this.setStats(stats)
			}
			var tr = document.getElementById(fileId);
			tr.className = this.customSettings.targetErrorClassName;
			var status = document.getElementById(fileId + "_status");
			if (serverData == "overLimit") {
				status.innerHTML = "上传失败:超出最多上传数量限制!"
			} else {
				window.document.write(serverData);
				window.document.close()
			}
			status.className = this.customSettings.targetErrorClassName
		}
	} catch (ex) {
		this.debug(ex)
	}
	if (document.getElementById(this.customSettings.myFileListTarget + "Count"))
		document.getElementById(this.customSettings.myFileListTarget + "Count").innerHTML = this
				.getStats().files_queued;
	if (document.getElementById(this.customSettings.myFileListTarget
			+ "SuccessUploadCount"))
		document.getElementById(this.customSettings.myFileListTarget
				+ "SuccessUploadCount").innerHTML = this.getStats().successful_uploads;
	updateQueueFileDisplay.call(this, file)
}
function queueFileuploadError(file, errorCode, message) {
	try {
		var tr = document.getElementById(file.id);
		if (tr)
			tr.className = this.customSettings.targetErrorClassName;
		var status = document.getElementById(file.id + "_status");
		if (status) {
			var errInfo = getFileUploadErrorInfo(file, errorCode, message, this);
			status.className = this.customSettings.targetErrorClassName;
			status.innerHTML = errInfo
		}
		this.cancelUpload(file.id)
	} catch (ex) {
		this.debug(ex)
	}
}
function queueFileUploadComplete(file) {
}
function queueComplete(numFilesUploaded) {
	if (document.getElementById(this.customSettings.myFileListTarget
			+ "SuccessUploadCount"))
		document.getElementById(this.customSettings.myFileListTarget
				+ "SuccessUploadCount").innerHTML = this.getStats().successful_uploads;
	if (this.customSettings.onCompleteFunction) {
		new this.customSettings.onCompleteFunction()
	}
}
function updateQueueFileDisplay(file) {
	if (this.customSettings.tdPercentUploaded)
		document.getElementById(this.customSettings.tdPercentUploaded).innerHTML = SWFUpload.speed
				.formatPercent(file.percentUploaded);
	if (this.customSettings.tdCurrentSpeed)
		document.getElementById(this.customSettings.tdCurrentSpeed).innerHTML = SWFUpload.speed
				.formatBPS(file.currentSpeed);
	if (this.customSettings.tdSizeUploaded)
		document.getElementById(this.customSettings.tdSizeUploaded).innerHTML = SWFUpload.speed
				.formatBytes(file.sizeUploaded);
	if (this.customSettings.tdTimeElapsed)
		document.getElementById(this.customSettings.tdTimeElapsed).innerHTML = SWFUpload.speed
				.formatTime(file.timeElapsed);
	if (this.customSettings.tdTimeRemaining)
		document.getElementById(this.customSettings.tdTimeRemaining).innerHTML = SWFUpload.speed
				.formatTime(file.timeRemaining)
}