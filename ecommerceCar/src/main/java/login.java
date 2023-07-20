

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ecommerceCar.prodotto;


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
				
				int flag = 0;
				ArrayList<prodotto> s = new ArrayList<prodotto>();
				Enumeration<String> attrNames = sessione.getAttributeNames();
				while (attrNames.hasMoreElements()){
					if (((String) attrNames.nextElement()).equals("id_prodotto")) {
				    	flag = 1;
					}
				}
				if(flag == 0){
					sessione.setAttribute("id_prodotto", s);
				}else{
					@SuppressWarnings("unchecked")
					ArrayList<prodotto> temp = (ArrayList<prodotto>) sessione.getAttribute("id_prodotto");
					s = temp;
				}
				
				// Controlla se l'arraylist "s" è vuoto o meno
				if (!s.isEmpty()) {
					System.out.println("L'arraylist 's' non è vuoto. Contiene " + s.size() + " elementi.");
					for (prodotto p : s) {
				        System.out.println("ID: " + p.getId());
				        System.out.println("Categoria: " + p.getCategoria());
				        System.out.println("Colore: " + p.getColore());
				        System.out.println("Interni: " + p.getInterni());
				        System.out.println("Ruote: " + p.getRuote());
				        System.out.println("---------------------------");
				        
				        if(p.getCategoria().equals("accessorio")) 
						{
							query = "insert into carrello (email_utente, id_prodotto,id_colore,id_ruote,id_interni) values ('"+email+"',"+p.getId()+", null,null,null);";
							statement.executeUpdate(query);
							System.out.println(query);
							
						}
						else
						{
							
							String id_colore = p.getColore();
							String id_ruote =  p.getRuote();
							String id_interni = p.getInterni();
							
							query = "insert into carrello (email_utente, id_prodotto,id_colore,id_ruote,id_interni) values ('"+email+"',"+p.getId()+","+id_colore+","+id_ruote+","+id_interni+")";
							statement.executeUpdate(query);
							System.out.println(query);
						}
					
					}
				}
				else {
					System.out.println("L'arraylist 's' è vuoto.");
				}
				
				
				request.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);

			}

			
            connection.close();
        } catch (Exception e) {
        	request.setAttribute("error", e);
            e.printStackTrace();
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
