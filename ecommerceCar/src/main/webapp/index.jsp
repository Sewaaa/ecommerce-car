<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.object.*"%>
<%@include file="headerhome.jsp" %>
<%
	if(session.getAttribute("prodotti")==null) {
		 response.sendRedirect("homeSERVLET");
	}
%>
<!DOCTYPE html>
<html lang="it">
<head>
<title>Home</title>	
<link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="css/index.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="></script>

<!-- FILTROCATALOGO PER TIPO PRODOTTO -->
  <script type="text/javascript">
    $(document).ready(function() {
      $("#filterType").change(function() {
        var selectedType = $(this).val();
        $.ajax({
          url: "homeSERVLET",
          method: "GET",
          data: { type: selectedType },
          success: function(response) {
            $(".container").html(response);
          }
        });
      });
    });
  </script>
  
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
<!-- CATALOGO -->
<body>
<div class="hero">
	<video muted autoplay loop class="videofullscreen">
    	<source src="imgs/videohome.mp4" type="video/mp4">
  	</video>
  <div class="titolo">
  	<H1><b>L'auto dei tuoi sogni<br>a portata di click</b></H1>
	<a href="chisiamo.jsp" class="bottone">Scopri di pi&#249;</a>  
  </div>
</div>


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
     if(session.getAttribute("brand")!=null) {
    	 @SuppressWarnings("unchecked")
         ArrayList<brand> lista_brand = (ArrayList<brand>) session.getAttribute("brand");
         for(brand b: lista_brand){
            
%>
	<td>
	<form action="brandSERVLET" method="get">
		<input type="hidden" name="brand" value="<%=b.getId()%>">
    	<button type="submit" class="invisible-button">
    		<img src="imgs/brands/<%=b.getPercorso()%>" alt="Logo Brand">
    	</button>
    </form>
    </td>
<%
		}
	}
%>
</tr>
</table>

<hr>

	<h2>Catalogo</h2>
	<!-- APPLICA FILTRI A PRODOTTI -->
   <div style="text-align: center; margin: -10px 0px 50px 0px;">
  	<p class="smalltext">Filtra catalogo per 
	  <select id="filterType" style="display: inline-block;">
	    <option value="tutti">Tutti</option>
	    <option value="macchina">Auto</option>
	    <option value="accessorio">Accessori</option>
	  </select>
	 </p>
	</div>
	

	<!-- TUTTI I PRODOTTI DEL CATALOGO -->
<div class="container">
<%
            if(session.getAttribute("prodotti")!=null) {
            	 @SuppressWarnings("unchecked")
                ArrayList<prodotto> lista_prodotti = (ArrayList<prodotto>) session.getAttribute("prodotti");
                for(prodotto p: lista_prodotti){
                    //String base64Image = Base64.encodeBase64String(p.getCopertina()); 
%>
		
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
<% 	
}
%>

<%@include file="footer.jsp" %>
</body>
</html>
