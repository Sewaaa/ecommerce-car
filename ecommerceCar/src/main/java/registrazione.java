

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
import javax.servlet.http.HttpSession;


@WebServlet("/registrazione")
public class registrazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public registrazione() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog"; 
		String user = "root";
		String password = "root";

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection(dbUrl, user, password);
			ResultSet resultSet;
			Statement statement=connection.createStatement();
			String nome = request.getParameter("nome");
			String cognome = request.getParameter("cognome");
			String email = request.getParameter("email");
			String telefono = request.getParameter("telefono");
			String pwd = request.getParameter("password");
			String via = request.getParameter("via");
			String nciv = request.getParameter("nciv");
			String citta = request.getParameter("citta");
			String cap = request.getParameter("cap");
			String provincia = request.getParameter("provincia");

			String query = "SELECT nome, cognome FROM UTENTI WHERE email = '" + email + "' AND psw = '" + pwd + "';";
			resultSet = statement.executeQuery(query);
			String result = "";
			int i=0;
			while (resultSet.next()) {
                i++;
            }
			HttpSession sessione = request.getSession();
			if(i!=0){
				result= "Questo utente è già esistente, accedi ora!";
				sessione.setAttribute("login", result);
		        request.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
			} else {
				
			query = "INSERT INTO UTENTI (email, psw, nome, cognome, telefono, provincia, citta, cap, via, n_civ) VALUES ('" + email + "', '" + pwd + "', '" + nome + "', '" + cognome + "', '" + telefono + "', '" + provincia + "','" + citta + "','" + cap + "', '" + via + "', '" + nciv + "');";
			statement.executeUpdate(query);
			System.out.print(query);
		    connection.close();
		    
		    result= "Accedi ora!";
			sessione.setAttribute("login", result);
	        request.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
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
