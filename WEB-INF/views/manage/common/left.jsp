<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="left">
	<c:forEach items="${rrres }" var="rrr">
		<c:if test="${rrr.resId==resLeft.id }">
			<div class="tit">${resLeft.resName }</div>
			<div class="nr">
				<c:forEach items="${resLeft.childs }" var="child">
					<c:forEach items="${rrres }" var="rrr2">
						<c:if test="${child.id==rrr2.resId }">
							<div <c:if test="${child.id==leftId }"> class="sl"</c:if>>
							<a href="javascript:void(0);" onclick="addLeft(${resLeft.id},${child.id},'${contextPath }${child.resUrl}')">${child.resName }</a>
							</div>
						</c:if>
					</c:forEach>
				</c:forEach>
			</div>
		</c:if>
	</c:forEach>
</div>
