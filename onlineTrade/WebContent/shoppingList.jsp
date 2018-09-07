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
<title>My Shopping List</title>
<link rel="stylesheet" type="text/css" href="headerStyle.css">
<link rel="stylesheet" type="text/css" href="bodyStyle.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
</head>
<body>
	<%
		String itemId = new String();
		String userId = new String();
		Object uname = session.getAttribute("uname");
		ArrayList<String> itemIdList = new ArrayList<String>();

		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/trade", "root", "");
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("SELECT * FROM users WHERE username='"+uname+"'");
		while (rs.next())
		{
			userId = rs.getString("user_id");
		}

		rs = st.executeQuery("SELECT * FROM shop WHERE user_id='"+userId+"'");
		while (rs.next())
		{
			itemId = rs.getString("item_id");
			itemIdList.add(itemId);
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
		<h2>Shopping List</h2>
	</div>
	<br>

	<div class="table" style="margin-top:0px;">
		<table>
			<thead>
				<tr>
					<th>Department</th>
					<th>Item Name</th>
					<th>Seller</th>
					<th>Remove</th>
				</tr>
			</thead>
			<tbody>
				<%
				String departmentId = new String();
				String itemname = new String();
				String sellerId = new String();
				String departmentname = new String();
				String sellername = new String();

				for (int i = 0; i < itemIdList.size(); i++)
				{
					itemId = itemIdList.get(i);
					rs = st.executeQuery("SELECT * FROM items WHERE item_id='"+itemId+"'");
					while (rs.next())
					{
						departmentId = rs.getString("department_id");
						itemname = rs.getString("item_name");
						sellerId = rs.getString("user_id");
					}

					rs = st.executeQuery("SELECT * FROM departments WHERE department_id='"+departmentId+"'");
					while (rs.next())
					{
						departmentname = rs.getString("department_name");
					}

					rs = st.executeQuery("SELECT * FROM users WHERE user_id='"+sellerId+"'");
					while (rs.next())
					{
						sellername = rs.getString("username");
					}


					out.println("<tr>");
					out.println("<td>");
					out.println(departmentname);
					out.println("</td>");
					out.println("<td>");
					out.println(itemname);
					out.println("</td>");
					out.println("<td>");
					out.println(sellername);
					out.println("</td>");
					out.println("<td>");
					out.println("<form action='removeItem.jsp'>");
					out.println("<input type='hidden', name='remove_link', value='"+itemId+"'>");
					out.println("<input type='submit', value='Remove'>");
					out.println("</form>");	
					out.println("</td>");
					out.println("</tr>");
				}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>