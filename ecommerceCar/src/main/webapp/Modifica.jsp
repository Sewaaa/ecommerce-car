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
    <h1 align="center">Modifica del Prodotto</h1>
    <%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*, java.text.DecimalFormat" %>
    <%
        String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog?serverTimezone=Europe/Rome"; 
        String user = "root";
        String password = "root";
        String id_brand = "";
        String tipo_prodotto = "";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(dbUrl, user, password);

            String id = request.getParameter("id_prodotto");
            String query = "SELECT p.nome as nome_prodotto, p.tipo as tipo_prodotto, p.data_rilascio as data_rilascio_prodotto, p.prezzo as prezzo_prodotto, b.nome as nome_brand, p.id_brand as id_brand, p.descrizione as descrizione_prodotto, m.percorso as path_p "
                         + "FROM prodotti as p, brand as b, media as m "
                         + "WHERE p.id_brand = b.id AND m.id_prodotto = p.id AND p.id = ?;";

            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, Integer.parseInt(id));

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                tipo_prodotto = resultSet.getString("tipo_prodotto");
                String nome_prodotto = resultSet.getString("nome_prodotto");
                String descrizione_prodotto = resultSet.getString("descrizione_prodotto");
                String data_rilascio_prodotto = resultSet.getString("data_rilascio_prodotto");
                String prezzo_prodotto = resultSet.getString("prezzo_prodotto");
                id_brand = resultSet.getString("id_brand");
                String path_p = resultSet.getString("path_p");
    %>
    <!-- form-->

    <form action="modifica_prodotto" method="post">
        <label for="tipo">Tipo:</label>
        <select name="tipo" id="tipo" required>
            <option value="macchina" <%=tipo_prodotto.equals("macchina") ? "selected" : "" %>>Macchina</option>
            <option value="accessorio" <%=tipo_prodotto.equals("accessorio") ? "selected" : "" %>>Accessorio</option>
        </select><br><br>
        
        <label for="brand">Brand:</label>
        <select name="brand" id="brand" required>
            <option value="1" <%=id_brand.equals("1") ? "selected" : "" %>>Ferrari</option>
            <option value="2" <%=id_brand.equals("2") ? "selected" : "" %>>Mercedes</option>
            <option value="3" <%=id_brand.equals("3") ? "selected" : "" %>>BMW</option>
            <option value="4" <%=id_brand.equals("4") ? "selected" : "" %>>Alpina</option>
            <option value="5" <%=id_brand.equals("5") ? "selected" : "" %>>Alfa Romeo</option>
            <option value="6" <%=id_brand.equals("6") ? "selected" : "" %>>Tesla</option>
        </select>
        <br><br>

        <label for="nome">Nome:</label>
        <input type="text" value="<%=nome_prodotto%>" name="nome" id="nome" required><br><br>
        
        <label for="descrizione">Descrizione:</label>
        <input type="text" value="<%=descrizione_prodotto%>" name="descrizione" id="descrizione" required><br><br>

        <label for="data_rilascio">Data di Rilascio:</label>
        <input type="text" value="<%=data_rilascio_prodotto%>" name="data_rilascio" id="data_rilascio" required><br><br>

        <label for="prezzo">Prezzo:</label>
        <input type="text" value="<%=prezzo_prodotto%>" name="prezzo" id="prezzo" required><br><br>

        <label for="foto">Path Foto:</label>
        <input type="text" value="<%=path_p%>" name="percorso" id="percorso" required><br><br>

        <input type="hidden" name="id_prodotto" id="id_prodotto_input" value="<%=id%>">
        <input type="submit" value="Modifica">
    </form>

    <% }
        connection.close(); 
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>
</body>
</html>
<%@include file="footer.jsp" %>
