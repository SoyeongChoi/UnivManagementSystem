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
	String roomId =request.getParameter("roomId");//강의실
	String day = request.getParameter("day");//요일
	String LectureCode = request.getParameter("LectureCode");//강의일정코드
	String className = request.getParameter("className");//수업이름
	String eTime = request.getParameter("eTime");
	String sTime = request.getParameter("sTime");
	
	LogonDBBeanSubject logon = LogonDBBeanSubject.getInstance();
	Class.forName("com.mysql.jdbc.Driver");
	String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
	String dbId = "root";
	String dbPass = "wjsgpals66";
	String real_id;
	String strDay = null;
	switch(day){
	case "0":
		strDay="월";
		break;
	case "1":
		strDay="화";
		break;
	case "2":
		strDay="수";
		break;
	case "3":
		strDay="목";
		break;
	case "4":
		strDay="금";
		break;
	}
	String DAY[] = {"월", "화", "수", "목", "금"};
	int total = 0;
	String[] arrRoom = null;
	try {
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		Statement stmt = conn.createStatement();
		
		List<String> Room = new ArrayList<String>();
		Statement stmtT = conn.createStatement();
		String Timequery = "select * from 강의실";
		ResultSet rs = stmtT.executeQuery(Timequery);
		while (rs.next()) {
			Room.add(rs.getString(1));
		}
		arrRoom = new String[Room.size()];
		for (int i = 0; i < Room.size(); i++) {
			arrRoom[i] = Room.get(i);
		}
		
%>


<body>
<h2><%=className %> 일정 수정</h2>
		<input type="submit" value="강의일정으로 돌아가기"
		onclick="location.href='insertLectureScheduleForm.jsp?roomId=<%=roomId%>'">
	<form method="post" name ="updateForm">
	<input type="hidden" name="className" value="<%=className %>">
	<input type="hidden" name = "roomId" value="<%=roomId %>">
	<input type="hidden" name = "day" value="<%=day %>">
	<input type="hidden" name = "LectureCode" value="<%=LectureCode %>">
	<input type="hidden" name = "sTime" value="<%=sTime%>">
	<input type="hidden" name = "eTime" value="<%=eTime%>">
			<table>
			<tr>
				<td>강의실 : </td>
				<td><%=roomId%></td>
				<td><input type="submit" value="강의실변경" onclick="a()">	</td>
			</tr>
			<tr>
				<td>요일 : </td>
				<td> <%=strDay %></td>
				<td><select id="select" name="changeDay">
						<option value="changeDay" disabled>요일 선택</option>
						<% for(int i = 0; i < DAY.length; i++){
								if(DAY[i] == strDay){
							%>
						<option value="<%=i%>" selected="selected"><%=DAY[i]%></option>
								<%}else{
								%>
						<option value="<%=i%>"><%=DAY[i]%></option>
			
						<% }
					}%>
					</select>
			</td>
			</tr>
			<tr>
				<td>시간 : </td>
				<td> <%=sTime %>시 ~ <%=eTime %>시</td>
				<td><input type="submit" value="시간변경" onclick="c()"></td>
			</tr>
		</table>
		<br/>
		
      <input type="submit" value="수정" onclick="d()">
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
	function d(){
		var f = document.updateForm;
		f.action="updateLectureSchedulePro.jsp";
		f.submit();
	}
</script>

</html>