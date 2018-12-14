 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <% request.setCharacterEncoding("UTF-8"); %>
   
    <%
    String id="";
   
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

   Class.forName("com.mysql.jdbc.Driver");
   String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
   String dbId = "root";
   String dbPass = "wjsgpals66";

   Connection conn = null;
   PreparedStatement p = null;
   ResultSet r = null;

   String academic=null;
   String passwd=null;
   String name=null;
   String birth=null;
   String major=null;
   String semester = null;
   try {
      conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
      
      p = conn.prepareStatement("select * from 회원 where 회원아이디=?"); //넘겨받은 과목
      p.setString(1, id);
      r = p.executeQuery();
      
      if(r.next()){
         academic = r.getString("학적");
         passwd = r.getString("비밀번호");
         name= r.getString("이름");
         birth = r.getString("생년월일");
         major = r.getString("학과");
         semester = r.getString("최근학기");
      }
      
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
    
    <html>
   <head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <title>학생 정보 수정</title>
   </head>
   <body>
      <h2>학생 정보 수정</h2>
      <form method="post" action="updateStudentPro.jsp">
            아이디 : <input type="text" name="id" value=<%=id%> maxlength="30" readonly><br /> 
            비밀번호 : <input type="text" name="passwd" value=<%=passwd%> maxlength="30"><br />
            성명 : <input type="text" name="name" value=<%=name%> maxlength="30"><br /> 
            생년월일 : <input type="number" name="birth" value=<%=birth%> maxlength="10"><br /> 
            학적 : <select name="academic">
            	<%if(academic.equals("재학")){
            		%>
            		<option value="재학" selected="selected">재학</option>
            		<option value="휴학">휴학</option>
            		<%
            	}else{
            	%><option value="재학">재학</option>
            		<option value="휴학"  selected="selected">휴학</option>
            	<%} %>
			</select>
			<br/>
            학과 : <input type="text" name="major" value="<%=major%>" maxlength="100"><br />
      최근학기: <input type="text" name="semester" value="<%=semester %>" maxlength="100" readonly><br/>   
         <input type="submit" value="수정하기">
      </form>
      <input type="submit" value="메인으로 돌아가기" onclick="location.href='CookieStudent.jsp'">
   </body>
   </html>