<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자등록</title>
</head>
<body>

<h2>관리자 등록</h2>
	<form method="post" action="insertManagerPro.jsp">
		아이디 : <input type="text" name="id" maxlength="30" required><br /> 
		성명 : <input type="text" name="name" maxlength="30" required><br /> 
		생년월일 : <input type="text" name="birth" maxlength="10" required value="19970000" onfocus="this.value=''""><br /> 
		직업 : <input type = "text" name="job" value="관리자" readonly><br/>
		<input type="submit" value="등록">
		<input type="reset" value="다시입력">
	</form>
</body>
</html>