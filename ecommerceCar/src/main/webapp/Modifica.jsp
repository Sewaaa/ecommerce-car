<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>	
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Modifica Informazioni</title>
    <style>
        body {
            align-items: center;
            text-align: center;
        }

        .disabled {
            background-color: #f2f2f2;
            color: #999;
        }

        .disabled option {
            color: #999;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="css/carrello.css">
</head>
<body>
    <!-- MODIFICA DEL PRODOTTO -->
    <h1 style="text-align: center;">Modifica del Prodotto</h1>
    <%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*, java.text.DecimalFormat, model.object.*" %>
    <%
        prodotto p = (prodotto) session.getAttribute("prodotto");
    %>

    <form action="modifica_prodotto" method="post">
        <label for="tipo">Tipo:</label>
        <select name="tipo" id="tipo" required>
            <option value="macchina" <%=p.getTipo().equals("macchina") ? "selected" : "" %>>Macchina</option>
            <option value="accessorio" <%=p.getTipo().equals("accessorio") ? "selected" : "" %>>Accessorio</option>
        </select><br><br>
        
        <label for="brand">Brand:</label>
        <select name="brand" id="brand" required>
            <option value="1" <%=p.getId_brand().equals("1") ? "selected" : "" %>>Ferrari</option>
            <option value="2" <%=p.getId_brand().equals("2") ? "selected" : "" %>>Mercedes</option>
            <option value="3" <%=p.getId_brand().equals("3") ? "selected" : "" %>>BMW</option>
            <option value="4" <%=p.getId_brand().equals("4") ? "selected" : "" %>>Jaguar</option>
            <option value="5" <%=p.getId_brand().equals("5") ? "selected" : "" %>>Alfa Romeo</option>
            <option value="6" <%=p.getId_brand().equals("6") ? "selected" : "" %>>Tesla</option>
        </select>
        <br><br>

        <label for="nome">Nome:</label>
        <input type="text" value="<%=p.getNome()%>" name="nome" id="nome" required><br><br>
        
        <label for="descrizione">Descrizione:</label>
        <input type="text" value="<%=p.getDescrizione()%>" name="descrizione" id="descrizione" required><br><br>

        <label for="data_rilascio">Data di Rilascio:</label>
        <input type="text" maxlength="4" value="<%=p.getData_rilascio()%>" name="data_rilascio" id="data_rilascio" required><br><br>

        <label for="prezzo">Prezzo:</label>
        <input type="text" value="<%=p.getPrezzo()%>" name="prezzo" id="prezzo" required><br><br>

        <label for="foto">Path Foto:</label>
        <input type="text" value="<%=p.getPercorso()%>" name="percorso" id="percorso" required><br><br>

        <input type="hidden" name="id_prodotto" id="id_prodotto_input" value="<%=p.getId()%>">
        <input type="submit" value="Modifica">
    </form>
</body>
</html>
<%@include file="footer.jsp" %>
