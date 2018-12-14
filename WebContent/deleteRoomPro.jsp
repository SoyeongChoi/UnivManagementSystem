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

	int total = 0;
	try {
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		Statement stmt = conn.createStatement();
		String id = request.getParameter("mId");
		String totalSql = "select count(*) from 강의일정 where 강의실아이디='"+id+"'";
		ResultSet rs = stmt.executeQuery(totalSql);
		rs.first();
		int count = rs.getInt(1);
		if(count>0){
			%>
			<script>
				alert("강의를 하고있는 강의실은 삭제할 수 없습니다.");
				location.href="ManagingLecture.jsp";
			</script>
			<%
		}else{
			String sql = "delete from 강의실 where 강의실아이디 = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		

%>
강의실[<%=id%>]의 삭제가 완료되었습니다.
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

