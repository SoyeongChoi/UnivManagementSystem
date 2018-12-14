<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="login.LogonDBBean"%>

<jsp:useBean id="member" class="login.LogonDataBean">
	<jsp:setProperty name="member" property="*" />
</jsp:useBean>

<%
	Class.forName("com.mysql.jdbc.Driver");
	String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
	String dbId = "root";
	String dbPass = "wjsgpals66";
	String real_id;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt2 = null;
	PreparedStatement pstmt3 = null;

	int total = 0;
	try {
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		Statement stmt = conn.createStatement();
		String id = request.getParameter("LectureCode");
		String className = request.getParameter("className");
		String totalSql = "select count(*) from 수강 where 과목코드 ='"+className+"'";
		ResultSet rs = stmt.executeQuery(totalSql);
		rs.first();
		int count = rs.getInt(1);
		if(count>0){
			%>
			<script>
				alert("수강되고 있는 강의의 강의일정은 삭제할 수 없습니다.");
				location.href="ManagingLecture.jsp";
			</script>
			<%
		}else{	
			pstmt = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=0");
			pstmt.executeQuery();
			pstmt2 = conn.prepareStatement("delete from 강의일정 where 강의일정코드 = ?");
			pstmt2.setString(1, id);
			pstmt2.executeUpdate();
			pstmt3 = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=1");
			pstmt3.executeQuery();
		

%>
강의일정[<%=id%>]의 삭제가 완료되었습니다.
<%
		}
	conn.close();
	} catch (SQLException e) {
		out.println(e.toString());
	} finally {
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException ex) {
			}

	}
%>
<br />
<input type="button" value="강의실로 돌아가기" onclick="main()">
<script type="text/javascript">
	function main() {
		location.href = "ManagingLecture.jsp";
	}
</script>

