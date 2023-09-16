package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.prodottoDAO;
import model.object.prodotto;

@WebServlet("/ModificaSERVLET")
public class ModificaSERVLET extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ModificaSERVLET() {
        super();
      
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = request.getParameter("id_prodotto");
		prodottoDAO pdao=new prodottoDAO();
		prodotto p=pdao.getSelectedProdotto(id);
		
		session.setAttribute("prodotto", p); 
		
		request.getServletContext().getRequestDispatcher("/Modifica.jsp").forward(request, response);
		   
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
