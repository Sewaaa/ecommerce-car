

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ecommerceCar.prodotto;
/**
 * Servlet implementation class carrello
 */
@WebServlet("/AggiungiAlCarrello")
public class AggiungiAlCarrello extends HttpServlet {
	
	private ArrayList<prodotto> s = new ArrayList<prodotto>();
	private prodotto nuovo;
	private static final long serialVersionUID = 1L;

	public AggiungiAlCarrello() {
        super();
    }

	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog"; 
		String user = "root";
		String password = "root";
		try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(dbUrl, user, password);
		Statement statement=connection.createStatement();
		ResultSet resultSet;
		HttpSession sessione = request.getSession();
		String email= (String)sessione.getAttribute("email");
		/*AGGIUNGI AL CARRELLO GESTIONE DALLA SESSIONE*/
		if(email == null || email.isEmpty()) 
		{
			s = (ArrayList<prodotto>) sessione.getAttribute("id_prodotto");
			if(request.getParameter("tipo").equals("macchina")) {
				
				
				nuovo = new prodotto(request.getParameter("id_prodotto"), request.getParameter("colore"), request.getParameter("interni"), request.getParameter("ruote"), request.getParameter("tipo"));
			}else {
				nuovo = new prodotto(request.getParameter("id_prodotto"), request.getParameter("tipo"));
			}
			s.add(nuovo);
			sessione.setAttribute("id_prodotto", s);
			request.getServletContext().getRequestDispatcher("/shopServlet").forward(request, response);
		}
		else	/*AGGIUNGI AL CARRELLO GESTIONE COL DATABASE*/
		{
			String id_prodotto = request.getParameter("id_prodotto");
			
			String query = "SELECT tipo FROM prodotti WHERE id="+id_prodotto+";";
			resultSet = statement.executeQuery(query);
			resultSet.next();
			if(resultSet.getString("tipo").equals("accessorio")) 
			{
				query = "insert into carrello (email_utente, id_prodotto,id_colore,id_ruote,id_interni) values ('"+email+"',"+id_prodotto+", null,null,null);";
				statement.executeUpdate(query);
			}
			else
			{
				String id_colore = request.getParameter("colore");
				String id_ruote = request.getParameter("ruote");
				String id_interni = request.getParameter("interni");
				
				query = "insert into carrello (email_utente, id_prodotto,id_colore,id_ruote,id_interni) values ('"+email+"',"+id_prodotto+","+id_colore+","+id_ruote+","+id_interni+")";
				statement.executeUpdate(query);
			}
			
			
			
            connection.close();
            request.getServletContext().getRequestDispatcher("/shopServlet").forward(request, response);
		
		
	}
		} catch (Exception e) {
        	request.setAttribute("error", e);
            e.printStackTrace();
           }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
