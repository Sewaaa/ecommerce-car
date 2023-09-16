<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="model.object.*" %>
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
<%@include file="header.jsp" %>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
    <title>Prodotto</title>
    <link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/shop.css">
    
    <!-- SCRITTA AGGIUNTO AL CARRELLO -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha384-KyZXEAg3QhqLMpG8r+YgG5Np6HiKu1pWWmH9B5z5l5uIdk9gxyfvKge/AUft8vq2x" crossorigin="anonymous"></script>

    <script>
        $(document).ready(function() {
            $('.product-form').submit(function(event) {
                event.preventDefault();
                $.ajax({
                    url: $(this).attr('action'),
                    type: $(this).attr('method'),
                    data: $(this).serialize(),
                    success: function(response) {
                      
                        var addToCartMessage = $('#add-to-cart-message');
                        addToCartMessage.text('AGGIUNTO AL CARRELLO!');
                        addToCartMessage.addClass('zoom-effect');
                        setTimeout(function() {
                            addToCartMessage.removeClass('zoom-effect');
                        }, 1000); // durata dell'animazione dell'aggiunta al carrello
                    },
                    error: function(xhr, status, error) {
                    	console.error(error);
                    }
                });
            });
        });
    </script>
</head>
<body>
<% 
	prodotto prodottoSelected = (prodotto) session.getAttribute("prodottoSelected");
%>
<div class="container mt-5">
    <div class="row">
        <div class="col-md-7">
            <img src="<%=prodottoSelected.getPercorso()%>" alt="Immagine del prodotto" class="product-img">
        </div>
        <div class="col-md-6">
            <h1 class="product-title"><%=prodottoSelected.getBrand()%> <%=prodottoSelected.getNome()%></h1>
            <p class="product-description"><%=prodottoSelected.getDescrizione()%></p>
            <form action="AggiungiAlCarrello" method="post" class="product-form">
               
                <input type="hidden" name="id_prodotto" value="<%=prodottoSelected.getId()%>">
                <input type="hidden" name="tipo" value="<%=prodottoSelected.getTipo()%>">
               
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
                            <option value="Nero">Nero</option>
                            <option value="Blu">Blu</option>
                            <option value="Giallo">Giallo</option>
                            <option value="Rosa">Rosa</option>
                            <option value="Rosso">Rosso</option>
                            <option value="Bianco">Bianco</option>
                        </select>
                    </td>
                    <td>
                        <h3 class="style-label">Seleziona interni:</h3>
                        <select name="interni" class="select">
                            <option value="Pelle">Pelle</option>
                            <option value="Riscaldati">Riscaldati</option>
                        </select>
                    </td>
                    <td>
                        <h3 class="style-label">Seleziona ruote:</h3>
                        <select name="ruote" class="select">
                            <option value="Carbonio">Carbonio</option>
                            <option value="Magnesio">Magnesio</option>
                            <option value="Alluminio">Alluminio</option>
                            <option value="Ghisa">Ghisa</option>
                            <option value="Oro">Oro</option>
                        </select>
                    </td>
                </tr>
                </table> 
                <%} %>
                
                <p class="product-price">&euro;<%=prodottoSelected.getPrezzo()%></p>
                <input type="submit" value="Aggiungi al carrello" class="product-add-to-cart">
            </form>
            <p id="add-to-cart-message"></p>
        </div>
    </div>
</div>
<br>
</body>
</html>
<%@include file="footer.jsp" %>
