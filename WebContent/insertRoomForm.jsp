<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>강의실 등록</title>
</head>
<body>

<h2>강의실 등록</h2>

	<form method="post" action="insertRoomPro.jsp">
		강의실 호수 : <input type="text" name="id" maxlength="30" required><br /> 
		<input type="submit" value="등록">
	</form>
</body>
</html>