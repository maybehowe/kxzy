// JavaScript Document
var formSubmit=function(){
	  if($("#loginName").val()=="" || $("#loginName").val() == null){
	     $("#loginName").focus();
	     $("#msgTip").text("登录名不能为空");
	     return;
	  }
	  var passwd = $("#passWord").val();
	  if(passwd == "" || passwd == null) {
	     $("#passWord").focus();
	     $("#msgTip").text("密码不能为空");
	     return;
	  }
	  var md5s = hex_md5(passwd);
	  if (!md5s) {
	  	return;
	  }
	  $.ajax({
	      url:contextPath+"/front/login/doLogin.rt",
	      data:{"loginName":$("#loginName").val(),
	            "pwd":md5s},
	      beforeSend:function(){
	         $("#msgTip").text("正在登录，请稍候...");
	      },
	      type:"post",
	      dataType:"json",
	      success:function(json){
	         if(json.flag){
	        	 var html='<div class="login" style="background:none;">';
	        	 html+='<a href="#">欢迎 '+json.loginName+' 登录浙江省科普资源共享服务平台！</a>';
	        	 html+='<a href="javascript:loginout()">注销</a>';
	        	 html+='</div>';
	         	$("#login").html(html);
	         } else{
	         	$("#msgTip").text(json.msg);
	         }
	      }
	  });
	};
	
$(function(){
	$("#submit_btn").click(formSubmit);
	$("#loginName").keydown(function (evt){
		 if(evt.keyCode == 13) {
			$("#passWord").focus();
		 }
	});
	$("#passWord").keydown(function (evt){
		 if(evt.keyCode == 13) {
			 formSubmit();
		 }
	});
});

function loginout(){
	  $.ajax({
	      url:contextPath+"/front/login/loginout.rt",
	      beforeSend:function(){
	         $("#msgTip").text("正在注销，请稍候...");
	      },
	      type:"post",
	      dataType:"json",
	      success:function(json){
	         window.location.reload();
	      }
	  });
}