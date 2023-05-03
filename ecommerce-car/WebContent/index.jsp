<html>

<head>
<title>home</title>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@500&display=swap');
</style>
</head>
	<style>
    /* Imposta la larghezza e l'altezza del contenitore della barra */
    .container {
        width: 100%;
        overflow-x: auto; /* Abilita lo scorrimento orizzontale */
        white-space: nowrap; /* Impedisce il wrapping dei contenuti su più righe */
    }

    /* Imposta la larghezza, l'altezza e il margine dei singoli elementi della barra */
    .item {
        width: 500px;
        height: 300px;
        margin-right: 10px; /* Aggiunge uno spazio tra gli elementi */
        display: inline-block; /* Impedisce ai contenuti di spostarsi su righe separate */
    }
</style>
<body style="margin: 0px;">

<%@include file="header.jsp" %>

<!-- Connesione al db-->
<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*" %>
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
		String query="select p.id as id_prodotto , b.nome as nome_brand, p.nome as nome_prodotto, m.percorso from prodotti as p ,brand as b, media as m where p.id_brand=b.id and m.id_prodotto=p.id and p.tipo='macchina';"; 
		//out.println(query);
		resultset = statement.executeQuery(query);
%>
	<h3>In Primo Piano</h3>
	<div class="container">
	<% while(resultset.next()){ %>
		 <div class="item">
		 	<a href="http://localhost/ecommerce-car?id=<%=resultset.getString("id_prodotto")%>"><img class="item" src="<%=resultset.getString("percorso")%>"></a>
		 	<br>
		 	<a align=center>
		 		<%=resultset.getString("nome_brand")%>
		 		<%=resultset.getString("nome_prodotto")%>
		 	</a>
		 	
		 </div>
	<% }%>
	</div>
<% 	
		connection.close();
	}catch (Exception e) {
		out.print(e);
	}
%>

<%@include file="footer.jsp" %>
</body>
</html>