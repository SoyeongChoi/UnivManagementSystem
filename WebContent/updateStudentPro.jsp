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
      
         String academic=request.getParameter("academic");
      String passwd=request.getParameter("passwd");
      String name=request.getParameter("name");
      String major=request.getParameter("major");
      String birth = request.getParameter("birth");

      Class.forName("com.mysql.jdbc.Driver");
      String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
      String dbId = "root";
      String dbPass = "wjsgpals66";

      Connection conn = null;
      PreparedStatement p = null;
      ResultSet r = null;      
      
      try{

      conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
      
      p = conn.prepareStatement("update 회원 set 학적=? ,비밀번호=?, 이름=?, 학과=?, 생년월일 = ? where 회원아이디=?"); //넘겨받은 과목
      p.setString(1, academic);
      p.setString(2, passwd);
      p.setString(3, name);
      p.setString(4, major);
      p.setString(5, birth);
      p.setString(6, id);
      System.out.println(academic);
      System.out.println(passwd);
      System.out.println(name);
      System.out.println(major);
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
      
         정보수정이 완료되었습니다.
      <br/>
      <input type="submit" value="메인으로 돌아가기" onclick="location.href='CookieStudent.jsp'">