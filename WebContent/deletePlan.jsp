<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "java.util.Calendar" %>
    <%@ page import = "login.LogonDBBeanPlan" %>
    <%@ page import = "login.LogonDataBeanPlan" %>

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
    request.setCharacterEncoding("utf-8");
  	String code = request.getParameter("subjectCode");
	Class.forName("com.mysql.jdbc.Driver");
	String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
	String dbId = "root";
	String dbPass = "wjsgpals66";

	try {
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		PreparedStatement pstmt = conn.prepareStatement("delete from 강의계획서 where 과목코드=?");
		pstmt.setString(1, code);
		pstmt.executeUpdate();
		conn.close();
	}catch(SQLException e){
		out.println(e.toString());
	}

    %> 
    	강의 계획서가 삭제되었습니다.  
    <br/>
    <form name=testform>
      <input type="button" value="강의 목록 보기" onclick="submitfuc(1)">
    <input type="button" value="메인으로 돌아가기" onclick="submitfuc(2)">
    </form>
   <script type="text/javascript">
   function submitfuc(index){ 
	    if(index==1){
	  	  document.testform.action="ShowSubjectList.jsp";
	    }else if(index==2){
	  	  document.testform.action="cookieProfessor.jsp";
	    }
	    document.testform.submit();
   }
    </script>