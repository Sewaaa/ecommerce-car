<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>	
<%
if ( session == null || email==null || !email.equals("admin@fgms.it")) {

	response.sendRedirect("accesso_negato.jsp");
}
else
{
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <title>Utenti Registrati</title>
    <link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
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
        table {
            border-collapse: collapse;
            width: 70%;
            margin: 0 auto;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 2px solid #ddd;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="css/carrello.css">
</head>
<body>
<%
    // Dichiarazione delle variabili per la connessione al database
    String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog?serverTimezone=Europe/Rome";
    String user = "root";
    String password = "root";

    // Recupero il parametro di ricerca dalla richiesta
    String searchEmail = request.getParameter("searchEmail");
    // Creazione della connessione al database
    Class.forName("com.mysql.jdbc.Driver");
    Connection connection = DriverManager.getConnection(dbUrl, user, password);

    // Creazione dello statement SQL
    String query = "SELECT email, nome, cognome, telefono FROM utenti WHERE email != 'admin@fgms.it'";
    if (searchEmail != null && !searchEmail.isEmpty()) {
        query += " AND email='" + searchEmail + "'";
    }
    else
    {
    	searchEmail = "";
    }
    Statement statement = connection.createStatement();
    ResultSet resultSet = statement.executeQuery(query);
%>
<br><br>
<form method="GET" action="">
    <label for="searchEmail">Cerca per Email:</label>
    <input type="text" id="searchEmail" name="searchEmail" value="<%= searchEmail %>">
    <button type="submit">Cerca</button>
</form>
<br>
<h2>Utenti Registrati</h2>
<table>
 <caption></caption>
    <tr>
        <th>Email</th>
        <th>Nome</th>
        <th>Cognome</th>
        <th>Telefono</th>
    </tr>
    <% while(resultSet.next()) { %>
        <tr>
            <td><%= resultSet.getString("email") %></td>
            <td><%= resultSet.getString("nome") %></td>
            <td><%= resultSet.getString("cognome") %></td>
            <td><%= resultSet.getString("telefono") %></td>
        </tr>
    <% } %>
</table>

<%
    // Chiusura della connessione al database
    resultSet.close();
    statement.close();
    connection.close();
%>
</body>
<%}%>
</html>
<%@include file="footer.jsp" %>