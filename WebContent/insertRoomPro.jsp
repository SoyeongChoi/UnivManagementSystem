<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	Class.forName("com.mysql.jdbc.Driver");
	String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
	String dbId = "root";
	String dbPass = "wjsgpals66";
	PreparedStatement pstmt = null;
	try {
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		Statement stmt = conn.createStatement();
		String totalSql = "select count(*) from 강의실 where 강의실아이디 ='" + id + "'";
		ResultSet rs = stmt.executeQuery(totalSql);

		rs.first();
		int count = rs.getInt(1);
		if (count > 0) {
			%>
			<script type="text/javascript">
			alert("이미 등록되어있는 강의실입니다.")
			location.href = "ManagingLecture.jsp";
	
			</script>
			<%
		} else {
			
			pstmt = conn.prepareStatement("insert into 강의실 values(?)");
			System.out.println("TEST");
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		}
		rs.close();
		conn.close();
		stmt.close();
	} catch (SQLException e) {
		out.println(e.toString());
	}
%>

강의실[<%=id%>] 이 등록되었습니다.
<input type="button" value="강의실보기" onclick="main()">
<script type="text/javascript">
	function main() {
		location.href = "ManagingLecture.jsp";
	}
</script>
