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
<html>
<head>
<meta charset="UTF-8">
<style>
	@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@500&display=swap');

	body{
		background-color: #f4f4f4;
	}
	
	#contenitore{
		font-family: 'Poppins', sans-serif;
		background-color: #ffffff;
		width: 25%;
		text-align:center;
		padding: 33px 40px 33px 40px;
		margin: 0 auto;
		margin-top: 170px;
		box-shadow: 0px 0px 5px 1px #d8d8d8;
	}
	
	img{
		width:250px;
	}
	
	.text{
		width: 98.5%;
		font-size: 18px;
		height: 40px;
		margin-top: 7px;
		margin-bottom: 7px;
	}
	
	.button{
		margin-top: 7px;
		margin-bottom: 7px;
		width: 100%;
		font-size: 18px;
		height: 45px;
		background-color: #A739FB;
		color: white;
		border: solid 1px #A739FB;
	}
</style>
<title>FGMS - LOG IN</title>
</head>
<body>
	<div id="contenitore">
		<form action="login" method="post">
			<img src="imgs/logotsw.png">
			<input type="text" name="email" class="text" placeholder="Inserire E-mail..." required>
			<input type="password" name="psw" class="text" placeholder="Inserire Password..." required>
			<input type="submit" value="Accedi" class="button">
			<a href="registrazione.jsp">Non hai ancora un account? Registrati ora !</a>
			<span> <% out.println(result); %> </span>
		</form>
	</div>
</body>
</html>