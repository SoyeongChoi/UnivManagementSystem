<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="login.LogonDBBeanApplyLecture"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="plan" class="login.LogonDataBeanApplyLecture">
	<jsp:setProperty name="plan" property="*" />
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

    request.setCharacterEncoding("utf-8");
  	String code = request.getParameter("subjectCode");
  	System.out.println("sdsds"+code);
  	Class.forName("com.mysql.jdbc.Driver");
	String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
	String dbId = "root";
	String dbPass = "wjsgpals66";
	String temp = "";
	
	try {
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		PreparedStatement pstmt = conn.prepareStatement("select * from 회원 m, 수강 s where m.최근학기 = s.수강학기 and m.회원아이디 = s.학생아이디 and 과목코드 = ?");
		pstmt.setString(1, code);
		ResultSet rs = pstmt.executeQuery();
        rs.last();
        int count = rs.getRow();
        rs.beforeFirst();
        
        String[][] Grade = new String[count][8];
        
         int r=0; //행
        while(rs.next()) {
        	Grade[r][0] = Float.toString(rs.getFloat("학점"));
           	Grade[r][1] = Float.toString(rs.getFloat("중간고사"));
           	Grade[r][2] = Float.toString(rs.getFloat("기말고사"));
           	Grade[r][3] = Float.toString(rs.getFloat("출석"));
           	Grade[r][4] = rs.getString("학생아이디");
           	Grade[r][5] =  Integer.toString(rs.getInt("수강학기"));
           	Grade[r][6] = rs.getString("과목코드");
           	Grade[r][7] = rs.getString("교수아이디");	                    
                 r+=1;
        }
        
        		
  	
    %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>성적 입력</title>
</head>
<body>

	<h2>성적을 입력할 학생 선택</h2>

	<input type="button" value="메인으로 돌아가기" onclick="main()">
	<script type="text/javascript">
    function main(){
       location.href="cookieProfessor.jsp";
    }
    </script>

	<br />
	<br />

	<form method="post" action="insertGrade.jsp">
		<%
   if(Grade.length==0){
	   %>
		현재 수강중인 학생이 없습니다.<br />

		<%
   }else{ 
	   String[] confirm = new String[Grade.length];
	   %>
		<table border="1" style="border-collapse: collapse">
			<tr>
				<th></th>
				<th width="100">학번</th>
				<th width="100">성적 입력 여부</th>
			</tr>
			<%
	          

   for(int i=0; i<Grade.length; i++){
   %>
			<tr>
				<td><input type="radio" name="studentID"
					value=<%=Grade[i][4] %> onclick="disabledF()"></td>
				<td><%=Grade[i][4]%></td>
				<input type="hidden" name="subjectCode" value="<%=Grade[i][6]%>" />
				<%
   		if(Float.parseFloat(Grade[i][2])<0){
   			confirm[i] = "no";
   		 %>
				<td>X</td>
				<%}
   		else{
   			confirm[i] = "yes";
   		 %>
				<td>성적입력 완료</td>
				<%
   		}
   		%>

			</tr>
			<%
   
   }
	   
	   for(int i=0; i<confirm.length; i++){
		   if(confirm[i].equals("yes")){
			   temp = "yes";
		   }else{
			   temp = "no";
			   break;
		   }
	   }
   %>
		</table>
		<%
	   
   }conn.close();
	}catch(SQLException e){
		out.println(e.toString());
	}
   %>
		<input type="submit" name="modify" value="성적 입력" disabled />
		<script type="text/javascript">
   function disabledF(){
		document.getElementsByName('modify')[0].disabled = false;
	}
   </script>
	</form>
	<form method="post" action="gradeCalculate.jsp">
		<input type="hidden" name="confirm" value="<%=temp %>"> <input
			type="hidden" name="subjectCode" value="<%=code%>" /> <input
			type="submit" value="학점 계산" />
	</form>
</body>
</html>