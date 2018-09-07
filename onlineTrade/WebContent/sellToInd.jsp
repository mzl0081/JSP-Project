<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "javax.servlet.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.*" %>
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
// Check that we have a file upload request
boolean isMultipart = ServletFileUpload.isMultipartContent(request);

// Create a factory for disk-based file items
DiskFileItemFactory factory = new DiskFileItemFactory();

// Configure a repository (to ensure a secure temp location is used)
ServletContext servletContext = this.getServletConfig().getServletContext();
File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
//out.println(repository);
factory.setRepository(repository);

// Create a new file upload handler
ServletFileUpload upload = new ServletFileUpload(factory);

// Parse the request
List<FileItem> items = upload.parseRequest(request);

// Process the uploaded items
Iterator<FileItem> iter = items.iterator();

ArrayList<String> inputFieldName=new ArrayList<String>();
ArrayList<String> inputFieldValue=new ArrayList<String>();

while (iter.hasNext()) 
{
    FileItem item = iter.next();

    if (item.isFormField()) 
    {
        String name = item.getFieldName();
    	String value = item.getString();
    	inputFieldName.add(name);
    	inputFieldValue.add(value);
    }
}

String department = inputFieldValue.get(0);
String itemname = inputFieldValue.get(1);
String contact = inputFieldValue.get(2);
String location = inputFieldValue.get(3);
String description = inputFieldValue.get(4);

Object uname = session.getAttribute("uname");
String departmentId = new String();
String uid = new String();

Class.forName("com.mysql.jdbc.Driver");
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/trade", "root", "");
Statement st = con.createStatement();

ResultSet rs = st.executeQuery("SELECT * FROM departments WHERE department_name='"+department+"';");

while (rs.next())
{
	departmentId = rs.getString("department_id");
}

// st.executeUpdate("INSERT INTO imgs (img_name) VALUES ('"+image+"')");----

rs = st.executeQuery("SELECT * FROM users WHERE username='"+uname+"'");
while (rs.next())
{
	uid = rs.getString("user_id");
}

st.executeUpdate("INSERT INTO items (user_id, item_name, department_id, contact, location, description) VALUES ('"+uid+"','"+itemname+"','"+departmentId+"','"+contact+"','"+location+"','"+description+"');");

String thisItemId = new String();
rs = st.executeQuery("SELECT * FROM items WHERE user_id='"+uid+"' AND item_name='"+itemname+"' AND department_id='"+departmentId+"' AND description='"+description+"';");
while (rs.next())
{
	thisItemId = rs.getString("item_id");
}

//out.println(thisItemId);

Iterator<FileItem> iter2 = items.iterator();
 
while (iter2.hasNext()) 
{
    FileItem item = iter2.next();

    if (!item.isFormField()) 
    {
    	String fieldName = item.getFieldName();
    	String filePath = item.getName();
        String fileName = FilenameUtils.getName(item.getName());
        String contentType = item.getContentType();
        boolean isInMemory = item.isInMemory();
        long sizeInBytes = item.getSize();
        
        File uploadFile = new File("C:\\Users\\lmz\\eclipse-workspace\\Web\\onlineTrade\\WebContent\\img\\"+fileName);
        item.write(uploadFile);
        
        String sql = "INSERT INTO imgs (item_id, img_name) VALUES ('"+thisItemId+"','"+fileName+"');";
        st.executeUpdate(sql);

    }
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
		<h3 style="color:black; font-size:24px; font-family:'Poppins', sans-serif;">
		Selling it!
		</h3>
		<br>
		<h3 style="color:black; font-size:24px; font-family:'Poppins', sans-serif;">
			<a href='index.jsp'>Please Go to the Home Page.</a>
		</h3>
	</div>

</body>
</html>



