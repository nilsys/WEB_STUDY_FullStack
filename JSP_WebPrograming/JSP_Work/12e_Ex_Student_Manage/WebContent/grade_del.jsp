<%@page import="dao.GradeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	//넘어온 파라미터를 받음. sung_del.jsp?no=2
	int no = Integer.parseInt(request.getParameter("no"));
	
	//DB의 성적정보 제거. 결과 처리된 행 수가 반환된다.
	int res = GradeDAO.getInstance().delete(no);
	
	response.sendRedirect("grade_view.jsp"); //DB에서 데이터 삭제 후 grade_view 페이지로 돌아가 갱신
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
	
	</body>
</html>