//onblur 鼠标移出失去焦点事件
//onfocus 鼠标移入获取焦点事件

/* ******************************************
*	验证用户名
* *******************************************/
function onblur_username() {
    var val = document.getElementById("txtUserName").value;
    if (val.length == 0) {
        document.getElementById('username_notice').innerHTML = "X";
        return false;
    }

    var err = 0;

    var reg = /^[0-9a-zA-Z]*$/;
    if (reg.test(val)) {
        err = 1;
    }

    if (err == 0) {
        document.getElementById('username_notice').innerHTML = "X";
        return false;
    }
    else {
        document.getElementById('username_notice').innerHTML = "√";
        return true;
    }
}

/* ******************************************
*	验证密码
* *******************************************/
function onblur_pass1() {
    var val = document.getElementById("txtPass1").value;
    if (val.length == 0) {
        document.getElementById('pass1_notice').innerHTML = "X";
        return false;
    }
    else{
        document.getElementById('pass1_notice').innerHTML = "√";
        return true;
    }
}
function onblur_pass2() {
    var pass1 = document.getElementById("txtPass1").value;
    var pass2 = document.getElementById("txtPass2").value;
    if (pass1 != pass2) {
        document.getElementById('pass2_notice').innerHTML = "X";
        return false;
    }
    else {
        document.getElementById('pass2_notice').innerHTML = "√";
        return true;
    }
}

/* ******************************************
*	备注不能为空
* *******************************************/
function onblur_class() {
    var val = document.getElementById("txtClass").value;
    if (val.length == 0) {
        document.getElementById('class_notice').innerHTML = "X";
        return false;
    }
    else{
        document.getElementById('class_notice').innerHTML = "√";
        return true;
    }
}

/* ******************************************
*	手机验证
* *******************************************/
function onblur_photo() {
    var val = document.getElementById("txtPhoto").value;
	if (val.length == 0) {
        document.getElementById("txtPhoto").value = "";
        document.getElementById('photo_notice').innerHTML = "";
        return true;
    }
    var err = 0;
    var reg = /^[0-9]+.?[0-9]*$/;
    if (reg.test(val)) {
        err = 1;
    }
    if (err == 0) {
        document.getElementById('photo_notice').innerHTML = "X";
        return false;
    }
    else {
        document.getElementById('photo_notice').innerHTML = "√";
        return true;
    }
}


/* ******************************************
*	电话验证
* *******************************************/
function onblur_photo2() {
    var val = document.getElementById("txtPhoto2").value;
	if (val.length == 0) {
        document.getElementById("txtPhoto2").value = "";
        document.getElementById('photo2_notice').innerHTML = "";
        return true;
    }
    var err = 0;
    var reg = /^[0-9]+.?[0-9]*$/;
    if (reg.test(val)) {
        err = 1;
    }
    if (err == 0) {
        document.getElementById('photo2_notice').innerHTML = "X";
        return false;
    }
    else {
        document.getElementById('photo2_notice').innerHTML = "√";
        return true;
    }
}


/* ******************************************
*	验证邮箱
* *******************************************/
function onblur_email() {
    var val = document.getElementById("txtEmail").value;
	if (val.length == 0) {
        document.getElementById("txtEmail").value = "";
        document.getElementById('email_notice').innerHTML = "";
        return true;
    }
    var err = 0;
    var reg = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)/;
    if (reg.test(val)) {
        err = 1;
    }
    if (err == 0) {
        document.getElementById('email_notice').innerHTML = "X";
        return false;
    }
    else {
        document.getElementById('email_notice').innerHTML = "√";
        return true;
    }
}


/* ******************************************
*	submit验证
* *******************************************/
function submit_lo() {
    if (onblur_username() && onblur_pass1() && onblur_pass2() && onblur_class() && onblur_photo() && onblur_photo2() && onblur_email()) {
        return true;
    }
    else {
        return false;
    }
}