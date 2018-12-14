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
   String roomId = request.getParameter("roomId");//강의실
   String day = request.getParameter("day");//요일
   String subject = request.getParameter("subject");//수업이름
   String eTime = request.getParameter("eTime");
   String sTime = request.getParameter("sTime");
   String professor = request.getParameter("professor");
   String LectureCode = subject + "@" + sTime + "@" + eTime + "@" + day;
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
         String startQuery = "select count(*) from 강의일정 where 시작시간 ='" + sTime + "' and 요일 ='" + day
               + "' and 강의실아이디='" + roomId + "'";
         System.out.println("CHE" + startQuery);
         rs = stmt.executeQuery(startQuery);
         rs.first();
         int che = Integer.valueOf(rs.getString(1));
         
   
         if (che>0) {
%>

<script>
            alert("다른강의와 강의시간이 겹칩니다.");
            history.go(-1);
         </script>

<%
   } else {
            String findProfessor = "select 교수아이디 from 과목 where 과목코드='" + subject + "'";
            rs = stmt.executeQuery(findProfessor);
            System.out.println("prof" + findProfessor);
            
            rs.first();
            String professorID = rs.getString(1);

            pstmt = conn.prepareStatement("insert into 강의일정 values(?, ?, ?, ?, ?, ?,?)");
            pstmt.setString(1, LectureCode);
            pstmt.setString(2, sTime);
            pstmt.setString(3, eTime);
            pstmt.setString(4, day);
            pstmt.setString(5, subject);
            pstmt.setString(6, professorID);
            pstmt.setString(7, roomId);
            pstmt.executeUpdate();

            //과목코드 과목명 학년 학점시수 학과 이수분야 학기 인원 분반 교수아이디
            //과목코드 :과목명+분반
         }
      }
      String url = "insertLectureScheduleForm.jsp?roomId=" + roomId;
%>
<script>
            document.location.href='<%=url%>';
   
</script>
<%
   conn.close();
   } catch (SQLException e) {
      out.println(e.toString());

   }
%>

</html>