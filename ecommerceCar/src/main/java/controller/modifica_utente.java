package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.utenteDAO;

@WebServlet("/modifica_utente")
public class modifica_utente extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public modifica_utente() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email= request.getParameter("email");
 		String password= request.getParameter("password");
 		String nome= request.getParameter("nome");
 		String cognome= request.getParameter("cognome");
 		String telefono= request.getParameter("telefono");
 		String provincia=request.getParameter("provincia");
 		String citta=request.getParameter("citta");
 		String cap=request.getParameter("cap");
 		String via=request.getParameter("via");
 		String nciv=request.getParameter("nciv");
 		String id=request.getParameter("id");
 		HttpSession sessione = request.getSession();
 		
 		utenteDAO utenteDAO=new utenteDAO();
		if(utenteDAO.checkUser(email) && !email.equals(id)){
			String result= "Questa email è già esistente";
			sessione.setAttribute("erroremail", result);
		}else {
		
		utenteDAO.modificaUtente(id,email, password, nome, cognome, telefono, provincia, citta, cap, via, nciv);
		sessione.setAttribute("email", email);
		sessione.setAttribute("nome", nome);
		sessione.setAttribute("cognome", cognome);
		sessione.setAttribute("erroremail", "Modifica Effettuata");
		}
		request.getServletContext().getRequestDispatcher("/gestioneutentiSERVLET").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}