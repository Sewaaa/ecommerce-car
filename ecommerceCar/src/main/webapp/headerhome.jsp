<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<% 	
	
	String email = (String)session.getAttribute("email");
	String nome = (String)session.getAttribute("nome");
	String cognome = (String)session.getAttribute("cognome");
%>
<!DOCTYPE html>
<html lang="it">
<head>
 <link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
<link href="css/all.css" rel="stylesheet" type="text/css"/>
<link href="css/headerhome.css" rel="stylesheet" type="text/css"/>
</head>

<body>

<div class="header">
  <div class="headerleft">
    <a class="menuitem"  href="homeSERVLET">CATALOGO</a>
    <a class="menuitem"  href="chisiamo.jsp">CHI SIAMO</a>
    <a class="menuitem" href="#" onclick="openBrandServlet(6)">BRAND</a>
  </div>

  <div class="headercenter">
    <img alt="logo" class="logoh" src="imgs/logotswhome.png">
  </div>

  <div class="headerright">
   <a href="carrelloSERVLET" class="menuitem" >CARRELLO</a>
    <% if (nome != null && cognome != null) {
      if (email.equals("admin@fgms.it")) { %>
        <div class="dropdown">
          <a class="menuitem"><% out.println(nome+" "+cognome); %></a>
          <div class="dropdown-content">
          	<a class="menuitem" href="ordini_adminSERVLET">Ordini</a>
          	<a class="menuitem" href="visualizzazione_utentiSERVLET">Utenti</a>
            <a class="menuitem" href="gestionedbSERVLET">Database</a>
            <a class="menuitem" href="gestioneutentiSERVLET">Dati Utente</a>
            <a class="menuitem" href="logout">Logout</a>
          </div>
        </div>
    <% } else { %>
        <div class="dropdown">
          <a class="menuitem" ><% out.println(nome+" "+cognome); %></a>
          <div class="dropdown-content">
          	<a class="menuitem" href="ordini_adminSERVLET">Ordini</a>
            <a class="menuitem" href="gestioneutentiSERVLET">Dati Utente</a>
            <a class="menuitem" href="logout">Logout</a>
          </div>
        </div>
    <% }
       }else
    	{%>
    	   <a href="login.jsp" class="menuitem" >LOGIN</a>
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
		<li><a class="menuitem"  href="homeSERVLET">CATALOGO</a></li>
		<li><a class="menuitem"  href="chisiamo.jsp">CHI SIAMO</a></li>
		<li><a class="menuitem" href="#" onclick="openBrandServlet(6)">BRAND</a></li>
		<li><a class="menuitem"  href="carrelloSERVLET">CARRELLO</a></li>
		<% if (nome != null && cognome != null) {
      		if (email.equals("admin@fgms.it")) { %>
        		<li><a class="menuitem discesa"><% out.println(nome+" "+cognome); %></a></li>
        		<li class="subitem1"><a class="menuitem" href="ordini_adminSERVLET">Ordini</a></li>
          		<li class="subitem2"><a class="menuitem" href="visualizzazione_utentiSERVLET">Utenti</a></li>
            	<li class="subitem3"><a class="menuitem" href="gestionedbSERVLET">Database</a></li>
            	<li class="subitem4"><a class="menuitem" href="gestioneutentiSERVLET">Dati Utente</a></li>
            	<li class="subitem5"><a class="menuitem" href="logout">Logout</a></li>
            <% } else { %>
            	<li><a class="menuitem discesa"><% out.println(nome+" "+cognome); %></a></li>
            	<li class="subitem1"><a class="menuitem" href="ordini_adminSERVLET">Ordini</a></li>
            	<li class="subitem2"><a class="menuitem" href="gestioneutentiSERVLET">Dati Utente</a></li>
            	<li class="subitem3"><a class="menuitem" href="logout">Logout</a></li>
        <% }}else{%>
    	   		<li><a href="login.jsp" class="menuitem" >LOGIN</a></li>
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
			document.querySelector('.logo').src="imgs/logotsw.png";
			document.body.style.overflow = "hidden";
			document.querySelector('.hamburger').style.color="black";
			document.querySelector('.header').style.backgroundColor="white";
			document.querySelector('.tendina').style.display="block";
		}else{
			document.querySelector('.logo').src="imgs/logotswhome.png";
			document.body.style.overflow = "scroll";
			document.querySelector('.hamburger').style.color="white";
			document.querySelector('.header').style.backgroundColor="transparent";
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
			document.querySelector('.subitem5').style.display="block";
		}
	}
</script>


</body>
</html>
