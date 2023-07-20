<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@include file="header.jsp" %>
<%
if ( session == null || email==null ){

	response.sendRedirect("accesso_negato.jsp");
}
else
{
%>
<html>
<head>
    <title>Checkout</title>
    <link rel="icon" href="imgs/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/checkout.css">
</head>
<body>
 <div class='container'>
  <div class='window'>
    <div class='order-info'>
      <div class='order-info-content'>
        <h2>Riepilogo Ordine</h2>
        <div class="scrollable-list">
  		<ul>
<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit, java.io.*, java.text.DecimalFormat" %>
<%
	

	String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog?serverTimezone=Europe/Rome"; 
	String user = "root";
	String password = "root";
	double prezzo_tot=0.00;
	double prezzo_noiva=0.00;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(dbUrl, user, password);
		//out.print("Database connecion successful");
		ResultSet resultSet;
		Statement statement=connection.createStatement();
		String query="";
		
		query="SELECT p.id as id_prodotto,p.tipo,c.id as id_carrello, p.nome as nome_prodotto, p.prezzo, b.nome as nome_brand, colori.nome as colore, ruote.tipo as ruote , interni.tipo as interni, m.percorso"+
				" FROM prodotti p"+
				" INNER JOIN carrello c ON p.id = c.id_prodotto"+
				" INNER JOIN media m ON p.id = m.id_prodotto"+
				" INNER JOIN brand b ON p.id_brand = b.id"+
				" left JOIN  colori ON colori.id = c.id_colore"+
				" left JOIN  ruote ON ruote.id = c.id_ruote"+
				" left JOIN  interni ON interni.id = c.id_interni"+
				" WHERE c.email_utente = '"+email+"'";
		
		//out.println(query);
		resultSet = statement.executeQuery(query);
		while(resultSet.next()){ %>
		<li>
		<div class='line'></div>
        <table class='order-table'>
          <tbody>
            <tr>
              <td><img src="<%=resultSet.getString("percorso")%>" class='full-width'></img>
              </td>
              <td>
                <br> 
                <span class= 'thin'>
                <b>
                <%=resultSet.getString("nome_brand")%>
			    <%=resultSet.getString("nome_prodotto")%>
			   	</b> 
			  	 </span>
			  <% if(resultSet.getString("tipo").equals("macchina")) {%>
				 		<br><span class='thin small'> 
				 		Colore: <%=resultSet.getString("colore")%><br>
				 		Ruote: <%=resultSet.getString("ruote")%><br>
				 		Interni: <%=resultSet.getString("interni")%><br><br></span>
			  <% }%>
              </td>

            </tr>
            <tr>
              <td>
                <div class='price'>€<%=resultSet.getString("prezzo")%></div>
              </td>
            </tr>
          </tbody>

        </table>
		</li>
		
		<% 	
				String valoreFormattato = resultSet.getString("prezzo").replaceAll("\\.", "").replace(",", ".");
				double valoreDouble = Double.parseDouble(valoreFormattato);
 				prezzo_tot=prezzo_tot+ ( valoreDouble +( valoreDouble*4 )/100); 
 				prezzo_noiva=prezzo_noiva+valoreDouble; 
			}
		connection.close();
		}catch (Exception e) {
			out.print(e);
		}
		DecimalFormat formato = new DecimalFormat("#,##0.00");
		String valoreRiFormattato = formato.format(prezzo_tot);
		%>
 	
       </ul>
       </div>
        <div class='line'></div>
        <div class='total'>
          <span style='float:left;'>
          	<br>
            TOTALE
          </span>
          <span style='float:right; text-align:right;'>
          	<div class='thin dense'><%=prezzo_noiva%> +IVA</div>
            €<%=valoreRiFormattato %>
          </span>
        </div>
