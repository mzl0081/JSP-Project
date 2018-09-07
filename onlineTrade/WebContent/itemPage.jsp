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
<title>Item Details</title>
<link rel="stylesheet" type="text/css" href="headerStyle.css">
<link rel="stylesheet" type="text/css" href="signupstyle.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
</head>
<body>
	<%
		String itemId = request.getParameter("reserve_link");
		String userId = new String();
		String sellername = new String();
		String departmentId = new String();
		String departmentname = new String();
		String itemname = new String();
		String contact = new String();
		String location = new String();
		String description = new String();

		//ArrayList<String> imgname=new ArrayList<String>();
		session.setAttribute("itemId", itemId);


		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/trade", "root", "");
		Statement st = con.createStatement();

		ArrayList<String> departmentList = new ArrayList<String>();
		String department;
		ResultSet rs = st.executeQuery("SELECT * FROM items WHERE item_id='"+itemId+"'");
		while (rs.next())
		{
			userId = rs.getString("user_id");
			departmentId = rs.getString("department_id");
			itemname = rs.getString("item_name");
			contact = rs.getString("contact");
			location = rs.getString("location");
			description = rs.getString("description");
		}

		rs = st.executeQuery("SELECT * FROM departments WHERE department_id='"+departmentId+"'");
		while (rs.next())
		{
			departmentname = rs.getString("department_name");
		}

		rs = st.executeQuery("SELECT * FROM users WHERE user_id='"+userId+"'");
		while (rs.next())
		{
			sellername = rs.getString("username");
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
		<h2>Item Information</h2>
		<form action="addToSL.jsp" method="GET">
			<div class="blank">
				<div>
					<label>Department: </label>
					<p><%=departmentname%></p>
				</div>
				<br>
				<div>
					<label>Item Name: </label>
					<p><%=itemname%></p>
				</div>
				<br>
				<div>
					<label>Seller: </label>
					<p><%=sellername%></p>
				</div>
				<br>
				<div>
					<label>Description: </label>
					<p><%=description%></p>
				</div>
				<br>
				<div>
				<label>image:</label>
				<%
				String imageName = new String();
				ArrayList<String> imageNameList = new ArrayList<String>();
				
				rs = st.executeQuery("SELECT * FROM imgs WHERE item_id='"+itemId+"'");	
				while (rs.next())
				{
					imageName = rs.getString("img_name");
					imageNameList.add(imageName);
				}
				
				for (int k = 0; k < imageNameList.size(); k++)
				{
					out.println("<image src='img/"+imageNameList.get(k)+"' width='200px' height='200px'/>&nbsp;");
				}

				%>
				</div>
				<br>
				<br>
				<br>
				<div>
					<label>Contact: </label>
					<p><%=contact%></p>
				</div>
				<br>
				<div>
					<label>Location: </label>
					<p><%=location%></p>
				</div>
				<br><br>
			</div>
			<div class="botton">
				<input type="submit" name="addShop" value="Add to Shopping List" style="width:210px;">	
			</div>
		</form>
	</div>


</body>
</html>