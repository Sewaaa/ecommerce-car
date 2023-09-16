package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.utenteDAO;
import model.object.utente;


@WebServlet("/visualizzazione_utentiSERVLET")
public class visualizzazione_utentiSERVLET extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public visualizzazione_utentiSERVLET() {
        super();
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String searchEmail = request.getParameter("searchEmail");
		utenteDAO utenteDAO=new utenteDAO();
		
		ArrayList<utente> utenti=utenteDAO.getAllUtenti(searchEmail);
		session.setAttribute("utenti", utenti );
		session.setAttribute("searchEmail", searchEmail );
		RequestDispatcher dispatcher = request.getRequestDispatcher("visualizzazione_utenti.jsp");
        dispatcher.forward(request,response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doGet(request, response);
	}

}
