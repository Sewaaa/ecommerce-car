<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ include file="header.jsp" %>
<html lang="it">
<head>
    <title>Ordine completato</title>
    <link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            text-align: center;
        }

        .icon {
            width: 150px;
            height: 150px;
            background-color: #8bc34a;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
            margin-left: auto;
            margin-right: auto;
            margin-top: 50px;
        }

        .icon i {
            color: white;
            font-size: 100px;
        }

        .message {
            font-size: 24px;
            font-weight: bold;
            color: #333333;
            margin-left: auto;
            margin-right: auto;
        }

        .button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-size: 16px;
            margin-top: 20px;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="icon">
            <i class="fas fa-check"></i>
        </div>
        <div class="message">
            Ordine completato
        </div>

        <%
        String prezzoTotale = request.getParameter("prezzo_totale");
        String prezzoNoIva = request.getParameter("prezzo_noiva");

        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("accesso_negato.jsp");
        } else {
        %>
	        <form action="crea_pdf" method="POST">
	            <input type="hidden" name="metodo_di_pagamento" value="<%=request.getParameter("metodo_di_pagamento")%>">
	            <input type="hidden" name="id_ordine" value="<%=session.getAttribute("generatedOrderId")%>">
	            <input type="hidden" name="nome" value="<%= session.getAttribute("nome") %>">
	            <input type="hidden" name="cognome" value="<%= session.getAttribute("cognome") %>">
	            <input type="hidden" name="email" value="<%= session.getAttribute("email") %>">
	            <input type="hidden" name="prezzo_totale" value="<%= prezzoTotale %>">
	            <input type="hidden" name="prezzo_noiva" value="<%= prezzoNoIva %>">
	            <button type="submit" class="button">Scarica Fattura</button>
	        </form>
        <% } %>
    </div>
</body>
</html>
<%@ include file="footer.jsp" %>
