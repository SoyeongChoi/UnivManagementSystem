<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "login.*" %>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    
   <jsp:useBean id="apply" class="login.LogonDataBeanApplyLecture">
    	<jsp:setProperty name="apply" property="*"/>
    </jsp:useBean>
    
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>학생 수강취소</title>
	</head>
	<body>

    <script charset="UTF-8">
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
		
    	String subjectCode = request.getParameter("subjectCode");
    	
	    Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "wjsgpals66";
	
		Connection conn = null;
		PreparedStatement p = null;
		
		try {
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			
			p = conn.prepareStatement("delete from 수강 where 학생아이디=? and 과목코드=?"); //넘겨받은 과목
			p.setString(1, id);
			p.setString(2, subjectCode);
			p.executeUpdate();
			
		}catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (p != null)
				try {
					p.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		%>
		alert("수강취소가 완료되었습니다.");
	    document.location.href="applyLectureManagement.jsp?lastSemester=<%=request.getParameter("lastSemester")%>";
    </script>
    
    </body>
	</html>
			