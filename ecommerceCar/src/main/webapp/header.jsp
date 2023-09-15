<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 	
	String email = (String)session.getAttribute("email");
	String nome = (String)session.getAttribute("nome");
	String cognome = (String)session.getAttribute("cognome");	
%>
<!DOCTYPE html>
<html lang="it">
<head>
<title>Header</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="></script>
<link href="css/all.css" rel="stylesheet" type="text/css"/>
<link href="css/header.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

</head>

<body>

<div class="header">
  <div class="headerleft">
    <a class="header-menuitem"  href="homeSERVLET">CATALOGO</a>
    <a class="header-menuitem"  href="chisiamo.jsp">CHI SIAMO</a>
    <a class="header-menuitem" href="#" onclick="openBrandServlet(6)">BRAND</a>
  </div>

  <div class="headercenter">
    <a href="homeSERVLET">
    	<img  alt="logo" class="logoh" src="imgs/logotsw.png">
  	</a>
  </div>

  <div class="headerright">
   <a href="carrelloSERVLET" class="header-menuitem">CARRELLO</a>
    <% if (nome != null && cognome != null) {
      if (email.equals("admin@fgms.it")) { %>
        <div class="header-dropdown">
          <a class="header-menuitem"><% out.println(nome+" "+cognome); %></a>
          <div class="header-dropdown-content">
          	<a class="header-menuitem" href="ordini_adminSERVLET">Ordini</a>
          	<a class="header-menuitem" href="visualizzazione_utentiSERVLET">Utenti</a>
            <a class="header-menuitem" href="gestionedbSERVLET">Database</a>
            <a class="header-menuitem" href="gestioneutentiSERVLET">Dati Utente</a>
            <a class="header-menuitem" href="logout">Logout</a>
          </div>
        </div>
    <% } else { %>
        <div class="header-dropdown">
          <a class="header-menuitem" ><% out.println(nome+" "+cognome); %></a>
          <div class="header-dropdown-content">
          	<a class="header-menuitem" href="ordini_adminSERVLET">Ordini</a>
            <a class="header-menuitem" href="gestioneutentiSERVLET">Dati Utente</a>
            <a class="header-menuitem" href="logout">Logout</a>
          </div>
        </div>
    <% }
       }else
    	{%>
    	   <a href="login.jsp" class="header-menuitem" >LOGIN</a>
    	 <%} %>		
  </div>
  
  <div class="header-hamburger">
  		<label class="hamburger">
			<i class="fa fa-bars"></i>
		</label>
  </div>
</div>

<div class="tendina">
	<ul>
		<li><a class="header-menuitem"  href="homeSERVLET">CATALOGO</a></li>
		<li><a class="header-menuitem"  href="chisiamo.jsp">CHI SIAMO</a></li>
		<li><a class="header-menuitem" href="#" onclick="openBrandServlet(6)">BRAND</a></li>
		<li><a class="header-menuitem"  href="carrelloSERVLET">CARRELLO</a></li>
		<% if (nome != null && cognome != null) {
      		if (email.equals("admin@fgms.it")) { %>
        		<li><a class="header-menuitem discesa"><% out.println(nome+" "+cognome); %></a></li>
        		<li class="subitem1"><a class="header-menuitem" href="ordini_adminSERVLET">Ordini</a></li>
          		<li class="subitem2"><a class="header-menuitem" href="visualizzazione_utentiSERVLET">Utenti</a></li>
            	<li class="subitem3"><a class="header-menuitem" href="gestionedbSERVLET">Database</a></li>
            	<li class="subitem4"><a class="header-menuitem" href="gestioneutentiSERVLET">Dati Utente</a></li>
            	<li class="subitem5"><a class="header-menuitem" href="logout">Logout</a></li>
            <% } else { %>
            	<li><a class="header-menuitem discesa"><% out.println(nome+" "+cognome); %></a></li>
            	<li class="subitem1"><a class="header-menuitem" href="ordini_adminSERVLET">Ordini</a></li>
            	<li class="subitem2"><a class="header-menuitem" href="gestioneutentiSERVLET">Dati Utente</a></li>
            	<li class="subitem3"><a class="header-menuitem" href="logout">Logout</a></li>
        <%	 }
      		}else{%>
    	   		<li><a href="login.jsp" class="header-menuitem" >LOGIN</a></li>
    	 <%} %>
	</ul>
</div>
<script>
function openBrandServlet(value) {
	window.location.href = 'brandSERVLET?brand=' + value;
}
</script>
<script>
	document.querySelector('.hamburger').onclick = function(){
		if(document.querySelector('.tendina').style.display == "none"){
			document.body.style.overflow = "hidden";
			document.querySelector('.tendina').style.display="block";
		}else{
			document.body.style.overflow = "scroll";
			document.querySelector('.tendina').style.display="none";
		}
	}
	
	document.querySelector('.discesa').onclick = function(){
		if(document.querySelector('.subitem1').style.display == "none"){
			document.querySelector('.subitem1').style.display="block";
			document.querySelector('.subitem2').style.display="block";
			document.querySelector('.subitem3').style.display="block";
			document.querySelector('.subitem4').style.display="block";
			document.querySelector('.subitem5').style.display="block";
		}else{
			document.querySelector('.subitem1').style.display="none";
			document.querySelector('.subitem2').style.display="none";
			document.querySelector('.subitem3').style.display="none";
			document.querySelector('.subitem4').style.display="none";
			document.querySelector('.subitem5').style.display="none";
		}
	}
</script>


</body>
</html>
