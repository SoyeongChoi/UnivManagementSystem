<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="login.LogonDBBeanSubject"%>
<%
   request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="Subject" class="login.LogonDataBeanSubject">
   <jsp:setProperty name="Subject" property="*" />
</jsp:useBean>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>강의실 일정 수정</title>
</head>
<%
   String roomId =request.getParameter("roomId");//강의실
   String day = request.getParameter("day");//요일
   String subject = request.getParameter("subject");   
   String professorId = request.getParameter("professor");
   LogonDBBeanSubject logon = LogonDBBeanSubject.getInstance();
   Class.forName("com.mysql.jdbc.Driver");
   String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
   String dbId = "root";
   String dbPass = "wjsgpals66";
   String real_id;
   String strDay = null;
   String professor = null;
   List<String> StartRealTime = new ArrayList<String>();
   for(int i = 9; i <= 18; i++){
      StartRealTime.add(String.valueOf(i));
   }
 
   List<String> EndRealTime = new ArrayList<String>();
   for(int i = 10; i <= 19; i++){
      EndRealTime.add(String.valueOf(i));
   }
   switch(day){
   case "0":
      strDay="월";
      break;
   case "1":
      strDay="화";
      break;
   case "2":
      strDay="수";
      break;
   case "3":
      strDay="목";
      break;
   case "4":
      strDay="금";
      break;
   }
   int total = 0;
   String[] arrRoom = null;
   String[] arrSTime = null;
   String[] arrETime = null;
   
   try {
      Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
      Statement stmt = conn.createStatement();
      
      List<String> startTime = new ArrayList<String>();
      List<String> endTime = new ArrayList<String>();
      Statement stmtT = conn.createStatement();
      String Timequery = "select 시작시간, 종료시간 from 강의일정 where 강의실아이디='"+roomId+"'"+ "and 요일='"+day+"'";
      
      ResultSet rs = stmtT.executeQuery(Timequery);
      while (rs.next()) {
         startTime.add(rs.getString(1));
         endTime.add(rs.getString(2));
         System.out.println("!!!!!!!!!!!!!!!!"+rs.getString(1)+" "+rs.getString(2));
         
      }
      arrSTime = new String[startTime.size()];
      arrETime = new String[endTime.size()];
      for (int i = 0; i < startTime.size(); i++) {
         arrSTime[i] = startTime.get(i);
         System.out.println("%%%%%%%%"+arrSTime[i]);
         StartRealTime.remove(startTime.get(i));
         int temp = Integer.parseInt(endTime.get(i))-1;
         StartRealTime.remove(String.valueOf(temp));
      }
      for (int i = 0; i < endTime.size(); i++) {
         arrETime[i] = endTime.get(i);
         EndRealTime.remove(endTime.get(i));
         int temp = Integer.parseInt(startTime.get(i))+1;
         EndRealTime.remove(String.valueOf(temp));
      }

      
%>


<body>
<h2><%=roomId %> 일정 추가</h2>

      <input type="submit" value="강의일정으로 돌아가기"
      onclick="location.href='insertLectureScheduleForm.jsp?roomId=<%=roomId%>'">
   <form method="post" name ="updateForm">
   <input type="hidden" name = "roomId" value="<%=roomId %>">
   <input type="hidden" name = "subject" value="<%=subject %>">
   <input type="hidden" name = "day" value="<%=day %>">
   <input type="hidden" name="professor" value="<%=professorId %>">
         <table>
         <tr>
            <td>과목 : </td>
            <td><%=subject%></td>
         </tr>
         <tr>
            <td>요일 : </td>
            <td> <%=strDay %></td>
         </tr>
         <tr>
            <td>시간 : </td>
            <td>시작시간
                  <br/>
                  <select id="select" name="sTime">
                  <option value="sTime" disabled>시작시간 선택</option>
                  <%int j = 0;
                  for(int i = 0; i < StartRealTime.size(); i++){

                        %>
                
                  <option value="<%=StartRealTime.get(i)%>"><%=StartRealTime.get(i)%></option>
         
                  <% 
               }%>
               </select>
               <br/>
               종료시간
               <br/>
               <select id="select" name="eTime">
                  <option value="changeEtime" disabled>종료시간 선택</option>
         		  <%
                  for(int i = 0; i < EndRealTime.size(); i++){

                        %>
                
                  <option value="<%=EndRealTime.get(i)%>"><%=EndRealTime.get(i)%></option>
         
                  <% 
               }%>
               </select>
               
               </td>
         </tr>
      </table>
      <br/>
      <input type="submit" value="등록" onclick="d()">
      <input type="submit" value="삭제">   
   </form>
   
</body>
<%
rs.close();
      conn.close();
      stmt.close();
   } catch (SQLException e) {
      out.println(e.toString());
   }
%>
<script type="text/javascript">
   function a(){
      var f = document.updateForm;
      f.action="ChangeRoom.jsp";
      f.submit();
   }
   function b(){
      var f = document.updateForm;
      f.action="SelectDay.jsp";
      f.submit();
   }
   function c(){
      var f = document.updateForm;
      f.action="SelectTime.jsp";
      f.submit();
   }
   function d(){
      var f = document.updateForm;
      f.action="insertLectureScheduleReal.jsp";
      f.submit();
   }
</script>

</html>