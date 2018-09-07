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
		String itemId = request.getParameter("edit_link");
		String itemname = new String();
		String departmentId = new String();
		String departmentname = new String();
		String contact = new String();
		String location = new String();
		String description = new String();

		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/trade", "root", "");
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("SELECT * FROM items WHERE item_id='"+itemId+"';");
		while (rs.next())
		{
			itemname = rs.getString("item_name");
			departmentId = rs.getString("department_id");
			contact = rs.getString("contact");
			location = rs.getString("location");
			description = rs.getString("description");
		}

		rs = st.executeQuery("SELECT * FROM departments WHERE department_id='"+departmentId+"';");
		while (rs.next())
		{
			departmentname = rs.getString("department_name");
		}

		ArrayList<String> departmentList = new ArrayList<String>();
		String department;
		rs = st.executeQuery("SELECT * FROM departments");
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
		<h2>Edit Your Items</h2>
		<form action="editToU.jsp" method="GET">
			<div class="blank">
				<div>
					<label>Department: </label>
					<select name="department_list">
					<%
						for (int i = 0; i < departmentList.size() ; i++)
						{
							if(departmentname.equals(departmentList.get(i)))
							{
								out.println("<option value='" + departmentList.get(i) + "' selected='selected'>");
								out.println(departmentList.get(i));
								out.println("</option>");
							}
							else
							{
								out.println("<option value='" + departmentList.get(i) + "'>");
								out.println(departmentList.get(i));
								out.println("</option>");	
							}
						}

					%>
					</select>
				</div>
				<br>
				<div>
					<label>ItemName: </label>
					<input type="text" name="itemname" value="<%=itemname%>">
				</div>
				<!-- <br>
				<div>
					<label>Image: </label>
					<input type="file" name="image" accept="image/*">
				</div> -->
				<br>
				<div>
					<label>Contact:<br>(Phone/Email) </label>
					<input type="text" name="contact" value="<%=contact%>">
				</div>
				<br>
				<br>
				<div>
					<label>Location: </label>
					<input type="text" name="location" value="<%=location%>">
				</div>
				<br>
				<div>
					<label>Description: </label>
					<textarea name="description" rows="10" cols="60" style="border: 2px solid black; border-radius: 7px; font-size: 18px;"><%=description%></textarea>
				</div>
				<br>
				<br>
			</div>
			<div class="botton">
				<input type="hidden" name="thisItem" value="<%=itemId%>">
				<input type="submit" name="update" value="Update">	
			</div>
		</form>
	</div>

</body>
</html>