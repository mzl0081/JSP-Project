<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*" %>

<%
Object uname = session.getAttribute("uname");
String uid = new String();

Class.forName("com.mysql.jdbc.Driver");
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/trade", "root", "");
Statement st = con.createStatement();

ResultSet rs = st.executeQuery("SELECT * FROM users WHERE username='"+uname+"'");

while (rs.next())
{
	uid = rs.getString("user_id");
}

String itemId = request.getParameter("removeitem_link");

rs = st.executeQuery("SELECT * FROM items WHERE item_id='"+itemId+"';");
while (rs.next())
{
	st.executeUpdate("DELETE FROM items WHERE item_id='"+itemId+"' AND user_id='"+uid+"';");
	break;
}

rs = st.executeQuery("SELECT * FROM shop WHERE item_id='"+itemId+"';");
while (rs.next())
{
	st.executeUpdate("DELETE FROM shop WHERE item_id='"+itemId+"';");
	break;
}
response.sendRedirect("userPanel.jsp");

%>
