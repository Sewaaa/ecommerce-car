<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style> 
	@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@500&display=swap');
	
	body{
		background-color: #f4f4f4;
	}
	
	#contenitore{
		font-family: 'Poppins', sans-serif;
		background-color: #ffffff;
		width: 40%;
		text-align:center;
		padding: 33px 40px 33px 40px;
		margin: 0 auto;
		margin-top: 80px;
		box-shadow: 0px 0px 5px 1px #d8d8d8;
	}
	
	img{
		width:250px;
	}
	
	.textright{
		width: 47.5%;
		float: right;
		font-size: 18px;
		height: 40px;
		margin-top: 7px;
		margin-bottom: 7px;
	}
	
	.textleft{
		width: 47.5%;
		float: left;
		font-size: 18px;
		height: 40px;
		margin-top: 7px;
		margin-bottom: 7px;
	}
	
	.button{
		margin-top: 7px;
		margin-bottom: 7px;
		width: 100%;
		font-size: 18px;
		height: 45px;
		background-color: #A739FB;
		color: white;
		border: solid 1px #A739FB;
	}
</style>
<title>FGMS - REGISTRAZIONE</title>
</head>
<body>
	<div id="contenitore">
		<form action="registrazione" method="post">
			<img src="imgs/logotsw.png">
			<br>
			<input type="text" name="nome" class="textleft" placeholder="Inserire nome*..." required>
			<input type="text" name="cognome" class="textright" placeholder="Inserire Cognome*..." required>
			<input type="text" name="telefono" class="textleft" placeholder="Inserire Telefono*..." required>
			<input type="text" name="via" class="textright" placeholder="Inserire Via..." >
			<input type="text" name="nciv" class="textleft" placeholder="Inserire N° Civico..." >
			<input type="text" name="citta" class="textright" placeholder="Inserire Provincia..." >
			<input type="text" name="provincia" class="textleft" placeholder="Inserire Città..." >
			<input type="text" name="cap" class="textright" placeholder="Inserire CAP..." >
			<input type="text" name="email" class="textleft" placeholder="Inserire E-mail*..." required>
			<input type="password" name="password" class="textright" placeholder="Inserire Password*..." required>
			<input type="submit" value="Registrati" class="button">
			<a href="login.jsp">Hai già un account? Accedi ora !</a>
		</form>
	</div>
</body>
</html>