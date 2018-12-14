<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 완료</title>
</head>
<body>
   <b id="n"></b>님이 로그인하셨습니다.
   <form method="post" action = "cookieLogout.jsp">
      <input type="submit" value = "로그아웃">
   </form>
   <form method="post" action = "updateStudentForm.jsp">
      <input type="submit" value = "회원정보보기">
   </form>
   <form method="post" id="lectureMF" action = "applyLectureManagement.jsp">
      <input type="submit" id="lectureM" value = "수강관리">
   </form>
   <form method="post" id="gradeMF" action = "gradeManagement.jsp">
      <input type="submit" value = "성적관리">
   </form>
   	<form method="post" id="scholar" action = "getInfoScholar.jsp">
		<input type="submit" value = "장학조회">
	</form>
   <form method="post" action = "showTableStudent.jsp">
      <input type="submit" value = "시간표보기">
   </form>
<script>
<%
   String id = "";
   try{
      Cookie[] cookies = request.getCookies();
      if(cookies != null){
         for(int i =0; i<cookies.length;i++){
            if(cookies[i].getName().equals("id")){
               id = cookies[i].getValue();
               %>
               document.getElementById("n").innerText="<%=id%>";
               <%
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
   
   Class.forName("com.mysql.jdbc.Driver");
   String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
   String dbId = "root";
   String dbPass = "wjsgpals66";

   Connection conn = null;
   PreparedStatement p = null;
   ResultSet r = null;
   String academic=null;
   String semester=null;
   try {
      conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
      
      p = conn.prepareStatement("select 학적, 최근학기 from 회원 where 회원아이디=?"); //넘겨받은 과목
      p.setString(1, id);
      r = p.executeQuery();
      
      if(r.next()){
         academic = r.getString("학적");
         semester = r.getString("최근학기");
      }
      System.out.print(semester);
      %>
      
      var form = document.getElementById("lectureMF");
      var input1 = document.createElement("input");
      input1.setAttribute("type", "hidden");
      input1.setAttribute("name", "lastSemester");
      input1.setAttribute("value", "<%=semester%>");
      form.appendChild(input1);
      
      var form2 = document.getElementById("gradeMF");
      var input2 = document.createElement("input");
      input2.setAttribute("type", "hidden");
      input2.setAttribute("name", "lastSemester");
      input2.setAttribute("value", "<%=semester%>");
      form2.appendChild(input2);
      <%
      if(academic.equals("휴학")==true){%>
         document.getElementById("lectureM").disabled = true;
      <%}
      
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
</script>
   
   
</body>
</html>