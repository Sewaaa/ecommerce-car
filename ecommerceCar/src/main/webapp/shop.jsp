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
    <title>Prodotto</title>
    <link rel="stylesheet" type="text/css" href="css/shop.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body style="margin: 0px;">

<%@include file="header.jsp" %>
<br>
<div class="container mt-5">
    <div class="row">
        <div class="col-md-6">
            <img src="${percorso}" alt="Immagine del prodotto" class="product-img">
        </div>
        <div class="col-md-6">
            <h1 class="product-title">${nomeBrand} ${nomeProdotto}</h1>
            <p class="product-description">${descrizione}</p>
            <p class="product-price">&euro;${prezzo}</p>
            <form action="AggiungiAlCarrello" method="post" class="product-form">
                <input type="number" name="quantita" value="1" min="1" max="5" class="product-quantity">
                <input type="hidden" name="id_prodotto" value="<%=request.getParameter("id_prodotto")%>">
                <% //out.println(s.get(0)); %>
                <input type="submit" value="Aggiungi al carrello" class="product-add-to-cart">
            </form>
        </div>
    </div>
</div>
<br>
<%@include file="footer.jsp" %>
</body>
</html>
