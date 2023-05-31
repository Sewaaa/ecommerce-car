<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<% 	
	String result = (String)session.getAttribute("utente");
%>
<html>
<head>
<title>Header</title>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@500&display=swap');
</style>
</head>
<body>

	<div style="background-color: white; box-shadow: 0px 5px 10px #dedede; height: 130px; line-height: 130px;">
		<div style="width: 40%; float: left;  text-align: left;">
		  <a style="text-decoration: none; font-size: 19px; color: black; margin-right: 15px; margin-left:40px; font-family: 'Poppins', sans-serif;" href="index.jsp">HOME</a>
		  <a style="text-decoration: none; font-size: 19px; color: black; margin-right: 15px; margin-left:15px; font-family: 'Poppins', sans-serif;" href="index.jsp">CATALOGO</a>
		  <a style="text-decoration: none; font-size: 19px; color: black; margin-right: 15px; margin-left:15px; font-family: 'Poppins', sans-serif;" href="chisiamo.jsp">CHI SIAMO</a>
		  <a style="text-decoration: none; font-size: 19px; color: black; margin-right: 15px; margin-left:15px; font-family: 'Poppins', sans-serif;" href="contatti.jsp">CONTATTI</a>
		</div>
		
		<div style="padding: 5px 0px 0px 0px; width: 20%; float: left;  text-align: center;">
		  <img style="line-height: 50px; width: 200px;" src="imgs/logotsw.png">
		</div>
		
		<div style="width: 40%; float: left; text-align: right;">
			<a href="login.jsp" style="text-decoration: none; font-size: 19px; color: black; margin-right: 15px; margin-left:40px; font-family: 'Poppins', sans-serif;">UTENTE</a>
			<a href="carrello.jsp" style="text-decoration: none; font-size: 19px; color: black; margin-right: 15px; margin-left:40px; font-family: 'Poppins', sans-serif;">CARRELLO</a>
			<%if(result != null){%>
				<a href="account.jsp" style="text-decoration: none; font-size: 19px; color: black; margin-right: 15px; margin-left:40px; font-family: 'Poppins', sans-serif;"><% out.println(result); %></a>
			<%} %>
		</div>
	</div>

</body>
</html>


