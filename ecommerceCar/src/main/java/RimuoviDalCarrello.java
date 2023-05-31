

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/RimuoviDalCarrello")
public class RimuoviDalCarrello extends HttpServlet {
	private ArrayList<String> s = new ArrayList<String>();
	private static final long serialVersionUID = 1L;
       

    public RimuoviDalCarrello() {
        super();
    }


	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession sessione = request.getSession();
		s = (ArrayList<String>) sessione.getAttribute("id_prodotto");
		int n = Integer.parseInt(request.getParameter("posizione"));
		s.remove(n);
		sessione.setAttribute("id_prodotto", s);
		request.getServletContext().getRequestDispatcher("/carrello.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
