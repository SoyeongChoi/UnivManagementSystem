<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="login.LogonDBBeanSubject"%>

<jsp:useBean id="member" class="login.LogonDataBeanSubject">
	<jsp:setProperty name="member" property="*" />
</jsp:useBean>

<%
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "wjsgpals66";
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		Statement stmt = conn.createStatement();
		stmt = conn.createStatement();
		String subjectCode = request.getParameter("subjectCode");
		LogonDBBeanSubject logon = LogonDBBeanSubject.getInstance();
		PreparedStatement pstmt = null;

		ResultSet rs = null;
			String checking = "select count(*) from 강의일정 where 과목코드 ='"+subjectCode+"'";
			rs = stmt.executeQuery(checking);
			rs.first();
			int count = rs.getInt(1);
		
			if (count > 0) {
				%>
				
				<script>
					alert("현재 강의중인 강의는 삭제할 수 없습니다.");
					history.go(-1);
				</script>
				<%
			}else{
				
				pstmt = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=0");
				pstmt.executeQuery();
				pstmt = conn.prepareStatement("delete from 과목 where 과목코드 = ?");
				pstmt.setString(1, subjectCode);
				pstmt.executeUpdate();
				pstmt = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=1");
				pstmt.executeQuery();

			}
		
%>
<%=subjectCode %>과목을 삭제하였습니다.
<br />
<input type="submit" value="돌아가기" onclick="main()">
<script type="text/javascript">
	function main() {
		location.href = "ManagingSubject.jsp";
	}
</script>