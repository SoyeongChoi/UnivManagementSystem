<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    <%@ page import = "java.sql.*" %>
   <%@ page import="java.util.Calendar" %>
    <%@ page import = "login.LogonDBBeanSchedule" %>
    <% request.setCharacterEncoding("UTF-8"); %>
      <jsp:useBean id="schedule" class="login.LogonDataBeanSchedule">
       <jsp:setProperty name="schedule" property="*"/>
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

    LogonDBBeanSchedule logon = LogonDBBeanSchedule.getInstance();
   String[][] Info = logon.getInfoAll(id);
    %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>강의시간표</title>
</head>
<body>
	
   <h2>강의 시간표</h2>

   <input type="button" value="메인으로 돌아가기" onclick="main()">
  <script type="text/javascript">
   	window.onload = function(){
   		$('#timetable').hide();
   		<% for(int i=0; i<Info.length; i++){
   			//시작시간,요일,끝나는시간 순서
   			String name = "'"+Info[i][4].split("@")[0]+" "+Info[i][4].split("@")[1]+"분반 "+Info[i][5]+"'";
   			int start = Integer.parseInt(Info[i][1])-9;
   			int week = Integer.parseInt(Info[i][3]);
   			int end = Integer.parseInt(Info[i][2])-start-9;
   			System.out.println(week);
   			%>
   			setRowspan(<%=start%>,<%=week%>,<%=end%>,<%=name%>);
   		<%}%>
   		$('#timetable').show();
   	}
   
   	</script>
    <br/>
   <br/>
   <table border="1" id="timetable" style="border-collapse:collapse">
   
   <thead>
   <tr>
   <th>/</th>
   <th width="100">월</th>
   <th width="100">화</th>
   <th width="100">수</th>
   <th width="100">목</th>
   <th width="100">금</th>
   </tr>
   </thead>
   <tbody>
   <tr>
    <th>9시</th>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   </tr>
   <tr>
    <th>10시</th>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   </tr>
   <tr>
    <th>11시</th>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   </tr>
   <tr>
    <th>12시</th>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   </tr>
   <tr>
    <th>13시</th>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   </tr>
   <tr>
    <th>14시</th>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   </tr>
   <tr>
    <th>15시</th>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   </tr>
   <tr>
    <th>16시</th>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   </tr>
   <tr>
    <th>17시</th>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   </tr>
   <tr>
    <th>18시</th>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   <td><div class = 'className'></div></td>
   </tr>
   </tbody>
   </table>
   	<script type="text/javascript">
   	function setRowspan(rowIndex, colIndex, spanValue, className){
    	$('#timetable > tbody > tr:eq('+rowIndex+') > td:eq('+colIndex+')').attr('rowspan',spanValue);
    	$('#timetable > tbody > tr:eq('+rowIndex+') > td:eq('+colIndex+') > .className').html(className);
    	for(i =1; i<spanValue; i++){
    		var tempIndex = rowIndex+i;
    		$('#timetable > tbody > tr:eq('+tempIndex+') > td:eq('+colIndex+')').hide();
    	}
    }
	function main(){
        location.href="cookieProfessor.jsp";
     }
   	</script>
    
    
   </body>
   
</html>