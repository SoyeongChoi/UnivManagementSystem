<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import="login.LogonDBBean"%>
    <% request.setCharacterEncoding("UTF-8"); %>
      <jsp:useBean id="member" class="login.LogonDataBean">
    	<jsp:setProperty name="member" property="*"/>
    </jsp:useBean>
   
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
	LogonDBBean logon = LogonDBBean.getInstance();
	String[] Info = logon.getInfo(id);
	
	String passwd=Info[0];
	String name=Info[1];
	String job =Info[2];
	String birth = Info[3];
    %>
    
    <html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>회원 정보보기</title>
	</head>
	<body>
		<h2>회원 정보 보기</h2>
		<form method="post" action="updateManagerForm.jsp">
			아이디 : <%=id%> <br /> 
			비밀번호 : <%=passwd%> <br />
			성명 : <%=name%> <br /> 
			생년월일 : <%=birth%><br />
			직업 : <%=job %> <br/>
			
			<input type="submit" value="수정하기">
		</form>
		<input type="submit" value="메인으로 돌아가기" onclick="location.href='CookieManager.jsp'">
	</body>
	</html>