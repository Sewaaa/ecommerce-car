package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.carrelloDAO;
import model.object.prodotto;



@WebServlet("/RimuoviDalCarrello")
public class RimuoviDalCarrello extends HttpServlet {

	private static final long serialVersionUID = 1L;
       

    public RimuoviDalCarrello() {
        super();
    }


	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sessione = request.getSession();
		ArrayList<prodotto> s = new ArrayList<>();
		String email= (String)sessione.getAttribute("email");
		if(email == null || email.isEmpty()) 
		{
			s = (ArrayList<prodotto>) sessione.getAttribute("id_prodotto");
			int n = Integer.parseInt(request.getParameter("posizione"));
			if(s.get(n).getQuantita() == 1) {
				s.remove(n);
			}else {
				s.get(n).sottQuantita();
			}
			sessione.setAttribute("id_prodotto", s);
			request.getServletContext().getRequestDispatcher("/carrelloSERVLET").forward(request, response);
			
		}
		else
		{
			
			carrelloDAO carrelloDAO = new carrelloDAO();
			String id_carrello=(String)  request.getParameter("posizione");
		    
			carrelloDAO.DeleteFromCart(id_carrello);
			
            request.getServletContext().getRequestDispatcher("/carrelloSERVLET").forward(request, response);	
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
