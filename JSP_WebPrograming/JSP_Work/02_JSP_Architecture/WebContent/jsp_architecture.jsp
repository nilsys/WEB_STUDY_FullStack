<!-- #1) 페이지 디렉티브 : JSP 페이지에 대한 정보를 입력하는 부분, page, taglib, include가 있다. -->
<%@page import="java.util.Random"%> <!-- 자바 클래스를 import한다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- contentType : JSP가 생성할 문서의 타입과 인코딩을 지정한다. 
    	 pageEncoding : JSP 파일을 작성할 캐릭터 셋 지정.
    -->
    
 <!-- #2) 스크립트 요소 : 문서의 내용을 동적으로 생성하기 위해 사용되는 것. JSP 프로그래밍에서 로직을 수행한다.
 		선언부, 스크립트 릿, 표현식이 존재한다.
  -->   
<!-- # 선언부(Declaration) : 변수 또는 메서드를 정의하는 일종의 전역개념의 릿 영역 . 변수나 메서드를 페이지 전체에서 사용가능하다.-->
<%!
	int n = 0;
	Random rnd = new Random();
	
	//선언부의 메서드는 자바의 메서드와 동일하다.
	public int plus(int a, int b){
		return a + b;
	}
%>

<!-- # 스크립트 릿(Scriptlet) : 자바 코드를 실행할 때 사용하는 블록. 지역개념의 스크립트 릿 -->
<%
	int random = rnd.nextInt(10) + 1;
	System.out.println(random);
	
	int n2 = 0;
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>JSP 구성요소</title>
	</head>
	<body>
		<p><%= "n++ : " + n++ %></p> <!-- # 표현식(Expression) : 어떤 값을 출력 결과에 포함시킴. 세미콜론을 사용하지 않음. -->
		<p><%= "n2++ : " + n2++ %></p>	<!-- 페이지 새로고침 시 선언영역의 변수는 초기화가 되지 않고 증가, 지역선언한 변수는 0으로 초기화된다. -->
		<p><%= plus(random, random) %></p>
	</body>
</html>