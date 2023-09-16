<!-- PAGINA DI CHECKOUT DI ORDINE -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.object.*, java.text.DecimalFormat, java.text.DecimalFormat, java.text.DecimalFormatSymbols" %>

<!DOCTYPE html>
<%@include file="header.jsp" %>
<!-- CONTROLLO PER ACCESSO NEGATO PER UTENTE NON LOGGATO -->
<%
if ( session == null || email==null ){

	response.sendRedirect("accesso_negato.jsp");
}
else
{
%>
<html lang="it">
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
      <!-- STAMPA DEI PRODOTTI DEL CARRELLO IN FASE D'ACQUISTO -->
        <h2>Riepilogo Ordine</h2>
        <div class="scrollable-list">
  		<ul>
<%
	double prezzo_tot=0.00;
	double prezzo_noiva=0.00;
	@SuppressWarnings("unchecked")
	ArrayList<prodotto>  carrello = (ArrayList<prodotto>)session.getAttribute("carrello");
	for(prodotto p: carrello){ %>
		<li>
		<div class='line'></div>
        <table class='order-table'>
          <caption></caption>
          <tbody>
          <tr>
            <th></th>
            <th></th>
            <th></th>
          </tr>
            <tr>
              <td><img alt="immagine prodotto" src="<%=p.getPercorso()%>" class='full-width'></img>
              </td>
              <td>
                <br> 
                <span class= 'thin'>
                <b>
                <%=p.getBrand()%>
			    <%=p.getNome()%>
			   	</b> 
			  	 </span>
			  <% if(p.getTipo().equals("macchina")) {%>
				 		<br><span class='thin small'> 
				 		Colore: <%=p.getColore()%><br>
				 		Ruote: <%=p.getRuote()%><br>
				 		Interni: <%=p.getInterni()%></span>
			  <% }%>
              </td>

            </tr>
            <tr>
              <td>
              <br>
                <div class='price'>€<%=p.getPrezzo()%></div>
              </td>
            </tr>
          </tbody>

        </table>
		</li>
		
		<% 	
				String valoreFormattato = p.getPrezzo().replaceAll("\\.", "").replace(",", ".");
				double valoreDouble = Double.parseDouble(valoreFormattato);
 				prezzo_tot=prezzo_tot+ ( valoreDouble +( valoreDouble*4 )/100); 
 				prezzo_noiva=prezzo_noiva+valoreDouble; 
			}

		DecimalFormat formato = new DecimalFormat("#,##0.00");
		String valoreRiFormattato = formato.format(prezzo_tot);
		
		String formatted_prezzonoiva = new DecimalFormat("#,###.00").format(prezzo_noiva);
		
		%>
 	
       </ul>
       </div>
        <div class='line'></div>
        <!-- STAMPA DEL TOTALE -->
        <div class='total'>
          <span style='float:left;'>
            TOTALE
          </span>
          <span class='thin dense' style='float:right; text-align:right;'>
          	<%=formatted_prezzonoiva%> +IVA
          	<br>
            €<%=valoreRiFormattato %>
          </span>
        </div>
</div>
</div>
		<!-- SCELTTA METODO PAGAMENTO -->
         <div class='credit-info'>
          <div class='credit-info-content'>
            <form action=effettua_ordine method=post>
            <table class='half-input-table'>
              <caption></caption>
	            <tr>
	            <th></th>
	            <th></th>
	            </tr>
              <tr><td>Metodo di pagamento: </td><td><div class='dropdown' id='card-dropdown'><div class='dropdown-btn' id='current-card'>Visa</div>
                <div class='dropdown-select'>
                <ul>
                  <li>Master Card</li>
                  <li>American Express</li>
                  </ul></div>
                </div>
               </td></tr>
            </table>
            <img alt="logo metodo pagamento" src='https://dl.dropboxusercontent.com/s/ubamyu6mzov5c80/visa_logo%20%281%29.png' height='80' class='credit-card-image' id='credit-card-image'></img>
            Numero di carta
            <input class='input-field' name="numero_carta" placeholder="xxxxxxxxxxxxxxxx" minlength="16" maxlength="16" pattern="[0-9]*" inputmode="numeric" required></input>
            Titolare
            <input class='input-field' placeholder="xxxxxxxx xxxxxxxx" required></input>
            <table class='half-input-table'>
             <caption></caption>
	            <tr>
	            <th></th>
	            <th></th>
	            </tr>
              <tr>
                <td> Scadenza
                 <input class='input-field' type="month" id="scadenza" name="scadenza" required>
				</td>
                <td>CVC
                  <input class='input-field' placeholder="xxx" minlength="3" maxlength="3"  pattern="[0-9]*" inputmode="numeric" required></input>
                </td>
              </tr>
            </table>
            <input type="hidden" name="metodo_di_pagamento" id="selected-payment-method" value="Visa">
            <input type="hidden" name="prezzo_totale" value=<%=valoreRiFormattato %>>   
            <input type="hidden" name="prezzo_noiva" value=<%=formatted_prezzonoiva%>>            
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
	    /*Ottieni la data odierna e formatta in (yyyy-MM)*/
	    var oggi = new Date();
	    var anno = oggi.getFullYear();
	    var mese = ("0" + (oggi.getMonth() + 1)).slice(-2); 
	    var dataOdierna = anno + "-" + mese;
	    document.getElementById("scadenza").min = dataOdierna;
	</script>

</body>
<%@include file="footer.jsp" %>
</html>
<%} %>
