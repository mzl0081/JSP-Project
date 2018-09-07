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
<link rel="stylesheet" type="text/css" href="bodyStyle.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
</head>
<body>
<%

Object uname = session.getAttribute("uname");
String uid = new String();
String email = new String();

Class.forName("com.mysql.jdbc.Driver");
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/trade", "root", "");
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM users WHERE username='"+uname+"'");

while (rs.next())
{
	uid = rs.getString("user_id");
	email = rs.getString("email");
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
		<h2>User Information</h2>
		<div class="blank">
			<div>
				<label>Username: </label>
				<p><%=session.getAttribute("uname")%></p>
			</div>
			<br>
			<div>
				<label>Email: </label>
				<p><%=email%></p>
			</div>
			<br>
		</div>
	</div>

	<div class="table" style="margin-top: 120px;">
		<table>
			<caption>Selling Items:</caption>
			<thead>
				<tr>
					<th>Department</th>
					<th>Item Name</th>
					<th>Edit</th>
					<th>Remove</th>
				</tr>
			</thead>
			<tbody>
			<%

				String departmentId = new String();
				String itemname = new String();
				String sellerId = uid;
				String departmentname = new String();
				String itemId = new String();

				ArrayList<String> departmentIdList = new ArrayList<String>();
				ArrayList<String> itemnameList = new ArrayList<String>();
				ArrayList<String> itemIdList = new ArrayList<String>();

				rs = st.executeQuery("SELECT * FROM items WHERE user_id='"+uid+"'");
				while (rs.next())
				{
					departmentId = rs.getString("department_id");
					itemname = rs.getString("item_name");
					itemId = rs.getString("item_id");
					departmentIdList.add(departmentId);
					itemnameList.add(itemname);
					itemIdList.add(itemId);					
				}				

				for (int i = 0; i < itemnameList.size(); i++)
				{
					rs = st.executeQuery("SELECT * FROM departments WHERE department_id='"+departmentIdList.get(i)+"'");
					while (rs.next())
					{
						departmentname = rs.getString("department_name");
					}

					out.println("<tr>");
					out.println("<td>");
					out.println(departmentname);
					out.println("</td>");
					out.println("<td>");
					out.println(itemnameList.get(i));
					out.println("</td>");
					out.println("<td>");
					out.println("<form action='editItem.jsp'>");
					out.println("<input type='hidden', name='edit_link', value='"+itemIdList.get(i)+"'>");
					out.println("<input type='submit', value='Edit'>");
					out.println("</form>");
					out.println("</td>");
					out.println("<td>");
					out.println("<form action='removeItem2.jsp'>");
					out.println("<input type='hidden', name='removeitem_link', value='"+itemIdList.get(i)+"'>");
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