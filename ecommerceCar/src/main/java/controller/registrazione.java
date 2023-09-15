package controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.utenteDAO;


@WebServlet("/registrazione")
public class registrazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public registrazione() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
			String nome = request.getParameter("nome");
			String cognome = request.getParameter("cognome");
			String email = request.getParameter("email");
			String telefono = request.getParameter("telefono");
			String pwd = request.getParameter("password");
			String via = request.getParameter("via");
			String nciv = request.getParameter("nciv");
			String citta = request.getParameter("citta");
			String cap = request.getParameter("cap");
			String provincia = request.getParameter("provincia");
			String result = "";
			
			utenteDAO utenteDAO=new utenteDAO();
			
			HttpSession sessione = request.getSession();
			if(utenteDAO.checkUser(email)){
				result= "Questo utente è già esistente, accedi ora!";
				sessione.setAttribute("login", result);
		        request.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
			} else {
				
			utenteDAO.InsertNewUtente(email, pwd, nome, cognome, telefono, provincia, citta, cap, via, nciv);
		    
		    result= "Accedi ora!";
			sessione.setAttribute("login", result);
	        request.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
			}
       
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
