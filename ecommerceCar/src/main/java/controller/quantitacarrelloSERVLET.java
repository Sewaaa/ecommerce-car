package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.carrelloDAO;
import model.dao.personalizzazioneDAO;
import model.dao.prodottoDAO;
import model.object.prodotto;


@WebServlet("/quantitacarrelloSERVLET")
public class quantitacarrelloSERVLET extends HttpServlet {
	private static final String idProdotto = "id_prodotto";
	private static final String stringemail = "email";
	private static final long serialVersionUID = 1L;
       

    public quantitacarrelloSERVLET() {
        super();
    }

	
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int quantita = Integer.parseInt(request.getParameter("quantita"));
		int hiddenquantita = Integer.parseInt(request.getParameter("hiddenquantita"));
		
		  while(hiddenquantita < quantita) {
			HttpSession sessione = request.getSession();
			String email= (String)sessione.getAttribute(stringemail);
			
			/*AGGIUNGI AL CARRELLO GESTIONE DALLA SESSIONE*/
			if(email == null || email.isEmpty()) {
				ArrayList<prodotto> s;
				s = (ArrayList<prodotto>) sessione.getAttribute(idProdotto);
				int n = Integer.parseInt(request.getParameter("posizione"));
				s.get(n).addQuantita();
			}else	/*AGGIUNGI AL CARRELLO GESTIONE COL DATABASE*/
			{
			
				prodottoDAO prodottoDAO = new prodottoDAO();
				carrelloDAO carrelloDAO = new carrelloDAO();
				String id_prodotto=(String)  request.getParameter(idProdotto);
				String tipo=prodottoDAO.getTipoProdottoById(id_prodotto);
				
				if(tipo.equals("accessorio"))
				{
					carrelloDAO.InsertIntoCart(email, id_prodotto);
				}
				else
				{
					personalizzazioneDAO persDAO=new personalizzazioneDAO();
					List<String> id_personalizzazioni = (List<String>)persDAO.NameToId(request.getParameter("colore"),request.getParameter("ruote"),request.getParameter("interni"));
					
					carrelloDAO.InsertIntoCart(email, id_prodotto, id_personalizzazioni.get(0), id_personalizzazioni.get(1) , id_personalizzazioni.get(2) );
				}	
		}
			hiddenquantita++;
		}
		  
		while(hiddenquantita > quantita) {
			HttpSession sessione = request.getSession();
			String email= (String)sessione.getAttribute(stringemail);
			
			/*AGGIUNGI AL CARRELLO GESTIONE DALLA SESSIONE*/
			if(email == null || email.isEmpty()) {
				ArrayList<prodotto> s ;
				s = (ArrayList<prodotto>) sessione.getAttribute(idProdotto);
				int n = Integer.parseInt(request.getParameter("posizione"));
					if(s.get(n).getQuantita() == 1) {
						s.remove(n);
					}else {
						s.get(n).sottQuantita();
					}
			}else {
				carrelloDAO carrelloDAO = new carrelloDAO();
				personalizzazioneDAO pdao = new personalizzazioneDAO();
				List<String> id_personalizzazioni = pdao.NameToId(request.getParameter("colore"), request.getParameter("ruote"), request.getParameter("interni"));
				String colore = id_personalizzazioni.get(0);
				String ruote = id_personalizzazioni.get(1);
				String interni = id_personalizzazioni.get(2);
				String id_carrello = carrelloDAO.SearchFromCart((String)request.getParameter(idProdotto), interni, ruote, colore, (String)sessione.getAttribute(stringemail));			    
				
				carrelloDAO.DeleteFromCart(id_carrello);
			}
			hiddenquantita--;
		}
		  
		request.getServletContext().getRequestDispatcher("/carrelloSERVLET").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
