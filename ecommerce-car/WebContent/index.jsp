<html>
<head>
<title>home</title>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@500&display=swap');
</style>
</head>
<body style="margin: 0px;">
<%@include file="header.jsp" %>

<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*" %>
<%
	String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog"; 
	String user = "root";
	String password = "root";

	try {
		out.print("1");
		Class.forName("com.mysql.jdbc.Driver");
		out.print("2");
		Connection connection = DriverManager.getConnection(dbUrl, user, password);
		out.print("Database connecion successful");
		
		
		connection.close();
	}catch (Exception e) {
		out.print(e);
	}
%>

<%@include file="footer.jsp" %>
</body>
</html>