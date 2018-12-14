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
   <title>강의계획서 조회</title>
   </head>
   <body>
   
   <input type="button" value="돌아가기" onclick="back()">
   <br/><br/>
    <script charset="UTF-8">
    
    function back(){
       history.go(-1);   
    }
    
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
      %>
      
      <%
       
       Class.forName("com.mysql.jdbc.Driver");
      String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
      String dbId = "root";
      String dbPass = "wjsgpals66";
   
      Connection conn = null;
      PreparedStatement p = null;
      ResultSet r = null;
      PreparedStatement p2 = null;
      ResultSet r2 = null;
      
      String subjectCode = request.getParameter("subjectCode");
      
      System.out.println("subjectCode"+subjectCode);
      String detail=null;
      String professorID=null;
      String evaluate=null;
      String subject = subjectCode.split("@")[0];
      String professorName=null;
      
      try {
         conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
         
         p = conn.prepareStatement("select * from 강의계획서 where 과목코드=?"); //넘겨받은 과목
         p.setString(1, subjectCode);
         r = p.executeQuery();
         
         if (r.next()) {
            detail=r.getString("세부강의내용");
            professorID=r.getString("교수아이디");
            evaluate=r.getString("평가방법");
         }
         
         p2 = conn.prepareStatement("select 이름 from 회원 where 회원아이디=?"); //넘겨받은 과목
         p2.setString(1, professorID);
         r2 = p2.executeQuery();
         
         if (r2.next()){
            professorName = r2.getString("이름");
         }
         
         
      }catch (Exception ex) {
         ex.printStackTrace();
      } finally {
         if (r!=null && r2!=null)
            try {
               r.close();
               r2.close();
            } catch (SQLException ex) {
            }
         if (p!=null && p2!=null)
            try {
               p.close();
               p2.close();
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
      
      <%if(professorName!=null){ %>
      
      <table border="1" style="border-collapse: collapse">
      <tr>
         <th>과목</th>
         <td><%=subject%></td>
      </tr>
      <tr>
         <th>교수명</th>
         <td><%=professorName%></td>
      </tr>
      <tr>
         <th>강의내용</th>
         <td><%=detail%></td>
      </tr>
      <tr>
         <th>평가방법</th>
         <td><%=evaluate%></td>
      </tr>
      
      </table>
      
      <%}else{%>
         정보가 존재하지 않습니다.
      <%}%>