import java.sql.*;  
import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

 

@WebServlet("/indexServlet")
public class indexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public indexServlet() {
        super();
     
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog?serverTimezone=Europe/Rome"; 
			String user = "root";
			String password = "root";

			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection connection = DriverManager.getConnection(dbUrl, user, password);
				ResultSet resultSet;
				Statement statement=connection.createStatement();
				String query="select b.nome as nome_brand, p.nome as nome_prodotto, m.percorso, p.descrizione, p.prezzo from prodotti as p ,brand as b, media as m where p.id_brand=b.id and m.id_prodotto=p.id and p.id="+request.getParameter("id_prodotto")+";"; 
				resultSet = statement.executeQuery(query);

	            if (resultSet.next()) {
	                request.setAttribute("nomeBrand", resultSet.getString("nome_brand"));
	                request.setAttribute("nomeProdotto", resultSet.getString("nome_prodotto"));
	                request.setAttribute("percorso", resultSet.getString("percorso"));
	                request.setAttribute("prezzo", resultSet.getString("prezzo"));
	                request.setAttribute("descrizione", resultSet.getString("descrizione"));
	            }

	            connection.close();
	        } catch (Exception e) {
	        	request.setAttribute("error", e);
	            e.printStackTrace();
	        }

			
	        request.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
