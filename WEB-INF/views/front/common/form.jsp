<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="rt" uri="http://www.roots.com/tags/commons"%>
<c:if test="${formJspIncluded != 'included'}">
	<c:set var="formJspIncluded" value="included" scope="request"></c:set>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<script type="text/javascript">var contextPath="${contextPath}";</script>
	<script type="text/javascript" src="${contextPath}/js/jquery-1.7.2.min.js"></script>
	<script src="${contextPath }/front/js/md5.js" type="text/javascript"></script>
	<script src="${contextPath }/front/js/login.js" type="text/javascript"></script>
</c:if>