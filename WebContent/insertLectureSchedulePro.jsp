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
<title>강의 추가하기</title>
</head>
<%
	String roomId =request.getParameter("roomId");//강의실
	LogonDBBeanSubject logon = LogonDBBeanSubject.getInstance();
	Class.forName("com.mysql.jdbc.Driver");
	String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
	String dbId = "root";
	String dbPass = "wjsgpals66";
	String real_id;
	String strDay = null;
	List<String> StartRealTime = new ArrayList<String>();
	for(int i = 9; i <= 18; i++){
		StartRealTime.add(String.valueOf(i));
	}
 
	List<String> EndRealTime = new ArrayList<String>();
	for(int i = 10; i <= 19; i++){
		EndRealTime.add(String.valueOf(i));
	}
	List<String> Lecture = new ArrayList<String>();
	int total = 0;
	String[] arrRoom = null;
	String[] arrSTime = null;
	String[] arrETime = null;
	String[] arrLecture = null;
	try {
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		Statement stmt = conn.createStatement();
		
		List<String> startTime = new ArrayList<String>();
		List<String> endTime = new ArrayList<String>();
		Statement stmtT = conn.createStatement();
		String Timequery = "select 시작시간, 종료시간 from 강의일정 where 강의실아이디='"+roomId+"'";
		String Lecturequery = "select 과목코드 from 과목";
		
		ResultSet rs = stmtT.executeQuery(Timequery);
		while (rs.next()) {
			startTime.add(rs.getString(1));
			endTime.add(rs.getString(2));
		}
		arrSTime = new String[startTime.size()];
		arrETime = new String[endTime.size()];
		for (int i = 0; i < startTime.size(); i++) {
			arrSTime[i] = startTime.get(i);
		}
		for (int i = 0; i < endTime.size(); i++) {
			arrSTime[i] = endTime.get(i);
		}
		rs = stmtT.executeQuery(Lecturequery);
		rs.first();
		while(rs.next()){
			Lecture.add(rs.getString(1));
		}
		arrLecture = new String[Lecture.size()];
		for(int i = 0; i< Lecture.size(); i++){
			arrLecture[i] = Lecture.get(i);
		}
		
		
%>


<body>
	<h2><%=roomId %>
		일정 추가
	</h2>

	<input type="submit" value="강의일정으로 돌아가기"
		onclick="location.href='insertLectureScheduleForm.jsp?roomId=<%=roomId%>'">
	<form method="post" name="updateForm">
		<input type="hidden" name="roomId" value="<%=roomId %>">
		<table>
			<tr>
				<td>과목 : </td>
				<td><input type="submit" value="과목선택" onclick="a()"></td>
			</tr>

			<tr>
				<td>요일 :</td>
				<td><input type="submit" value="요일선택" onclick="b()" disabled></td>
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

</html>