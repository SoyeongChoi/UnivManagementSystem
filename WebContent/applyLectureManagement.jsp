<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="login.*"%>

<%
   request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수강신청관리</title>
</head>
<body>
   <%
      String id = "";

      try {
         Cookie[] cookies = request.getCookies();

         if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
               if (cookies[i].getName().equals("id")) {
                  id = cookies[i].getValue();
               }
            }
            if (id.equals("")) {
               response.sendRedirect("loginForm.jsp");
            }

         } else {
            response.sendRedirect("loginForm.jsp");
         }
      } catch (Exception e) {
      }
      System.out.println(id);
      
      String nextSemester = request.getParameter("lastSemester");
      nextSemester = String.valueOf(Integer.parseInt(nextSemester)+1);
      String nextSemester2;
      if(Integer.parseInt(nextSemester)%2==0){
         nextSemester2 = "2";
      }else{
         nextSemester2 = "1";
      }
   %>

   <h2>수강신청관리</h2>
   
   <form action="CookieStudent.jsp">
      <input type="submit" value="메인으로 돌아가기" onclick="main()">
   </form>

   <br />
   ------------------------------------------------------------------------------------------------------------------------
   <h3>◆ 수강신청내역</h3>
   <form name="testform2" method="post" id="formT2" accept-charset="UTF-8">
      <input type="hidden" name="lastSemester" value="<%=request.getParameter("lastSemester")%>">
      <table id="insertTable2" border="1" style="border-collapse: collapse">
         <tr>
            <th width=50></th>
            <th width=100>과목명</th>
            <th width=100>분반</th>
            <th width=100>학과</th>
            <th width=100>학년</th>
            <th width=100>학기</th>
            <th width=100>학점시수</th>
            <th width=100>이수분야</th>
            <th width=100>교수명</th>
            <th width=100>요일</th>
            <th width=100>시작시간</th>
            <th width=100>종료시간</th>
            <th width=100>강의실</th>
         </tr>
      </table>
      <br/>
      
      <input type="button" onclick="submitfunc(2)" value="수강취소" id="modify2" disabled>
      <input type="button" onclick="submitfunc(4)" value="강의계획서 조회" id="modify4" disabled>
   </form>
   
   <script type="text/javascript">
   function submitfunc(index){
      if(index==1){
         document.testform.action="applyLecture.jsp";
         document.testform.submit();
      }
      if(index==2){
         if(confirm("정말 취소하시겠습니까?") == true){    //확인
            document.testform2.action="cancelLecture.jsp";
            document.testform2.submit();
         }else{   //취소
             return;
         }
      }
      if(index==3){
         document.testform.action="showSubjectSchedule.jsp";
         document.testform.submit();
      }
      if(index==4){
         document.testform2.action="showSubjectSchedule.jsp";
         document.testform2.submit();
      }
   }
   </script>
   
   <script>
   function check_Day(day){
      var strDay = null;
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
         return strDay;
   }
   
   </script>
   
   <script>
   <%Class.forName("com.mysql.jdbc.Driver");
         String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
         String dbId = "root";
         String dbPass = "wjsgpals66";

         Connection conn = null;
         PreparedStatement p1 = null;
         ResultSet r1 = null;
         PreparedStatement p2 = null;
         ResultSet r2 = null;
         PreparedStatement p3 = null;
         ResultSet r3 = null;
         PreparedStatement p4 = null;
         ResultSet r4 = null;
         
         try {
            conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

            p1 = conn.prepareStatement("select 과목코드 from 수강 where 학생아이디=? and 수강학기=?");
            p1.setString(1,id);
            p1.setString(2,nextSemester);
            r1 = p1.executeQuery();
            int r = 0; // 행

            while (r1.next()) {
            System.out.println("s");
            p2 = conn.prepareStatement("select * from 과목 where 과목코드=?");
            p2.setString(1, r1.getString("과목코드"));
            r2 = p2.executeQuery();
            if(r2.next()){%>
            var tr = document.createElement("tr");;
            
            var td = document.createElement("td");
            td.setAttribute("width", "50");
            
            var radio = document.createElement("input");
            radio.setAttribute("type", "radio");
            radio.setAttribute("name", "subjectCode");
            radio.setAttribute("value", "<%=r2.getString("과목코드")%>");
            radio.setAttribute("onclick", "disabledF2()");
            td.appendChild(radio);
            
            var td0 = document.createElement("td");
            td0.setAttribute("width", "100");
            td0.innerText = "<%=r2.getString("과목명")%>";
            
            var td1 = document.createElement("td");
            td1.setAttribute("width", "100");
            td1.innerText = "<%=r2.getString("분반")%>";
            
            var td2 = document.createElement("td");
            td2.setAttribute("width", "100");
            td2.innerText = "<%=r2.getString("학과")%>";
            
            var td3 = document.createElement("td");
            td3.setAttribute("width", "100");
            td3.innerText = "<%=r2.getString("학년")%>";
            
            var td4 = document.createElement("td");
            td4.setAttribute("width", "100");
            td4.innerText = "<%=r2.getString("학기")%>";
            
            var td5 = document.createElement("td");
            td5.setAttribute("width", "100");
            td5.innerText = "<%=r2.getString("학점시수")%>";
            
            var td6 = document.createElement("td");
            td6.setAttribute("width", "100");
            td6.innerText = "<%=r2.getString("이수분야")%>";
            
               
            <%p3 = conn.prepareStatement("select 이름 from 회원 where 회원아이디=?");
               p3.setString(1, r2.getString("교수아이디"));
               r3 = p3.executeQuery();
               if (r3.next()) {%>
               var td7 = document.createElement("td");
               td7.setAttribute("width", "100");
               td7.innerText = "<%=r3.getString("이름")%>";
               <%}

               p4 = conn.prepareStatement("select * from 강의일정 where 과목코드=? order by 요일 desc");
               p4.setString(1, r2.getString("과목코드"));
               r4 = p4.executeQuery();

               if (r4.next()) {%>
            
               var td8 = document.createElement("td");
               td8.setAttribute("width", "100");
               td8.innerText = check_Day("<%=r4.getString("요일")%>");
               
               var td9 = document.createElement("td");
               td9.setAttribute("width", "100");
               td9.innerText = "<%=r4.getString("시작시간")%>";
               
               var td10 = document.createElement("td");
               td10.setAttribute("width", "100");
               td10.innerText = "<%=r4.getString("종료시간")%>";
               
               var td11 = document.createElement("td");
               td11.setAttribute("width", "100");
               td11.innerText = "<%=r4.getString("강의실아이디")%>";
               
               <%if (r4.next()) {%>
               
               td8.innerText = check_Day("<%=r4.getString("요일")%>")+"\n"+td8.innerText;
               td9.innerText = "<%=r4.getString("시작시간")%>"+"\n"+td9.innerText;
               td10.innerText = "<%=r4.getString("종료시간")%>"+"\n"+td10.innerText;
               td11.innerText = "<%=r4.getString("강의실아이디")%>" + "\n" + td11.innerText;
               
               <%}%>
               tr.appendChild(td);
               tr.appendChild(td0);
               tr.appendChild(td1);
               tr.appendChild(td2);
               tr.appendChild(td3);
               tr.appendChild(td4);
               tr.appendChild(td5);
               tr.appendChild(td6);
               tr.appendChild(td7);
               tr.appendChild(td8);
               tr.appendChild(td9);
               tr.appendChild(td10);
               tr.appendChild(td11);
   
               document.getElementById("insertTable2").appendChild(tr);
               <%}%>

               <%r++;
         }
         }
         }catch (Exception ex) {
            ex.printStackTrace();
         } finally {
            if (r1 != null && r2 != null && r3 != null && r4 != null)
               try {
                  r1.close();
                  r2.close();
                  r3.close();
                  r4.close();
               } catch (SQLException ex) {
               }
            if (p1 != null && p2 != null && p3 != null && p4 != null)
               try {
                  p1.close();
                  p2.close();
                  p3.close();
                  p4.close();
               } catch (SQLException ex) {
               }
            if (conn != null)
               try {
                  conn.close();
               } catch (SQLException ex) {
               }
         }%>
   </script>

   <h3>◆ 수강신청</h3>
   <form name="testform" method="post" id="formT" accept-charset="UTF-8">
   <input type="hidden" name="lastSemester" value="<%=request.getParameter("lastSemester")%>">
      <table id="insertTable" border="1" style="border-collapse: collapse">
         <tr>
            <th width=50></th>
            <th width=100>과목명</th>
            <th width=100>분반</th>
            <th width=100>학과</th>
            <th width=100>학년</th>
            <th width=100>학기</th>
            <th width=100>학점시수</th>
            <th width=100>이수분야</th>
            <th width=100>교수명</th>
            <th width=100>요일</th>
            <th width=100>시작시간</th>
            <th width=100>종료시간</th>
            <th width=100>강의실</th>
         </tr>
      </table>
      <br/>
      
      <input type="button" onclick="submitfunc(1)" value="수강신청" id="modify" disabled>
      <input type="button" onclick="submitfunc(3)" value="강의계획서 조회" id="modify3" disabled>
   </form>

   <script>
   <%
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         PreparedStatement pstmt2 = null;
         ResultSet rs2 = null;
         PreparedStatement pstmt3 = null;
         ResultSet rs3 = null;
         
         try {
            conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

            pstmt = conn.prepareStatement("select * from 과목 where 학기=?");
            pstmt.setString(1, nextSemester2);
            rs = pstmt.executeQuery();

            int r = 0; // 행

            while (rs.next()) {%>
            
            var tr = document.createElement("tr");;
            
            var td = document.createElement("td");
            td.setAttribute("width", "50");
            
            var radio = document.createElement("input");
            radio.setAttribute("type", "radio");
            radio.setAttribute("name", "subjectCode");
            radio.setAttribute("value", "<%=rs.getString("과목코드")%>");
            radio.setAttribute("onclick", "disabledF()");
            td.appendChild(radio);
            
            var td0 = document.createElement("td");
            td0.setAttribute("width", "100");
            td0.innerText = "<%=rs.getString("과목명")%>";
            
            var td1 = document.createElement("td");
            td1.setAttribute("width", "100");
            td1.innerText = "<%=rs.getString("분반")%>";
            
            var td2 = document.createElement("td");
            td2.setAttribute("width", "100");
            td2.innerText = "<%=rs.getString("학과")%>";
            
            var td3 = document.createElement("td");
            td3.setAttribute("width", "100");
            td3.innerText = "<%=rs.getString("학년")%>";
            
            var td4 = document.createElement("td");
            td4.setAttribute("width", "100");
            td4.innerText = "<%=rs.getString("학기")%>";
            
            var td5 = document.createElement("td");
            td5.setAttribute("width", "100");
            td5.innerText = "<%=rs.getString("학점시수")%>";
            
            var td6 = document.createElement("td");
            td6.setAttribute("width", "100");
            td6.innerText = "<%=rs.getString("이수분야")%>";
            
               
            <%pstmt2 = conn.prepareStatement("select 이름 from 회원 where 회원아이디=?");
               pstmt2.setString(1, rs.getString("교수아이디"));
               rs2 = pstmt2.executeQuery();
               if (rs2.next()) {%>
               var td7 = document.createElement("td");
               td7.setAttribute("width", "100");
               td7.innerText = "<%=rs2.getString("이름")%>";
            <%}

               pstmt3 = conn.prepareStatement("select * from 강의일정 where 과목코드=? order by 요일 desc");
               pstmt3.setString(1, rs.getString("과목코드"));
               rs3 = pstmt3.executeQuery();

               if (rs3.next()) {%>
            
               var td8 = document.createElement("td");
               td8.setAttribute("width", "100");
               td8.innerText = check_Day("<%=rs3.getString("요일")%>");
               
               var td9 = document.createElement("td");
               td9.setAttribute("width", "100");
               td9.innerText = "<%=rs3.getString("시작시간")%>";
               
               var td10 = document.createElement("td");
               td10.setAttribute("width", "100");
               td10.innerText = "<%=rs3.getString("종료시간")%>";
               
               var td11 = document.createElement("td");
               td11.setAttribute("width", "100");
               td11.innerText = "<%=rs3.getString("강의실아이디")%>";
               
               <%if (rs3.next()) {%>
               
               td8.innerText = check_Day("<%=rs3.getString("요일")%>")+"\n"+td8.innerText;
               td9.innerText = "<%=rs3.getString("시작시간")%>"+"\n"+td9.innerText;
               td10.innerText = "<%=rs3.getString("종료시간")%>"+"\n"+td10.innerText;
               td11.innerText = "<%=rs3.getString("강의실아이디")%>" + "\n" + td11.innerText;
               <%}%>

               tr.appendChild(td);
               tr.appendChild(td0);
               tr.appendChild(td1);
               tr.appendChild(td2);
               tr.appendChild(td3);
               tr.appendChild(td4);
               tr.appendChild(td5);
               tr.appendChild(td6);
               tr.appendChild(td7);
               tr.appendChild(td8);
               tr.appendChild(td9);
               tr.appendChild(td10);
               tr.appendChild(td11);
               
               document.getElementById("insertTable").appendChild(tr);
               <%}%>
         <%r++;
            }
         }
         catch (Exception ex) {
            ex.printStackTrace();
         } finally {
            if (rs != null && rs2 != null && rs3 != null)
               try {
                  rs.close();
                  rs2.close();
                  rs3.close();
               } catch (SQLException ex) {
               }
            if (pstmt != null && pstmt2 != null && pstmt3 != null)
               try {
                  pstmt.close();
                  pstmt2.close();
                  pstmt3.close();
               } catch (SQLException ex) {
               }
            if (conn != null)
               try {
                  conn.close();
               } catch (SQLException ex) {
               }
         }%>
      function disabledF() {
         document.getElementById("modify").disabled = false;
         document.getElementById("modify3").disabled = false;
      }
      function disabledF2() {
         document.getElementById("modify2").disabled = false;
         document.getElementById("modify4").disabled = false;
      }
   </script>
</body>
</html>