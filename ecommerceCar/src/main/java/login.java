

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


@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public login() {
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
			String email = request.getParameter("email");
			String pwd = request.getParameter("psw");

			String query = "SELECT nome, cognome FROM UTENTI WHERE email = '" + email + "' AND psw = '" + pwd + "';";
			resultSet = statement.executeQuery(query);
			String result="";
			String nome="";
			String cognome = "";
			
			int i=0;
			while (resultSet.next()) {
                i++;
                nome = resultSet.getString("nome");
				cognome = resultSet.getString("cognome");
            }
			
			HttpSession sessione = request.getSession();
			
			if(i==0){
				result= "Utente non registrato!";
				sessione.setAttribute("login", result);
		        request.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
			} else {
				sessione.setAttribute("nome", nome );
				sessione.setAttribute("cognome", cognome);
				sessione.setAttribute("email", email);
				request.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);

			}

			
            connection.close();
        } catch (Exception e) {
        	request.setAttribute("error", e);
            e.printStackTrace();
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
