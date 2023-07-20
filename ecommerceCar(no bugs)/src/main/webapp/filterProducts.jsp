<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*" %>
<link rel="stylesheet" type="text/css" href="css/index.css">
<body>
<br><br>
<div class="container">
  <%
  String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog"; 
	String user = "root";
	String password = "root";
    String selectedType = request.getParameter("type");
    String query = "SELECT p.id AS id_prodotto,p.tipo, b.nome AS nome_brand,p.prezzo, p.nome AS nome_prodotto, m.percorso " +
                   "FROM prodotti AS p, brand AS b, media AS m " +
                   "WHERE p.id_brand = b.id AND m.id_prodotto = p.id";
    if (selectedType != null && !selectedType.isEmpty()) {
      query += " AND p.tipo = ?";
    }
    try {
      Class.forName("com.mysql.jdbc.Driver");
      Connection connection = DriverManager.getConnection(dbUrl, user, password);
      PreparedStatement statement = connection.prepareStatement(query);
      if (selectedType != null && !selectedType.isEmpty()) {
        statement.setString(1, selectedType);
      }
      ResultSet resultset = statement.executeQuery();
      while (resultset.next()) {
  %>
   <div class="prodotto">
			 <form action="shopServlet" method="get">	
				 <div class="photo">
				 	<button type="submit" class="invisible-button">
				 		<img class="item" alt="Immagine non disponibile" src="<%=resultset.getString("percorso")%>">
				 	<br>
				 	<p class="nomeprodotto">
				 		<%=resultset.getString("nome_brand")%>
				 		<%=resultset.getString("nome_prodotto")%>
				 		<br>
				 		<span class="smalltext">
				 			<%=resultset.getString("tipo")%>
				 		</span>
				 	</p>
				 	<span class="smalltext">
				 		&euro;<%=resultset.getString("prezzo")%>
				 	</span>
				 	</button>
				 </div>
				 <input type="hidden" name="tipo" value="<%=resultset.getString("tipo")%>">
				 <input type="hidden" name="id_prodotto" value="<%=resultset.getString("id_prodotto")%>">
			 </form>
		  </div>
  <% 
      }
      connection.close();
    } catch (Exception e) {
      out.print(e);
    }
  %>
</div>
</body>
</html>
