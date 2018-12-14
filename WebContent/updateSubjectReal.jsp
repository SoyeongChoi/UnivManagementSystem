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

<%
   String subjectCode = request.getParameter("subjectCode");//옛날 과목코드
   
   String subject = request.getParameter("subject");
   String strYear = request.getParameter("year");
   String strCreditNum = request.getParameter("creditNum");
   String major = request.getParameter("major");
   String course = request.getParameter("course");
   String strSemeter = request.getParameter("semester");
   String strPeopleNum = request.getParameter("peopleNum");
   String classNum = request.getParameter("classNum");
   int peopleNum = Integer.parseInt(strPeopleNum);
   int semester = Integer.valueOf(strSemeter);
   int year = Integer.valueOf(strYear);
   int creditNum = Integer.parseInt(strCreditNum);
   String professor = request.getParameter("select");
   
   String newSubjectCode = subject+"@"+classNum;//새로운 과목코드
   
   Class.forName("com.mysql.jdbc.Driver");
   String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
   String dbId = "root";
   String dbPass = "wjsgpals66";
   String real_id;
   int total = 0;
   PreparedStatement pstmt = null;
   PreparedStatement pstmtLec = null;
   PreparedStatement pstmtPlan = null;
   PreparedStatement pstmtSchedule = null;
   PreparedStatement pstmt2 = null;
   PreparedStatement pstmt3 = null;
   
   try {
      Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
      Statement stmt = conn.createStatement();
      
      
      //강의일정 코드에서 강의일정코드랑 과목코드 바꾼거!!!
      
      String checking = "select count(*) from 수강 where 과목코드 ='"+subjectCode+"'";
      ResultSet rs = stmt.executeQuery(checking);
      System.out.println(checking);
      rs.first();
      int count = rs.getInt(1);
      if (count > 0) {
         %>
         
         <script>
            alert("현재 강의중인 강의는 수정할 수 없습니다.");
            document.location.href='ManagingSubject.jsp';
         </script>
         <%
      }else{
      String Query = "select * from 강의계획서 where 과목코드='"+subjectCode+"'";
      System.out.println(Query);
      rs = stmt.executeQuery(Query);
      while(rs.next()){
         pstmtPlan = conn.prepareStatement("update 강의계획서 set 과목코드 = ? where 과목코드 = ?");
         pstmtPlan.setString(1, newSubjectCode);
         pstmtSchedule.setString(2, subjectCode);
         pstmtPlan.executeUpdate();
         
      }

      pstmt2 = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=0");
      pstmt2.executeQuery();
      pstmt = conn.prepareStatement("update 과목 set 과목코드 =?, 과목명=?, 학년 = ?,학점시수 = ?, 학과 = ?, 이수분야 = ?, 학기 = ?, 인원 = ?, 분반=?, 교수아이디 = ? where 과목코드 = ? ");
      pstmt.setString(1, newSubjectCode);
      pstmt.setString(2, subject);
      pstmt.setInt(3, year);
      pstmt.setInt(4, creditNum);
      pstmt.setString(5, major);
      pstmt.setString(6, course);
      pstmt.setInt(7, semester);
      pstmt.setInt(8, peopleNum);
      pstmt.setString(9, classNum);
      pstmt.setString(10, professor);
      pstmt.setString(11, subjectCode);
      
      //과목코드 과목명 학년 학점시수 학과 이수분야 학기 인원 분반 교수아이디
      //과목코드 :과목명+분반
      pstmt.executeUpdate();

      pstmt3 = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=1");
      pstmt3.executeQuery();
      }
      conn.close();
   } catch (SQLException e) {
      out.println(e.toString());
   }
%>

[과목명 : <%=subject %>]이 수정되었습니다.
<br />
<input type="button" value="돌아가기" onclick="main()">
<script type="text/javascript">
   function main() {
      location.href = "ManagingSubject.jsp";
   }
</script>