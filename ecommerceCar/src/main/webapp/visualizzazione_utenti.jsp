<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>	
<%
if (session == null || email == null || !email.equals("admin@fgms.it")) {
    response.sendRedirect("accesso_negato.jsp");
} else {
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <title>Utenti Registrati</title>
    <link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
    <style>
        /* Stili CSS */
    </style>
    <link rel="stylesheet" type="text/css" href="css/carrello.css">
</head>
<body>
<%
    String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog?serverTimezone=Europe/Rome";
    String dbUser = "root";
    String dbPassword = "root";

    String searchEmail = request.getParameter("searchEmail");
    searchEmail = (searchEmail != null) ? searchEmail : ""; // Impostare a stringa vuota se null

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        String query = "SELECT email, nome, cognome, telefono FROM utenti WHERE email != 'admin@fgms.it'";
        if (!searchEmail.isEmpty()) {
            query += " AND email=?";
        }

        PreparedStatement preparedStatement = connection.prepareStatement(query);
        if (!searchEmail.isEmpty()) {
            preparedStatement.setString(1, searchEmail);
        }

        ResultSet resultSet = preparedStatement.executeQuery();
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
        <% while (resultSet.next()) { %>
            <tr>
                <td><%= resultSet.getString("email") %></td>
                <td><%= resultSet.getString("nome") %></td>
                <td><%= resultSet.getString("cognome") %></td>
                <td><%= resultSet.getString("telefono") %></td>
            </tr>
        <% } %>
    </table>
<%
        resultSet.close();
        preparedStatement.close();
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
<% } %>
</html>
<%@ include file="footer.jsp" %>
