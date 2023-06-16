	<%@include file="header.jsp" %>	
	<!DOCTYPE html>
	<html>
<%
if ( session == null || !email.equals("admin@fgms.it")) {
%>	
	<head>
	<title>Accesso Negato</title>
	</head>
	<body>
	<h1 align=center>Accesso negato</h1>
    <p align=center><%out.println("("+email+")"+nome+" "+cognome);%> non ha l'autorizzazione per accedere a questa pagina.</p>
    <div align=center><a href="login.jsp">Effettua il login</a></div>
	</body>
<%	
}
else
{
%>
	<head>
	<title>Gestione DB</title>
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
<br><br><br>
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

<!-- RIMOZIONE PRODOTTO DAL CATALOGO -->

<br><br><br>
<h1 align=center> Rimuovi Prodotto </h1>
 
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
		String query="select p.id as id_prodotto , b.nome as nome_brand, p.nome as nome_prodotto, m.percorso from prodotti as p ,brand as b, media as m where p.id_brand=b.id and m.id_prodotto=p.id"; 
		//out.println(query);
		resultset = statement.executeQuery(query);
		 while(resultset.next()){ %>
			 <div class="item">
			 
			 <form action="shopServlet" method="get">	
				 	<button type="submit" class="invisible-button">
				 		<img class="item" src="<%=resultset.getString("percorso")%>">
				 	</button>
				 	<input type="hidden" name="id_prodotto" value="<%=resultset.getString("id_prodotto")%>">
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
			 	<button type="submit" class="remove-btn">Remove</button>
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