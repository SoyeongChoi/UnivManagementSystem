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
  	
    %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>강의계획서</title>
</head>
<body>

   <h2>강의계획서 등록</h2>

   <input type="button" value="메인으로 돌아가기" onclick="main()">
   <script type="text/javascript">
    function main(){
       location.href="cookieProfessor.jsp";
    }
    </script>
   
   <br/>
   <br/>

   <form method="post" action="insertPlanPro.jsp">
		세부강의내용 : <input type="text" name="content" maxlength="200" required/><br /> 
		평가방법 : <input type="text" name="method" maxlength="100" required/><br />
		<input type="hidden" name="subjectCode" value="<%=code %>" >
		<input type="submit" value="등록">
	</form></form>
	
</body>
</html>