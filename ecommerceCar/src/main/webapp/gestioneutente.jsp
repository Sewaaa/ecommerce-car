<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>	
<% 
	HttpSession sessione = request.getSession();
	String result = ""; 
	int flag = 0;
	Enumeration<String> attrNames = session.getAttributeNames();
	while (attrNames.hasMoreElements()){
		if (((String) attrNames.nextElement()).equals("erroremail")) {
			flag = 1;
		}
	}
	if(flag == 0){
		session.setAttribute("erroremail", result);
	}else{
		result = (String)session.getAttribute("erroremail");
	}
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Dati Utente</title>
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
    <h1 style="text-align: center;">Gestione Dati Utente</h1>
    <%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*, java.text.DecimalFormat, model.object.*" %>
    <%
		utente u = (utente) session.getAttribute("utente");
	%>

    <form action="modifica_utente" method="post">
    	<label for="email">Email:</label>
        <input type="email" value="<%= u.getEmail() %>" maxlength="50" name="email" class="input" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" required><br><br>
        
        <label for="password">Password:</label>
        <input type="password" value="<%= u.getPsw() %>" maxlength="25" name="password" class="input" pattern="^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,}$" oninvalid="this.setCustomValidity('La password richiesta deve avere almeno 8 caratteri, un simbolo speciale e un numero.');" oninput="this.setCustomValidity('');" required><br><br>
    
        <label for="nome">Nome:</label>
        <input type="text" value="<%= u.getNome() %>" maxlength="15" name="nome" class="input" required><br><br>
        
        <label for="cognome">Cognome:</label>
        <input type="text" value="<%= u.getCognome() %>" maxlength="15" name="cognome" class="input" ><br><br>
        
        <label for="telefono">Telefono:</label>
        <input type="text" value="<%= u.getTelefono() %>" name="telefono" class="input" maxlength="12" pattern="[0-9]{10,12}" oninvalid="this.setCustomValidity('Numero di telefono non valido. Formato richiesto: 1112223333');" oninput="this.setCustomValidity('');" ><br><br>
        
        <label for="provincia">Provincia:</label>
        <input type="text" value="<%= u.getProvincia() %>" maxlength="30" name="provincia" class="input" ><br><br>
        
        <label for="citta">Città:</label>
        <input type="text" value="<%= u.getCitta() %>" maxlength="30" name="citta" class="input" ><br><br>
        
        <label for="cap">CAP:</label>
        <input type="text" value="<%= u.getCap() %>" pattern="[0-9]{5}" maxlength="5" name="cap" class="input" ><br><br>
        
        <label for="via">Via:</label>
        <input type="text" value="<%= u.getVia() %>" maxlength="50" name="via" class="input" ><br><br>
        
        <label for="nciv">Numero Civico:</label>
        <input type="text" value="<%= u.getNciv() %>" maxlength="3" pattern="[0-9]{1,2,3}" name="nciv" class="input" ><br><br>

		<input type="hidden" name="id" id="id" value="<%=(String)session.getAttribute("email")%>">
        <input type="submit" value="Salva">
        <br><br>
        <span> <% out.println(result); %> </span>
    </form>
</body>
</html>
<%@include file="footer.jsp" %>
