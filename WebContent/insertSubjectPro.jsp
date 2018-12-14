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
	String subject = request.getParameter("subject");
	String strYear = request.getParameter("year");
	String strCreditNum = request.getParameter("creditNum");
	String major = request.getParameter("major");
	String course = request.getParameter("course");
	String strSemeter = request.getParameter("semester");
	String strPeopleNum = request.getParameter("peopleNum");
	String classNum = request.getParameter("classNum");
	int peopleNum = Integer.parseInt(strPeopleNum);
	int creditNum = Integer.parseInt(strCreditNum);
	int semester= Integer.valueOf(strSemeter);
	int year = Integer.valueOf(strYear);
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
		String totalSql = "select 이름, 회원아이디 from 회원 where 직업='교수' and 학과='" + major + "'";
		ResultSet rs = stmt.executeQuery(totalSql);
		List<String> professor = new ArrayList<String>();
		List<String> professorId = new ArrayList<String>();
		while (rs.next()) {
			professor.add(rs.getString(1));
			professorId.add(rs.getString(2));
		}
		prof = new String[professor.size()];
		profId = new String[professor.size()];
		for (int i = 0; i < professor.size(); i++) {
			prof[i] = professor.get(i);
			profId[i] = professorId.get(i);
		}
		String listSql = "select 회원아이디, 이름, 비밀번호, 학과, 생년월일 from 회원 where 직업='학생'";
		rs = stmt.executeQuery(listSql);

		rs.close();
		conn.close();
		stmt.close();
	} catch (SQLException e) {
		out.println(e.toString());
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>과목 입력 정보보기</title>
</head>
<body>
<h2>과목등록</h2>
	<form method="post" action="insertSubjectReal.jsp">
		과목명 : <input type="text" name="subject" maxlength="50" value="<%=subject %>" required><br /> 
		학년 : <input type="text" name="year" maxlength="30" value="<%=year %>" required><br />
		학점시수 : <input type="number" name="creditNum" maxlength="30" value="<%=creditNum %>" required><br /> 
		학기 : <input type="number" name="semester" value="<%=semester %>" maxlength="10" required><br/>
		인원 : <input type="number" name="peopleNum" value="<%=peopleNum %>" maxlength="10" required><br/>
		학과 : <input type="text" name="major" maxlength="30" value="<%=major %>" required><input type="submit" value="교수 보기"></button><br /> 
		<select id="select" name="select" >
			<option value="교수선택" disabled selected="selected">교수선택</option>
			<% for(int i = 0; i < prof.length; i++){%>
			<option value="<%=profId[i]%>"><%=prof[i]+" , 아이디:"+profId[i]%></option>
			<%} %>
		</select>
		<br/>
		이수분야 : <input type="text" name="course" value="<%=course %>" maxlength="30" required><br/>
		분반 : <input type="text" name="classNum" value="<%=classNum %>" maxlength="10" required><br/>	
		<input type="submit" value="등록">
	<input type="submit" value="메인으로 돌아가기"
		onclick="location.href='CookieManager.jsp'">
	<input type="submit" value="다시 입력하기"
		onclick="location.href='insertSubjectForm.jsp'">
	</form>
<script>


	
	</script>

</body>
</html>