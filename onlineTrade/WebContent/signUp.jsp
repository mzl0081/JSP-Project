<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register</title>
<link rel="stylesheet" type="text/css" href="signupstyle.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
</head>
<body>
	<jsp:include page="header.html"></jsp:include>
	<div class="content">
		<h2>Register</h2>
		<form action="resToLog.jsp" method="GET" onsubmit="return Validate()" name="vform">
			<div class="blank">
				<div>
				<div>
					<label>User Name: </label>
					<input type="text" name="username">
					<div id = "uname_error"></div>
				</div>
				<br>
				<div>
					<label>Email: </label>
					<input type="text" name="email">
					<div id = "email_error"></div>
				</div>
				<br>
				<div>
					<label>Password: </label>
					<input type="password" name="password">
					<div id = "password_error"></div>
				</div>
				<br>
				<div>
					<label>Confirm Password: </label>
					<input type="password" name="conpwd">
					<div id = "cpassword_error"></div>
				</div>
				<br>
				<br>
			</div>
			<div class="botton">
				<input type="submit" name="submit" value="Sign Up">	
			</div>
		</form>
	</div>
	
</body>
</html>

<script type="text/javascript">
	//getting all input objects
	var username = document.forms["vform"]["username"];
	var email = document.forms["vform"]["email"];
	var password = document.forms["vform"]["password"];
	var conpwd = document.forms["vform"]["conpwd"];
	var emailFormat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

	//getting all error display objects
	var uname_error = document.getElementById("uname_error");
	var email_error = document.getElementById("email_error");
	var password_error = document.getElementById("password_error");
	var cpassword_error = document.getElementById("cpassword_error");


	//setting all event listeners
	username.addEventListener("blur", unameVerify, true);
	email.addEventListener("blur", emailVerify, true);
	password.addEventListener("blur", passwordVerify, true);

	//validation function
	function Validate()
	{
		if(username.value == "")
		{
			username.style.border = "2px solid #f44336";
			uname_error.textContent = "*User name is required";
			username.focus();
			return false;
		}
		
		if(email.value == "")
		{
			email.style.border = "2px solid #f44336";
			email_error.textContent = "*Email is required";
			email.focus();
			return false;
		}
		else
	    {
	      if(!email.value.match(emailFormat))
	      {
	        email.style.border = "2px solid #f44336";
	        email_error.textContent = "*Email Format is wrong";
	        email.focus();
	        return false;
	      }
	    }

		if(password.value == "")
		{
			password.style.border = "2px solid #f44336";
			password_error.textContent = "*Password is required";
			password.focus();
			return false;
		}

		//check if the two passwords match
		if(password.value != conpwd.value)
		{
			password.style.border = "2px solid #f44336";
			conpwd.style.border = "2px solid #f44336";
			cpassword_error.innerHTML = "*The two passwords do not match";
			return false;
		}
	}
	// event handler functions
	
	function unameVerify()
	{
		if(username.value !="" )
		{
			username.style.border = "2px solid black";
			uname_error.innerHTML = "";
			return true;
		}
	}
	
	function emailVerify()
	{
		if(email.value !="" )
		{
			email.style.border = "2px solid black";
			email_error.innerHTML = "";
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