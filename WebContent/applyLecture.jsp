<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "login.*" %>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    
   <jsp:useBean id="apply" class="login.LogonDataBeanApplyLecture">
       <jsp:setProperty name="apply" property="*"/>
    </jsp:useBean>
    
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   <html>
   <head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <title>학생 수강신청</title>
   </head>
   <body>

    <script charset="UTF-8">
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
      
       String subjectCode = request.getParameter("subjectCode");  
       System.out.println("#################"+subjectCode);
       String pid = null;
       int semester = 0;
       Class.forName("com.mysql.jdbc.Driver");
      String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
      String dbId = "root";
      String dbPass = "wjsgpals66";
   
      Connection conn = null;
      PreparedStatement p = null;
      ResultSet r = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      PreparedStatement pstmt0 = null;
      ResultSet rs0 = null;
      PreparedStatement pstmt1 = null;
      ResultSet rs1 = null;
      PreparedStatement pstmt2 = null;
      ResultSet rs2 = null;
      PreparedStatement pstmt3 = null;
      ResultSet rs3 = null;
      PreparedStatement pstmt4 = null;
      ResultSet rs4 = null;
      
      int sTime = 0;
      int eTime = 0;
      String day = null;
      int peopleMAX = 0;
      int people = 0;
      int overlapSubject=0;
      int overlapTime=0;
      
      try {
         conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
         
         p = conn.prepareStatement("select * from 강의일정 where 과목코드=?"); //넘겨받은 과목
         p.setString(1, subjectCode);
         r = p.executeQuery();

         pstmt3 = conn.prepareStatement("select * from 과목 where 과목코드=?"); //넘겨받은 과목
         pstmt3.setString(1, subjectCode);
         rs3 = pstmt3.executeQuery();
         if(rs3.next()){
            peopleMAX = Integer.valueOf(rs3.getString("인원"));
            System.out.println("최대인원"+peopleMAX);
         }
         
         pstmt2 = conn.prepareStatement("select 최근학기 from 회원 where 회원아이디=?");
         pstmt2.setString(1,id);
         rs2 = pstmt2.executeQuery();
   
         while (rs2.next()) {
            semester = Integer.valueOf(rs2.getString("최근학기"))+1;
         }
         
         
         pstmt4 = conn.prepareStatement("select * from 수강 where 과목코드=?");
         pstmt4.setString(1, subjectCode);
         rs4 = pstmt4.executeQuery();
         while(rs4.next()){
            people++;
         }
         System.out.println("인원"+people);
            
         
         while (r.next()) { //수강신청하려는 과목의 정보
            sTime = Integer.valueOf(r.getString("시작시간"));
            eTime = Integer.valueOf(r.getString("종료시간"));
            day = r.getString("요일");
            
            pstmt = conn.prepareStatement("select 과목코드, 수강학기 from 수강 where 학생아이디=?");
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {  //학생이 수강했던 +하는 모든과목
               pstmt0 = conn.prepareStatement("select * from 강의일정 where 과목코드=?"); //과목에 대한 정보 모두 가져옴
               pstmt0.setString(1, rs.getString("과목코드"));
               System.out.println("*****"+rs.getString("과목코드"));
               if(rs.getString("과목코드").split("@")[0].equals(subjectCode.split("@")[0])){
                  System.out.println("과목겹침");
                  overlapSubject++;
                  break;
               }
               
               rs0 = pstmt0.executeQuery();
               while(rs0.next()){ // 과목 정보 차례로 가져옴
                  if(Integer.parseInt(rs.getString("수강학기"))==semester){
                  if(rs0.getString("요일").equals(day)==false){ //요일이 안겹치면
                     System.out.println("요일안겹침");
                  }else{
                     if(Integer.valueOf(rs0.getString("시작시간"))>=eTime || Integer.valueOf(rs0.getString("종료시간"))<=sTime){//안겹침
                        System.out.println("시간안겹침");
                     }
                     else{//겹침
                        System.out.println("시간겹침");
                        overlapTime++;
                        break;
                     }
                  }
                  }
               }
            }
         }
            if(people+1>peopleMAX){%>
               alert("인원이 초과하였습니다.");
                document.location.href="applyLectureManagement.jsp?lastSemester=<%=request.getParameter("lastSemester")%>";
            <%
            }
            else if(overlapTime!=0){%>
                alert("중복된 시간입니다.");
                document.location.href="applyLectureManagement.jsp?lastSemester=<%=request.getParameter("lastSemester")%>";
            <%
            }
            else if(overlapSubject!=0){%>
               alert("이미 신청한 과목입니다.");
                document.location.href="applyLectureManagement.jsp?lastSemester=<%=request.getParameter("lastSemester")%>";
            <%
            }
            else{
            
               pstmt1 = conn.prepareStatement("select 교수아이디 from 과목 where 과목코드=?");
               pstmt1.setString(1, subjectCode);
               rs1 = pstmt1.executeQuery();
         
               while (rs1.next()) {
                  pid = rs1.getString("교수아이디");
               }
               
               LogonDBBeanApplyLecture logon = LogonDBBeanApplyLecture.getInstance();
                apply.setProfessorID(pid);
                System.out.println(pid);
                apply.setSemester(semester);
                System.out.println(semester);
                apply.setStudentID(id);
                System.out.println(id);
                apply.setSubjectCode(subjectCode);
                System.out.println(subjectCode);
                logon.insertApplyLecture(apply);
                
               %>
               alert("수강신청이 성공하였습니다.");
                document.location.href="applyLectureManagement.jsp?lastSemester=<%=request.getParameter("lastSemester")%>";
                <%
         }
         
      }catch (Exception ex) {
         ex.printStackTrace();
      } finally {
         if (r!=null && rs != null && rs0 != null && rs1 != null && rs2 != null)
            try {
               r.close();
               rs.close();
               rs0.close();
               rs1.close();
               rs2.close();
            } catch (SQLException ex) {
            }
         if (p!=null && pstmt != null && pstmt0 != null && pstmt1 != null && pstmt2 != null)
            try {
               p.close();
               pstmt.close();
               pstmt0.close();
               pstmt1.close();
               pstmt2.close();
            } catch (SQLException ex) {
            }
         if (conn != null)
            try {
               conn.close();
            } catch (SQLException ex) {
            }
      }
      %>
    </script>
    
    </body>
   </html>