<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>과목정보 보기</title>
</head>
<body>
	<h2>과목 정보</h2>
	<br />
	<br />
	<input type="submit" onclick="location.href='insertSubjectForm.jsp'"
		value="과목 추가하기">

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
			String totalSql = "select * from 과목";
			ResultSet rs = stmt.executeQuery(totalSql);

			if (rs.next()) {
				total += 1;
			}

			String listSql = "select * from 과목";
			rs = stmt.executeQuery(listSql);
	%>
	<table class="body row-clickable" border="1"
		style="border-collapse: collapse; text-align: center">
		<tr>
			<th width="100">과목명</th>
			<th width="100">학년</th>
			<th width="100">학점시수</th>
			<th width="100">학과</th>
			<th width="100">이수분야</th>
			<th width="100">학기</th>
			<th width="100">인원</th>
			<th width="100">분반</th>
			<th width="100">교수명</th>
			<th width="100">수정하기</th>
			<th width="100">삭제하기</th>
		</tr>
		<%
			if (total == 0) {
		%>
		<tr>
			<td colspan="11">현재 추가한 과목이 없습니다.</td>
		</tr>
		<%
			} else {
					while (rs.next()) {
						String subjectCode = rs.getString(1);
						String subject = rs.getString(2);
						int year = Integer.valueOf(rs.getString(3));
						int creditNum = Integer.valueOf(rs.getString(4));
						String major = rs.getString(5);
						String course = rs.getString(6);
						String semester = rs.getString(7);
						int peopleNum = Integer.valueOf(rs.getString(8));
						String classNum = rs.getString(9);
						String pId = rs.getString(10);
						Statement stmt2 = conn.createStatement();
						String proNameQuery = "select 이름 from 회원 where 회원아이디='"+pId+"'";
						System.out.println(proNameQuery);
						ResultSet rs2 = stmt2.executeQuery(proNameQuery);
						rs2.first();
						String professor = rs2.getString(1);

		%>
		<tr>
			<td><%=subject%></td>
			<td><%=year%></td>
			<td><%=creditNum%></td>
			<td><%=major%></td>
			<td><%=course%></td>
			<td><%=semester%></td>
			<td><%=peopleNum%></td>
			<td><%=classNum%></td>
			<td><%=professor%></td>
			<td><input type="submit"
				onclick="location.href='updateSubjectForm.jsp?subjectCode=<%=subjectCode%>'"
				value="수정"></td>
			<td><input type="submit" onclick="button_event('<%=subjectCode%>')" value="삭제"></td>
		</tr>
		<%
			}
				}
		%>
	</table>
	<%
			rs.close();
			conn.close();
			stmt.close();
		} catch (SQLException e) {
			out.println(e.toString());
		}
	%>

	<input type="button" value="메인으로 돌아가기" onclick="goTheaterManagement()">
	<script type="text/javascript">
		function goTheaterManagement() {
			location.href = "CookieManager.jsp";
		}
	</script>

	<script type="text/javascript">
		function button_event(x) {
			if (confirm("정말 삭제하시겠습니까?")) { //확인
				document.location.href = "deleteSubjectPro.jsp?subjectCode=" + x;
			} else {
				return;
			}
		}
	</script>
</body>
</html>