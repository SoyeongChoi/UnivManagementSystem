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
<title>강의 일정 수정</title>
</head>
<%
	String className = request.getParameter("className");//수업아이디
	String day = request.getParameter("day");
	String paramsEtime = request.getParameter("eTime");
	String paramsStime = request.getParameter("sTime");
	String check = request.getParameter("check");
	String sTime = null;
	String eTime = null;
	LogonDBBeanSubject logon = LogonDBBeanSubject.getInstance();
	Class.forName("com.mysql.jdbc.Driver");
	String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
	String dbId = "root";
	String dbPass = "wjsgpals66";
	String real_id;
	String strDay = null;
	System.out.println(day);
	System.out.println("###########3" + check);
	System.out.println(paramsEtime);
	switch (day) {
		case "0" :
			strDay = "월";
			break;
		case "1" :
			strDay = "화";
			break;
		case "2" :
			strDay = "수";
			break;
		case "3" :
			strDay = "목";
			break;
		case "4" :
			strDay = "금";
			break;
	}
	if (check != null) {
		int temp = Integer.valueOf(paramsStime) + Integer.valueOf(paramsEtime) - 1;
		paramsEtime = String.valueOf(temp);
		switch (paramsEtime) {
			case "0" :
				eTime = "10";
				break;
			case "1" :
				eTime = "11";
				break;
			case "2" :
				eTime = "12";
				break;
			case "3" :
				eTime = "13";
				break;
			case "4" :
				eTime = "14";
				break;
			case "5" :
				eTime = "15";
				break;
			case "6" :
				eTime = "16";
				break;
			case "7" :
				eTime = "17";
				break;
			case "8" :
				eTime = "18";
				break;
			case "9" :
				eTime = "19";
				break;
		}
		switch (paramsStime) {
			case "0" :
				sTime = "9";
				break;
			case "1" :
				sTime = "10";
				break;
			case "2" :
				sTime = "11";
				break;
			case "3" :
				sTime = "12";
				break;
			case "4" :
				sTime = "13";
				break;
			case "5" :
				sTime = "14";
				break;
			case "6" :
				sTime = "15";
				break;
			case "7" :
				sTime = "16";
				break;
			case "8" :
				sTime = "17";
				break;
			case "9" :
				sTime = "18";
				break;
		}
	} else {
		sTime = paramsStime;
		eTime = paramsEtime;
	}
	int total = 0;
	String[] arrSTime = null;
	String[] arrETime = null;
	String roomId = null;
	String LectureCode = null;
	try {
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		Statement stmt = conn.createStatement();
		String totalSql = "select 강의실아이디, 강의일정코드 from 강의일정 where 과목코드='" + className + "' and 요일='" + day + "'"
				+ " and 시작시간='" + sTime + "'" + " and 종료시간='" + eTime + "'";
		System.out.println(totalSql);
		ResultSet rsT = stmt.executeQuery(totalSql);
		rsT.first();
		roomId = rsT.getString(1);
		LectureCode = rsT.getString(2);
		List<String> startTime = new ArrayList<String>();
		List<String> endTime = new ArrayList<String>();
		Statement stmtT = conn.createStatement();
		String Timequery = "select 시작시간, 종료시간 from 강의일정 where 강의실아이디='" + roomId + "'" + "and 요일='" + day + "'";
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
		String listSql = "select 회원아이디, 이름, 비밀번호, 학과, 생년월일 from 회원 where 직업='학생'";
		rs = stmt.executeQuery(listSql);
%>


<body>
	<h2><%=className%>
		일정 수정
	</h2>

	<input type="submit" value="강의일정으로 돌아가기"
		onclick="location.href='insertLectureScheduleForm.jsp?roomId=<%=roomId%>'">
	<form method="post" name="updateForm">
		<input type="hidden" name="roomId" value="<%=roomId%>"> <input
			type="hidden" name="day" value="<%=day%>"> <input
			type="hidden" name="LectureCode" value="<%=LectureCode%>"> <input
			type="hidden" name="className" value="<%=className%>"> <input
			type="hidden" name="sTime" value="<%=sTime%>"> <input
			type="hidden" name="eTime" value="<%=eTime%>">
		<table>
			<tr>
				<td>강의실 :</td>
				<td><%=roomId%></td>
				<td><input type="submit" value="강의실변경" onclick="a()"></td>
			</tr>
			<tr>
				<td>요일 :</td>
				<td><%=strDay%></td>
				<td><input type="submit" value="요일변경" onclick="b()"></td>
			</tr>
			<tr>
				<td>시간 :</td>
				<td><%=sTime%>시 ~ <%=eTime%>시</td>
				<td><input type="submit" value="시간변경" onclick="c()"></td>
			</tr>
		</table>
		<br />
	</form>
	<input type="submit" value="삭제" onclick="location.href='deleteLectureSchedule.jsp?LectureCode=<%=LectureCode%>&className=<%=className%>'">
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
	function a(){
		var f = document.updateForm;
		f.action="ChangeRoom.jsp";
		f.submit();
	}
	function b(){
		var f = document.updateForm;
		f.action="ChangeDay.jsp";
		f.submit();
	}
	function c(){
		var f = document.updateForm;
		f.action="ChangeTime.jsp";
		f.submit();
	}
</script>

</html>