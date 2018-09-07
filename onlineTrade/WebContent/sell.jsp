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
<title>Sell</title>
<link rel="stylesheet" type="text/css" href="headerStyle.css">
<link rel="stylesheet" type="text/css" href="signupstyle.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
</head>
<body>
	<%

		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/trade", "root", "");
		Statement st = con.createStatement();

		ArrayList<String> departmentList = new ArrayList<String>();
		String department;
		ResultSet rs = st.executeQuery("SELECT * FROM departments");
		while (rs.next())
		{
			department = rs.getString("department_name");
			departmentList.add(department);
		}

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
		<h2>Sell Your Items</h2>
		<form action="sellToInd.jsp" method="POST" enctype="multipart/form-data">
			<div class="blank">
				<div>
					<label>Department: </label>
					<select name="department_list">
					<%
						for (int i = 0; i < departmentList.size() ; i++)
						{
							out.println("<option value='" + departmentList.get(i) + "'>");
							out.println(departmentList.get(i));
							out.println("</option>");
						}

					%>
					</select>
				</div>
				<br>
				<div>
					<label>ItemName: </label>
					<input type="text" name="itemname">
				</div>
				<br>
				<div>
					<label>Image: </label>
					<input type="file" name="image" accept="image/*" multiple>
				</div>
				<br>
				<div>
					<label>Contact:<br>(Phone/Email) </label>
					<input type="text" name="contact">
				</div>
				<br>
				<br>
				<div>
					<label>Location: </label>
					<input type="text" name="location">
				</div>
				<br>
				<div>
					<label>Description: </label>
					<textarea name="description" rows="10" cols="60" style="border: 2px solid black; border-radius: 7px; font-size: 18px;"></textarea>
				</div>
				<br>
				<br>
			</div>
			<div class="botton">
				<input type="submit" name="sell" value="Sell">	
			</div>
		</form>
	</div>

</body>
</html>