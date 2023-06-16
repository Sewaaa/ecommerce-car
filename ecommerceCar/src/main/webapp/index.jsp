<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*" %>
<%
	String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog"; 
	String user = "root";
	String password = "root";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(dbUrl, user, password);
		//out.print("Database connecion successful");
		ResultSet resultset;
		Statement statement=connection.createStatement();
		String query="select p.id as id_prodotto , b.nome as nome_brand, p.nome as nome_prodotto, m.percorso from prodotti as p ,brand as b, media as m where p.id_brand=b.id and m.id_prodotto=p.id ;"; 
		//out.println(query);
		resultset = statement.executeQuery(query);
%>
<!DOCTYPE html>
<html>

<head>
<title>Home</title>	
<link rel="stylesheet" type="text/css" href="css/index.css">

<script type="text/javascript">
$(function() {
	$(".item").css("opacity","1.0");	// Opacità delle immagini impostate al 50%
	$(".item").hover(function () {	// Al passaggio del mouse
	$(this).stop().animate({opacity: 0.5}, "slow");}, // imposta l'opacità al 100%
	function () {	// quando il mouse non è sull'elemento
	$(this).stop().animate({opacity: 1.0}, "slow");});	// imposta l'opacità al 50%
	});
</script>
</head>
<%@include file="header.jsp" %>
<body>
<br><br>
	<h2 align=center>Catalogo</h2>
	
		<div class="container">
		<% while(resultset.next()){ %>
			 <form action="shopServlet" method="get">	
				 <div class="photo">
				 	<button type="submit" class="invisible-button">
				 		<img class="item" alt="Immagine non disponibile" src="<%=resultset.getString("percorso")%>">
				 	</button>
				 	<br>
				 	<a style="align:center">
				 		<%=resultset.getString("nome_brand")%>
				 		<%=resultset.getString("nome_prodotto")%>
				 	</a>
				 </div>
				 <input type="hidden" name="id_prodotto" value="<%=resultset.getString("id_prodotto")%>">
			 </form>
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