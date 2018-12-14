<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="login.*"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>장학조회</title>
</head>
<body>
	<%
		String id = "";

		try {
			Cookie[] cookies = request.getCookies();

			if (cookies != null) {
				for (int i = 0; i < cookies.length; i++) {
					if (cookies[i].getName().equals("id")) {
						id = cookies[i].getValue();
					}
				}
				if (id.equals("")) {
					response.sendRedirect("loginForm.jsp");
				}

			} else {
				response.sendRedirect("loginForm.jsp");
			}
		} catch (Exception e) {
		}
		System.out.println(id);
	%>

	<h2>장학조회</h2>
	
	<form action="CookieStudent.jsp">
		<input type="submit" value="메인으로 돌아가기" onclick="main()">
	</form>

	<br />
		<table id="insertTable2" border="1" style="border-collapse: collapse">
			<tr>
				<th width=100>선발학기</th>
				<th width=100>장학명</th>
				<th width=100>장학금액</th>
			</tr>
		</table>
		<br/>
	
	
	<script>
	<%Class.forName("com.mysql.jdbc.Driver");
			String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
			String dbId = "root";
			String dbPass = "wjsgpals66";

			Connection conn = null;
			PreparedStatement p1 = null;
			ResultSet r1 = null;
			
			try {
				conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

				p1 = conn.prepareStatement("select * from 장학 where 회원아이디=?");
				p1.setString(1,id);
				r1 = p1.executeQuery();
				
				while (r1.next()) {%>
				
				var tr = document.createElement("tr");;
				
				var td0 = document.createElement("td");
				td0.setAttribute("width", "100");
				td0.innerText = "<%=r1.getString("선발학기")%>";
				
				var td1 = document.createElement("td");
				td1.setAttribute("width", "100");
				td1.innerText = "<%=r1.getString("장학명")%>";
				
				var td2 = document.createElement("td");
				td2.setAttribute("width", "100");
				td2.innerText = "<%=r1.getString("장학금액")%>";
				
				tr.appendChild(td0);
				tr.appendChild(td1);
				tr.appendChild(td2);
		
				document.getElementById("insertTable2").appendChild(tr);
			<%
			}
			
			}catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				if (r1 != null)
					try {
						r1.close();
					} catch (SQLException ex) {
					}
				if (p1 != null)
					try {
						p1.close();
					} catch (SQLException ex) {
					}
				if (conn != null)
					try {
						conn.close();
					} catch (SQLException ex) {
					}
			}%>
	</script>
