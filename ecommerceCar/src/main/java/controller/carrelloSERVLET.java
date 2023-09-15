package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.carrelloDAO;
import model.object.prodotto;


@WebServlet("/carrelloSERVLET")
public class carrelloSERVLET extends HttpServlet {
	private static final String idProdotto = "id_prodotto";
	private static final long serialVersionUID = 1L;
  
    public carrelloSERVLET() {
        super();
       
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		
		HttpSession session = request.getSession();
		carrelloDAO carrelloDAO= new carrelloDAO();
		ArrayList<prodotto>  carrello = new ArrayList<>();
		
		RequestDispatcher dispatcher;
		String email = (String)session.getAttribute("email");
		if(email==null)
		{
			/*CASO SE UTENTE NON LOGGATO*/
			/*controllo esistenza carrello */
			int flag = 0;
			ArrayList<prodotto> s = new ArrayList<>();
			Enumeration<String> attrNames = session.getAttributeNames();
			while (attrNames.hasMoreElements()){
				if (((String) attrNames.nextElement()).equals(idProdotto)) {
			    	flag = 1;
				}
			}
			if(flag == 0){
				session.setAttribute(idProdotto, s);
			}else{
				@SuppressWarnings("unchecked")
				ArrayList<prodotto> temp = (ArrayList<prodotto>) session.getAttribute(idProdotto);
				s = temp;
			}
			
			carrello = (ArrayList<prodotto>) carrelloDAO.getGuestCart(s); 
		}
		else
		{
			/*CASO UTENTE LOGGATO*/
			carrello = (ArrayList<prodotto>) carrelloDAO.getMyCart(email); 
		}
		session.setAttribute("carrello", carrello);
		
		dispatcher = request.getRequestDispatcher("/carrello.jsp");
        dispatcher.forward(request,response);
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
