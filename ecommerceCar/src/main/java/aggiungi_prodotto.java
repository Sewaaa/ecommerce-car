import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/aggiungi_prodotto")
public class aggiungi_prodotto extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public aggiungi_prodotto() {
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
			String query="";
			
			String tipo = request.getParameter("tipo");
		
				String brand = request.getParameter("brand");
				String nome = request.getParameter("nome");
				String descrizione = request.getParameter("descrizione");
				String data_rilascio = request.getParameter("data_rilascio");
				String prezzo = request.getParameter("prezzo");
				String foto = request.getParameter("foto");
				
				query="insert into prodotti (nome,tipo,descrizione,data_rilascio,prezzo,id_brand) values ('"+nome+"','"+tipo+"','"+descrizione+"','"+data_rilascio+"','"+prezzo+"',"+brand+"); ";
				int rowsAffected= statement.executeUpdate(query,Statement.RETURN_GENERATED_KEYS);  

	            if (rowsAffected > 0) {
					ResultSet generatedKeys = statement.getGeneratedKeys();
		            if (generatedKeys.next()) {
		                int idProdotto = generatedKeys.getInt(1);
		                query="insert into media (percorso,id_prodotto) values ('"+foto+"', "+idProdotto+")";
						statement.executeUpdate(query);
		            }
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
