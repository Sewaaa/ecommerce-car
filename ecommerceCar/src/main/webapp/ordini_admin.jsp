<!-- Ordini lato admin -->
<%@ page import="java.sql.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*, java.text.DecimalFormat, model.object.*" %>
<%@include file="header.jsp" %>
<%
if (session == null || email == null) {
    response.sendRedirect("accesso_negato.jsp");
} else {
%>
<!DOCTYPE html>
<html lang="it">
<style>
		.button {
            display: inline-block;
            padding: 7px 13px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            margin-left: 10px;
        }
</style>
<head>
    <title>Ordini degli utenti</title>
    <link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/carrello.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="></script>
    <script>
        function filtraOrdini() {
            var emailUtente = document.getElementById("utenteEmail").value;
            var orderOption = document.getElementById("orderSelect").value;

            $.ajax({
                type: "GET",
                url: "ordini_adminSERVLET",
                data: { email: emailUtente, order: orderOption },
                success: function (response) {
                    $("#cart").html(response);
                },
                error: function (xhr, status, error) {
                    console.error(error);
                }
            });
        }
    </script>
</head>
<body>
    <h1>Ordini degli utenti</h1>
    <div style="text-align: center;">
        <input type="text" id="utenteEmail" placeholder="Inserisci l'email dell'utente">
        <button onclick="filtraOrdini()">Filtra ordini</button>
        <br><br>
        <label for="orderSelect">Ordina per data:</label>
        <select id="orderSelect" onchange="filtraOrdini()">
            <option value="recenti">Pi&ugrave; recente</option>
            <option value="vecchi" selected>Meno recente</option>
        </select>
        <br><br>
    </div>

    <div id="cart">
        <%
         boolean hasResults = false;
         @SuppressWarnings("unchecked")
         ArrayList<ordine> ordini = (ArrayList<ordine>) session.getAttribute("ordini");
 		
         String currentOrderId = "";
         for(ordine o: ordini){ //SCORRI OGNI ORDINE
        	 hasResults =true;
        	 if (!currentOrderId.equals(o.getId())) {	
         %>
                <div class="item-ordine">
                    Utente: <%=o.getUtente().getEmail()%>
                    <br>
                    ORDINE <%= o.getId() %>&#176; (<%= o.getData_ordine()%>)
                    <br>
                    Totale: &euro;<%= o.getPrezzo_tot() %> (iva inclusa)
                 </div>
		<%
			currentOrderId = o.getId();
      	 	}
		ArrayList<prodotto> prodotti = o.getProdotti();
		
		for(prodotto p: prodotti){  //SCORRI TUTTI I PRODOTTI DELL'ORDINE CORRENTE
		%>
				
                 <div class="item">
		            <img alt="immagine prodotto" class="item" src="<%=p.getPercorso()%>">
					
		            <div class="title">
		                <%=p.getBrand()%>
		                <%=p.getNome()%>
		            </div>
					<br>
		            <% if(p.getTipo().equals("macchina")) {%>
		            <div class="personalizzazione">
		                ( Colore: <b><%=p.getColore() %> </b> -
		                Ruote: <b><%= p.getRuote() %></b> -
		                Interni: <b><%= p.getInterni() %></b> )
		            </div>
		            <% }%>
		
		    <div class="price">&euro;<%=p.getPrezzo()%> +iva </div>
		    <form action="crea_pdf" method="POST">
	            <input type="hidden" name="metodo_di_pagamento" value="<%= o.getMetodo_di_pagamento() %>">
	            <input type="hidden" name="id_ordine" value="<%= o.getId() %>">
	            <input type="hidden" name="nome" value="<%= o.getNome() %>">
	            <input type="hidden" name="cognome" value="<%= o.getCognome() %>">
	            <input type="hidden" name="email" value="<%= o.getUtente().getEmail() %>">
	            <input type="hidden" name="prezzo_totale" value="<%= o.getPrezzo_tot() %>">
	            <input type="hidden" name="prezzo_noiva" value="<%= o.getPrezzo_novia() %>">
	            <button type="submit" class="button">Scarica Fattura</button>
	        </form>
			</div>

            <%
			}
		  }
          if (!hasResults) { %>
             <div style="text-align: center;"><b>Nessun Ordine Effettuato</b></div>
        <% 
          	}
  		%>
  </div>
</body>
<%@include file="footer.jsp" %>
</html>
<% } %>
