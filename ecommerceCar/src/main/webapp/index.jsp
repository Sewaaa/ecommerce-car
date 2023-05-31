<!-- Connesione al db-->
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
</head>

<body>
<%@include file="header.jsp" %>
	<br><br>
	<h2 align=center>Catalogo</h2>
	
		<div class="container">
		<% while(resultset.next()){ %>
			 <form action="shopServlet" method="get">	
				 <div class="photo">
				 	<button type="submit" class="invisible-button">
				 		<img class="item" src="<%=resultset.getString("percorso")%>">
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