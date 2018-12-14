<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원정보 보기</title>
</head>
<body>
	<h2>회원 정보</h2>
	<br />
	<br />
	<input type="submit" onclick="location.href='insertStudentForm.jsp'" value="학생 등록하기">
	<input type="submit" onclick="location.href='insertProfessorForm.jsp'" value="교수 등록하기">
	<input type="submit" onclick="location.href='insertManagerForm.jsp'" value="관리자 등록하기">
	
	<h3>학생 정보</h3>
	<%
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "wjsgpals66";
		String real_id;
		int total = 0;
		try {
			Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			Statement stmt = conn.createStatement();
			String totalSql = "select * from 회원 where 직업='학생'";
			ResultSet rs = stmt.executeQuery(totalSql);

			if (rs.next()) {
				total += 1;
			}

			String listSql = "select 회원아이디, 이름, 비밀번호, 학과, 생년월일 from 회원 where 직업='학생'";
			rs = stmt.executeQuery(listSql);
	%>
	<table class="body row-clickable" border="1"
		style="border-collapse: collapse; text-align: center">
		<tr>
			<th width="100">아이디</th>
			<th width="100">이름</th>
			<th width="100">비밀번호</th>
			<th width="100">학과</th>
			<th width="100">생년월일</th>
			<th width="100">정보 삭제 하기</th>
		</tr>
		<%
			if (total == 0) {
		%>
		<tr>
			<td colspan="6">현재 추가한 학생이 없습니다.</td>
		</tr>
		<%
			} else {
					while (rs.next()) {
						String id = rs.getString(1);
						String name = rs.getString(2);
						String pw = rs.getString(3);
						String major = rs.getString(4);
						String birth = rs.getString(5);
						real_id = id;
		%>
		<tr>
			<td><%=id%></td>
			<td><%=name%></td>
			<td><%=pw%></td>
			<td><%=major%></td>
			<td><%=birth%></td>
			<td>
			<form>
				<input type="button" value="삭제" onclick="location.href='deleteMemberPro.jsp?mId=<%=id%>'">
			</form>
			</td>
		</tr>
		<%
			}
				}
		%>
	</table>
	<br />
	<br />
	<br />
	<h3>교수 정보</h3>
	<br>
	<%
		total = 0;
			Statement stmt2 = conn.createStatement();
			String totalSql2 = "select * from 회원 where 직업='교수'";
			ResultSet rs2 = stmt2.executeQuery(totalSql2);
			if (rs2.next()) {
				total += 1;
			}
			String listSql2 = "select 회원아이디, 이름, 비밀번호, 학과, 생년월일 from 회원 where 직업='교수'";
			rs2 = stmt2.executeQuery(listSql2);
	%>
	<table class="body row-clickable" border="1"
		style="border-collapse: collapse; text-align: center">
		<tr>
			<th width="100">아이디</th>
			<th width="100">이름</th>
			<th width="100">비밀번호</th>
			<th width="100">학과</th>
			<th width="100">생년월일</th>
			<th width="100">정보 삭제 하기</th>
		</tr>
		<%
			if (total == 0) {
		%>
		<tr>
			<td colspan="6">현재 추가한 교수가 없습니다.</td>
		</tr>
		<%
			} else {
					while (rs2.next()) {
						String id = rs2.getString(1);
						String name = rs2.getString(2);
						String pw = rs2.getString(3);
						String major = rs2.getString(4);
						String birth = rs2.getString(5);
						real_id = id;
		%>
		<tr>
			<td><%=id%></td>
			<td><%=name%></td>
			<td><%=pw%></td>
			<td><%=major%></td>
			<td><%=birth%></td>
			<td>
			<form>
				<input type="button" value="삭제" onclick="location.href='deleteMemberPro.jsp?mId=<%=id%>'">
			</form>
			</td>
		</tr>
		<%} 
		}%>
	</table>
			<br />
	<br />
	<br />
	<h3>관리자 정보</h3>
	<br>
	<%
		total = 0;
			Statement stmt3 = conn.createStatement();
			String totalSql3 = "select * from 회원 where 직업='관리자'";
			ResultSet rs3 = stmt3.executeQuery(totalSql2);
			if (rs3.next()) {
				total += 1;
			}
			String listSql3 = "select 회원아이디, 이름, 비밀번호, 생년월일 from 회원 where 직업='관리자'";
			rs3 = stmt3.executeQuery(listSql3);
	%>
	<table class="body row-clickable" border="1"
		style="border-collapse: collapse; text-align: center">
		<tr>
			<th width="100">아이디</th>
			<th width="100">이름</th>
			<th width="100">비밀번호</th>
			<th width="100">생년월일</th>
			<th width="100">정보 삭제 하기</th>
		</tr>
		<%
			if (total == 0) {
		%>
		<tr>
			<td colspan="6">현재 추가한 관리자가 없습니다.</td>
		</tr>
		<%
			} else {
					while (rs3.next()) {
						String id = rs3.getString(1);
						String name = rs3.getString(2);
						String pw = rs3.getString(3);
						String birth = rs3.getString(4);
						real_id = id;
		%>
		<tr>
			<td><%=id%></td>
			<td><%=name%></td>
			<td><%=pw%></td>
			<td><%=birth%></td>
			<td>
			<form>
				<input type="button" value="삭제" onclick="location.href='deleteMemberPro.jsp?mId=<%=id%>'">
			</form>
			</td>
		</tr>
		<%
			}
				}
				rs.close();
				conn.close();
				stmt.close();
			} catch (SQLException e) {
				out.println(e.toString());
			}
			
		%>
	</table>
	<input type="button" value="메인으로 돌아가기" onclick="goTheaterManagement()">
	<script type="text/javascript">
		function goTheaterManagement() {
			location.href = "CookieManager.jsp";
		}
	</script>

	<script type="text/javascript">
			function button_event(x){
				if (confirm("정말 삭제하시겠습니까?")){ //확인
					document.location.href="deleteMemberPro.jsp?mId="+x;
				}
				else{ 
					return;
				}
			}
		</script>
</body>
</html>