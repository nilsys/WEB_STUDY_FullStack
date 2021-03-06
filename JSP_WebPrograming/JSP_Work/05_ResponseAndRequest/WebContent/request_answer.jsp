<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 
# Request 
웹 브라우저의 요청 정보를 제공하는 객체이다.
웹 브라우저, 즉 클라이언트가 전송한 요청 정보를 제공해준다.
클라이언트, 서버 정보 관련 메서드, 파라미터 관련 메서드, 헤더 정보 메서드 등을 제공한다.

-->
<%
	/* 요청 파라미터의 인코딩과 디코딩
	파라미터를 서로 주고받을 때 인코딩할 때 사용한 캐릭터 셋과 디코딩할 때 사용하는 캐릭터 셋이 같아야 한다.
	특히 파라미터를 데이터셋 형태의 post로 받게 된다면 그에 맞게 디코딩하여 사용해야 한다.
	*/
	request.setCharacterEncoding("UTF-8");
	String pet_val = request.getParameter("q_pet");
	String pet_info = "";
	if(pet_val.equals("dog")){
		pet_info = "강아지를 선택하셨습니다";
	}
	if(pet_val.equals("cat")){
		pet_info = "고양이를 선택하셨습니다";
	}
	if(pet_val.equals("fish")){
		pet_info = "물고기를 선택하셨습니다";
	}
%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Request 기본 객체와 파라미터 처리</title>
	</head>
	<script>
		function back(f){
			f.method = "post";
			f.action = "response_back.jsp";
			f.submit();
		}
	</script>
	<body>
		
		<!-- Request 객체의 클라이언트, 서버 관련 메서드 -->
		<h1>Request 기본 객체의 클라이언트 및 서버 정보 관련 메서드</h1>
		1) 클라이언트 IP : <%= request.getRemoteAddr() %><br>
		2) 요청정보 길이 : <%= request.getContentLength() %><br>
		3) 요청정보 인코딩 : <%= request.getCharacterEncoding() %><br>
		4) 요청정보 컨텐츠타입 : <%= request.getContentType() %><br>
		5) 요청정보 프로토콜 : <%= request.getProtocol() %><br>
		6) 요청정보 전송방식 : <%= request.getMethod() %><br>
		7) 요청 URL : <%= request.getRequestURL() %><br>
		8) 컨텍스트 경로 : <%= request.getContextPath() %><br>
		9) 서버 이름 : <%= request.getServerName() %><br>
		<hr>
		
		<!-- Request 객체의 헤더 정보 처리 -->
		<h1>Request 헤더 관련 메서드</h1>
		네트워크상에서 패킷 전달 시 헤더에 정보가 담겨서 전달된다. 이 헤더에는 웹 브라우저의 종류, 선호하는 언어 등을 담고 있다.
		이러한 헤더 정보를 읽어올 수 있는 기능을 제공한다.<br>
		해당 헤더값 구하기. <%= request.getHeader("Accept-Language") %> 
		<hr>
		<h1>클라이언트의 요청 파라미터 처리하기</h1>
		<!--  
		# Request 객체의 요청 파라미터 처리하기
		getParameter(name) : 이름이 name인 파라미터의 값을 구한다. 존재하지 않는 경우 null을 반환.
		getParameterValues(name) : 이름이 name인 모든 파라미터의 값을 배열로 구한다.
		getParameterNames() : 브라우저가 요청한 파라미터의 이름 목록을 구한다.
		getParameterMap() : 브라우저가 요청한 파라미터의 이름 목록을 구한다.
		-->
		answer.jsp?question_pet=fish 이런식으로 파라미터가 넘어온다.<br>
		<!-- question_pet은 input의 name속성, fish는 input의 value속성에 해당한다. -->
		<%= request.getParameter("q_name") %>님 환영합니다. <%= pet_info %><br>
		<% String[] val = request.getParameterValues("q_pet"); 
			for(int i = 0; i < val.length; i++){%>
				<%= val[i] + " " %>
		<%}%>
		<br>
		<form>
			<input type="button" value="돌아가기" onclick="back(this.form);">
		</form>
	</body>
</html>