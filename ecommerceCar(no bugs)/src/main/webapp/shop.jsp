<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="ecommerceCar.prodotto" %>
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
<meta charset="UTF-8">
    <title>Prodotto</title>
    <link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/shop.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $('.product-form').submit(function(event) {
                event.preventDefault(); // Previeni il comportamento predefinito dell'invio del form
                
                // Effettua la chiamata Ajax
                $.ajax({
                    url: $(this).attr('action'),
                    type: $(this).attr('method'),
                    data: $(this).serialize(),
                    success: function(response) {
                        // Aggiorna il messaggio di conferma con animazione di zoom
                        var addToCartMessage = $('#add-to-cart-message');
                        addToCartMessage.text('AGGIUNTO AL CARRELLO!');
                        addToCartMessage.addClass('zoom-effect');
                        setTimeout(function() {
                            addToCartMessage.removeClass('zoom-effect');
                        }, 1000); // Rimuovi la classe dopo 1 secondo (durata dell'animazione)
                    },
                    error: function() {
                        // Gestisci gli errori, se necessario
                    }
                });
            });
        });
    </script>
</head>
<body>

<%@include file="header.jsp" %>

<div class="container mt-5">
    <div class="row">
        <div class="col-md-7">
            <img src="${percorso}" alt="Immagine del prodotto" class="product-img">
        </div>
        <div class="col-md-6">
            <h1 class="product-title">${nomeBrand} ${nomeProdotto}</h1>
            <p class="product-description">${descrizione}</p>
            <form action="AggiungiAlCarrello" method="post" class="product-form">
                <% //<input type="number" name="quantita" value="1" min="1" max="5" class="product-quantity">%>
                <input type="hidden" name="id_prodotto" value="<%=request.getParameter("id_prodotto")%>">
                <input type="hidden" name="tipo" value="<%=request.getParameter("tipo")%>">
               
                <%if(request.getParameter("tipo").equals("macchina")){ %>
                
                <table>
                 <caption></caption>
	            <tr>
	            <th></th>
	            <th></th>
	            <th></th>
	            </tr>
                <tr>
                    <td>
                        <h3 class="style-label">Seleziona colore:</h3>
                        <select name="colore" class="select">
                            <option value="1">Nero</option>
                            <option value="2">Blu</option>
                            <option value="3">Giallo</option>
                            <option value="4">Rosa</option>
                            <option value="5">Rosso</option>
                            <option value="6">Bianco</option>
                        </select>
                    </td>
                    <td>
                        <h3 class="style-label">Seleziona interni:</h3>
                        <select name="interni" class="select">
                            <option value="1">Pelle</option>
                            <option value="2">Riscaldati</option>
                        </select>
                    </td>
                    <td>
                        <h3 class="style-label">Seleziona ruote:</h3>
                        <select name="ruote" class="select">
                            <option value="1">Carbonio</option>
                            <option value="2">Magnesio</option>
                            <option value="3">Alluminio</option>
                            <option value="4">Ghisa</option>
                            <option value="5">Oro</option>
                        </select>
                    </td>
                </tr>
                </table> 
                <%} %>
                
                <p class="product-price">&euro;${prezzo}</p>
                <input type="submit" value="Aggiungi al carrello" class="product-add-to-cart">
            </form>
            <p id="add-to-cart-message"></p>
        </div>
    </div>
</div>
<br>
<%@include file="footer.jsp" %>
</body>
</html>
