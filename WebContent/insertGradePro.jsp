<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "java.util.Calendar" %>
    <%@ page import = "login.LogonDBBeanApplyLecture" %>
    <%@ page import = "login.LogonDataBeanApplyLecture" %>

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
  	System.out.println(code);
  	String mid = request.getParameter("midterm");
  	String finals = request.getParameter("finals");
  	String student_id = request.getParameter("studentID");
  	String attend = request.getParameter("attend");
  	String semester = request.getParameter("semester");
  	String grade = request.getParameter("grade");
	Class.forName("com.mysql.jdbc.Driver");
	String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
	String dbId = "root";
	String dbPass = "wjsgpals66";
	
	if(Float.parseFloat(mid)>100||Float.parseFloat(mid)<0||Float.parseFloat(finals)>100||Float.parseFloat(finals)<0||Float.parseFloat(attend)<0||Float.parseFloat(attend)>10){
	%>
	<script>
	alert('입력이 잘못되었습니다!');
	</script>
	<%
	}else{
	try {
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		PreparedStatement pstmt = conn.prepareStatement("update 수강 set 중간고사=?, 기말고사=?, 출석=? where 학생아이디=? and 과목코드=?");
		pstmt.setString(1, mid);
		pstmt.setString(2, finals);
		pstmt.setString(3,attend);
		pstmt.setString(4,student_id);
		pstmt.setString(5,code);
		pstmt.executeUpdate();
		conn.close();
	}catch(SQLException e){
		out.println(e.toString());
	}

    %> 
    	성적 입력이 완료되었습니다.  
    <br/>
    <form action="selectStudent.jsp" method="post">
    <input type="hidden" name="subjectCode" value=<%=code %>>
    <input type="submit" value="나머지 학생 입력">
    </form>
    <input type="button" value="메인으로 돌아가기" onclick="main()">
   <script type="text/javascript">
    function main(){
       location.href="cookieProfessor.jsp";
    }
    </script>
    <%
	}
    %>