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

import model.dao.ordiniDAO;
import model.object.ordine;


@WebServlet("/ordini_adminSERVLET")
public class ordini_adminSERVLET extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ordini_adminSERVLET() {
        super();
       
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String emailAttuale = (String)session.getAttribute("email");
		String paginaJsp="/ordini_admin.jsp";
		String emailFiltrata = request.getParameter("email");
        String orderOption = request.getParameter("order");
        
        if(!emailAttuale.equals("admin@fgms.it"))//Se non è l'admin, mostra ordini solo dell'utente loggato
        {
        	emailFiltrata=emailAttuale;
        	paginaJsp="/ordini_utenti.jsp";
        }
        ordiniDAO ordiniDAO=new ordiniDAO();
        ArrayList<ordine> o=new ArrayList<ordine>();
       
        
        if( orderOption!=null  && (orderOption.equals("recenti") || orderOption.equals("vecchi")))
        {
        	o=ordiniDAO.getAllOrdini(emailFiltrata,orderOption); //caso per prenderli in ordine dal piu recente o dal piu vecchio
        	session.setAttribute("ordini", o );
        	session.setAttribute("oSize", o.size() );
        	session.setAttribute("orderOption", orderOption );
        	RequestDispatcher dispatcher = request.getRequestDispatcher("/filtroOrdini.jsp");
            dispatcher.forward(request,response);
        }
        else {
        	o=ordiniDAO.getAllOrdini(emailFiltrata);
        	session.setAttribute("ordini", o );
        	session.setAttribute("oSize", o.size() );
        	session.setAttribute("orderOption", orderOption );
        	RequestDispatcher dispatcher = request.getRequestDispatcher(paginaJsp);
            dispatcher.forward(request,response);
        }
   }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
