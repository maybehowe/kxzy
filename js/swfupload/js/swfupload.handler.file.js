function fileSWFPreLoad() {
}
function fileSWFLoadFailed() {
	window.location.href = basePath + "common/prompt/unInstallFlash.jsp"
}
function fileBrowsed(file) {
	try {
		var currentFileId = file.id;
		var stats = this.getStats();
		var fileId;
		while (stats.files_queued > 1) {
			fileId = this.getFile().id;
			if (fileId != currentFileId) {
				stats.files_queued--;
				this.setStats(stats);
				this.cancelUpload(fileId, false)
			}
		}
		fileProgress(file, this)
	} catch (ex) {
		this.debug(ex)
	}
}
function fileBrowseError(file, errorCode, message) {
	try {
		fileProgress(file, this);
		var errInfo = getFileValidateErrorInfo(file, errorCode, message, this);
		updateFileDisplay(this.customSettings.targetErrorClassName, errInfo,
				this.customSettings.myFileListTarget);
		this.cancelUpload(file.id)
	} catch (ex) {
		this.debug(ex)
	}
}
function fileProgress(file, swfUploadInstance) {
	if (swfUploadInstance) {
		var fileId = file.id;
		if (!document.getElementById(fileId)) {
			var innerhtml = "<ul id='" + fileId + "_status'>" + "<li>"
					+ file.name.sub(20, '...') + "</li>" + "<li>"
					+ "<div class=\"pbBox\">"
					+ "<div class=\"pbar\"><span style=\"width: 0px;\" id='"
					+ fileId + "_bar'>&nbsp;</span></div>" + "<cite id='"
					+ fileId + "_singleFilePercent'>0.00%</cite>" + "</div>"
					+ "</li>" + "<li><a id=\"" + fileId
					+ "_del\" href=\"javascript:;\" title=\"\">取消</a></li>"
					+ "</ul>";
			updateFileDisplay("", innerhtml,
					swfUploadInstance.customSettings.myFileListTarget);
			var delObject = document.getElementById(fileId + "_del");
			delObject.onclick = function() {
				swfUploadInstance.cancelUpload(fileId);
				updateFileDisplay("", "",
						swfUploadInstance.customSettings.myFileListTarget)
			}
		}
	}
}
function fileDialogComplete(numFilesSelected, numFilesQueued) {
	try {
		if (this.settings.auto_upload) {
			this.startUpload()
		}
	} catch (ex) {
		this.debug(ex)
	}
}
function fileUploadStart(file) {
}
function fileUploadProgress(file, bytesLoaded, bytesTotal) {
	try {
		var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);
		var fileId = file.id;
		var bar = document.getElementById(fileId + "_bar");
		bar.style.width = percent + "px";
		var delObject = document.getElementById(fileId + "_del");
		if (delObject) {
			delObject.style.display = "none"
		}
		document.getElementById(fileId + "_singleFilePercent").innerHTML = SWFUpload.speed
				.formatPercent(file.percentUploaded)
	} catch (ex) {
		this.debug(ex)
	}
}
function fileUploadSuccess(file, serverData) {
	try {
		var fileId = file.id;
		if (serverData == "success") {
			updateFileDisplay(this.customSettings.targetSuccessClassName,
					this.customSettings.targetSuccessInnerHTML,
					this.customSettings.myFileListTarget)
		} else {
			this.cancelUpload(fileId, false);
			var stats = this.getStats();
			if (stats.successful_uploads > 0) {
				stats.successful_uploads--;
				this.setStats(stats)
			}
			window.document.write(serverData);
			window.document.close()
		}
	} catch (ex) {
		this.debug(ex)
	}
}
function fileUploadError(file, errorCode, message) {
	alert(errorCode);
	var errInfo = getFileUploadErrorInfo(file, errorCode, message, this);
	updateFileDisplay(this.customSettings.targetErrorClassName, errInfo,
			this.customSettings.myFileListTarget);
	this.cancelUpload(file.id)
}
function fileUploadComplete(file) {
}
function fileComplete(numFilesUploaded) {
	if (this.customSettings.onCompleteFunction) {
		new this.customSettings.onCompleteFunction()
	}
}
function updateFileDisplay(className, innerHTML, targetId) {
	var logoFileList = document.getElementById(targetId);
	logoFileList.className = className;
	logoFileList.innerHTML = innerHTML
}