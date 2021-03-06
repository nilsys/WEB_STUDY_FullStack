<%@page import="java.util.List"%>
<%@page import="vo.PersonVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	//ArrayList<PersonVO> list = new ArrayList<>();
	List<PersonVO> list = new ArrayList<>(); //접근 속도를 빠르게 하기 위해서 List형으로 선언
	
	//임의의 Database 설정. VO의 형태로 List에 담는다.
	PersonVO p1 = new PersonVO();
	p1.setName("kim");
	p1.setAge(20);
	p1.setTel("010-1111-2222");
	
	PersonVO p2 = new PersonVO();
	p2.setName("lee");
	p2.setAge(22);
	p2.setTel("010-2222-3333");
	
	list.add(p1);
	list.add(p2);
%>
<%-- ArrayList를 Table형태로 출력하기. --%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>VO 클래스를 이용하여 데이터베이스 조회하기</title>
		<style>
			table{ border-collapse : collapse;	/* 라인 합치기 */	border-color : black;}
			th{ background-color : skyblue;}
			td{ width:100px; test-align:center; background-color : gray;}
			.td3{ width : 150px; }
			
		</style>
	</head>
	<body>
		<table border = "1">
		<tr>
			<th>이름</th>
			<th>나이</th>
			<th>전화번호</th>
		</tr>
		<% for(int i = 0; i < list.size(); i++){ %>
		<tr>
			<td><%= list.get(i).getName() %></td>
			<td><%= list.get(i).getAge() %></td>
			<td class = "td3"><%= list.get(i).getTel() %></td>
		</tr>		
		<% } %>	
		</table>
	</body>
</html>