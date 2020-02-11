<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/home.jsp</title>
<jsp:include page="include/resource.jsp"/>
</head>
<body>
<jsp:include page="include/navbar.jsp"/>
<div class="container">
	<h1>왕언니가 남기고간 선물</h1>
	<ul>
		<li><a href="member/list.do">회원 목록보기(member table)</a></li>
		<li><a href="angular/test01.html">angularjs Test</a></li>
	</ul>
	<h2>공지사항</h2>
	<ul>
		<c:forEach var="tmp" items="${requestScope.notice }" >
			<li>${tmp }</li>		
		</c:forEach>
	</ul>
</div>
</body>
</html>
