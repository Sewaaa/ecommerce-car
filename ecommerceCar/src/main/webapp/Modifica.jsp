<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>	
<!DOCTYPE html>
<html>
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
<head>
    <meta charset="ISO-8859-1">
    <title>Modifica Informazioni</title>
</head>
<body>
<!-- MODIFICA DEL PRODOTTO -->

<h1 align=center> Modifica del Prodotto </h1>
<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*, java.text.DecimalFormat" %>
<%
    String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog?serverTimezone=Europe/Rome"; 
    String user = "root";
    String password = "root";
    String id_brand="";
    String tipo_prodotto="";
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(dbUrl, user, password);
        //out.print("Connessione al database riuscita");
        ResultSet resultset;
        Statement statement=connection.createStatement();
        String id = request.getParameter("id_prodotto");
        String query="select p.nome as nome_prodotto, p.tipo as tipo_prodotto, p.data_rilascio as data_rilascio_prodotto, p.prezzo as prezzo_prodotto, b.nome as nome_brand, p.id_brand as id_brand, p.descrizione as descrizione_prodotto, m.percorso as path_p from prodotti as p ,brand as b, media as m  where p.id_brand=b.id AND m.id_prodotto = p.id and p.id='" + id + "';";
        //out.println(query);
        resultset = statement.executeQuery(query);

        if (resultset.next()){
            tipo_prodotto= resultset.getString("tipo_prodotto");
            String nome_prodotto= resultset.getString("nome_prodotto");
            String descrizione_prodotto= resultset.getString("descrizione_prodotto");
            String data_rilascio_prodotto= resultset.getString("data_rilascio_prodotto");
            String prezzo_prodotto= resultset.getString("prezzo_prodotto");
            id_brand= resultset.getString("id_brand");
            String path_p= resultset.getString("path_p");
            %>
            <!-- form-->

            <form action="modifica_prodotto" method="post">
                <label for="tipo">Tipo:</label>
                <select name="tipo" id="tipo" required>
                    <option value="macchina" selected>Macchina</option>
                    <option value="accessorio">Accessorio</option>
                </select><br><br>
                
                <label for="brand">Brand:</label>
                <select name="brand" id="brand" required>
                    <option value="1">Ferrari</option>
                    <option value="2">Mercedes</option>
                    <option value="3">BMW</option>
                    <option value="4">Alpina</option>
                    <option value="5">Alfa Romeo</option>
                    <option value="6">Tesla</option>
                </select>
                <br><br>

                <label for="nome">Nome:</label>
                <input type="text" value= "<%=nome_prodotto%>" name="nome" id="nome" required><br><br>
                
                <label for="descrizione">Descrizione:</label>
                <input type="text" value="<%=descrizione_prodotto%>" name="descrizione"  id="descrizione" required><br><br>

                <label for="data_rilascio">Data di Rilascio:</label>
                <input type="text"  value= "<%=data_rilascio_prodotto%>" name="data_rilascio" id="data_rilascio" required><br><br>

                <label for="prezzo">Prezzo:</label>
                <input type="text"  value= "<%=prezzo_prodotto%>" name="prezzo" id="prezzo" required><br><br>

                <label for="foto">Path Foto:</label>
                <input type="text" value= "<%=path_p%>" name="percorso" id="percorso" required><br><br>

                <input type="hidden" name="id_prodotto" value="<%=id%>">
                <input type="submit" value="Modifica">
            </form>

        <% }
        connection.close(); 
    } catch (Exception e) {
        out.print(e);
    }
%>
<script>
    var tipo = <%=tipo_prodotto%>;  

    // Seleziona l'opzione corretta in base al valore di tipo_prodotto
    var selectElement = document.getElementById('tipo');
    for (var i = 0; i < selectElement.options.length; i++) {
        if (selectElement.options[i].value === tipo.toString()) {
            selectElement.options[i].selected = true;
            break;
        }
    }
</script>	
<script>
    var tipo = <%=id_brand%>;  

    // Seleziona l'opzione corretta in base al valore di id_brand
    var selectElement = document.getElementById('brand');
    for (var i = 0; i < selectElement.options.length; i++) {
        if (selectElement.options[i].value === tipo.toString()) {
            selectElement.options[i].selected = true;
            break;
        }
    }
</script>	
</body>
</html>
<%@include file="footer.jsp" %>
