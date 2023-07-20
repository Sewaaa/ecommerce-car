<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*" %>
<%
    String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog"; 
    String user = "root";
    String password = "root";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(dbUrl, user, password);

        ResultSet resultset;
        String query = "SELECT p.id AS id_prodotto, b.nome AS nome_brand, p.tipo, p.nome AS nome_prodotto, p.prezzo, m.percorso " +
                       "FROM prodotti AS p " +
                       "JOIN brand AS b ON p.id_brand = b.id " +
                       "JOIN media AS m ON m.id_prodotto = p.id " +
                       "WHERE b.id = ?";
        
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, Integer.parseInt(request.getParameter("brand")));
        resultset = statement.executeQuery();
        resultset.next();
%>


<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<title>I Nostri Brand</title>
<link rel="icon" href="imgs/favicon.ico" type="image/x-icon">

<link rel="stylesheet" type="text/css" href="css/brand.css">

<script type="text/javascript" src="javascript/slide.js"></script>
<!-- EFEFTTO PASSAGGIO MOUSE SU FOTO CATALOGO -->
<script type="text/javascript">
$(function() {
	$(".item").css("opacity","1.0");	// Opacit� delle immagini impostate al 50%
	$(".item").hover(function () {	// Al passaggio del mouse
	$(this).stop().animate({opacity: 0.5}, "slow");}, // imposta l'opacit� al 100%
	function () {	// quando il mouse non � sull'elemento
	$(this).stop().animate({opacity: 1.0}, "slow");});	// imposta l'opacit� al 50%
	});
</script>
</head>
<!-- CATALOGO -->
</head>
<body>
<%@include file="header.jsp" %>

<table class="brand">
<caption></caption>
<tr>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
</tr>
<tr>
	<td>
	<form action="brand.jsp" method="get">
		<input type="hidden" name="brand" value="6">
    	<button type="submit" class="invisible-button">
    		<img src="imgs/brands/tesla.png" alt="Logo 1">
    	</button>
    </form>
    </td>
    
    <td>
    <form action="brand.jsp" method="get">
		<input type="hidden" name="brand" value="2">
		<button type="submit" class="invisible-button">
   			<img src="imgs/brands/mercedes.png" alt="Logo 2">
   		</button>
   	</form>
   	</td>
   	
   	<td>
	<form action="brand.jsp" method="get">
		<input type="hidden" name="brand" value="3">
		<button type="submit" class="invisible-button">
   			<img src="imgs/brands/bmw.png" alt="Logo 3">
   		</button>
   	</form>
   	</td>
   	
   	<td>
   	<form action="brand.jsp" method="get">
		<input type="hidden" name="brand" value="1">
   		<button type="submit" class="invisible-button">
   			<img src="imgs/brands/ferrari.png" alt="Logo 4">
   		</button>
   	</form>
   	</td>
   	
   	<td>
   	<form action="brand.jsp" method="get">
		<input type="hidden" name="brand" value="4">
   		<button type="submit" class="invisible-button">
   			<img src="imgs/brands/alpina.png" alt="Logo 5">
   		</button>
   	</form>
   	</td>
   	
   	<td>
   	<form action="brand.jsp" method="get">
		<input type="hidden" name="brand" value="5">
   		<button type="submit" class="invisible-button">
   			<img src="imgs/brands/alfaromeo.png" alt="Logo 6">
   		</button>
   	</form>
   	</td>
</tr>
</table>

<hr>

	<h2><%=resultset.getString("nome_brand")%></h2>
		<div class="container">
		<% do { %>
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
		<% }while(resultset.next());%>
		</div>
		
	

<% 
        connection.close();
    } catch (Exception e) {
        out.print(e);
    }
%>
