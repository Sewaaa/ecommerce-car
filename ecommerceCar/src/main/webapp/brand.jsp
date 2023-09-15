<!-- Pagina dei prodotti con filtraggio per Brand -->
<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*, model.object.*" %>
<%@include file="header.jsp" %>
<%
		@SuppressWarnings("unchecked")
		ArrayList<prodotto> prodotti = (ArrayList<prodotto>) session.getAttribute("brandProdotti");   
		String nome_brand = (String) session.getAttribute("Nomebrand");  
%>

<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<title>I Nostri Brand</title>
<link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="css/brand.css">
<script type="text/javascript" src="javascript/slide.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="></script>

<!-- PRODOTTI IN EVIDENZA AL PASSAGGIO DEL MOUSE -->
	<script>
    	$(document).ready(function() {
      		$(".item").hover(
        		function() {
          			$(this).css("opacity", "0.5");
        		},
        		function() {
          			$(this).css("opacity", "1");
        		}
      		);
    	});
  </script>
</head>

<body>
<!-- LOGHI BRAND -->
<table class="brand">
<caption></caption>
<tr>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
</tr>
<tr>

<%
	@SuppressWarnings("unchecked")
	ArrayList<brand> lista_brand = (ArrayList<brand>) session.getAttribute("brand");
	for(brand b: lista_brand){				
%>
	<td>
   	<form action="brandSERVLET" method="get">
		<input type="hidden" name="brand" value="<%=b.getId()%>">
   		<button type="submit" class="invisible-button">
   			<img src="imgs/brands/<%=b.getPercorso()%>" alt="Logo <%=b.getId()%>">
   		</button>
   	</form>
   	</td>
<%} %>
</tr>
</table>

<!-- NOME BRAND SELEZIONATO -->
<hr>
	<h2><%=nome_brand%></h2>
		<div class="container">
		<!-- STAMPA PRODOTTI -->
		<%for(prodotto p: prodotti){ %>
		  <div class="prodotto">
			 <form action="shopSERVLET" method="get">	
				 <div class="photo">
				 	<button type="submit" class="invisible-button">
				 		<img class="item" alt="Immagine non disponibile" src="<%=p.getPercorso()%>">
				 	<br>
				 	<p class="nomeprodotto">
				 		<%=p.getBrand()%>
				 		<%=p.getNome()%>
				 		<br>
				 		<span class="smalltext">
				 			<%=p.getTipo()%>
				 		</span>
				 	</p>
				 	<span class="smalltext">
				 		&euro;<%=p.getPrezzo()%>
				 	</span>
				 	</button>
				 </div>
				 <input type="hidden" name="tipo" value="<%=p.getTipo()%>">
				 <input type="hidden" name="id_prodotto" value="<%=p.getId()%>">
			 </form>
		  </div>
		<% }%>
		</div>

