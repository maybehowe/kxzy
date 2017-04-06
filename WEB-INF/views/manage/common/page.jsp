<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
/*<![CDATA[*/
var fName = "<%=request.getParameter("formName") %>";
var pageUrl = "<%=request.getParameter("pageUrl") %>";
$(function(){
	$("#pageNum").keydown(function(evt){
		if(evt.keyCode == 13){
			goPage();
		}
	});
	$("#goPage").click(function(){
		goPage();
	});
})
function pageFormSubmit(){
	$("#"+fName).attr("action",pageUrl);
	$("#"+fName).submit();
}
function homeOrLast(count){
	$("#curPage").val(count);
	pageFormSubmit();
}
function prevPage(curPage){
	if(curPage==1){
		$("#curPage").val(1);
	} else{
		$("#curPage").val(curPage-1);
	}
	pageFormSubmit();
}
function nextPage(curPage, pageCount){
	if(curPage==pageCount){
		$("#curPage").val(pageCount);
	} else{
		$("#curPage").val(curPage+1);
	}
	pageFormSubmit();
}
function goPage(){
	var count = ${page.pageCount};
	var num = $("#pageNum").val();
	var reg = /^[0-9]*[1-9][0-9]*$/;
	if(reg.test(num)){
		if(num >= count){
			$("#curPage").val(count);
		} else {
			$("#curPage").val(num);
		}
		pageFormSubmit();
	} else{
		alert("请输入大于0的正整数");
	}
}
/*]]>*/
</script>
<div class="page_div">
	<a href="javascript:void(0)" onclick="homeOrLast(1);" class="home"></a>
	<a href="javascript:void(0)" onclick="prevPage(${page.curPage});" class="prev"></a>
	<div class="fl">&nbsp;&nbsp;${page.curPage} / ${page.pageCount==0 ? 1 : page.pageCount }</div>
	<a href="javascript:void(0)" onclick="nextPage(${page.curPage},${page.pageCount});" class="next"></a>
	<a href="javascript:void(0)" onclick="homeOrLast(${page.pageCount});" class="last"></a>
	<div class="fl">&nbsp;　　跳转至第&nbsp;<input type="text" id="pageNum" class="text" maxlength="4" />&nbsp;页&nbsp;</div>
	<a href="javascript:void(0)" id="goPage" class="go"></a>
</div>
