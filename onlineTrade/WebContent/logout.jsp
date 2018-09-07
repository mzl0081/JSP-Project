<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Log out</title>
<link rel="stylesheet" type="text/css" href="signupstyle.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
</head>
<body>
	<jsp:include page="header.html"></jsp:include>
	<div class="content">
	<%
		session.removeAttribute("username");
		session.invalidate();
	%>

		<h3 style="color:black; font-size:24px; font-family:'Poppins', sans-serif;">
		You've been successfully Log out!
		</h3>
		<br>
		<h3 style="color:black; font-size:24px; font-family:'Poppins', sans-serif;">
			<a href='index.jsp'>Please Go to the Home Page.</a>
		</h3>
	</div>


</body>
</html>