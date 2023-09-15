package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.utenteDAO;
import model.object.utente;

/**
 * Servlet implementation class gestioneutentiSERVLET
 */
@WebServlet("/gestioneutentiSERVLET")
public class gestioneutentiSERVLET extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
    public gestioneutentiSERVLET() {
        super();
    }

    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("email");
		utenteDAO udao=new utenteDAO();
		utente u=udao.getUtenteLoggato(id);
		
		session.setAttribute("utente", u); 
		
		request.getServletContext().getRequestDispatcher("/gestioneutente.jsp").forward(request, response);
		   
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}