<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>강의실 보기</title>
</head>
<body>
   <h2>강의실 정보</h2>
   <br />
   <br />
   <input type="submit" onclick="location.href='insertRoomForm.jsp'"
      value="강의실 추가하기">

   <%
      Class.forName("com.mysql.jdbc.Driver");
      String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
      String dbId = "root";
      String dbPass = "wjsgpals66";
      String real_id;
      int total = 0;
      try {
         Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
         Statement stmt = conn.createStatement();
         String totalSql = "select * from 강의실";
         ResultSet rs = stmt.executeQuery(totalSql);

         if (rs.next()) {
            total += 1;
         }

         String listSql = "select 강의실아이디 from 강의실";
         rs = stmt.executeQuery(listSql);
   %>
   <table class="body row-clickable" border="1"
      style="border-collapse: collapse; text-align: center">
      <tr>
         <th width="100">강의실</th>
         <th width="200">강의 일정 등록하기</th>
         <th width="100">삭제하기</th>
      </tr>
      <%
         if (total == 0) {
      %>
      <tr>
         <td colspan="3">현재 추가한 강의실이 없습니다.</td>
      </tr>
      <%
         } else {
               while (rs.next()) {
                  String id = rs.getString(1);
      %>
      <tr>
         <td><%=id%></td>
         <td><form>
               <input type="button" value="강의일정"
                  onclick="location.href='insertLectureScheduleForm.jsp?roomId=<%=id%>'">
            </form></td>
         <td>
            <form>
               <input type="button" value="삭제"
                  onclick="location.href='deleteRoomPro.jsp?mId=<%=id%>'">
            </form>
         </td>
      </tr>
      <%
         }
            }
      %>
   </table>

   <%
      rs.close();
         conn.close();
         stmt.close();
      } catch (SQLException e) {
         out.println(e.toString());
      }
   %>
   <input type="button" value="메인으로 돌아가기" onclick="goTheaterManagement()">
   <script type="text/javascript">
      function goTheaterManagement() {
         location.href = "CookieManager.jsp";
      }
   </script>

   <script type="text/javascript">
      function button_event(x) {
         if (confirm("정말 삭제하시겠습니까?")) { //확인
            location.href = "deleteRoomPro.jsp?mId=" + x;
         } else {
            return;
         }
      }
   </script>
</body>
</html>