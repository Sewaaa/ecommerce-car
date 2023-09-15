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
import model.object.*;

@WebServlet("/AggiungiAlCarrello")
public class AggiungiAlCarrello extends HttpServlet {
	
	private ArrayList<prodotto> s = new ArrayList<prodotto>();
	private prodotto nuovo;
	private static final long serialVersionUID = 1L;

	public AggiungiAlCarrello() {
        super();
    }

	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sessione = request.getSession();
		String email= (String)sessione.getAttribute("email");
		/*AGGIUNGI AL CARRELLO GESTIONE DALLA SESSIONE*/
		if(email == null || email.isEmpty()) 
		{
			s = (ArrayList<prodotto>) sessione.getAttribute("id_prodotto");
			@SuppressWarnings("unused")
			boolean flag = false;
			for(int i=0; i<s.size(); i++) {
				if(request.getParameter("tipo").equals("macchina")) {
					if(s.get(i).getId().equals(request.getParameter("id_prodotto")) && s.get(i).getColore().equals(request.getParameter("colore")) && s.get(i).getInterni().equals(request.getParameter("interni")) && s.get(i).getRuote().equals(request.getParameter("ruote")) ) {
						flag = true;
						s.get(i).addQuantita();
						request.getServletContext().getRequestDispatcher("/shop.jsp").forward(request, response);
				}}else {
					if(s.get(i).getId().equals(request.getParameter("id_prodotto"))) {
						flag = true;
						s.get(i).addQuantita();
						request.getServletContext().getRequestDispatcher("/shop.jsp").forward(request, response);
				}}
			}
			
		if(flag == false) {				
			if(request.getParameter("tipo").equals("macchina")) {
				nuovo = new prodotto(request.getParameter("id_prodotto"), request.getParameter("colore"), request.getParameter("ruote"), request.getParameter("interni"), request.getParameter("tipo"));
				nuovo.addQuantita();
			}else {
				nuovo = new prodotto(request.getParameter("id_prodotto"), request.getParameter("tipo"));
				nuovo.addQuantita();
			}
			s.add(nuovo);
			sessione.setAttribute("id_prodotto", s);
			request.getServletContext().getRequestDispatcher("/shopSERVLET").forward(request, response);
		}}
		else	/*AGGIUNGI AL CARRELLO GESTIONE COL DATABASE*/
		{
		
			prodottoDAO prodottoDAO = new prodottoDAO();
			carrelloDAO carrelloDAO = new carrelloDAO();
			String id_prodotto=(String)  request.getParameter("id_prodotto");
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
            request.getServletContext().getRequestDispatcher("/shop.jsp").forward(request, response);	
	}
}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
