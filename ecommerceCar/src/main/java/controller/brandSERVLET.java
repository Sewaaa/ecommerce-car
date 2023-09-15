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

import model.dao.brandDAO;
import model.dao.prodottoDAO;
import model.object.prodotto;

/**
 * Servlet implementation class brandSERVLET
 */
@WebServlet("/brandSERVLET")
public class brandSERVLET extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public brandSERVLET() {
        super();
       
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		prodottoDAO prodottoDAO=new prodottoDAO();
		brandDAO brandDAO=new brandDAO();
		
		ArrayList<prodotto> prodotti = (ArrayList<prodotto>) prodottoDAO.getBrandProdotti( request.getParameter("brand"));
		String nome_brand=brandDAO.getBrandFromId(request.getParameter("brand"));
		session.setAttribute("brandProdotti", prodotti );
		session.setAttribute("Nomebrand", nome_brand );

		 RequestDispatcher dispatcher = request.getRequestDispatcher("/brand.jsp");
	     dispatcher.forward(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
