

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/Rimuovi_da_db")
public class Rimuovi_da_db extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public Rimuovi_da_db() {
        super();

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog"; 
		String user = "root";
		String password = "root";

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection(dbUrl, user, password);
			Statement statement=connection.createStatement();
			String id = request.getParameter("id_prodotto");
			
			String query = "delete from prodotti as p where id='" + id + "';";
			statement.executeUpdate(query);
			
            connection.close();
            request.getServletContext().getRequestDispatcher("/GestioneDB.jsp").forward(request, response);
        } catch (Exception e) {
        	request.setAttribute("error", e);
            e.printStackTrace();
           }
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
