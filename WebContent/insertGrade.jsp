<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import="java.util.Calendar" %>
    <%@ page import = "login.LogonDBBeanApplyLecture" %>
    <% request.setCharacterEncoding("UTF-8"); %>
      <jsp:useBean id="subject" class="login.LogonDataBeanApplyLecture">
       <jsp:setProperty name="subject" property="*"/>
    </jsp:useBean>
   
    
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

    LogonDBBeanApplyLecture logon = LogonDBBeanApplyLecture.getInstance();
    String code = request.getParameter("subjectCode");
    String student_id = request.getParameter("studentID");
   	Class.forName("com.mysql.jdbc.Driver");
	String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
	String dbId = "root";
	String dbPass = "wjsgpals66";

	int total = 0;
	try {

		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		Statement stmt = conn.createStatement();
		String Sql = "select * from 수강 where 학생아이디='"+student_id+"' and 과목코드='"+code+"'";
		ResultSet rs = stmt.executeQuery(Sql);
		String[] list = new String[5];
		while (rs.next()) {
			list[0] = rs.getString("학점");
			list[1] = rs.getString("중간고사");
			list[2] = rs.getString("기말고사");
			list[3] = rs.getString("출석");
			list[4] = rs.getString("수강학기");
		}
		
    %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>성적입력</title>
</head>
<body>

   <h2>성적 입력 페이지</h2>

   <input type="button" value="메인으로 돌아가기" onclick="main()">
   <script type="text/javascript">
    function main(){
       location.href="cookieProfessor.jsp";
    }
    </script>
   
   <br/>
   <br/>

   <form method="post" action="insertGradePro.jsp">
   		학번: <%=student_id %><br /> 
		중간고사 성적(0~100) : <input type="text" name="midterm" maxlength="30" value=<%=list[1] %> required><br /> 
		기말고사 성적(0~100) : <input type="text" name="finals" maxlength="30" value=<%=list[2] %> required><br />
		출석 점수(0~10): <input type="text" name="attend" maxlength="30" value=<%=list[3] %> required><br />
		<input type="hidden" name="subjectCode" value=<%=code%> >
		<input type="hidden" name="studentID" value=<%=student_id %>>
		<input type="hidden" name="semester" value=<%=list[4] %>>
		<input type="hidden" name="grade" value=<%=list[0] %>>
		<input type="submit" value="등록">
	</form>
    <%
    rs.close();
	stmt.close();
	conn.close();
		} catch (SQLException e) {
			out.println(e.toString());
		}
    %>
    
</body>
</html>

