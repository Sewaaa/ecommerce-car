package controller;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.dao.prodottoDAO;



@WebServlet("/modifica_prodotto")
public class modifica_prodotto extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public modifica_prodotto() {
        super();
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tipo_p= request.getParameter("tipo");
 		String nome_p= request.getParameter("nome");
 		String data_rilascio_p= request.getParameter("data_rilascio");
 		String prezzo_p= request.getParameter("prezzo");
 		String id_prodotto= request.getParameter("id_prodotto");
 		String id_brand=request.getParameter("brand");
 		String descrizione_p=request.getParameter("descrizione");
 		String foto_p=request.getParameter("percorso");

	 	

		prodottoDAO prodottoDAO=new prodottoDAO();
		
		prodottoDAO.modificaProdotto(tipo_p,nome_p,data_rilascio_p,prezzo_p,id_prodotto,id_brand,descrizione_p,foto_p);
		
       request.getServletContext().getRequestDispatcher("/gestionedbSERVLET").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
