<!-- # 데이터베이스에 연동, JDBC 프로그래밍.

# Model 1 : 현재 사용하는 것은 Mode1. 한 페이지 내에서 DB연동, 쿼리문 수행, JSP 연산, HTML 문서 작업을 수행한다.
	매번 DB연동 등을 해야 한다는 단점이 존재한다. 이를 해결하기 위해 MVC패턴에 해당하는 Model2가 고안되었다.
 -->
<%@page import="vo.DeptVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	
	//톰캣이 참조할 리소스 검색
	InitialContext ic = new InitialContext();	
	//리소스파일(context)의 위치 검색
	Context ctx = (Context)ic.lookup("java:comp/env"); //javax.naming패키지에서 import, context 검색
	//리소스의 name을 통해 사용하고자 하는 자원을 검색
	DataSource dataSource = (DataSource)ctx.lookup("jdbc/oracle_test");	//javax.sql로 import
	//DB 연결하기
	Connection conn = dataSource.getConnection(); //java.sql로 import
	System.out.println("---DB 연결 성공---");
	
	
	String sql = "SELECT * FROM DEPT";
	//pstmt를 통해 현재 연결된 DB에 SQL쿼리를 수행함. 
	PreparedStatement pstmt = conn.prepareStatement(sql);
	//결과를 ResultSet이 받는다. 
	ResultSet rs = pstmt.executeQuery();	
	
	
	//dept_list에 DB의 데이터를 저장한다.
	List<DeptVO> dept_list = new ArrayList<>();
	while(rs.next()){	//rs.next() 수행시 다음 행을 탐색한다. 
		DeptVO vo = new DeptVO();	//부서 VO 생성
		//현재 컬럼값을 vo에 담는다.
		vo.setDeptNo(rs.getInt("DEPTNO"));//DEPTNO 컬럼에 있는 값을 가져옴	
		vo.setdName(rs.getString("DNAME"));	//DNAME 컬럼에 있는 값을 가져옴	
		vo.setLoc(rs.getString("LOC"));	//LOC 컬럼에 있는 값을 가져옴	
		dept_list.add(vo);
	}
	
	
	//DB의 사용이 끝나면 관련 객체들 스트림 해제, 연결해제 / 역순으로 닫기.
	rs.close();
	pstmt.close();
	conn.close();
	
%> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>데이터베이스에서 값 받아오기.</title>
		<script type="text/javascript">
			function send (data){
				var f = document.getElementById("m_form"); /* 폼태그를 id로 검색 */
				var hid = document.getElementById("hid"); /* 입력상자 */
				hid.value = data;
				f.submit();
			}
		</script>
	</head>
	<body>
	<form action = "sawon_list.jsp" id="m_form"> <!-- submit시 이동할 url설정 -->
		<table border="1">
			<caption>== 부서목록 ==</caption>
			
			<tr>
				<th>부서번호</th>
				<th>부서명</th>
				<th>부서위치</th>
			</tr>
			
			<% for( int i = 0; i < dept_list.size(); i++ ){ %>
			
				<tr>
					<td><%= dept_list.get(i).getDeptNo() %></td>
						<td>
							<a href="javascript:send('<%= dept_list.get(i).getDeptNo()%>');"  name="deptno">
								<%= dept_list.get(i).getdName() %>
							</a>
							<!-- a태그에서 메서드를 호출하려면 풀코드로 작성해야한다. -->
							<!-- a태그에서 this.form을 인자로 넘겨주어도 반응을 안한다. a태그는 form의 자식이 아니기 때문. -->
							<!-- a태그는 form을 submit시 파라미터로 넘어가지 않는다. -->
						</td>
					<td><%= dept_list.get(i).getLoc() %></td>
				</tr>
			
			<%} %>
		</table>
		<input type="hidden" value="" id="hid" name="deptno"> 
		<!-- submit시 실제 파라미터로 넘어가는 곳. hidden으로 보이지 않도록 설정 -->
		
	</form>
	</body>
</html>