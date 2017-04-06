<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var fName = "<%=request.getParameter("formName") %>";
var pageUrl = "<%=request.getParameter("pageUrl") %>";
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
function pageFormSubmit(){
	$("#"+fName).attr("action",pageUrl);
	$("#"+fName).submit();
}
function jumpPage(curPage, pageSize){
	$("#curPage").val(curPage);
	$("#pageSize").val(pageSize);
	pageFormSubmit();
}
</script>
<div class="fy">
	<a href="javascript:void(0);" class="prev" onclick="prevPage(${curPage});">&lt;</a>
	<c:if test="${page.pageCount>0 }">
		<c:if test="${page.pageCount<=7 }">
			<c:forEach begin="1" end="${page.pageCount }" var="num">
				<a href="javascript:void(0);"<c:if test="${page.curPage!=num }"> onclick="jumpPage(${num },${page.pageSize });"</c:if><c:if test="${page.curPage==num }"> class="sel"</c:if>>${num }</a>
			</c:forEach>
		</c:if>
		<c:if test="${page.pageCount>7 }">
			<c:if test="${page.curPage<=4 }">
			<c:forEach begin="1" end="7" var="num">
					<a href="javascript:void(0);"<c:if test="${page.curPage!=num }"> onclick="jumpPage(${num },${page.pageSize });"</c:if><c:if test="${page.curPage==num }"> class="sel"</c:if>>${num }</a>
				</c:forEach>
			</c:if>
			<c:if test="${page.curPage>4 }">
				<c:if test="${(page.curPage+3) <=(page.pageCount-1) }">
					<c:forEach begin="${page.curPage-3 }" end="${page.curPage+3 }" var="num">
						<a href="javascript:void(0);"<c:if test="${page.curPage!=num }"> onclick="jumpPage(${num },${page.pageSize });"</c:if><c:if test="${page.curPage==num }"> class="sel"</c:if>>${num }</a>
					</c:forEach>
				</c:if>
				<c:if test="${(page.curPage+3) >(page.pageCount-1) }">
					<c:forEach begin="${page.pageCount-6 }" end="${page.pageCount}" var="num">
						<a href="javascript:void(0);"<c:if test="${page.curPage!=num }"> onclick="jumpPage(${num },${page.pageSize });"</c:if><c:if test="${page.curPage==num }"> class="sel"</c:if>>${num }</a>
					</c:forEach>
				</c:if>
			</c:if>
		</c:if>
	</c:if>
	<c:if test="${page.pageCount==0 }">
	<a href="javascript:void(0);" class="hover">1</a>
	</c:if>
	<a href="javascript:void(0);" class="next" onclick="nextPage(${curPage},${page.pageCount });">&gt;</a>
	<div class="cb"></div>
</div>
