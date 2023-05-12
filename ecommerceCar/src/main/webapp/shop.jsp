<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Prodotto</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/shop.css">
</head>
<body style="margin: 0px;">

<%@include file="header.jsp" %>

<div class="container mt-5">
    <div class="row">
        <div class="col-md-6">
            <img src="${percorso}" alt="Immagine del prodotto" class="product-img">
        </div>
        <div class="col-md-6">
            <h1 class="product-title">${nomeBrand} ${nomeProdotto}</h1>
            <p class="product-description">${descrizione}</p>
            <p class="product-price">&euro;${prezzo}</p>
            <form action="aggiungi_carrello.php" method="post" class="product-form">
                <input type="number" name="quantita" value="1" min="1" max="5" class="product-quantity">
                <input type="hidden" name="id_prodotto" value="${id}">
                <input type="submit" value="Aggiungi al carrello" class="product-add-to-cart">
            </form>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>
</body>
</html>
