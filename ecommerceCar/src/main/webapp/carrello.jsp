<!-- PAGINA DEL CARRELLO (SENZA ACCOUNT GESTITO CON SESSIONI / CON ACCOUNT GESTITO CON IL DB ) -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import ="java.util.ArrayList"%>
<%@ page import ="java.util.Enumeration"%>
<%@ page import="model.object.*" %>
<%@ page import="java.text.DecimalFormat" %>

<%@include file="header.jsp" %>
<!DOCTYPE html>
<html lang="it">
<head>
<title>Carrello</title>	
<link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="css/carrello.css">
</head>
<body style="margin: 0px;">
	<h2 style="text-align: center;">Carrello</h2>
<%
	    double prezzo_tot=0.0;
	/*PRELIEVO PRODOTTI DEL CARRELLO CARRELLO*/
		@SuppressWarnings("unchecked")
		ArrayList<prodotto>  carrello = (ArrayList<prodotto>)session.getAttribute("carrello");
	%>
	
	<div id="cart">
			 <!-- STAMPA PRODOTTI DEL CARRELLO -->
		<%
		for(prodotto p: carrello){
		%>
			 <div class="item">
			 
			 <form action="shopSERVLET" method="get">	
				 	<button type="submit" class="invisible-button">
				 		<img alt="immagine prodotto" class="item" src="<%=p.getPercorso()%>">
				 	</button>
				 	<input type="hidden" name="id_prodotto" value="<%=p.getId()%>">
			 		<input type="hidden" name="tipo" value="<%=p.getTipo()%>">
			 </form>
			 
			 <form action="shopSERVLET" method="get">	
				 	<button type="submit" class="invisible-button">
				 	<div class="title">
				 
				 		<%=p.getBrand()%>
				 		<%=p.getNome()%>
				 	</div>
				 	<!-- CONTROLLO TIPO DEL PRODOTTO -->
				 		<% if(p.getTipo().equals("macchina")) {%>
				 		<div class="personalizzazione">
				 		( Colore: <b><%=p.getColore()%> </b>- 
				 		  Ruote: <b><%=p.getRuote()%></b>	-
				 		  Interni: <b><%=p.getInterni()%></b> )
				 		 </div>
				 		 <% }%>
				 
				 	</button>
				 	<input type="hidden" name="tipo" value="<%=p.getTipo()%>">
				 	<input type="hidden" name="id_prodotto" value="<%=p.getId()%>">
				 	
			 </form>
			 
			 <div class="quantita">
			 	<form action="quantitacarrelloSERVLET" method="post">
			 		<b>Quantit&#225;:</b>
			 		<input min="0" max="99" type="number" class="input" name="quantita" value="<%=p.getQuantita()%>">
			 		<input type="hidden" name="hiddenquantita" value="<%=p.getQuantita()%>">
			 		<input type="hidden" name="id_prodotto" value="<%=p.getId()%>">
			 		<input type="hidden" name="ruote" value="<%=p.getRuote()%>">
			 		<input type="hidden" name="interni" value="<%=p.getInterni()%>">
			 		<input type="hidden" name="colore" value="<%=p.getColore()%>">
			 		<input type="hidden" name="tipo" value="<%=p.getTipo()%>">
			 		<input type="hidden" name="posizione" value="<%=p.getIdcarrello()%>">
			 		<button type="submit" class="btn">Salva</button>
			 	</form>
			 </div>
			 
			 <div class="price">&euro;<%=p.getPrezzo()%> +iva </div>
			 
			 <form action="RimuoviDalCarrello" method="post">					 	
				 	<input type="hidden" name="posizione" value="<%=p.getIdcarrello()%>">
				 	<button type="submit" class="remove-btn">Rimuovi</button>
			</form>	 
				
			 
			 </div>
		<% 		
				String valoreFormattato = p.getPrezzo().replaceAll("\\.", "").replace(",", ".");
        		double valoreDouble = Double.parseDouble(valoreFormattato);

		 		prezzo_tot=prezzo_tot+ ( valoreDouble +( valoreDouble*4 )/100); 
				}
	 	  	DecimalFormat formato = new DecimalFormat("#,##0.00");
	        String valoreRiFormattato = formato.format(prezzo_tot);
		 %>
		 
		  <%
			  if(!valoreRiFormattato.equals("0,00"))
			  {
		  %>
		  <div id="total">Totale: &euro;<%=valoreRiFormattato%> (iva inclusa)</div>
		  <form action="checkout.jsp" method=post>
			  <br>
			  <input type="submit" value="Completa Ordine" class="product-add-to-cart">
			  <br><br><br>	 	
		  </form>
		  <%}
			else{%>
		  <div style="text-align: center;"><b>Carrello Vuoto</b></div>
		  <%
		  		}
		   
		  %>
</div>
</body>
</html>
<%@include file="footer.jsp" %>


