<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*" %>
<%
Object itemId = session.getAttribute("itemId");
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

st.executeUpdate("INSERT INTO shop (user_id, item_id) VALUES ('"+uid+"','"+itemId+"');");
session.removeAttribute("itemId");
response.sendRedirect("shoppingList.jsp");


%>
