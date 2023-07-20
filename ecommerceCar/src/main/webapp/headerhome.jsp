<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<% 	
	HttpSession sessione = request.getSession();
	String email = (String)session.getAttribute("email");
	String nome = (String)session.getAttribute("nome");
	String cognome = (String)session.getAttribute("cognome");
	
	
%>
<!DOCTYPE html>
<html lang="it">
<head>
<title>Header</title>
<link href="css/all.css" rel="stylesheet" type="text/css"/>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@500&display=swap');
	
	.dropdown {
      position: relative;
      display: inline-block;
      z-index: 100;
    }
    
    .dropdown:hover .dropdown-content{
    	transition: .5s;
    	visibility: visible;
    	opacity: 1;
    	top: 30px;
    }

    .dropdown-content {
      position: absolute;
      width: 100px;
      top:45%;
      visibility: hidden;
      opacity: 0;
    }

    .dropdown-content a {
      text-decoration: none;
      display: block;
      transition: background-color 0.3s ease;
      font-family: 'Poppins', sans-serif;
      font-size: 18px;
      text-align: left;
      padding: 5px 0px 5px 0px;
    }

    .dropdown-content a:hover {
      opacity: 0.5;
    }
    
    .menuitem{
    	text-decoration: none; 
    	text-shadow: 0px 5px 10px #000000; 
    	font-size: 19px; 
    	color: #ffffff; 
    	margin-right: 15px; 
    	margin-left:15px; 
    	font-family: 'Poppins', sans-serif;
    	z-index: 100;
    }
    
    .header{
    	background-color: transparent; 
    	height: 200px; 
    	position:absolute; 
    	overflow: hidden; 
    	width:93% !important; 
    	z-index: 100; 
    	padding:0px 4% 0px 3%;
    }
</style>
</head>

<body>

<div class="header">
  <div style=" width: 40%; float: left;  text-align: left; padding-top:50px;">
    <a class="menuitem"  href="index.jsp">CATALOGO</a>
    <a class="menuitem"  href="chisiamo.jsp">CHI SIAMO</a>
    <a class="menuitem"  href="brand.jsp?brand=6">BRAND</a>
  </div>

  <div style="padding: 5px 0px 0px 0px; width: 20%; float: left;  text-align: center;">
    <img alt="logo" style="line-height: 50px; width: 200px;" src="imgs/logotswhome.png">
  </div>

  <div style="width: 40%; float: left; text-align: right; padding-top:50px;">
   <a href="carrello.jsp" class="menuitem" >CARRELLO</a>
    <% if (nome != null && cognome != null) {
      if (email.equals("admin@fgms.it")) { %>
        <div class="dropdown">
          <a class="menuitem"><% out.println(nome+" "+cognome); %></a>
          <div class="dropdown-content">
          	<a class="menuitem" href="ordini_utenti.jsp">Ordini</a>
          	<a class="menuitem" href="visualizzazione_utenti.jsp">Utenti</a>
            <a class="menuitem" href="GestioneDB.jsp">Database</a>
            <a class="menuitem" href="">Logout</a>
          </div>
        </div>
    <% } else { %>
        <div class="dropdown">
          <a href="account.jsp" class="menuitem" ><% out.println(nome+" "+cognome); %></a>
          <div class="dropdown-content">
          	<a class="menuitem" href="ordini.jsp">Ordini</a>
            <a class="menuitem" href="logout">Logout</a>
          </div>
        </div>
    <% }
       }else
    	{%>
    	   <a href="login.jsp" class="menuitem" >LOGIN</a>
    	 <%} %>		
  </div>
</div>

</body>
</html>


