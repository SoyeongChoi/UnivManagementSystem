<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "login.LogonDBBeanPlan" %>
   
    <% request.setCharacterEncoding("UTF-8"); %>
    
   <jsp:useBean id="plan" class="login.LogonDataBeanPlan">
    	<jsp:setProperty name="plan" property="*"/>
    </jsp:useBean>

    <%
    LogonDBBeanPlan logon = LogonDBBeanPlan.getInstance();
    logon.updatePlan(plan);
    %>
    
        강의계획서가 수정되었습니다.<br/>
    
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