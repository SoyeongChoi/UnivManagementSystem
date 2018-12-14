<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인</title>
</head>
<body>
<%
	String id = "";
	try{
		Cookie[] cookies = request.getCookies();
		if(cookies != null){
			for(int i =0; i<cookies.length;i++){
				if(cookies[i].getName().equals("id")){
					id = cookies[i].getValue();
				}
			}
			if(id.equals("")){
				response.sendRedirect("loginForm.jsp");
			}
		}else{
			response.sendRedirect("loginForm.jsp");
		}
	}catch(Exception e){
		
	}
%>
	<h2>관리자 페이지</h2>
	<b><%=id %></b>님이 로그인하셨습니다.
	<form method="post" action = "cookieLogout.jsp">
		<input type="submit" value = "로그아웃">
	</form>
	<form method="post" action = "lookingManagerInfo.jsp">
		<input type="submit" value = "내정보보기">
	</form>
	<form method="post" action = "ManagingSubject.jsp">
		<input type="submit" value = "과목관리">
	</form>
   <form method="post" action = "ManagingLecture.jsp">
   		<input type="submit" value="강의일정관리">
   </form>
	<form method="post" action = "insertScholarship.jsp">
      <input type="submit" value = "장학자선발">
   </form>
   <form method="post" action = "ManagingMember.jsp">
   		<input type="submit" value="사용자관리">
   </form>
   <!-- 사용자 관리에서 등록 및 수정 진행 -->
   
</body>
</html>