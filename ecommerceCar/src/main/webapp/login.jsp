<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	HttpSession sessione = request.getSession();
	String result = ""; 
	int flag = 0;
	Enumeration<String> attrNames = session.getAttributeNames();
	while (attrNames.hasMoreElements()){
		if (((String) attrNames.nextElement()).equals("login")) {
			flag = 1;
		}
	}
	if(flag == 0){
		session.setAttribute("login", result);
	}else{
		result = (String)session.getAttribute("login");
	}
%>
<!DOCTYPE html>
<html lang="it">
<head>
<link rel="stylesheet" type="text/css" href="css/login.css">
<meta charset="UTF-8">
<title>FGMS - LOG IN</title>
<link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
</head>
<body>
	<div id="contenitore">
		<form action="login" method="post">
			<img alt="logo" src="imgs/logotsw.png">
			<input type="text" name="email" class="text" placeholder="Inserire E-mail..." required>
			<input type="password" name="psw" class="text" placeholder="Inserire Password..." required>
			<input type="submit" value="Accedi" class="button">
			<a href="registrazione.jsp">Non hai ancora un account? Registrati ora !</a>
			<br>
			<span> <% out.println(result); %> </span>
		</form>
	</div>
</body>
</html>