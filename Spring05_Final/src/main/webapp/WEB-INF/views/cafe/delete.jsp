<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/private/delete.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<div class="container">
	<h1>Alert</h1>
	<p><strong>${dto.writer }</strong>님의 글을 삭제했습니다.</p>
	<a href="list.do"></a>
	
<%-- 	<%if(isSuccess){ %>
		<script>
			alert("<%=num%> 번 글을 삭제했습니다.");
			location.href="../list.jsp"
		</script>
	<%}else{ %>
		<h1>Alert</h1>
		<p class="alert alert-danger">글 삭제 실패 <a class="alert-link" href="../detail.jsp?num=<%=num%>">돌아가기</a></p>
	<%} %>
--%>
</div>
</body>
</html>