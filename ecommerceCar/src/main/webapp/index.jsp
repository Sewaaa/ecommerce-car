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
		String query="select p.id as id_prodotto , b.nome as nome_brand, p.tipo, p.nome as nome_prodotto, p.prezzo, m.percorso from prodotti as p ,brand as b, media as m where p.id_brand=b.id and m.id_prodotto=p.id ;"; 
		//out.println(query);
		resultset = statement.executeQuery(query);
%>
<!DOCTYPE html>
<html lang="it">

<head>
<title>Home</title>	
<link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="css/index.css">

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
<!-- FILTROCATALOGO PER TIPO PRODOTTO -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script type="text/javascript">
    $(document).ready(function() {
      $("#filterType").change(function() {
        var selectedType = $(this).val();
        $.ajax({
          url: "filterProducts.jsp",
          method: "GET",
          data: { type: selectedType },
          success: function(response) {
            $(".container").html(response);
          }
        });
      });
    });
  </script>
</head>
<!-- CATALOGO -->
<body>
<%@include file="headerhome.jsp" %>
<div class="hero">
	<video muted autoplay loop class="videofullscreen">
    	<source src="imgs/videohome.mp4" type="video/mp4">
  	</video>
  <div class="titolo">
  	<H1><b>L'auto dei tuoi sogni<br>a portata di click</b></H1>
	<a href="brand.jsp" class="bottone">Scopri di pi&#249;</a>  
  </div>
</div>


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

	<h2>Catalogo</h2>
	<!-- APPLICA FILTRI A PRODOTTI -->
   <div style="text-align: center; margin: -10px 0px 50px 0px;">
  	<p class="smalltext">Filtra catalogo per 
	  <select id="filterType" style="display: inline-block;">
	    <option value="">Tutti</option>
	    <option value="macchina">Auto</option>
	    <option value="accessorio">Accessori</option>
	  </select>
	 </p>
	</div>
		<div class="container">
		<% while(resultset.next()){ %>
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