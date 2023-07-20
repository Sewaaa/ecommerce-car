<!DOCTYPE html>
<%@include file="header.jsp" %>		
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
 <h1 align=center> Inserisci Nuovo Prodotto </h1>
	  
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
            <option value="4">Alpina</option>
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
<h1 align=center> Rimuovi e Modifica Prodotti </h1>
 
<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*, java.text.DecimalFormat" %>
<%
	String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog?serverTimezone=Europe/Rome"; 
	String user = "root";
	String password = "root";
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(dbUrl, user, password);
		//out.print("Database connecion successful");
		ResultSet resultset;
		Statement statement=connection.createStatement();
		String query="select p.id as id_prodotto ,p.tipo, b.nome as nome_brand, p.nome as nome_prodotto, m.percorso from prodotti as p ,brand as b, media as m where p.id_brand=b.id and m.id_prodotto=p.id"; 
		//out.println(query);
		resultset = statement.executeQuery(query);
		 while(resultset.next()){ %>
			 <div class="item">
			 
			 <form action="shopServlet" method="get">	
				 	<input type="hidden" name="id_prodotto" value="<%=resultset.getString("id_prodotto")%>">
				 	<input type="hidden" name="tipo" value="<%=resultset.getString("tipo")%>">
				 	<button type="submit" class="invisible-button">
				 		<img alt="immagine prodotto" class="item" src="<%=resultset.getString("percorso")%>">
				 	</button>
			 </form>
			 
			 <form action="shopServlet" method="get">	
				 	<button type="submit" class="invisible-button">
				 	<div class="title">
				 		<%=resultset.getString("nome_brand")%>
				 		<%=resultset.getString("nome_prodotto")%>
				 	</div>
				 	</button>
				 	<input type="hidden" name="id_prodotto" value="<%=resultset.getString("id_prodotto")%>">
				 	
			 </form>
			 <form action="Rimuovi_da_db" method="post">
			 	<button type="submit" class="remove-btn">Rimuovi</button>
			 	<input type="hidden" name="id_prodotto" value="<%=resultset.getString("id_prodotto")%>">
			 </form>
			<form action="Modifica.jsp" method="post">
			 	<button type="submit" class="modifica-btn">Modifica</button>
			 	<input type="hidden" name="id_prodotto" value="<%=resultset.getString("id_prodotto")%>">
			 </form>
			 </div>
		
	<%	}
		connection.close(); 
	}catch (Exception e) {
		out.print(e);
	}
	%>
</body>	
	

<%}%>

</html>
<%@include file="footer.jsp" %>