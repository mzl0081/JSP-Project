<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "java.io.IOException" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>RegisterToLogIn</title>
<link rel="stylesheet" type="text/css" href="signupstyle.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
</head>
<body>
	<jsp:include page="header.html"></jsp:include>
	<div class="content">
	
	<%	
	String username = request.getParameter("username");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String conpwd = request.getParameter("conpwd");
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/trade", "root", "");
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("SELECT * FROM users");
		boolean flag = false;
		while (rs.next())
		{
			if (username.equals(rs.getString("username")))
			{
				flag = true;
				out.println("<h3 style='color:black; font-size:24px; font-family:'Poppins', sans-serif;'>");
				out.println("User name has already existed.");
				out.println("</h3>");
				out.println("<br>");
				out.println("<h3 style='color:black; font-size:24px; font-family:'Poppins', sans-serif;'>");
				out.println("<a href='signUp.jsp'>Please Sign Up agian.");
				out.println("</a></h3>");
				break;
			}
		}
		
		if (flag == false)
		{
			int i = st.executeUpdate("INSERT INTO users (username, email, password) VALUES ('"+username+"', '"+email+"','"+password+"')");
			out.println("<h3 style='color:black; font-size:24px; font-family:'Poppins', sans-serif;'>");
			out.println("You've been successfully registered!");
			out.println("</h3>");
			out.println("<br>");
			out.println("<h3 style='color:black; font-size:24px; font-family:'Poppins', sans-serif;'>");
			out.println("<a href='login.jsp'>Please Go to Log in Page.");
			out.println("</a></h3>");
		
		}
	
	}
	catch (Exception e)
	{
		out.println("<h3 style='color:black; font-size:24px; font-family:'Poppins', sans-serif;'>");
		out.println("Error!");
		out.println("</h3>");
	}



	%>
	</div>

</body>
</html>