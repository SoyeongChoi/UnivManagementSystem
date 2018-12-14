<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 완료</title>
</head>
<body>
   <b><%=id %></b>님이 로그인하셨습니다.
   <form method="post" action = "cookieLogout.jsp">
      <input type="submit" value = "로그아웃">
   </form>
   <form method="post" action = "updateMemberForm.jsp">
      <input type="submit" value = "회원정보수정">
   </form>
   <!-- 강의 관리 안에서 성적입력, 강의계획서 등록 -->
   <form method="post" action = "ShowSubjectList.jsp">
      <input type="submit" value = "강의관리">
   </form>
   <form method="post" action = "movieChart.jsp">
      <input type="submit" value = "시간표확인">
   </form>
</body>
</html>