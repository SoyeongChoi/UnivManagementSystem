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
<title>성적관리</title>
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
		
		String lastSemester = request.getParameter("lastSemester");
		System.out.println(lastSemester);
	%>

	<h2>성적관리</h2>
	
	<form action="CookieStudent.jsp">
		<input type="submit" value="메인으로 돌아가기" onclick="main()">
	</form>

	<br />
	------------------------------------------------------------------------------------------------------------------------
	<h3>◆ 현재학기</h3>
		<table id="insertTable2" border="1" style="border-collapse: collapse">
			<tr>
				<th width=150>과목명</th>
				<th width=100>교수명</th>
				<th width=100>이수분야</th>
				<th width=100>수강학기</th>
				<th width=100>학점시수</th>
				<th width=100>학점</th>
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
			PreparedStatement p2 = null;
			ResultSet r2 = null;
			PreparedStatement p3 = null;
			ResultSet r3 = null;
			
			float numberxgrade=0; // 학점시수*학점의 총합
			float numberSum=0; //학점시수 총합
			
			try {
				conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

				p1 = conn.prepareStatement("select * from 수강 where 학생아이디=? and 수강학기=?");
				p1.setString(1,id);
				p1.setString(2,lastSemester);
				r1 = p1.executeQuery();

				while (r1.next()) {
				p2 = conn.prepareStatement("select * from 과목 where 과목코드=?");
				p2.setString(1, r1.getString("과목코드"));
				r2 = p2.executeQuery();
				
				if(r2.next()){
				numberSum += r2.getInt("학점시수");
				numberxgrade += r2.getInt("학점시수")*r1.getFloat("학점");
				%>
				
				var tr = document.createElement("tr");;
				
				var td0 = document.createElement("td");
				td0.setAttribute("width", "150");
				td0.innerText = "<%=r2.getString("과목명")%>";
				
				<%p3 = conn.prepareStatement("select 이름 from 회원 where 회원아이디=?");
				p3.setString(1, r2.getString("교수아이디"));
				r3 = p3.executeQuery();
				if (r3.next()) {%>
				var td1 = document.createElement("td");
				td1.setAttribute("width", "100");
				td1.innerText = "<%=r3.getString("이름")%>";
				<%}%>

				var td2 = document.createElement("td");
				td2.setAttribute("width", "100");
				td2.innerText = "<%=r2.getString("이수분야")%>";
				
				var td3 = document.createElement("td");
				td3.setAttribute("width", "100");
				td3.innerText = "<%=r1.getString("수강학기")%>";
				
				var td4 = document.createElement("td");
				td4.setAttribute("width", "100");
				td4.innerText = "<%=r2.getString("학점시수")%>";
				
				var td5 = document.createElement("td");
				td5.setAttribute("width", "100");
				td5.innerText = "<%=r1.getString("학점")%>";
				
				tr.appendChild(td0);
				tr.appendChild(td1);
				tr.appendChild(td2);
				tr.appendChild(td3);
				tr.appendChild(td4);
				tr.appendChild(td5);
		
				document.getElementById("insertTable2").appendChild(tr);
			<%
			}
			}
			}catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				if (r1 != null && r2 != null && r3 != null)
					try {
						r1.close();
						r2.close();
						r3.close();
					} catch (SQLException ex) {
					}
				if (p1 != null && p2 != null && p3 != null)
					try {
						p1.close();
						p2.close();
						p3.close();
					} catch (SQLException ex) {
					}
				if (conn != null)
					try {
						conn.close();
					} catch (SQLException ex) {
					}
			}%>
	</script>
	<b>평균학점 : <%=numberxgrade/numberSum%> </b> 
	<br/>
	
	
	<h3>◆ 전체학기</h3>
		<table id="insertTable" border="1" style="border-collapse: collapse">
			<tr>
				<th width=150>과목명</th>
				<th width=100>교수명</th>
				<th width=100>이수분야</th>
				<th width=100>수강학기</th>
				<th width=100>학점시수</th>
				<th width=100>학점</th>
			</tr>
		</table>
		<br/>
	
	<script>
	<%
			PreparedStatement p4 = null;
			ResultSet r4 = null;
			PreparedStatement p5 = null;
			ResultSet r5 = null;
			PreparedStatement p6 = null;
			ResultSet r6 = null;
			
			float numberxgrade2=0; // 학점시수*학점의 총합
			float numberSum2=0; //학점시수 총합
			
			try {
				conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

				p1 = conn.prepareStatement("select * from 수강 where 학생아이디=? and 수강학기<=?");
				p1.setString(1,id);
				p1.setString(2,lastSemester);
				r1 = p1.executeQuery();

				while (r1.next()) {
				p2 = conn.prepareStatement("select * from 과목 where 과목코드=?");
				p2.setString(1, r1.getString("과목코드"));
				r2 = p2.executeQuery();
				
				if(r2.next()){
				numberSum2 += r2.getInt("학점시수");
				numberxgrade2 += r2.getInt("학점시수")*r1.getFloat("학점");
				%>
				var tr = document.createElement("tr");;
				
				var td0 = document.createElement("td");
				td0.setAttribute("width", "150");
				td0.innerText = "<%=r2.getString("과목명")%>";
				
				<%p3 = conn.prepareStatement("select 이름 from 회원 where 회원아이디=?");
				p3.setString(1, r2.getString("교수아이디"));
				r3 = p3.executeQuery();
				if (r3.next()) {%>
				var td1 = document.createElement("td");
				td1.setAttribute("width", "100");
				td1.innerText = "<%=r3.getString("이름")%>";
				<%}%>

				var td2 = document.createElement("td");
				td2.setAttribute("width", "100");
				td2.innerText = "<%=r2.getString("이수분야")%>";
				
				var td3 = document.createElement("td");
				td3.setAttribute("width", "100");
				td3.innerText = "<%=r1.getString("수강학기")%>";
				
				var td4 = document.createElement("td");
				td4.setAttribute("width", "100");
				td4.innerText = "<%=r2.getString("학점시수")%>";
				
				var td5 = document.createElement("td");
				td5.setAttribute("width", "100");
				td5.innerText = "<%=r1.getString("학점")%>";
				
				tr.appendChild(td0);
				tr.appendChild(td1);
				tr.appendChild(td2);
				tr.appendChild(td3);
				tr.appendChild(td4);
				tr.appendChild(td5);
		
				document.getElementById("insertTable").appendChild(tr);
			<%
			}
			}
			}catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				if (r4 != null && r5 != null && r6 != null)
					try {
						r4.close();
						r5.close();
						r6.close();
					} catch (SQLException ex) {
					}
				if (p4 != null && p5 != null && p6 != null)
					try {
						p4.close();
						p5.close();
						p6.close();
					} catch (SQLException ex) {
					}
				if (conn != null)
					try {
						conn.close();
					} catch (SQLException ex) {
					}
			}%>
	</script>

	<b>평균학점 : <%=numberxgrade2/numberSum2%> </b> 