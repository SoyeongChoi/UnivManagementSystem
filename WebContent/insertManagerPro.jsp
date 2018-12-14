<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "login.LogonDBBean" %>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    
   <jsp:useBean id="member" class="login.LogonDataBean">
       <jsp:setProperty name="member" property="*"/>
    </jsp:useBean>

    <%
    LogonDBBean logon = LogonDBBean.getInstance();
    Class.forName("com.mysql.jdbc.Driver");
   String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
   String dbId = "root";
   String dbPass = "wjsgpals66";
   String real_id;
   Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
   Statement stmt = conn.createStatement();
   
   PreparedStatement pstmt = null;String totalSql = "select count(*) from 회원 where 회원아이디='"+member.getId()+"'";
   ResultSet rs = stmt.executeQuery(totalSql);
   String temp = member.getId();
   rs.first();
   int count = rs.getInt(1);
   if(count>0){
      %>
      <script>
         alert("이미 존재하는 아이디입니다.");
         history.go(-1);
      </script>
      <%
   }else{

    
    if(!member.getId().contains("manager")){
    %><script type="text/javascript">
       alert("manager가 포함되지 않은 아이디는 생성할 수 없습니다.");
       location.href="insertManagerForm.jsp";
    </script>
    
   <%
    }else{
       logon.insertMember(member);   
   }
   }
   %>
    
    <jsp:getProperty property="name" name="member"/>님 을 추가하였습니다.<br/>
    <input type="button" value="돌아가기" onclick="login()">
    <script type="text/javascript">
    function login(){
       location.href="CookieManager.jsp";
    }
    </script>