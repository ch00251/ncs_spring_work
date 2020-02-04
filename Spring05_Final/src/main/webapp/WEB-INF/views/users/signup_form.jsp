<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup_form.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
<style>
	/* 페이지 로딩 시점에 도움말과 피드백 아이콘은 일단 숨기기*/
	.help-block, .form-control-feedback{
		display:none;
	}
</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
</head>
<body>
<div class="container">
	<h1>회원 가입 페이지</h1>
	<form action="insert.do" method="post" id="signupForm">
		<!-- 초기 상태 -->
		<div class="form-group has-feedback">
			<label class="control-label" for="id">아이디</label>
			<input class="form-control" type="text" id="id" name="id"/>
			<p class="help-block" id="id_notusable">사용 불가능한 아이디 입니다.</p>
			<p class="help-block" id="id_required">반드시 아이디를 입력하세요</p>
			<span class="glyphicon glyphicon-remove form-control-feedback"></span>
			<span class="glyphicon glyphicon-ok form-control-feedback"></span>
		</div>
		<div class="form-group has-feedback">
			<label class="control-label" for="pwd">비밀번호</label>
			<input class="form-control" type="password" id="pwd" name="pwd" />
			<p class="help-block" id="pwd_required">반드시 입력하세요</p>
			<p class="help-block" id="pwd_notequal">아래의 확인란과 동일하게 입력하세요</p>
			<span class="glyphicon glyphicon-remove form-control-feedback"></span>
			<span class="glyphicon glyphicon-ok form-control-feedback"></span>
		</div>
		<div class="form-group">
			<label class="control-label" for="pwd2">비밀번호 확인</label>
			<input class="form-control" type="password" id="pwd2" name="pwd2" />
		</div>
		<div class="form-group has-feedback">
			<label class="control-label" for="email">이메일</label>
			<input class="form-control" type="email" id="email" name="email" />
			<p class="help-block" id="email_notmatch">이메일 형식에 맞게 입력하세요</p>
			<span class="glyphicon glyphicon-remove form-control-feedback"></span>
			<span class="glyphicon glyphicon-ok form-control-feedback"></span>
		</div>
		<button disabled="disabled" class="btn btn-primary" type="submit">가입</button>
		<button class="btn btn-warning" type="reset">취소</button>
	</form>
