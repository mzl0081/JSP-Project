<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Panel</title>
<link rel="stylesheet" type="text/css" href="headerStyle.css">
<link rel="stylesheet" type="text/css" href="signupstyle.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
</head>
<body>
<%
String department = request.getParameter("department_list");
String itemId = request.getParameter("thisItem");
String itemname = request.getParameter("itemname");
//String image = "";
String contact = request.getParameter("contact");
String location = request.getParameter("location");
String description = request.getParameter("description");
Object uname = session.getAttribute("uname");
String departmentId = new String();
String uid = new String();



Class.forName("com.mysql.jdbc.Driver");
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/trade", "root", "");
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM departments WHERE department_name='"+department+"'");
while (rs.next())
{
	departmentId = rs.getString("department_id");
}
//st.executeUpdate("INSERT INTO imgs (img_name) VALUES ('"+image+"')");

rs = st.executeQuery("SELECT * FROM users WHERE username='"+uname+"'");
while (rs.next())
{
	uid = rs.getString("user_id");
}


st.executeUpdate("UPDATE items SET user_id='"+uid+"', item_name='"+itemname+"', department_id='"+departmentId+"', contact='"+contact+"', location='"+location+"', description='"+description+"' WHERE item_id='"+itemId+"';");
%>

	<div class="nav">
		<div class="header">
			<h1><a href="index.jsp">Online<br>Trade</a></h1>
		</div>
		<div class="user_login">
			<a href="userPanel.jsp">Welcome <%=session.getAttribute("uname")%></a>
			<br><br><br>
			<a href="shoppingList.jsp">Shopping List</a>
			<br><br><br>
			<a href="sell.jsp">Sell</a>
			<br><br><br>
			<a href="logout.jsp">Log out</a>
		</div>
	</div>

	<div class="content">
		<h3 style="color:black; font-size:24px; font-family:'Poppins', sans-serif;">
		Update Successfully!
		</h3>
		<br>
		<h3 style="color:black; font-size:24px; font-family:'Poppins', sans-serif;">
			<a href='userPanel.jsp'>Please Go to the User Panel.</a>
		</h3>
	</div>

</body>
</html>



