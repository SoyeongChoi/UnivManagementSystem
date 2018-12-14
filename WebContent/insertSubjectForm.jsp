<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>과목등록</title>
</head>
<body>
<h2>과목등록</h2>
	<form method="post" action="insertSubjectPro.jsp">
		과목명 : <input type="text" name="subject" maxlength="50" required><br /> 
		학년 : <input type="number" name="year" maxlength="30" required><br />
		학점시수 : <input type="number" name="creditNum" maxlength="30" required><br /> 
		학기 : <input type="number" name="semester" maxlength="10" required><br/>
		인원 : <input type="number" name="peopleNum" maxlength="10" required><br/>
		학과 : <input type="text" name="major" maxlength="30" required><input type="submit" value="교수보기"></button><br /> 
		이수분야 : <input type="text" name="course" maxlength="30" ><br/>
		분반 : <input type="text" name="classNum" maxlength="10" ><br/>
		<input type="submit" value="등록">
		<input type="submit" value="메인으로 돌아가기"
		onclick="location.href='CookieManager.jsp'">
		<input type="reset" value="다시입력">
	</form>
</body>
</html>