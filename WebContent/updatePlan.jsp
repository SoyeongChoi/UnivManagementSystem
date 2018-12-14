<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import="java.util.Calendar" %>
    <%@ page import = "login.LogonDBBeanPlan" %>
    <% request.setCharacterEncoding("UTF-8"); %>
      <jsp:useBean id="plan" class="login.LogonDataBeanPlan">
       <jsp:setProperty name="plan" property="*"/>
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
  	String method = request.getParameter("evaluation_method");
  	String content = request.getParameter("content");
  	System.out.println("......."+code);
  	
    %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>강의계획서 수정</title>
</head>
<body>

   <h2>강의계획서 수정</h2>

   <input type="button" value="메인으로 돌아가기" onclick="main()">
   <script type="text/javascript">
    function main(){
       location.href="cookieProfessor.jsp";
    }
    </script>
   
   <br/>
   <br/>

   <form method="post" action="updatePlanPro.jsp">
		세부강의내용 : <input type="text" name="content" maxlength="200" value='<%=content %>' required><br /> 
		평가방법 : <input type="text" name="evaluation_method" maxlength="100" value='<%=method %>'required><br />
		<input type="hidden" name="subject_code" value='<%=code %>' >
		<input type="hidden" name="professor_id" value='<%=id %>'>
		<input type="submit" value="등록">
	</form></form>
	
</body>
</html>