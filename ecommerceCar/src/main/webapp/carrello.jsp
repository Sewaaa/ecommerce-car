<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import ="java.util.ArrayList"%>
<%@ page import ="java.util.Enumeration"%>
<%@ page import ="ecommerceCar.prodotto"%>
<%
	
	int flag = 0;
	ArrayList<prodotto> s = new ArrayList<prodotto>();
	Enumeration<String> attrNames = session.getAttributeNames();
	while (attrNames.hasMoreElements()){
		if (((String) attrNames.nextElement()).equals("id_prodotto")) {
	    	flag = 1;
		}
	}
	if(flag == 0){
		session.setAttribute("id_prodotto", s);
	}else{
		@SuppressWarnings("unchecked")
		ArrayList<prodotto> temp = (ArrayList<prodotto>) session.getAttribute("id_prodotto");
		s = temp;
	}
%>
<!DOCTYPE html>
<html lang="it">

<head>
<title>Carrello</title>	
<link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="css/carrello.css">

</head>


<body style="margin: 0px;">

<%@include file="header.jsp" %>

	<h2 align=center>Carrello</h2>
	
	
	 <!-- Connesione al db-->
<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*, java.text.DecimalFormat" %>
<%
	String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog?serverTimezone=Europe/Rome"; 
	String user = "root";
	String password = "root";
	double prezzo_tot=0.00; 
	/*CARRELLO GESTITO CON SESSIONE, PER UTENTE NON LOGGATO*/
	if(email == null || email.isEmpty()) 
	{%>
		<div id="cart">
		<%
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection(dbUrl, user, password);
			//out.print("Database connecion successful");
			ResultSet resultset;
			Statement statement=connection.createStatement();
			int i=0;
		 	for (prodotto x : s) {
			String query="select p.id as id_prodotto ,p.prezzo,p.tipo, b.nome as nome_brand, p.nome as nome_prodotto, m.percorso from prodotti as p ,brand as b, media as m where p.id_brand=b.id and m.id_prodotto=p.id and p.id="+s.get(i).getId()+";"; 
			//out.println(query);
			resultset = statement.executeQuery(query);
			 while(resultset.next()){ %>
				 <div class="item">
				 
				 <form action="shopServlet" method="get">	
					 	<button type="submit" class="invisible-button">
					 		<img alt="immagine prodotto" class="item" src="<%=resultset.getString("percorso")%>">
					 	</button>
					 	<input type="hidden" name="id_prodotto" value="<%=resultset.getString("id_prodotto")%>">
					 	<input type="hidden" name="tipo" value="<%=resultset.getString("tipo")%>">
				 </form>
				 
				 <form action="shopServlet" method="get">	
					 	<button type="submit" class="invisible-button">
					 	<div class="title">
					 		<%=resultset.getString("nome_brand")%>
					 		<%=resultset.getString("nome_prodotto")%>
					 	</div>
					 	
					 	<% String tipo = s.get(i).getCategoria();
					 	   Statement st=connection.createStatement();
					 	   if(tipo.equals("macchina")){ 
					 		  
					 		    ResultSet ResultSet;
					 		  	query="select * from colori where id="+s.get(i).getColore();
					 		  	ResultSet = st.executeQuery(query);
					 		  	ResultSet.next(); 
					 		  	String colore=ResultSet.getString("nome");
								
					 		  	query="select * from ruote where id="+s.get(i).getRuote();
								ResultSet = st.executeQuery(query);
								ResultSet.next(); 
								String ruote=ResultSet.getString("tipo");
								
								query="select * from interni where id="+s.get(i).getInterni();
								ResultSet = st.executeQuery(query);
								ResultSet.next(); 
								String interni=ResultSet.getString("tipo"); 
							
					 	%>
					 	   
					 		<div class="personalizzazione">
					 		( Colore: <b><%=colore%> </b>- 
				 			  Ruote: <b><%=ruote%></b>	-
				 		 	  Interni: <b><%=interni%></b> )
					 		
					 		</div>
					 	<%}%>
					 	</button>
					 	<input type="hidden" name="tipo" value="<%=resultset.getString("tipo")%>">
					 	<input type="hidden" name="id_prodotto" value="<%=resultset.getString("id_prodotto")%>">	
				 </form>
				 
				 <div class="price"><%=resultset.getString("prezzo")%> +iva </div>
				 
				 <form action="RimuoviDalCarrello" method="post">	
					 	<button type="submit" class="remove-btn">Remove</button>
					 	<input type="hidden" name="posizione" value="<%=i%>">
				</form>	 
					
				 
				 </div>
			<% 		
					i++;
					String valoreFormattato = resultset.getString("prezzo").replaceAll("\\.", "").replace(",", ".");
	        		double valoreDouble = Double.parseDouble(valoreFormattato);

			 		prezzo_tot=prezzo_tot+ ( valoreDouble +( valoreDouble*4 )/100); 
					}
			 	}
		 	  	DecimalFormat formato = new DecimalFormat("#,##0.00");
		        String valoreRiFormattato = formato.format(prezzo_tot);
			 %>
			  
			  <%
			  if(!valoreRiFormattato.equals("0,00"))
			  {
			  %>
			  <div id="total">Totale: <%=valoreRiFormattato%> (iva inclusa)</div>
			  <form action=login.jsp method=post>
				  <br>
				  <input type="submit" value="Completa Ordine" class="product-add-to-cart">
				  <br><br><br>
		 	  </form>
		
			<%}else{%>
		  	<div align=center><b>Carrello Vuoto</b></div>
		  	<%}%>
		
	<% 	
			connection.close();
		}catch (Exception e) {
			out.print(e);
		}
	%>
	</div>
	<%
	}
	else	/*CARRELLO GESTITO A LIVELLO DB PER UTENTI CON ACCOUNT*/
	{
	%>
	<div id="cart">
	<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(dbUrl, user, password);
		//out.print("Database connecion successful");
		ResultSet resultSet;
		Statement statement=connection.createStatement();
		String query="";
		
		query="SELECT p.id as id_prodotto,p.tipo,c.id as id_carrello, p.nome as nome_prodotto, p.prezzo, b.nome as nome_brand, colori.nome as colore, ruote.tipo as ruote , interni.tipo as interni, m.percorso"+
				" FROM prodotti p"+
				" INNER JOIN carrello c ON p.id = c.id_prodotto"+
				" INNER JOIN media m ON p.id = m.id_prodotto"+
				" INNER JOIN brand b ON p.id_brand = b.id"+
				" left JOIN  colori ON colori.id = c.id_colore"+
				" left JOIN  ruote ON ruote.id = c.id_ruote"+
				" left JOIN  interni ON interni.id = c.id_interni"+
				" WHERE c.email_utente = '"+email+"'";
		
		//out.println(query);
		resultSet = statement.executeQuery(query);
		while(resultSet.next()){ %>
			 
			 <div class="item">
			 
			 <form action="shopServlet" method="get">	
				 	<button type="submit" class="invisible-button">
				 		<img alt="immagine prodotto" class="item" src="<%=resultSet.getString("percorso")%>">
				 	</button>
				 	<input type="hidden" name="id_prodotto" value="<%=resultSet.getString("id_prodotto")%>">
			 		<input type="hidden" name="tipo" value="<%=resultSet.getString("tipo")%>">
			 </form>
			 
			 <form action="shopServlet" method="get">	
				 	<button type="submit" class="invisible-button">
				 	<div class="title">
				 
				 		<%=resultSet.getString("nome_brand")%>
				 		<%=resultSet.getString("nome_prodotto")%>
				 	</div>
				 	
				 		<% if(resultSet.getString("tipo").equals("macchina")) {%>
				 		<div class="personalizzazione">
				 		( Colore: <b><%=resultSet.getString("colore")%> </b>- 
				 		  Ruote: <b><%=resultSet.getString("ruote")%></b>	-
				 		  Interni: <b><%=resultSet.getString("interni")%></b> )
				 		 </div>
				 		 <% }%>
				 
				 	</button>
				 	<input type="hidden" name="tipo" value="<%=resultSet.getString("tipo")%>">
				 	<input type="hidden" name="id_prodotto" value="<%=resultSet.getString("id_prodotto")%>">
				 	
			 </form>
			 
			 <div class="price"><%=resultSet.getString("prezzo")%> +iva </div>
			 
			 <form action="RimuoviDalCarrello" method="post">					 	
				 	<input type="hidden" name="id_carrello" value="<%=resultSet.getString("id_carrello")%>">
				 	<button type="submit" class="remove-btn">Rimuovi</button>
			</form>	 
				
			 
			 </div>
		<% 		
				String valoreFormattato = resultSet.getString("prezzo").replaceAll("\\.", "").replace(",", ".");
        		double valoreDouble = Double.parseDouble(valoreFormattato);

		 		prezzo_tot=prezzo_tot+ ( valoreDouble +( valoreDouble*4 )/100); 
				}
	 	  	DecimalFormat formato = new DecimalFormat("#,##0.00");
	        String valoreRiFormattato = formato.format(prezzo_tot);
		 %>
		 
		  <%
			  if(!valoreRiFormattato.equals("0,00"))
			  {
		  %>
		  <div id="total">Totale: <%=valoreRiFormattato%> (iva inclusa)</div>
		  <form action="checkout.jsp" method=post>
			  <br>
			  <input type="submit" value="Completa Ordine" class="product-add-to-cart">
			  <br><br><br>	 	
		  </form>
		  <%}else{%>
		  <div align=center><b>Carrello Vuoto</b></div>
		  <%}%>

	
<% 	
		connection.close();

	}catch (Exception e) {
		out.print(e);
	}
}

%>
</div>
<%@include file="footer.jsp" %>
</body>
</html>


