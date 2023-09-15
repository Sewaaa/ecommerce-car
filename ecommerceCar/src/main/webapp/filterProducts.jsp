<!-- PAGINA PER AGGIORNAMENTO IN AJAX NELLA HOME PER FILTRAGGIO IN BASE AL TIPO PRODOTTO -->
<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.dao.*"%>
<%@ page import="model.object.*"%>
<link rel="stylesheet" type="text/css" href="css/index.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
<body>
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
</body>
</html>