</div>
<script>
	//아이디를 사용할 수 있는지 여부
	var isIdUsable=false;
	//아이디를 입력 했는지 여부
	var isIdInput=false;
	
	//비밀번호를 확인란과 같게 입력했는지 여부
	var isPwdEqual=false;
	//비밀번호를 입력했는지 여부
	var isPwdInput=false;
	
	//이메일을 형식에 맞게 입력했는지 여부
	var isEmailMatch=false; 
	//이메일을 입력했는지 여부
	var isEmailInput=false;
	
	//아이디를 한번이라도 입력한 적이 있는지 여부
	var isIdDirty=false;
	//비밀번호 입력란에 한번이라도 입력한 적이 있는지 여부
	var isPwdDirty=false;
	
	
	//이메일을 입력할 때 실행할 함수 등록
	$("#email").on("input", function(){
		var email=$("#email").val();
		if(email.match("@")){//정규표현식, @의 포함여부를 알 수 있음
			//이메일 형식에 맞게 입력 했다면
			isEmailMatch=true;
		}else{//형식에 맞지 않게 입력했다면
			isEmailMatch=false;
		}
		
		if(email.length==0){//이메일을 입력하지 않았다면
			isEmailInput=false;
		}else{//이메일을 입력 했다면
			isEmailInput=true;
		}
		//이메일 에러 여부
		var isError=isEmailInput && !isEmailMatch;
		setState("#email",isError);
	});
	
	//비밀번호를 입력할 때 실행할 함수 등록
	$("#pwd, #pwd2").on("input",function(){
		//상태값을 바꿔준다.
		isPwdDirty=true;
		
		//입력한 비밀번호를 읽어온다.
		var pwd=$("#pwd").val();
		var pwd2=$("#pwd2").val();
	
		if(pwd != pwd2){//두 비밀번호를 동일하게 입력하지 않았다면
			isPwdEqual=false;
		}else{
			isPwdEqual=true;
		}
//		isPwdEqual= pwd != pwd2 ? false : true;//isPwdEqual= pwd != pwd2가 true면 false가 대입 
		
		if(pwd.length==0){
			isPwdInput=false;
		}else{
			isPwdInput=true;
		}
		var isError =!isPwdEqual || !isPwdInput;
		setState("#pwd",isError);
	});
	
	//아이디를 입력할때 실행할 함수등록
	$("#id").on("input", function(){
		//상태값을 바꿔준다.
		isIdDirty=true;
		
		//1. 입력한 아이디를 읽어온다.
		var inputId=$("#id").val();
		//2. 서버에서 보내서 사용가능 여부를 응답 받는다.
		$.ajax({//페이지 전환 없이 자바스크립트로 원하는 시점에 요청을 보내는 것
			url:"${pageContext.request.contextPath }/users/checkid.do",//어떤 경로로 요청할것인지
			method:"GET",//요청 메소드
			data:{inputId:inputId},//요청하면서 요청파라미터 전달, checkid.jsp?inputId=gura 와 같은의미
			success:function(responseData){//서버에서 ajax요청에 대해 성공적으로 응답하면 이 함수가 호출되고 응답한 문자열(data)는 resoponseData로 들어옴
				if(responseData.isExist){//이미 존재하는 아이디라면
					isIdUsable=false;
				}else{
					isIdUsable=true;
				}
				//아이디 에러 여부
				var isError =!isIdUsable || !isIdInput;
				setState("#id", isError);
			}             
		});
		
		//아이디를 입력했는지 검증
		if(inputId.length==0){//만일 입력하지 않았다면
			isIdInput=false;
		}else{
			isIdInput=true;
		}
		//아이디 에러 여부
		var isError =!isIdUsable || !isIdInput;
		setState("#id", isError);
	});
	
	//입력란의 상태를 바꾸는 함수
	function setState(sel,isError){
		//일단 UI 를 초기 상태로 바꿔준다.
		$(sel)//제이쿼리 선택자
		.parent()
		.removeClass("has-success has-error")
		.find(".help-block, .form-control-feedback")//두개는 숨기고
		.hide();
		
		//색상과 아이콘을 바꿔주는 작업
		if(isError){
			//입력란이 error 인 상태
			$(sel)
			.parent()
			.addClass("has-error")
			.find(".glyphicon-remove")
			.show();
		}else{
			//입력란이 success 인 상태
			$(sel)
			.parent()
			.addClass("has-success")
			.find(".glyphicon-ok")
			.show();
		}
		//에러가 있다면 에러 메세지 띄우기
		if(isEmailInput && !isEmailMatch){//입력도 하고 일치하지 않을 때
			$("#email_notmatch").show();
		}
		if(!isPwdEqual && isPwdDirty){//사용 불가 상태
			$("#pwd_notequal").show();
		}
		if(!isPwdInput && isPwdDirty){
			$("#pwd_requried").show();
		}
		//에러가 있다면 에러 메세지 띄우기
		if(!isIdUsable && isIdDirty){//사용 불가 상태
			$("#id_notusable").show();
		}
		if(!isIdInput && isIdDirty){
			$("#id_required").show();
		}
		
		//버튼의 상태 바꾸기
		if(isIdUsable && isIdInput && isPwdEqual &&
				isPwdInput && (!isEmailInput || isEmailMatch)){
			//이메일을 입력했고 매치가 되면 
			$("button[type=submit]").removeAttr("disabled");
		}else{
			$("button[type=submit]").attr("disabled","disabled");
		}
	}
	
	/* //이메일 입력란의 상태를 바꾸는 함수
	function setEmailState(){
		//일단 UI 를 초기 상태로 바꿔준다.
		$("#email")//제이쿼리 선택자
		.parent()
		.removeClass("has-success has-error")
		.find(".help-block, .form-control-feedback")//두개는 숨기고
		.hide();
		
		//색상과 아이콘을 바꿔주는 작업
		if(isEmailInput && !isEmailMatch){//입력도 해야되고 맞지 않을 때(이메일을 입력 안해도 되기 때문에 상황이 다름)
			//이메일 입력란이 error 인 상태
			$("#email")
			.parent()
			.addClass("has-error")
			.find(".glyphicon-remove")
			.show();
		}else{
			//이메일 입력란이 success 인 상태
			$("#email")
			.parent()
			.addClass("has-success")
			.find(".glyphicon-ok")
			.show();
		}
		//에러가 있다면 에러 메세지 띄우기
		if(isEmailInput && !isEmailMatch){//입력도 하고 일치하지 않을 때
			$("#email_notmatch").show();
		}
	} */
	
	/* //비밀번호 입력란의 상태를 바꾸는 함수
	function setPwdState(){
		//일단 UI 를 초기 상태로 바꿔준다.
		$("#pwd")
		.parent()
		.removeClass("has-success has-error")
		.find(".help-block, .form-control-feedback")//두개는 숨기고
		.hide();
		
		//색상과 아이콘을 바꿔주는 작업
		if(!isPwdEqual || !isPwdInput){
			//비밀번호가 같지 않거나 혹은 입력하지 않았을 때
			$("#pwd")
			.parent()
			.addClass("has-error")
			.find(".glyphicon-remove")
			.show();
		}else{
			//비밀번호 입력란이 success 인 상태
			$("#pwd")
			.parent()
			.addClass("has-success")
			.find(".glyphicon-ok")
			.show();
		}
		//에러가 있다면 에러 메세지 띄우기
		if(!isPwdEqual){//사용 불가 상태
			$("#pwd_notequal").show();
		}
		if(!isPwdInput){
			$("#pwd_requried").show();
		}
	}
	
	//아이디 입력란의 상태를 바꾸는 함수
	function setIdState(){
		//일단 UI 를 초기 상태로 바꿔준다.
		$("#id")
		.parent()
		.removeClass("has-success has-error")
		.find(".help-block, .form-control-feedback")//두개는 숨기고
		.hide();
		
		//색상과 아이콘을 바꿔주는 작업
		if(!isIdUsable|| !isIdInput){
			//아이디 입력란이 error인 상태(아이디를 사용할 수 없거나 아이디를 입력하지 않았을 때)
			$("#id")
			.parent()
			.addClass("has-error")
			.find(".glyphicon-remove")
			.show();
			$("button[type=submit]")
			.attr("diabled","disabled"); //속성추가할때는 .attr을 이용, disabled 속성으로 disabled를 넣으라는 뜻
		}else{
			//아이디 입력란이 success 인 상태
			$("#id")
			.parent()
			.addClass("has-success")
			.find(".glyphicon-ok")
			.show();
			$("button[type=submit]")
			.removeAttr("diabled");//속성을 제거 할 때
		}
		//에러가 있다면 에러 메세지 띄우기
		if(!isIdUsable){//사용 불가 상태
			$("#id_notusable").show();
		}
		if(!isIdInput){
			$("#id_required").show();
		}
		
	}*/
	
</script>
</body>
</html>