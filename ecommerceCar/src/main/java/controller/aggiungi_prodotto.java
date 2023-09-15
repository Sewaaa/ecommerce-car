package controller;
import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.dao.prodottoDAO;

@WebServlet("/aggiungi_prodotto")
public class aggiungi_prodotto extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public aggiungi_prodotto() {
        super();  
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tipo = request.getParameter("tipo");
		String brand = request.getParameter("brand");
		String nome = request.getParameter("nome");
		String descrizione = request.getParameter("descrizione");
		String data_rilascio = request.getParameter("data_rilascio");
		String prezzo = request.getParameter("prezzo");
		String foto = request.getParameter("foto");
		
		prodottoDAO prodottoDAO=new prodottoDAO();

		try {
			prodottoDAO.InsertNewProdotto (nome,tipo,descrizione,data_rilascio,prezzo,brand,foto);
		} catch (Exception e) {		
			
		}
			  
        request.getServletContext().getRequestDispatcher("/gestionedbSERVLET").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
