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
<title>Home Page</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
<link rel="stylesheet" type="text/css" href="bodyStyle.css">
<link rel="stylesheet" type="text/css" href="headerStyle.css">

</head>
<body>

	<div class="nav">
		<div class="header">
			<h1><a href="index.jsp">Online<br>Trade</a></h1>
		</div>
		<div class="user_login">
		<%
			if ((session.getAttribute("uname") == null)||(session.getAttribute("uname") == ""))
			{
		%>
			
				<a href="login.jsp">Log in</a>
				<br><br><br>
				<a href="signUp.jsp">Sign Up</a>
				<br><br><br>
				<a href="login.jsp">Shopping List</a>
				<br><br><br>
				<a href="login.jsp">Sell</a>

		<%
			}
			else
			{
		%>
			
				<a href="userPanel.jsp">Welcome <%=session.getAttribute("uname")%></a>
				<br><br><br>
				<a href="shoppingList.jsp">Shopping List</a>
				<br><br><br>
				<a href="sell.jsp">Sell</a>
				<br><br><br>
				<a href="logout.jsp">Log out</a>

		<%
			}
		%>			
		</div>
	</div>
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

	<div class="content">
		<h2>Search Items</h2>
		<br>
		<form  action="index.jsp" method="GET">
			<select name="department_list">
				<option value="All">All</option>
		<%
			for (int i = 0; i < departmentList.size() ; i++)
			{
				out.println("<option value='" + departmentList.get(i) + "'>");
				out.println(departmentList.get(i));
				out.println("</option>");
			}

		%>
			</select>
			<input type="submit" name="search" value="Search">
		</form>
	</div>
	

	<div class="table">
		<table>
			<thead>
				<tr>
					<th>Department</th>
					<th>Item Name</th>
					<th>Seller</th>
					<th>See Details</th>
				</tr>
			</thead>
			<tbody>
			<% 
				String itemId;
				String userId;
				String itemname;
				String departmentId;
				String user;
				String departmentname;

				ArrayList<String> itemIdList = new ArrayList<String>();
				ArrayList<String> itemnameList = new ArrayList<String>();
				ArrayList<String> userIdList = new ArrayList<String>();
				ArrayList<String> departmentIdList = new ArrayList<String>();
				ArrayList<String> userList = new ArrayList<String>();
				ArrayList<String> departmentnameList = new ArrayList<String>();


				rs = st.executeQuery("SELECT * FROM items");
				while (rs.next())
				{
					itemId = rs.getString("item_id");
					userId = rs.getString("user_id");
					itemname = rs.getString("item_name");
					departmentId = rs.getString("department_id");
					itemIdList.add(itemId);
					userIdList.add(userId);
					itemnameList.add(itemname);
					departmentIdList.add(departmentId);
				}

				for (int j = 0; j < itemnameList.size(); j++)
				{
					rs = st.executeQuery("SELECT * FROM departments WHERE department_id='"+departmentIdList.get(j)+"'");
					while (rs.next())
					{
						departmentname = rs.getString("department_name");
						departmentnameList.add(departmentname);
					}

					rs = st.executeQuery("SELECT * FROM users WHERE user_id='"+userIdList.get(j)+"'");
					while (rs.next())
					{
						user = rs.getString("username");
						userList.add(user);
					}
				}
			%>
			
			<%
				String opt = request.getParameter("department_list");				
				if (opt == null)
				{
					out.println("");
				}
				else if(opt.equals("All"))
				{
					 for (int j = 0; j < itemnameList.size(); j++)
					{
						out.println("<tr>");
						out.println("<td>");
						out.println(departmentnameList.get(j));
						out.println("</td>");
						out.println("<td>");
						out.println(itemnameList.get(j));
						out.println("</td>");
						out.println("<td>");
						out.println(userList.get(j));
						out.println("</td>");

						out.println("<td>");
						if ((session.getAttribute("uname") == null)||(session.getAttribute("uname") == ""))
						{
							out.println("<a href='login.jsp'>See details</a>");
						}
						else
						{
							out.println("<form action='itemPage.jsp'>");
							out.println("<input type='hidden', name='reserve_link', value='"+itemIdList.get(j)+"'>");
							out.println("<input type='submit', value='See details'>");
							out.println("</form>");

							//session.setAttribute("reserve_link", bookIdList.get(j));
						}
						out.println("</td>");
						out.println("</tr>");
					} 
				}
				else
				{
					for (int i = 0; i < departmentList.size(); i++)
					{
						if (opt.equals(departmentList.get(i)))
						{
							for (int j = 0; j < departmentnameList.size(); j++)
							{
								if (opt.equals(departmentnameList.get(j)))
								{
									out.println("<tr>");
									out.println("<td>");
									out.println(departmentnameList.get(j));
									out.println("</td>");
									out.println("<td>");
									out.println(itemnameList.get(j));
									out.println("</td>");
									out.println("<td>");
									out.println(userList.get(j));
									out.println("</td>");
									
									out.println("<td>");
									if ((session.getAttribute("uname") == null)||(session.getAttribute("uname") == ""))
									{
										out.println("<a href='login.jsp'>See details</a>");
									}
									else
									{
										out.println("<form action='itemPage.jsp'>");
										out.println("<input type='hidden', name='reserve_link', value='"+itemIdList.get(j)+"'>");
										out.println("<input type='submit', value='See details'>");
										out.println("</form>");
									}
									out.println("</td>");
									out.println("</tr>");
								}
							}
							break;
						}
					}
				}

				%>
			</tbody>
		</table>
	</div>
</body>
</html>





