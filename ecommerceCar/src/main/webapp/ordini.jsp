<!-- Ordini lato Utenti -->
<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*, java.text.DecimalFormat" %>
<!DOCTYPE html>
<%@include file="header.jsp" %>
<%
if ( session == null || email==null ) {

	response.sendRedirect("accesso_negato.jsp");
}
else
{
%>


<html>
<head>
    <title>Ordini Effettuati</title>
    <link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/carrello.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
      $(document).ready(function() {
        $("#sort-order").change(function() {
          var sortOrder = $(this).val();
          loadOrderedOrders(sortOrder);
        });
      });

      function loadOrderedOrders(sortOrder) {
        $.ajax({
          url: "getOrderedOrders.jsp",
          type: "GET",
          data: { sortOrder: sortOrder },
          success: function(data) {
            $("#cart").html(data);
          },
          error: function(xhr, status, error) {
            console.error(error);
          }
        });
      }
    </script>
</head>
<body>
  <h1>Ordini Effettuati</h1>

  <!-- Filtro a tendina per l'ordinamento -->
  <p class="smalltext"> Ordina per:
  <select id="sort-order" style="display: inline-block;">
    <option value="recente">Pi&ugrave; recente</option>
    <option value="vecchia">Meno recente</option>
    <option value="meno-caro">Meno caro</option>
    <option value="piu-caro">Pi&ugrave; caro</option>
  </select>
  </p>
  <div id="cart">
    <%
	boolean hasResults = false;
    String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog?serverTimezone=Europe/Rome"; 
    String user = "root";
    String password = "root";
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(dbUrl, user, password);
        
        Statement statement = connection.createStatement();
        String query = "SELECT o.id AS id_ordine, p.id AS id_prodotto,p.tipo as tipo,p.nome AS nome_prodotto, b.nome AS nome_brand, m.percorso AS percorso_media, p.prezzo AS prezzo_prodotto,c.nome AS nome_colore, r.tipo AS tipo_ruote, i.tipo AS tipo_interni"
        		+" FROM ACQUISTI a"
        		+" JOIN ORDINI o ON a.id_ordine = o.id"
        		+" JOIN UTENTI u ON a.email_utente = u.email"
        		+" JOIN PRODOTTI p ON a.id_prodotto = p.id"
        		+" JOIN BRAND b ON p.id_brand = b.id"
        		+" JOIN MEDIA m ON p.id = m.id_prodotto"
        		+" left join COLORI c ON a.id_colore = c.id"
        		+" left join RUOTE r ON a.id_ruote = r.id"
        		+" left join INTERNI i ON a.id_interni = i.id"
        		+" WHERE u.email = '"+email+"'"
        		+" ORDER BY o.id DESC;";
        System.out.println(query);
        ResultSet resultSet = statement.executeQuery(query);
            String currentOrderId = "";
            while (resultSet.next()) {
            	hasResults = true;
                String orderId = resultSet.getString("id_ordine");
                String nomeProdotto = resultSet.getString("nome_prodotto");
                String nomeBrand = resultSet.getString("nome_brand");
                String percorsoMedia = resultSet.getString("percorso_media");
                String prezzoProdotto = resultSet.getString("prezzo_prodotto");
                String nomeColore = resultSet.getString("nome_colore");
                String tipoRuote = resultSet.getString("tipo_ruote");
                String tipoInterni = resultSet.getString("tipo_interni");

                if (!currentOrderId.equals(orderId)) {
                	Statement statement2 = connection.createStatement();
			        String query2 = "select * from ordini where id="+resultSet.getString("id_ordine")+" and email_utente='"+email+"';";
			        System.out.println(query);
			        ResultSet resultSet2 = statement2.executeQuery(query2);
			        resultSet2.next();
                 %>
                 	<div class="item-ordine">
                       ORDINE <%= orderId %>&#176; 
                       <br>(<%=resultSet2.getString("data_ordine")%>)
                       <br>Totale: &euro;<%=resultSet2.getString("prezzo_tot")%>
                  	</div>  
        	
                  <% 
                    currentOrderId = orderId;
                } %>
                
               <div class="item">
                    <form action="shopServlet" method="get">	
				 	<button type="submit" class="invisible-button">
				 		<img class="item" src="<%=percorsoMedia%>">
				 	</button>
				 	<input type="hidden" name="id_prodotto" value="<%=resultSet.getString("id_prodotto")%>">
			 		<input type="hidden" name="tipo" value="<%=resultSet.getString("tipo")%>">
			 		</form>
			 	
                    
                    
                    <form action="shopServlet" method="get">	
				 	<button type="submit" class="invisible-button">
				 	<div class="title">
				 
				 		<%=nomeBrand%>
				 		<%=nomeProdotto%>
				 	</div>
				 	
				 		<% if(resultSet.getString("tipo").equals("macchina")) {%>
				 		<div class="personalizzazione">
				 		( Colore: <b><%=nomeColore%> </b>- 
				 		  Ruote: <b><%=tipoRuote%></b>	-
				 		  Interni: <b><%=tipoInterni%></b> )
				 		 </div>
				 		 <% }%>
				 
				 	</button>
				 	
				 	<input type="hidden" name="id_prodotto" value="<%=resultSet.getString("id_prodotto")%>">
				 	<input type="hidden" name="tipo" value="<%=resultSet.getString("tipo")%>">
					</form>

					 <div class="price">&euro;<%=prezzoProdotto%> +iva </div>
					  </div>
			
                
            <% } 
            if (!hasResults) { %>
            <div align=center><b>Nessun Ordine Effettuato</b></div>
        <% }         
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
  </div>

</body>
<%@include file="footer.jsp" %>
</html>
<%} %>
