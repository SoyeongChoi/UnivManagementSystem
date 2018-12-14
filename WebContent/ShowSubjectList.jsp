<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import="java.util.Calendar" %>
    <%@ page import = "login.LogonDBBeanSubject" %>
    <% request.setCharacterEncoding("UTF-8"); %>
      <jsp:useBean id="subject" class="login.LogonDataBeanSubject">
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

    LogonDBBeanSubject logon = LogonDBBeanSubject.getInstance();
   String[][] Info = logon.getInfoAll(id);
   System.out.println(id);
    %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>강의목록</title>
</head>
<body>

   <h2>강의 목록 확인 페이지</h2>

   <input type="button" value="메인으로 돌아가기" onclick="main()">
   <script type="text/javascript">
    function main(){
       location.href="cookieProfessor.jsp";
    }
    </script>
   
   <br/>
   <br/>

   <form method="post" name="testform">
   <table id="insertTable" border="1" style="border-collapse:collapse">
      <tr>
         <th width=50></th>
         <th width=200>과목코드</th>
         <th width=200>과목명</th>
         <th width=50>학년</th>
         <th width=100>학점시수</th>
         <th width=100>학과</th>
         <th width=100>이수분야</th>
         <th width=50>학기</th>
         <th width=50>분반</th>
      </tr>
      <%

      if(Info.length==0){
      %>
      <tr>
         <td colspan="9">현재 강의중인 강좌가 없습니다.</td>
      </tr>
      <%
         }else{      
        	 for(int i=0; i<Info.length; i++){
      %>
      <tr>
         <td><input type="radio" onclick="disabledF()" name="subjectCode" value="<%=Info[i][0]%>" ></td>
         <td><%=Info[i][0]%></td>
         <td><%=Info[i][1]%></td>
         <td><%=Info[i][2]%></td>
         <td><%=Info[i][3]%></td>
         <td><%=Info[i][4]%></td>
         <td><%=Info[i][5]%></td>
         <td><%=Info[i][6]%></td>
         <td><%=Info[i][8]%></td>
      </tr>
      <%
        	 }
         }
      %>
   </table>
   	<input type="button" onclick="submitfuc(2)" value="성적 등록" name="modify" disabled/>
	<input type="button" onclick="submitfuc(3)" value="강의 계획서 확인" name="modify" disabled/>

   </form>
    
    <script type="text/javascript">
   function submitfuc(index){ if(index==2){
    	  document.testform.action="selectStudent.jsp";
      }else if(index==3){
    	  document.testform.action="insertPlanPro.jsp";
      }
      document.testform.submit();
   }
   function disabledF(){
		document.getElementsByName('modify')[0].disabled = false;
		document.getElementsByName('modify')[1].disabled = false;
		document.getElementsByName('modify')[2].disabled = false;
	}
   </script>
</body>
</html>