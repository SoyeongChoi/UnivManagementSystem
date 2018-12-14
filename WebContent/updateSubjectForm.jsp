<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="login.LogonDBBeanSubject"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="Subject" class="login.LogonDataBeanSubject">
	<jsp:setProperty name="Subject" property="*" />
</jsp:useBean>

<%
	String subjectCode = request.getParameter("subjectCode");
	LogonDBBeanSubject logon = LogonDBBeanSubject.getInstance();
	Class.forName("com.mysql.jdbc.Driver");
	String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
	String dbId = "root";
	String dbPass = "wjsgpals66";
	String real_id;
	int total = 0;
	String[] prof = null;
	String[] profId = null;
	try {
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		Statement stmt = conn.createStatement();
		String totalSql = "select * from 과목 where 과목코드='" + subjectCode + "'";
		ResultSet rs = stmt.executeQuery(totalSql);
		rs.first();
		String subject = rs.getString(2);
		int year = Integer.valueOf(rs.getString(3));
		int creditNum = Integer.valueOf(rs.getString(4));
		String major = rs.getString(5);
		String course = rs.getString(6);
		int semester = Integer.valueOf(rs.getString(7));
		int peopleNum = Integer.valueOf(rs.getString(8));
		String classNum = rs.getString(9);
		String professorId = rs.getString(10);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>과목수정정보</title>
</head>
<body>
<h2>과목수정</h2>
	<form method="post" action="updateSubjectPro.jsp?subjectCode=<%=subjectCode%>">
		과목명 : <input type="text" name="subject" maxlength="50" value="<%=subject %>" required><br /> 
		학년 : <input type="text" name="year" maxlength="30" value="<%=year %>" required><br />
		학점시수 : <input type="number" name="creditNum" maxlength="30" value="<%=creditNum %>" required><br /> 
		학기 : <input type="number" name="semester" value="<%=semester %>" maxlength="10" required><br/>
		인원 : <input type="number" name="peopleNum" value="<%=peopleNum %>" maxlength="10" required><br/>
		학과 : <input type="text" name="major" maxlength="30" value="<%=major %>" required><input type="submit" value="교수 보기" onclick="location.href='updateSubjectPro.jsp?subjectCode=<%=subjectCode%>"><br /> 
		이수분야 : <input type="text" name="course" value="<%=course %>" maxlength="30" ><br/>
		분반 : <input type="text" name="classNum" value="<%=classNum %>" maxlength="10" required><br/>	
		<input type="hidden" name="profesID" value="<%=professorId %>">
		<input type="submit" value="수정">
	<input type="reset" value="다시 입력하기">
	</form>
	
		<input type="submit" value="메인으로 돌아가기"
		onclick="location.href='CookieManager.jsp'">

<%
		rs.close();
		conn.close();
		stmt.close();
	} catch (SQLException e) {
		out.println(e.toString());
	}
%>


</body>
</html>