<!-- Pagina di accesso negato -->
<!DOCTYPE html>
<html lang="it">
<head>
    <title>Accesso Negato</title>
    <link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
    <style>
        html, body {
            height: 100%;

            justify-content: center;
            align-items: center;
        }

        .container {
            text-align: center;
        }

        .logo {
            width: 100px;
            height: 100px;
            margin-bottom: 20px;
        }
    </style>
</head>
<%@include file="header.jsp" %>	
<body>
    <div class="container">
        <img width="96" height="96" src="https://img.icons8.com/windows/96/id-not-verified.png" alt="id-not-verified"/>
        <h1>Accesso Negato</h1>
        <p>Spiacenti, non hai i permessi per accedere a questa pagina.</p>
    </div>
</body>
<%@include file="footer.jsp" %>	
</html>
