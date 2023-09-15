<!-- PAGINA PER FILTRO ORDINI IN AJAX IN BASE ALLA DATA DI ORDINI UTENTI.JSP (LATO AMMINISTRATORE) -->
<%@ page import="java.util.ArrayList,java.sql.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*, java.text.DecimalFormat, model.object.*" %>
<!DOCTYPE html>
<html lang="it">
<head>
	<title>Filtro Ordini</title>
    <link rel="stylesheet" type="text/css" href="css/carrello.css">
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
</head>
<body>
     <div id="cart">
        <%
         boolean hasResults = false;
         @SuppressWarnings("unchecked")
         ArrayList<ordine> ordini = (ArrayList<ordine>) session.getAttribute("ordini");
 		
         String currentOrderId = "";
         int n_ordini=0;
         if(session.getAttribute("orderOption").equals("recenti") && !session.getAttribute("email").equals("admin@fgms.it"))
         {
        	 n_ordini=(int)session.getAttribute("oSize");
         }
         for(ordine o: ordini){ //SCORRI OGNI ORDINE
        	 hasResults =true;
        	 if (!currentOrderId.equals(o.getId())) {
        		 if(session.getAttribute("orderOption").equals("recenti")&& !session.getAttribute("email").equals("admin@fgms.it"))
                 n_ordini--;
        		 else if(!session.getAttribute("email").equals("admin@fgms.it")) n_ordini++;
                 
         %>
                <div class="item-ordine">
                    Utente: <%=o.getUtente().getEmail()%>
                    <br>
                    <% if(!session.getAttribute("email").equals("admin@fgms.it"))
                    	{%>
                    	ORDINE <%= n_ordini %>&#176; (<%= o.getData_ordine()%>)
                    	<%}
                    else{%>
                    	ORDINE <%= o.getId() %>&#176; (<%= o.getData_ordine()%>)
                    	<%}%>
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
</html>
