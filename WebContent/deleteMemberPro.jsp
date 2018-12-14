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
		String totalSql = "select count(*) from 과목 where 교수아이디='"+id+"'";
		ResultSet rs = stmt.executeQuery(totalSql);
		rs.first();
		int count = rs.getInt(1);
		totalSql = "select count(*) from 회원 where 직업='관리자'";
		ResultSet rs2 = stmt.executeQuery(totalSql);
		rs2.first();
		int count2 = rs2.getInt(1);
		
		if(count>0){
			%>
			<script>
				alert("강의가 배정된 교수는 삭제할 수 없습니다.");
				location.href="ManagingMember.jsp";
			</script>
			<%
		}else if(count2<2){
			%>
			<script>
				alert("최소 한명의 관리자는 존재해야 합니다.");
				history.go(-1);
			</script>
			<%
		}else{
			String sql = "delete from 회원 where 회원아이디 = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		

%>
<%=id%>님의 탈퇴가 완료되었습니다.
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
<input type="button" value="메인으로 돌아가기" onclick="main()">
<script type="text/javascript">
	function main() {
		location.href = "CookieManager.jsp";
	}
</script>

