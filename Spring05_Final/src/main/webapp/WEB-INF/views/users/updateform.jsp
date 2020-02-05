<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../include/resource.jsp"/>
<title>/users/updateform.jsp</title>
</head>
<body>
<div class="container">
	<h1>회원정보 수정 폼</h1>
	<form action="update.do" method="post">
		<input type="hidden" name="id" value="${id}" />
		<div class="form-group">
			<label for="id">아이디</label>
			<input class="form-control" type="text" name="id" value="${id} " disabled />
		</div>
		<div class="form-group">
			<label for="email">이메일</label>
			<input class="form-control" type="text" id="email" name="email"
				value="${dto.email }" />
		</div>
		<button class="btn btn-primary" type="submit">수정확인</button>
		<button class="btn btn-primary" type="reset">취소</button>
	</form>
</div>
</body>
</html>