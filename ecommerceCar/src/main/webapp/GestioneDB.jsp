<!-- PAGINA PER APPORTARE MODIFICHE AL DATABASE (AGGIUNGI/RIMUOVI/MODIFICA PRODOTTI) -->
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.object.*"%>
<!DOCTYPE html>
<%@include file="header.jsp" %>	
	
<!-- CONTROLLO PER ACCESSO NEGATO -->
<%
if ( session == null || email==null || !email.equals("admin@fgms.it")) {

	response.sendRedirect("accesso_negato.jsp");
}
else
{
%>
	<html lang="it">
	<head>
	<title>Gestione DB</title>
	<link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
	<style>
		body {
            align-items: center;
            text-align: center;
        }

        .disabled {
            background-color: #f2f2f2;
            color: #999;
        }

        .disabled option {
            color: #999;
        }
    </style>
      <link rel="stylesheet" type="text/css" href="css/carrello.css">
	</head>
<body>
<!-- INSERIMENTO NUOVO PRODOTTO -->
 <h1 style="text-align: center;"> Inserisci Nuovo Prodotto </h1>
	  
       <form action="aggiungi_prodotto" method="POST" >
       
        <label for="tipo">Tipo:</label>
        <select name="tipo" id="tipo" required>
            <option value="macchina" selected>Macchina</option>
            <option value="accessorio">Accessorio</option>
        </select><br><br>
       
        <label for="brand">Brand:</label>
        <select name="brand" id="brand" required>
            <option value="1" selected>Ferrari</option>
            <option value="2">Mercedes</option>
            <option value="3">BMW</option>
            <option value="4">Jaguar</option>
            <option value="5">Alfa Romeo</option>
            <option value="6">Tesla</option>
        </select><br><br>

        <label for="nome">Nome:</label>
        <input type="text" name="nome" id="nome" required><br><br>

        <label for="descrizione">Descrizione:</label>
        <textarea name="descrizione" id="descrizione" rows="4" cols="50" required></textarea><br><br>

        <label for="data_rilascio">Data di Rilascio:</label>
		<input type="number" name="data_rilascio" id="data_rilascio" placeholder="Anno" required><br><br>
		
        <label for="prezzo">Prezzo:</label>
        <input type="number" name="prezzo" id="prezzo" step="0.01" required><br><br>

        <label for="foto">Path Foto:</label>
        <input type="text" name="foto" id="foto" required><br><br>

        <input type="submit" value="Inserisci">
    </form>

<!-- RIMOZIONE E MODIFICA PRODOTTI DEL CATALOGO -->

<br><br><br>
<h1 style="text-align: center;"> Rimuovi e Modifica Prodotti </h1>
 
<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*, java.text.DecimalFormat" %>
<%
		@SuppressWarnings("unchecked")
		ArrayList<prodotto> lista_prodotti = (ArrayList<prodotto>) session.getAttribute("prodotti");
		for(prodotto p: lista_prodotti){
%>
			 <div class="item">
			 
			 <form action="shopSERVLET" method="get">	
				 	<input type="hidden" name="id_prodotto" value="<%=p.getId()%>">
				 	<input type="hidden" name="tipo" value="<%=p.getTipo()%>">
				 	<button type="submit" class="invisible-button">
				 		<img alt="immagine prodotto" class="item" src="<%=p.getPercorso()%>">
				 	</button>
			 </form>
			 
			 <form action="shopSERVLET" method="get">	
				 	<button type="submit" class="invisible-button">
				 	<div class="title">
				 		<%=p.getBrand()%>
				 		<%=p.getNome()%>
				 	</div>
				 	</button>
				 	<input type="hidden" name="id_prodotto" value="<%=p.getId()%>">
				 	
			 </form>
			 
			 <form action="Rimuovi_da_db" method="post">
			 	<button type="submit" class="remove-btn">Rimuovi</button>
			 	<input type="hidden" name="id_prodotto" value="<%=p.getId()%>">
			 </form>
			<form action="ModificaSERVLET" method="post">
			 	<button type="submit" class="modifica-btn">Modifica</button>
			 	<input type="hidden" name="id_prodotto" value="<%=p.getId()%>">
			 </form>
			 </div>
		
	<%}%>
</body>	

<%}%>

</html>
<%@include file="footer.jsp" %>
