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

import model.dao.prodottoDAO;
import model.object.prodotto;


@WebServlet("/gestionedbSERVLET")
public class gestionedbSERVLET extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public gestionedbSERVLET() {
        super();        
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
        prodottoDAO prodottoDAO=new prodottoDAO();
        
        ArrayList<prodotto> prodotti= (ArrayList<prodotto>) prodottoDAO.getAllProdotti();

        session.setAttribute("prodotti", prodotti);
        		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/GestioneDB.jsp");
        dispatcher.forward(request,response);	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
