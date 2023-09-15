<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>	
<%@ page import="model.object.*"%>
<%
if ( session == null || email==null || !email.equals("admin@fgms.it")) {

	response.sendRedirect("accesso_negato.jsp");
}
else
{
%>
<!DOCTYPE html >
<html lang="it">
<head>
    <title>Risultati Utenti</title>
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
	@SuppressWarnings("unchecked")
	ArrayList<utente> utenti= (ArrayList<utente>) session.getAttribute("utenti");
%>
<br><br>
<form method="GET" action="visualizzazione_utentiSERVLET">
    <label for="searchEmail">Cerca per Email:</label>
       <%
    	if(session.getAttribute("searchEmail")==null)
    	{
    		%> 
    		<input type="text" id="searchEmail" name="searchEmail" value="">
    		<%
    	}	
    	else
    	{	%> 
			<input type="text" id="searchEmail" name="searchEmail" value="<%= session.getAttribute("searchEmail") %>">
			<%
		}
         %>
   
    <button type="submit">Cerca</button>
</form>
<br>
<h2>Utenti Registrati</h2>
<table>
    <tr>
        <th>Email</th>
        <th>Nome</th>
        <th>Cognome</th>
        <th>Telefono</th>
    </tr>
    <% for(utente u: utenti){ %>
        <tr>
            <td><%= u.getEmail() %></td>
            <td><%= u.getNome() %></td>
            <td><%= u.getCognome() %></td>
            <td><%= u.getTelefono() %></td>
        </tr>
    <% } %>
</table>

</body>
<%}%>
</html>
<%@include file="footer.jsp" %>
