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
   String subjectCode = subject+"@"+classNum;
   Class.forName("com.mysql.jdbc.Driver");
   String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
   String dbId = "root";
   String dbPass = "wjsgpals66";
   String real_id;
   int total = 0;
   PreparedStatement pstmt = null;

   try {
      Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
      Statement stmt = conn.createStatement();
      pstmt = conn.prepareStatement("insert into 과목 values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
      pstmt.setString(1, subjectCode);
      pstmt.setString(2, subject);
      pstmt.setInt(3, year);
      pstmt.setInt(4, creditNum);
      pstmt.setString(5, major);
      pstmt.setString(6, course);
      pstmt.setInt(7, semester);
      pstmt.setInt(8, peopleNum);
      pstmt.setString(9, classNum);
      pstmt.setString(10, professor);
      
      //과목코드 과목명 학년 학점시수 학과 이수분야 학기 인원 분반 교수아이디
      //과목코드 :과목명+분반
      pstmt.executeUpdate();
      conn.close();
   } catch (SQLException e) {
      out.println(e.toString());
   }
%>

[과목명 : <%=subject %>]이 등록되었습니다.
<br />
<input type="button" value="돌아가기" onclick="main()">
<script type="text/javascript">
   function main() {
      location.href = "ManagingSubject.jsp";
   }
</script>