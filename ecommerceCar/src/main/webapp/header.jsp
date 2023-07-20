<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	
	.header-dropdown {
	  position: relative;
	  display: inline-block;
	  z-index: 100;
	}


	.header-dropdown:hover .header-dropdown-content {
	  transition: .5s;
	  visibility: visible;
	  opacity: 1;
	  top: 30px;
	}

	.header-dropdown-content {
	  position: absolute;
	  background-color: white;
	  width: 120px;
	  margin-left: 15px;
	  border: solid 1px #ffffff;
	  top: 45%;
	  visibility: hidden;
	  opacity: 0;
	  box-shadow: 0px 0px 10px #dedede;
	}


	.header-dropdown-content a {
	  text-decoration: none;
	  display: block;
	  transition: background-color 0.3s ease;
	  font-family: 'Poppins', sans-serif;
	  font-size: 18px;
	  text-align: center;
	  padding: 5px 0px 5px 0px;
	}


	.header-dropdown-content a:hover {
	  opacity: 0.5;
	}


	.header-menuitem {
	  text-decoration: none;
	  font-size: 19px;
	  color: #000000;
	  margin-right: 15px;
	  margin-left: 15px;
	  font-family: 'Poppins', sans-serif;
	  z-index: 100;
	}


	.header {
	  background-color: transparent;
	  height: 130px;
	  width: 93% !important;
	  z-index: 100;
	  padding: 0px 4% 0px 3%;
	  box-shadow: 0px 5px 10px #dedede;
	}
</style>
</head>

<body>

<div class="header">
  <div style=" width: 40%; float: left;  text-align: left; padding-top:50px;">
    <a class="header-menuitem"  href="index.jsp">CATALOGO</a>
    <a class="header-menuitem"  href="chisiamo.jsp">CHI SIAMO</a>
    <a class="header-menuitem"  href="brand.jsp?brand=6">BRAND</a>
  </div>

  <div style="padding: 5px 0px 0px 0px; width: 20%; float: left;  text-align: center;">
    <img alt="logo" style="line-height: 50px; width: 200px;" src="imgs/logotsw.png">
  </div>

  <div style="width: 40%; float: left; text-align: right; padding-top:50px;">
   <a href="carrello.jsp" class="header-menuitem" >CARRELLO</a>
    <% if (nome != null && cognome != null) {
      if (email.equals("admin@fgms.it")) { %>
        <div class="header-dropdown">
          <a class="header-menuitem"><% out.println(nome+" "+cognome); %></a>
          <div class="header-dropdown-content">
          	<a class="header-menuitem" href="ordini_utenti.jsp">Ordini</a>
          	<a class="header-menuitem" href="visualizzazione_utenti.jsp">Utenti</a>
            <a class="header-menuitem" href="GestioneDB.jsp">Database</a>
            <a class="header-menuitem" href="logout">Logout</a>
          </div>
        </div>
    <% } else { %>
        <div class="header-dropdown">
          <a href="account.jsp" class="header-menuitem" ><% out.println(nome+" "+cognome); %></a>
          <div class="header-dropdown-content">
          	<a class="header-menuitem" href="ordini.jsp">Ordini</a>
            <a class="header-menuitem" href="logout">Logout</a>
          </div>
        </div>
    <% }
       }else
    	{%>
    	   <a href="login.jsp" class="header-menuitem" >LOGIN</a>
    	 <%} %>		
  </div>
</div>

</body>
</html>
