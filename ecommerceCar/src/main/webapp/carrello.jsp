<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import ="java.util.ArrayList"%>
<%@ page import ="java.util.Enumeration"%>
<%
	HttpSession sessione = request.getSession();
	int flag = 0;
	ArrayList<String> s = new ArrayList<String>();
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
		ArrayList<String> temp = (ArrayList<String>) session.getAttribute("id_prodotto");
		s = temp;
	}
%>

<!DOCTYPE html>
<html>

<head>
<title>Carrello</title>	
<link rel="stylesheet" type="text/css" href="css/carrello.css">
</head>


<body style="margin: 0px;">

<%@include file="header.jsp" %>
<br><br>
	<h2 align=center>Carrello</h2>
	
	<div id="cart">
	 <!-- Connesione al db-->
<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*, java.text.DecimalFormat" %>
<%
	String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog?serverTimezone=Europe/Rome"; 
	String user = "root";
	String password = "root";
	double prezzo_tot=0.00; 

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(dbUrl, user, password);
		//out.print("Database connecion successful");
		ResultSet resultset;
		Statement statement=connection.createStatement();
		int i=0;
	 	for (String x : s) {
		String query="select p.id as id_prodotto ,p.prezzo, b.nome as nome_brand, p.nome as nome_prodotto, m.percorso from prodotti as p ,brand as b, media as m where p.id_brand=b.id and m.id_prodotto=p.id and p.id="+s.get(i)+";"; 
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
		  <div id="total">Totale: <%=valoreRiFormattato%> (iva inclusa)</div>
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