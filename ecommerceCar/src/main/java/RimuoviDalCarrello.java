

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
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
		HttpSession sessione = request.getSession();
		String email= (String)sessione.getAttribute("email");
		if(email == null || email.isEmpty()) 
		{
			s = (ArrayList<String>) sessione.getAttribute("id_prodotto");
			int n = Integer.parseInt(request.getParameter("posizione"));
			s.remove(n);
			sessione.setAttribute("id_prodotto", s);
			request.getServletContext().getRequestDispatcher("/carrello.jsp").forward(request, response);
			
		}
		else
		{
			String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog"; 
			String user = "root";
			String password = "root";
	
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection connection = DriverManager.getConnection(dbUrl, user, password);
				Statement statement=connection.createStatement();
				String id = request.getParameter("id_carrello");
				String query = "delete from carrello where id='" + id + "';";
				statement.executeUpdate(query);
				
	            connection.close();
	            request.getServletContext().getRequestDispatcher("/carrello.jsp").forward(request, response);
	        } catch (Exception e) {
	        	request.setAttribute("error", e);
	            e.printStackTrace();
	           }
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