</div>
</div>
	
         <div class='credit-info'>
          <div class='credit-info-content'>
            <form action=effettua_ordine method=post>
            <table class='half-input-table'>
              <tr><td>Metodo di pagamento: </td><td><div class='dropdown' id='card-dropdown'><div class='dropdown-btn' id='current-card'>Visa</div>
                <div class='dropdown-select'>
                <ul>
                  <li>Master Card</li>
                  <li>American Express</li>
                  </ul></div>
                </div>
               </td></tr>
            </table>
            <img src='https://dl.dropboxusercontent.com/s/ubamyu6mzov5c80/visa_logo%20%281%29.png' height='80' class='credit-card-image' id='credit-card-image'></img>
            Numero di carta
            <input class='input-field' name="numero_carta" placeholder="xxxxxxxxxxxxxxxx" minlength="16" maxlength="16" pattern="[0-9]*" inputmode="numeric" required></input>
            Titolare
            <input class='input-field' placeholder="xxxxxxxx xxxxxxxx" required></input>
            <table class='half-input-table'>
              <tr>
                <td> Scadenza
                 <input class='input-field' type="month" id="scadenza" name="scadenza" required>
				</td>
                <td>CVC
                  <input class='input-field' placeholder="xxxx" minlength="4" maxlength="4"  pattern="[0-9]*" inputmode="numeric" required></input>
                </td>
              </tr>
            </table>
            <input type="hidden" name="metodo_di_pagamento" id="selected-payment-method" value="Visa">
            <input type="hidden" name="prezzo_totale" value=<%=valoreRiFormattato %>>   
            <input type="hidden" name="prezzo_noiva" value=<%=prezzo_noiva%>>            
            <button type="submit" class='pay-btn'>Checkout</button>
            </form>
          </div>
        </div>
    
      </div>
</div>

<!-- SCRIPT PER TENDINA SCELTA PAGAMENTO -->
<script>
 	var cardDrop = document.getElementById('card-dropdown');
 	var activeDropdown;
 	cardDrop.addEventListener('click',function(){
 	  var node;
 	  for (var i = 0; i < this.childNodes.length-1; i++)
 	    node = this.childNodes[i];
 	    if (node.className === 'dropdown-select') {
 	      node.classList.add('visible');
 	       activeDropdown = node; 
 	    };
 	})

 	window.onclick = function(e) {
 	  console.log(e.target.tagName)
 	  console.log('dropdown');
 	  console.log(activeDropdown)
 	  if (e.target.tagName === 'LI' && activeDropdown){
 	    if (e.target.innerHTML === 'Master Card') {
 	      document.getElementById('credit-card-image').src = 'https://dl.dropboxusercontent.com/s/2vbqk5lcpi7hjoc/MasterCard_Logo.svg.png';
 	          activeDropdown.classList.remove('visible');
 	      activeDropdown = null;
 	      e.target.innerHTML = document.getElementById('current-card').innerHTML;
 	      document.getElementById('current-card').innerHTML = 'Master Card';
 	     document.getElementById('selected-payment-method').value = "Mastercard";
 	    }
 	    else if (e.target.innerHTML === 'American Express') {
 	         document.getElementById('credit-card-image').src = 'https://dl.dropboxusercontent.com/s/f5hyn6u05ktql8d/amex-icon-6902.png';
 	          activeDropdown.classList.remove('visible');
 	      activeDropdown = null;
 	      e.target.innerHTML = document.getElementById('current-card').innerHTML;
 	      document.getElementById('current-card').innerHTML = 'American Express';      
 	     document.getElementById('selected-payment-method').value = "American Express";
 	    }
 	    else if (e.target.innerHTML === 'Visa') {
 	         document.getElementById('credit-card-image').src = 'https://dl.dropboxusercontent.com/s/ubamyu6mzov5c80/visa_logo%20%281%29.png';
 	          activeDropdown.classList.remove('visible');
 	      activeDropdown = null;
 	      e.target.innerHTML = document.getElementById('current-card').innerHTML;
 	      document.getElementById('current-card').innerHTML = 'Visa';
 	     document.getElementById('selected-payment-method').value = "Visa";
 	    }
 	  }
 	  else if (e.target.className !== 'dropdown-btn' && activeDropdown) {
 	    activeDropdown.classList.remove('visible');
 	    activeDropdown = null;
 	  }
 	}

 	</script>
	<script>
	    // Ottieni la data odierna
	    var oggi = new Date();
	    
	    // Formatta la data odierna nel formato richiesto per il campo di input (yyyy-MM)
	    var anno = oggi.getFullYear();
	    var mese = ("0" + (oggi.getMonth() + 1)).slice(-2); // Aggiungi lo zero iniziale se necessario
	    var dataOdierna = anno + "-" + mese;
	    
	    // Imposta la data odierna come valore minimo per il campo di input
	    document.getElementById("scadenza").min = dataOdierna;
	</script>

</body>
<%@include file="footer.jsp" %>
</html>
<%} %>
