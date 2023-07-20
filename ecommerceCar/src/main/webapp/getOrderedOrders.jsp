<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*, java.text.DecimalFormat" %>
<%
	HttpSession sessione = request.getSession();
	String email = (String)session.getAttribute("email");
    String sortOrder = request.getParameter("sortOrder");

    String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog?serverTimezone=Europe/Rome"; 
    String user = "root";
    String password = "root";
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(dbUrl, user, password);
        
        Statement statement = connection.createStatement();
        String query = "SELECT o.id AS id_ordine, o.data_ordine, o.prezzo_tot, p.id AS id_prodotto, p.tipo AS tipo, p.nome AS nome_prodotto, b.nome AS nome_brand, m.percorso AS percorso_media, p.prezzo AS prezzo_prodotto, c.nome AS nome_colore, r.tipo AS tipo_ruote, i.tipo AS tipo_interni "
        	    + "FROM ACQUISTI a "
        	    + "JOIN ORDINI o ON a.id_ordine = o.id "
        	    + "JOIN UTENTI u ON a.email_utente = u.email "
        	    + "JOIN PRODOTTI p ON a.id_prodotto = p.id "
        	    + "JOIN BRAND b ON p.id_brand = b.id "
        	    + "JOIN MEDIA m ON p.id = m.id_prodotto "
        	    + "LEFT JOIN COLORI c ON a.id_colore = c.id "
        	    + "LEFT JOIN RUOTE r ON a.id_ruote = r.id "
        	    + "LEFT JOIN INTERNI i ON a.id_interni = i.id "
        	    + "WHERE u.email = '" + email + "' ";

        	if (sortOrder != null) {
        	    switch (sortOrder) {
        	        case "recente":
        	            query += "ORDER BY o.id DESC";
        	            break;
        	        case "vecchia":
        	            query += "ORDER BY o.id ASC";
        	            break;
        	        case "meno-caro":
        	            query += "ORDER BY CAST(prezzo_tot AS DECIMAL) ASC";
        	            break;
        	        case "piu-caro":
        	            query += "ORDER BY CAST(prezzo_tot AS DECIMAL) DESC";
        	            break;
        	        default:
        	            break;
        	    }
        	}
        
        System.out.println(query);
        ResultSet resultSet = statement.executeQuery(query);
        boolean hasResults = false;
        String currentOrderId = "";
        while (resultSet.next()) {
        	hasResults = true;
            String orderId = resultSet.getString("id_ordine");
            String dataOrdine = resultSet.getString("data_ordine");
            String prezzoTot = resultSet.getString("prezzo_tot");
            String nomeProdotto = resultSet.getString("nome_prodotto");
            String nomeBrand = resultSet.getString("nome_brand");
            String percorsoMedia = resultSet.getString("percorso_media");
            String prezzoProdotto = resultSet.getString("prezzo_prodotto");
            String nomeColore = resultSet.getString("nome_colore");
            String tipoRuote = resultSet.getString("tipo_ruote");
            String tipoInterni = resultSet.getString("tipo_interni");
            %>
             
            <% 
            if (!currentOrderId.equals(orderId)) {
            	Statement statement2 = connection.createStatement();
		        String query2 = "SELECT * FROM ORDINI WHERE id = " + orderId + " AND email_utente = '" + email + "';";
		        System.out.println(query2);
		        ResultSet resultSet2 = statement2.executeQuery(query2);
		        resultSet2.next();
             %>
             	<div class="item-ordine">
                    ORDINE <%= orderId %>&#176; 
                    <br>(<%= resultSet2.getString("data_ordine") %>)
                    <br>Totale: &euro;<%= resultSet2.getString("prezzo_tot") %>
              	</div>  
    	
            <% 
                currentOrderId = orderId;
            } %>
            
            <div class="item">
                <form action="shopServlet" method="get">	
			 		<button type="submit" class="invisible-button">
			 			<img alt="immagine prodotto" class="item" src="<%= percorsoMedia %>">
			 		</button>
			 		<input type="hidden" name="id_prodotto" value="<%= resultSet.getString("id_prodotto") %>">
			 		<input type="hidden" name="tipo" value="<%= resultSet.getString("tipo") %>">
		 		</form>
		 	
                <form action="shopServlet" method="get">	
			 		<button type="submit" class="invisible-button">
			 			<div class="title">
			 				<%= nomeBrand %>
			 				<%= nomeProdotto %>
			 			</div>
			 	
			 			<% if (resultSet.getString("tipo").equals("macchina")) { %>
			 			<div class="personalizzazione">
			 				( Colore: <b><%= nomeColore %></b> - 
			 				  Ruote: <b><%= tipoRuote %></b>	-
			 				  Interni: <b><%= tipoInterni %></b> )
			 			</div>
			 			<% } %>
			 
			 		</button>
			 		<input type="hidden" name="id_prodotto" value="<%= resultSet.getString("id_prodotto") %>">
			 		<input type="hidden" name="tipo" value="<%= resultSet.getString("tipo") %>">
				</form>

				<div class="price">&euro;<%= prezzoProdotto %> +iva </div>
			</div>
        <% } 
        if (!hasResults) { %>
        <div align=center><b>Nessun Ordine Effettuato</b></div>
    <% }  
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
