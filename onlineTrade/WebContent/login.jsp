<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Log in</title>
<link rel="stylesheet" type="text/css" href="signupstyle.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
</head>
<body>
	<jsp:include page="header.html"></jsp:include>
	<div class="content">
		<h2>Log in</h2>
		<form action = "logToInd.jsp" method="GET" onsubmit="return Validate()" name="vform">
			<div class="blank">
				<div>
					<label>User Name: </label>
					<input type="text" name="username">
					<div id="uname_error"></div>
				</div>
				<br>
				<div>
					<label>Password: </label>
					<input type="password" name="password">
					<div id="password_error"></div>
				</div>
				<br>
				<br>
			</div>
			<div class="botton">
				<input type="submit" name="submit" value="Log in">	
			</div>
		</form>
			<%

			if (session.getAttribute("msg") == "wrong password")
			{
				out.println("<h3 style='color:#f44336; font-size:18px; font-family:'Poppins', sans-serif;'>");
				out.println("*Password is wrong.");
				out.println("</h3>");
			}
			else if (session.getAttribute("msg") == "user not exist")
			{
				out.println("<h3 style='color:#f44336; font-size:18px; font-family:'Poppins', sans-serif;'>");
				out.println("*User doesn't exist. Please Register first.");
				out.println("</h3>");
			}
			else
			{
				out.println("");
			}

			%>
	</div>
	
	

</body>
</html>


<script type="text/javascript">
	var username = document.forms["vform"]["username"];
	var password = document.forms["vform"]["password"];
	
	var uname_error = document.getElementById("uname_error");
	var password_error = document.getElementById("password_error");
	
	username.addEventListener("blur", unameVerify, true);
	password.addEventListener("blur", passwordVerify, true);

	function Validate()
	{
		if ((username.value == "")||(username.value == " "))
		{
			username.style.border = "2px solid #f44336";
			uname_error.textContent = "*User name is required.";
			username.focus();
			return false;
		}
		
		if (password.value == "")
		{
			password.style.border = "2px solid #f44336";
			password_error.textContent = "*Password is required.";
			password.focus();
			return false;
		}
		
	}
	
	function unameVerify()
	{
		if((username.value !="")&&(username.value !=" "))
		{
			username.style.border = "2px solid black";
			uname_error.innerHTML = "";
			return true;
		}
	}
	
	function passwordVerify()
	{
		if(password.value !="")
		{
			password.style.border = "2px solid black";
			password_error.innerHTML = "";
			return true;
		}
	}

</script>

