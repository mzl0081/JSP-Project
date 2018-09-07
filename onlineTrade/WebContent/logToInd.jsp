<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "java.io.IOException" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LogtoIndex</title>
</head>
<body>
<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	session.removeAttribute("msg");
	
	Class.forName("com.mysql.jdbc.Driver");
	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/trade", "root", "");
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("SELECT * FROM users");
	boolean uflag = false;
	boolean pflag = false;
	
	
	while (rs.next())
	{
		if (username.equals(rs.getString("username")))
		{
			uflag = true;
			if (password.equals(rs.getString("password")))
			{
				pflag = true;
				session.setAttribute("uname", username);
				response.sendRedirect("index.jsp");
				break;
			}
		}
	}
	
	if (uflag == false)
	{
		session.setAttribute("msg", "user not exist");
		response.sendRedirect("login.jsp");
	}
	
	if (uflag == true && pflag == false)
	{
		session.setAttribute("msg", "wrong password");
		response.sendRedirect("login.jsp");
	}

	
	
	
%>

</body>
</html>