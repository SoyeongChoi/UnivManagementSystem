<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="login.LogonDBBean"%>

<%
   request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="member" class="login.LogonDataBean">
   <jsp:setProperty name="member" property="*" />
</jsp:useBean>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>강의실 수정PRO</title>
</head>
<body>
</body>
<%
String changeRoomId = request.getParameter("changeRoomId");//바뀐 강의실
//먼저 강의실에 대해서 시간 요일 체크해서 할수 있는지 없는지 alert창 띄우기

String changeDay = request.getParameter("changeDay");//바뀐 요일
//먼저 요일에 대해서 시간 요일 체크해서 할수 있는지 없는지 alert창 띄우기

String changeStime = request.getParameter("changeStime");
String changeEtime = request.getParameter("changeEtime");


String roomId =request.getParameter("roomId");//강의실
String day = request.getParameter("day");//요일
String LectureCode = request.getParameter("LectureCode");//강의일정코드
String className = request.getParameter("className");//수업이름
String eTime = request.getParameter("eTime");
String sTime = request.getParameter("sTime");


Class.forName("com.mysql.jdbc.Driver");
String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
String dbId = "root";
String dbPass = "wjsgpals66";
String real_id;
int total = 0;
PreparedStatement pstmt = null;
PreparedStatement pstmtDay = null;
PreparedStatement pstmtTime = null;
PreparedStatement pstmtRoom = null;

try {
   Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
   Statement stmt = conn.createStatement();
   
   if(changeRoomId != null){
      stmt = conn.createStatement();
      String totalSql = "select count(*) from 강의일정 where 강의실아이디='"+changeRoomId+"' and 요일='"+day+"' and 시작시간 ='"+sTime+"' and 종료시간='"+eTime+"'";
      ResultSet rs = stmt.executeQuery(totalSql);
      rs.first();
      int count = rs.getInt(1);
      if(count > 0){
         
      %>
      <script>
      <!-- 이거 만약에 존재하는 경우임 !!!! -->
         alert("선택하신 강의실에는 같은시간, 요일에 수업이 존재합니다.");
         history.go(-1);
      </script>
      
      <%
      }else{
         String newLectureCode[] = LectureCode.split("@");
         String newLC = newLectureCode[0]+"@"+newLectureCode[1]+"@"+newLectureCode[2]+"@"+newLectureCode[3]+"@"+changeRoomId;
         
         pstmt = conn.prepareStatement("update 강의일정 set 강의일정코드 =?, 강의실아이디 = ? where 강의일정코드 = ? ");
         pstmt.setString(1, newLC);
         pstmt.setString(2, changeRoomId);
         pstmt.setString(3, LectureCode);
         System.out.println(pstmt.toString());
         pstmt.executeUpdate();
         
         //과목코드 과목명 학년 학점시수 학과 이수분야 학기 인원 분반 교수아이디
         //과목코드 :과목명+분반
         String url= "updateLectureScheduleForm.jsp?className="+className+"&day="+day+"&eTime="+eTime+"&sTime="+sTime;
         %>
         <script>
            document.location.href='<%=url%>';
         </script>
         <%
         
         
      }
   }else if(changeDay != null){
      stmt = conn.createStatement();
      String totalSql = "select count(*) from 강의일정 where 강의실아이디='"+roomId+"' and 요일='"+changeDay+"' and 시작시간 ='"+sTime+"' and 종료시간='"+eTime+"'";
      ResultSet rs = stmt.executeQuery(totalSql);
      rs.first();
      int count = rs.getInt(1);
      if(count > 0){
         
      %>
      <script>
      <!-- 이거 만약에 존재하는 경우임 !!!! -->
         alert("선택하신 요일에는 같은시간에 수업이 존재합니다.");
         history.go(-1);
      </script>
      
      <%
      }else{

         String newLectureCode[] = LectureCode.split("@");
         String newLC = newLectureCode[0]+"@"+newLectureCode[1]+"@"+newLectureCode[2]+"@"+newLectureCode[3]+"@"+roomId;
         
         pstmt = conn.prepareStatement("update 강의일정 set 요일 =? where 강의일정코드 = ? ");
         pstmt.setString(1, changeDay);
         pstmt.setString(2, LectureCode);
         //과목코드 과목명 학년 학점시수 학과 이수분야 학기 인원 분반 교수아이디
         //과목코드 :과목명+분반
         pstmt.executeUpdate();
         /*
         String className = request.getParameter("className");//수업아이디
         String day = request.getParameter("day");
         String paramsEtime = request.getParameter("eTime");
         String paramsStime = request.getParameter("sTime");
         String check = request.getParameter("check");
         //input hidden을 code로 만들기
         --> 이거 보내야댐 
         */
         String url= "updateLectureScheduleForm.jsp?className="+className+"&day="+changeDay+"&eTime="+eTime+"&sTime="+sTime;
         %>
         <script>
            document.location.href='<%=url%>';
         </script>
         <%
         
      }
   }else if(changeEtime!=null){
      stmt = conn.createStatement();
      
      String Timequery = "select count(*) from 강의일정 where 강의일정코드='" + LectureCode + "'";
      ResultSet rs = stmt.executeQuery(Timequery);
      rs.first();
      System.out.println("TimeQuert" + Timequery);
      int count = Integer.valueOf(rs.getString(1));
      
      if (count > 0) {
      %>

         <script>
            alert("현재 강의는 같은 시간에 진행되고 있습니다.");
            history.go(-1);
         </script>

      <%
   } else {
         stmt = conn.createStatement();
      
         String newLectureCode[] = LectureCode.split("@");
         String newLC = newLectureCode[0]+"@"+newLectureCode[1]+"@"+changeStime+"@"+changeEtime+"@"+day;
         
         pstmt = conn.prepareStatement("update 강의일정 set 강의일정코드 =?, 시작시간 = ?, 종료시간 =? where 강의일정코드 = ? ");
         pstmt.setString(1, newLC);
         pstmt.setString(2, changeStime);
         pstmt.setString(3, changeEtime);
         pstmt.setString(4, LectureCode);
         System.out.println("$$$$$$$$$$"+pstmt.toString());
         pstmt.executeUpdate();
         
         //과목코드 과목명 학년 학점시수 학과 이수분야 학기 인원 분반 교수아이디
         //과목코드 :과목명+분반
         String url= "updateLectureScheduleForm.jsp?className="+className+"&day="+day+"&eTime="+changeEtime+"&sTime="+changeStime;
         %>
         <script>
            document.location.href='<%=url%>';
         </script>
         <%
      }
   }else{
      String url= "updateLectureScheduleForm.jsp?className="+className+"&day="+day+"&eTime="+eTime+"&sTime="+sTime;
      %>
      <script>
         document.location.href='<%=url%>';
      </script>
      <%
   }
   
   
//////여기에 그대로 붙여
   
   conn.close();
} catch (SQLException e) {
   out.println(e.toString());

}
%>

</html>