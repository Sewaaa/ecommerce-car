import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/modifica_prodotto")
public class modifica_prodotto extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public modifica_prodotto() {
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
			Statement statement2=connection.createStatement();
			String query="";
			String query2="";
			
			String tipo_p= request.getParameter("tipo");
			//System.out.println(tipo_p);
	 		String nome_p= request.getParameter("nome");
	 		String data_rilascio_p= request.getParameter("data_rilascio");
	 		String prezzo_p= request.getParameter("prezzo");
	 		String id_prodotto= request.getParameter("id_prodotto");
	 		String id_brand=request.getParameter("brand");
	 		String descrizione_p=request.getParameter("descrizione");
	 		String foto_p=request.getParameter("percorso");
	 		//System.out.println(descrizione_p);
				
	 		 query = "UPDATE prodotti AS p SET p.nome = '" + nome_p + "', p.tipo = '" + tipo_p + "', "
	 		 		+ "p.data_rilascio = '" + data_rilascio_p+ "', p.prezzo = '" + prezzo_p + "', p.id_brand='"+id_brand+"',"
	 		 		+ "p.descrizione='"+descrizione_p+"'" +
	                "WHERE p.id = '"+id_prodotto+"';";
	 		 query2="UPDATE MEDIA as m "
	 		 		+ "SET m.percorso = '"+foto_p+"'"+
	 		 		"WHERE m.id_prodotto = '"+id_prodotto+"';";
	 		//System.out.println(query);
	 		statement.executeUpdate(query);
	 		statement2.executeUpdate(query2);
	 		//int rowsAffected = statement.executeUpdate();
	 		//stmt.close();
	 		//System.out.println(query);
	 		connection.close();
        } catch (Exception e) {
        	request.setAttribute("error", e);
            e.printStackTrace();
        }

		
       request.getServletContext().getRequestDispatcher("/GestioneDB.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
