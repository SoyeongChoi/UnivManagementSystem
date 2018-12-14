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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>강의실 일정 수정</title>
</head>
<%
	String roomId = request.getParameter("roomId");//강의실

	LogonDBBeanSubject logon = LogonDBBeanSubject.getInstance();
	Class.forName("com.mysql.jdbc.Driver");
	String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
	String dbId = "root";
	String dbPass = "wjsgpals66";
	String real_id;
	String subject = request.getParameter("subject");
	String professor[] = null;
	String professorId[] = null;
	int total = 0;
	try {
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		Statement stmt = conn.createStatement();
		
		List<String> Room = new ArrayList<String>();
		List<String> PId = new ArrayList<String>();
		Statement stmtT = conn.createStatement();
		String Timequery = "select 학과 from 과목 where 과목코드='"+subject+"'";
		ResultSet rs = stmtT.executeQuery(Timequery);
		rs.first();
		String major = rs.getString(1);
		String PQuery = "select 회원아이디, 이름 from 회원 where 직업='교수' and 학과='"+major+"'";
		rs = stmtT.executeQuery(PQuery);
		while (rs.next()) {
			PId.add(rs.getString(1));
			Room.add(rs.getString(2));
		}
		professor = new String[Room.size()];
		professorId = new String[PId.size()];
		for (int i = 0; i < Room.size(); i++) {
			professorId[i] = PId.get(i);
			professor[i] = Room.get(i);
		}
%>


<body>
	<h2><%=roomId%>
		일정 추가
	</h2>
	<input type="submit" value="강의일정으로 돌아가기"
		onclick="location.href='insertLectureScheduleForm.jsp?roomId=<%=roomId%>'">
	<form method="post" name="updateForm">
		<input type="hidden" name="roomId" value="<%=roomId%>">
		<input type="hidden" name="subject" value="<%=subject%>">
		<table>
			<tr>
				<td>과목 :</td>
				<td><%=subject %></td>
			</tr>
			<tr>
				<td>교수 : </td>
				<td><select id="select" name="professor">
						<option value="professor" disabled>교수 선택</option>
						<%
							for (int i = 0; i < professor.length; i++) {
						%>
						<option value="<%=professorId[i]%>"><%=professor[i]%></option>
						<%
							}
						%>
				</select></td>
			</tr>
			<tr>
				<td>요일 :</td>
				<td><input type="submit" value="요일선택" onclick="b()" ></td>
			</tr>
			<tr>
				<td>시간 :</td>
				<td><input type="button" value="시간선택" onclick="c()" disabled></td>
			</tr>
		</table>
		<br /> <input type="submit" value="등록" onclick="d()" disabled>
	</form>

</body>
<%
	rs.close();
		conn.close();
		stmt.close();
	} catch (SQLException e) {
		out.println(e.toString());
	}
%>
<script type="text/javascript">
	function a() {
		var f = document.updateForm;
		f.action = "SelectSubject.jsp";
		f.submit();
	}
	function b() {
		var f = document.updateForm;
		f.action = "SelectDay.jsp";
		f.submit();
	}
	function c() {
		var f = document.updateForm;
		f.action = "ChangeTime.jsp";
		f.submit();
	}
	function e() {
		var f = document.updateForm;
		f.action = "SelectProfessor.jsp";
		f.submit();
	}
	function d() {
		var f = document.updateForm;
		f.action = "updateLectureSchedulePro.jsp";
		f.submit();
	}
</script>

