<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<% 	
	String nome = (String)session.getAttribute("nome");
	String cognome = (String)session.getAttribute("cognome");
	String email = (String)session.getAttribute("email");
	
%>
<!DOCTYPE html>
<html>
<head>
<title>Header</title>
<link href="css/all.css" rel="stylesheet" type="text/css"/>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@500&display=swap');
	
	.dropdown {
      position: relative;
      display: inline-block;
    }

    .dropbtn {
      background-color: #fff;
      color: black;
      font-size: 19px;
      border: none;
      cursor: pointer;
      font-family: 'Poppins', sans-serif;
      margin-right: 15px;
      margin-left: 40px;
      padding: 10px 20px;
      border-radius: 4px;
      border: 1px solid #ddd;
      transition: background-color 0.3s ease;
    }

    .dropdown-content {
      display: none;
      position: absolute;
      background-color: #f9f9f9;
      width: 130px;
      height: auto;
      box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
      z-index: 1;
      border-radius: 4px;
    }

    .dropdown-content a {
      color: black;
      text-decoration: none;
      display: block;
      transition: background-color 0.3s ease;
      font-family: 'Poppins', sans-serif;
      font-size: 16px;
      text-align: center;
    }

    .dropdown-content a:hover {
      background-color: #e0e0e0;
    }

    .dropdown:hover .dropdown-content {
      display: block;
    }
</style>
</head>

<body>

<div style="background-color: white; box-shadow: 0px 5px 10px #dedede; height: 130px; line-height: 130px;">
  <div style="width: 40%; float: left;  text-align: left;">
    <a style="text-decoration: none; font-size: 19px; color: black; margin-right: 15px; margin-left:15px; font-family: 'Poppins', sans-serif;" href="index.jsp">CATALOGO</a>
    <a style="text-decoration: none; font-size: 19px; color: black; margin-right: 15px; margin-left:15px; font-family: 'Poppins', sans-serif;" href="chisiamo.jsp">CHI SIAMO</a>
    <a style="text-decoration: none; font-size: 19px; color: black; margin-right: 15px; margin-left:15px; font-family: 'Poppins', sans-serif;" href="contatti.jsp">CONTATTI</a>
  </div>

  <div style="padding: 5px 0px 0px 0px; width: 20%; float: left;  text-align: center;">
    <img style="line-height: 50px; width: 200px;" src="imgs/logotsw.png">
  </div>

  <div style="width: 40%; float: left; text-align: right;">
   <a href="carrello.jsp" style="text-decoration: none; font-size: 19px; color: black; margin-right: 15px; margin-left:40px; font-family: 'Poppins', sans-serif;">CARRELLO</a>
    <% if (nome != null && cognome != null) {
      if (email.equals("admin@fgms.it")) { %>
        <div class="dropdown">
          <a style="text-decoration: none; font-size: 19px; color: black; margin-right: 15px; margin-left:40px; font-family: 'Poppins', sans-serif;"><% out.println(nome+" "+cognome); %></a>
          <div class="dropdown-content">
            <a href="GestioneDB.jsp">Database</a>
            <a href="logout">Logout</a>
          </div>
        </div>
    <% } else { %>
        <div class="dropdown">
          <a href="account.jsp" style="text-decoration: none; font-size: 19px; color: black; margin-right: 15px; margin-left:40px; font-family: 'Poppins', sans-serif;"><% out.println(nome+" "+cognome); %></a>
          <div class="dropdown-content">
            <a href="logout">Logout</a>
          </div>
        </div>
    <% }
       }else
    	{%>
    	   <a href="login.jsp" style="text-decoration: none; font-size: 19px; color: black; margin-right: 15px; margin-left:40px; font-family: 'Poppins', sans-serif;">LOGIN</a>
    	 <%} %>		
  </div>
</div>

</body>
</html>


