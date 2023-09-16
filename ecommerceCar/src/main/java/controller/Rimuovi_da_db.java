package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.dao.prodottoDAO;


@WebServlet("/Rimuovi_da_db")
public class Rimuovi_da_db extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public Rimuovi_da_db() {
        super();

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			String id = request.getParameter("id_prodotto");
			prodottoDAO prodottoDAO=new prodottoDAO();
			prodottoDAO.removeProdotto(id);
			
            request.getServletContext().getRequestDispatcher("/gestionedbSERVLET").forward(request, response);
   
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
