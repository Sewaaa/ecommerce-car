package controller;

import java.io.IOException;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.carrelloDAO;
import model.dao.personalizzazioneDAO;
import model.dao.utenteDAO;
import model.object.*;


@WebServlet("/login")
public class login extends HttpServlet {
	private static final String idProdotto = "id_prodotto";
	private static final long serialVersionUID = 1L;
       

    public login() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		carrelloDAO carrelloDAO=new carrelloDAO();

			String result="";
			utenteDAO utenteDAO=new utenteDAO();
			utente u= utenteDAO.login(request.getParameter("email"), request.getParameter("psw"));
			
			HttpSession sessione = request.getSession();
			
			if(u==null){
				result= "Utente non registrato!";
				sessione.setAttribute("login", result);
		        request.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
			} else {
				sessione.setAttribute("nome", u.getNome() );
				sessione.setAttribute("cognome", u.getCognome());
				sessione.setAttribute("email", u.getEmail());
				
				int flag = 0;
				ArrayList<prodotto> s = new ArrayList<>();
				Enumeration<String> attrNames = sessione.getAttributeNames();
				while (attrNames.hasMoreElements()){
					if (( attrNames.nextElement()).equals(idProdotto)) {
				    	flag = 1;
					}
				}
				if(flag == 0){
					sessione.setAttribute(idProdotto, s);
				}else{
					@SuppressWarnings("unchecked")
					ArrayList<prodotto> temp = (ArrayList<prodotto>) sessione.getAttribute(idProdotto);
					s = temp;
				}
				
				// Controlla se l'arraylist "s" è vuoto o meno
				if (!s.isEmpty()) {
					
					for (prodotto p : s) {
						if(p.getTipo().equals("accessorio")) 
						{
							for(int i=0; i<p.getQuantita(); i++) {
								carrelloDAO.InsertIntoCart(u.getEmail(), p.getId());
							}
				        	
						}
						else
						{	
							
							personalizzazioneDAO pDAO = new personalizzazioneDAO();
							
							List<String> id_personalizzazioni = pDAO.NameToId(p.getColore(), p.getRuote(), p.getInterni());
							   
							for(int i=0; i<p.getQuantita(); i++) {
								carrelloDAO.InsertIntoCart(u.getEmail(), p.getId(), id_personalizzazioni.get(0), id_personalizzazioni.get(1), id_personalizzazioni.get(2));	
							}
						}
					}
				}
				else {
					
				}
				
				
				request.getServletContext().getRequestDispatcher("/homeSERVLET").forward(request, response);

			}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
