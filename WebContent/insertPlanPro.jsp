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
  	String content = request.getParameter("content");
  	String method = request.getParameter("method");
  	
    LogonDBBeanPlan r = LogonDBBeanPlan.getInstance();
    String[] old = r.getInfo(code);
    System.out.println(code);
    if(old[0]==null){
    	if(content!=null){
    		LogonDataBeanPlan r2 = new LogonDataBeanPlan();
            r2.setProfessor_id(id);
            r2.setContent(content);
            r2.setEvaluation_method(method);
            r2.setSubject_code(code);
            
            r.insertMember(r2);
            
           %>
            
            	강의 계획서가 등록되었습니다.<br/>
            	<br/>
            	<%
    	}else{
    		 %>
             
         	등록된 강의 계획서가 없습니다.<br/>
         	<form method="post" action="insertPlan.jsp">
         	<input type="hidden" name="subjectCode" value="<%=code %>"/>
         	<input type="submit" value="강의 계획서 등록">
         	</form>
         	<br/>
         	<%
    	}
    	
    }else{
    content = old[0];
    method = old[1];
    }
        	%>
    
    <form method="post" name="testform">
    <table id="insertTable" border="1" style="border-collapse:collapse">
      <tr>
         <th width=50></th>
         <th width=200>과목코드</th>
         <th width=200>세부강의내용</th>
         <th width=50>평가방법</th>
      </tr>
      <tr>
         <th width=50></th>
         <th width=200><%=code %></th>
         <th width=200><%=content %></th>
         <th width=200><%=method %></th>
      </tr>
      </table>
      <%
    if(content!=null){
    	%>
      <input type="hidden" name="subjectCode" value="<%=code %>"/>
      <input type="hidden" name="evaluation_method" value="<%=method %>"/>
      <input type="hidden" name="content" value="<%=content %>"/>
      <input type="button" value="수정" onClick="submitfuc(1)">
      <input type="button" value="삭제" onClick="submitfuc(2)">
      
 	<%
    }
    %>
    </form>
    <input type="button" value="메인으로 돌아가기" onclick="main()">
   <script type="text/javascript">
    function main(){
       location.href="cookieProfessor.jsp";
    }
    function submitfuc(index){ 
    if(index==1){
  	  document.testform.action="updatePlan.jsp";
    }else if(index==2){
  	  document.testform.action="deletePlan.jsp";
    }
    document.testform.submit();
 }
    </script>