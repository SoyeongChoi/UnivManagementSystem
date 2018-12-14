<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="login.LogonDBBean"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");

	LogonDBBean logon = LogonDBBean.getInstance();
	int check = logon.userCheck(id, passwd);

	if (check == 1) { // 둘다 맞으면
		if(id.contains("manager")){
			Cookie cookie = new Cookie("id", id);
			cookie.setMaxAge(60*60*24); //1일
			response.addCookie(cookie);
			response.sendRedirect("CookieManager.jsp");
		}else if(id.contains("professor")){
			Cookie cookie = new Cookie("id", id);
			cookie.setMaxAge(60*60*24); //1일
			response.addCookie(cookie);
			response.sendRedirect("cookieProfessor.jsp");
		}else{
			Cookie cookie = new Cookie("id", id);
			cookie.setMaxAge(60*60*24); //1일
			response.addCookie(cookie);
			response.sendRedirect("CookieStudent.jsp");
		}
		
	} else if (check == 0) { // 패스워드 틀리면
		%>
		<script>
			alert("패스워드가 틀렸습니다.");
			history.back();
		</script>
		<%
	} else { // 아이디 틀리면
		%>
		<script>
			alert("아이디가 틀렸거나 존재하지 않는 아이디입니다.");
			history.back();
		</script>
		<%
	}
%>