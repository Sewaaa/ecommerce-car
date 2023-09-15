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

import model.object.*;
import model.dao.*;

@WebServlet("/homeSERVLET")
public class homeSERVLET extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public homeSERVLET() {
        super();
  
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		prodottoDAO prodDAO = new prodottoDAO();
		brandDAO brandDAO = new brandDAO();
		ArrayList<prodotto>  lista_prodotti ;
		ArrayList<brand>  lista_brand ;
		RequestDispatcher dispatcher;
		String tipo=request.getParameter("type");
		
		/*Salvataggio tutti i brand*/
		lista_brand = (ArrayList<brand>) brandDAO.getAllBrand();
		session.setAttribute("brand", lista_brand);
		
		/*Salvataggio prodotti*/
		if(tipo==null || tipo.isEmpty())
		{
			lista_prodotti = (ArrayList<prodotto>) prodDAO.getAllProdotti(); 
	        session.setAttribute("prodotti", lista_prodotti); 
	        dispatcher = request.getRequestDispatcher("/index.jsp");
	        dispatcher.forward(request,response);	
		}
		/*Salvataggio prodotti filtrati per tipo*/
		else
		{
			lista_prodotti = (ArrayList<prodotto>) prodDAO.getFiltredProdotti(tipo);
	        session.setAttribute("prodotti", lista_prodotti);
	        dispatcher = request.getRequestDispatcher("/filterProducts.jsp");
	        dispatcher.forward(request,response);	
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
