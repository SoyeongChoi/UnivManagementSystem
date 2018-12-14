<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Calendar"%>
<% request.setCharacterEncoding("UTF-8"); %>
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
     Class.forName("com.mysql.jdbc.Driver");
   String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
   String dbId = "root";
   String dbPass = "wjsgpals66";
   String temp = "";
   String[][] Info;
   int count=0;
   try {
      Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
      PreparedStatement pstmt = conn.prepareStatement("select s.과목코드  from 회원 m, 수강 s where m.최근학기 = s.수강학기 and m.회원아이디 = s.학생아이디 and s.학생아이디=?");
      pstmt.setString(1, id);
      ResultSet rs = pstmt.executeQuery();
      while(rs.next()) {
             PreparedStatement pstmt1 = conn.prepareStatement("select * from 강의일정 where 과목코드=?");
             pstmt1.setString(1,rs.getString("과목코드"));
            ResultSet rs1 = pstmt1.executeQuery();
             while(rs1.next()){
                count++;
          }
      }
         rs.beforeFirst();
        Info = new String[count][7];
        int r=0; //행
        while(rs.next()) {
           PreparedStatement pstmt1 = conn.prepareStatement("select * from 강의일정 where 과목코드=?");
            pstmt1.setString(1,rs.getString("과목코드"));
          ResultSet rs1 = pstmt1.executeQuery();
            
             
            while(rs1.next()) {
               Info[r][0] = rs1.getString("강의일정코드");
                Info[r][1] = String.valueOf(rs1.getInt("시작시간"));
                Info[r][2] = String.valueOf(rs1.getInt("종료시간"));
                Info[r][3] = String.valueOf(rs1.getInt("요일"));
                Info[r][4] = rs1.getString("과목코드");
                Info[r][5] = rs1.getString("강의실아이디");
                r+=1;
            }
        }

            %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>시간표</title>
</head>
<body>

   <h2>시간표</h2>

   <form action="CookieStudent.jsp">
      <input type="submit" value="메인으로 돌아가기" onclick="main()">
   </form>
   <script type="text/javascript">
      window.onload = function(){
         $('#timetable').hide();
         <% for(int i=0; i<Info.length; i++){
            System.out.println(Info[i][0]);
            //시작시간,요일,끝나는시간 순서
            String name = "'"+Info[i][4].split("@")[0]+" "+Info[i][4].split("@")[1]+"분반 "+Info[i][5]+"'";
            int start = Integer.parseInt(Info[i][1])-9;
            int week = Integer.parseInt(Info[i][3]);
            int end = Integer.parseInt(Info[i][2])-start-9;
            //System.out.println(week);
            %>
            setRowspan(<%=start%>,<%=week%>,<%=end%>,<%=name%>);
         <%}%>
         $('#timetable').show();
      }
   
      </script>
   <br />
   <br />
   <table border="1" id="timetable" style="border-collapse: collapse">

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
            <td><div class='className'></div></td>
            <td><div class='className'></div></td>
            <td><div class='className'></div></td>
            <td><div class='className'></div></td>
            <td><div class='className'></div></td>
         </tr>
         <tr>
         <th>10시</th>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         </tr>
         <tr>
         <th>11시</th>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         </tr>
         <tr>
         <th>12시</th>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         </tr>
         <tr>
         <th>13시</th>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         </tr>
         <tr>
         <th>14시</th>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         </tr>
         <tr>
         <th>15시</th>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         </tr>
         <tr>
         <th>16시</th>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         </tr>
         <tr>
         <th>17시</th>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         </tr>
         <tr>
         <th>18시</th>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         <td><div class='className'></div></td>
         </tr>
      </tbody>
   </table>
   <%
        conn.close();
   }catch(SQLException e){
      out.println(e.toString());
   }
   
   %>
   <script type="text/javascript">
      function setRowspan(rowIndex, colIndex, spanValue, className){
       $('#timetable > tbody > tr:eq('+rowIndex+') > td:eq('+colIndex+')').attr('rowspan',spanValue);
       $('#timetable > tbody > tr:eq('+rowIndex+') > td:eq('+colIndex+') > .className').html(className);
       for(i =1; i<spanValue; i++){
          var tempIndex = rowIndex+i;
          $('#timetable > tbody > tr:eq('+tempIndex+') > td:eq('+colIndex+')').hide();
       }
    }
      </script>


</body>

</html>