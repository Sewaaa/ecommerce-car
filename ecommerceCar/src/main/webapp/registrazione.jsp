<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/registrazione.css">
 
<title>FGMS - REGISTRAZIONE</title>
<link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
</head>
<body>
	<div id="contenitore">
		<form id="loginForm" action="registrazione" method="post">
			<a href="index.jsp"><img alt="logo" src="imgs/logotsw.png"></a><br><br>
			<input type="text" name="nome" class="textleft" placeholder="Inserire nome*..." required>
			<input type="text" name="cognome" class="textright" placeholder="Inserire Cognome*..." required>
			<input type="text" name="telefono" class="textleft" placeholder="Inserire Telefono*..."  maxlength="12" pattern="[0-9]{10,12}" oninvalid="this.setCustomValidity('Numero di telefono non valido. Formato richiesto: 1112223333');" oninput="this.setCustomValidity('');" required>
			<input type="email" name="email" class="textright" placeholder="Inserire E-mail*..." pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" required>
			<input type="password" name="password" id="passwordField" class="textleft password" placeholder="Inserire Password*..." pattern="^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,}$" oninvalid="this.setCustomValidity('La password richiesta deve avere almeno 8 caratteri, un simbolo speciale e un numero.');" oninput="this.setCustomValidity('');" required>
			<input type="password" name="confirmpassword" id="passwordField" class="textright confirm" placeholder="Conferma Password*..." oninvalid="this.setCustomValidity('Le due password non sono combacianti');" oninput="this.setCustomValidity('');" required>
			<input type="text" name="via" class="text100" maxlength="50" placeholder="Inserire Via..." >
			<input type="text" name="nciv" class="textleft" maxlength="3" placeholder="Inserire N° Civico..." >
			<input type="text" name="citta" class="textright" maxlength="15" placeholder="Inserire Provincia..." >
			<input type="text" name="provincia" class="textleft" maxlength="30" placeholder="Inserire Città..." >
			<input type="text" name="cap" class="textright" maxlength="5" placeholder="Inserire CAP..." >
			<span id="passwordErrorMessage" class="error-message"></span> 
			<!-- Spazio per il messaggio di errore -->
			<input type="submit" value="Registrati" class="button" onclick="alert('Ciao!')">
			<a href="login.jsp">Hai già un account? Accedi ora!</a>
		</form>
		
		<script>
			document.querySelector('.button').onclick = function(){
				var password = document.querySelector('.password').value,
					confirmpassword = document.querySelector('.confirm').value;
	
				if(password != confirmpassword){
					alert("Le due password non sono combacianti");
					document.querySelector('.confirm').focus();
					return false;
				}else if(password == confirmpassword){
					return true;
				}
			}
		</script>
	</div>
</body>
</html>
