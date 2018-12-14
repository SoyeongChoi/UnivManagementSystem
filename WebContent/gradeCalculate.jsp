<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="login.LogonDBBeanApplyLecture"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="plan" class="login.LogonDataBeanApplyLecture">
	<jsp:setProperty name="plan" property="*" />
</jsp:useBean>


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

	request.setCharacterEncoding("utf-8");
	String code = request.getParameter("subjectCode");
	String temp = request.getParameter("confirm");
	LogonDBBeanApplyLecture logon = LogonDBBeanApplyLecture.getInstance();
	String[][] Info = logon.getInfoAll(code);

	float[] total = new float[Info.length];
	final HashMap map = new HashMap();
	final HashMap map2 = new HashMap();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>학점 계산</title>
</head>
<body>

	<h2>학점 계산 완료</h2>
	
	<input type="button" value="메인으로 가기" onclick="main()">
	<script type="text/javascript">
		function main() {
			location.href = "cookieProfessor.jsp";
		}
	</script>
	
	<br />
	<br />

	<%
		if (Info == null) {
	%>
	현재 수강중인 학생이 없습니다.

	<%
		}else if(!temp.equals("yes")){
			%>
			<script>alert('성적이 모두 입력되지 않았습니다.');</script>
			<form method="post" action="selectStudent.jsp">
			<input type="submit" value="성적 입력하러 가기">
			<input type="hidden" name = "subjectCode" value="<%=code %>">
			</form>
			<%
		}
		else {

			for (int i = 0; i < Info.length; i++) {
				total[i] = (float) 0.45 * Float.parseFloat(Info[i][1]) + (float) 0.45 * Float.parseFloat(Info[i][2])
						+ (float) 0.1 * Float.parseFloat(Info[i][3]);
				if (Float.parseFloat(Info[i][3]) <= 4) {
					map2.put(Info[i][4], "0");
				} else if(Float.parseFloat(Info[i][2])>0){
					map.put(Info[i][4], String.valueOf(total[i]));
				}
			}
		System.out.println("**********"+code);
		List list = new ArrayList();
		list.addAll(map.keySet());
		Collections.sort(list, new Comparator() {
			public int compare(Object o1, Object o2) {
				Object v1 = map.get(o1);
				Object v2 = map.get(o2);
				return ((Comparable) v2).compareTo(v1);
			}
		});
		for (int i = 0; i < list.size(); i++) {
			if (i < (list.size() * 0.3)-1) {
				System.out.println(list.size()*0.3);
				map2.put(list.get(i), "4.5");
			} else if (i < (list.size() * 0.7)-1) {
				System.out.println(list.size());
				System.out.println((list.size()*0.7)-1);
				map2.put(list.get(i), "3.5");
			} else {
				map2.put(list.get(i), "2.5");
			}
		}
		
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcUrl = "jdbc:mysql://localhost:3306/university_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "wjsgpals66";
		try {
			Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			PreparedStatement pstmt = conn.prepareStatement("update 수강 set 학점=? where 학생아이디=? and 과목코드=?");
			Set set = map2.entrySet();
			Iterator iterator = set.iterator();
			while (iterator.hasNext()) {
				Map.Entry entry = (Map.Entry) iterator.next();
				pstmt.setString(1, (String) entry.getValue());
				pstmt.setString(2, (String) entry.getKey());
				pstmt.setString(3, code);
				pstmt.executeUpdate();
			}
		
			conn.close();
		} catch (SQLException e) {
			out.println(e.toString());
		}
		String[][] grade_info = logon.getInfoAll(code);
		%>
		<table border="1" style="border-collapse:collapse">
		<tr>
		<th width=70>학번</th>
		<th width=100>학점</th>
		</tr>
		
		<%
		for(int i=0; i<grade_info.length; i++){
			String grade_float = grade_info[i][0];
			String grade_char = "";
			if(grade_float.equals("4.5")){
				grade_char = "A+";
			}else if(grade_float.equals("3.5")){
				grade_char = "B+";
			}else if(grade_float.equals("0.0")){
				grade_char = "F";
			}else if(grade_float.equals("2.5")){
				grade_char = "C+";
			}else{
				grade_char = "성적입력 안됨";
			}
			%>
			<tr>
			<td><%=grade_info[i][4]%></td>
			<td><%=grade_char %></td>
			</tr>
			<%
		}
		}
	%>
	</table>
	<input type="hidden" name="subjectCode" value=<%=code%> />

</body>
</html>