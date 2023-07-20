

import java.io.IOException;
import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;

@WebServlet("/effettua_ordine")
public class effettua_ordine extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

    public effettua_ordine() {
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
		Statement st=connection.createStatement();
		PreparedStatement smt=null;
		ResultSet resultSet;
		HttpSession sessione = request.getSession();
		String email= (String)sessione.getAttribute("email");
		String metodo_di_pagamento = request.getParameter("metodo_di_pagamento");
		String numero_carta = request.getParameter("numero_carta");
		String prezzo_totale= request.getParameter("prezzo_totale");
		String prezzo_noiva= request.getParameter("prezzo_noiva");
		SimpleDateFormat sdfDate = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
        Date currentDate = new Date();
        String formattedDate = sdfDate.format(currentDate);
        String formattedTime = sdfTime.format(currentDate);
        int generatedId=0;
        
        String query = "insert into ordini(email_utente,prezzo_tot,prezzo_noiva,data_ordine) values ('"+email+"','"+prezzo_totale+"','"+prezzo_noiva+"','"+formattedDate+" "+formattedTime+"');";
        System.out.println(query);
        smt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        int rowsAffected = smt.executeUpdate();

        if (rowsAffected > 0) {
            // Recupera l'ID generato dall'inserimento
            resultSet = smt.getGeneratedKeys();
            if (resultSet.next()) {
                generatedId = resultSet.getInt(1);
                	
                // Stampa l'ID generato
                System.out.println("ID generato: " + generatedId);
                request.setAttribute("generatedId", generatedId);
            }
        }

        
    			
		query="select * from carrello where email_utente='"+email+"';";
		System.out.println(query);
		resultSet = statement.executeQuery(query);
		while(resultSet.next()){
			query="insert into ACQUISTI(email_utente,id_prodotto,id_ruote,id_interni,id_colore,id_ordine)"
			+"values ('"+email+"','"+resultSet.getString("id_prodotto")+"',"+resultSet.getString("id_ruote")+","+resultSet.getString("id_interni")+","+resultSet.getString("id_colore")+","+generatedId+");"; 
			System.out.println(query);
			st.executeUpdate(query);
		}
		
		query="DELETE FROM CARRELLO\r\n"
				+ "WHERE email_utente = '"+email+"';";
		System.out.println(query);
		statement.executeUpdate(query);
		
		 connection.close();
		 request.getServletContext().getRequestDispatcher("/ordine_completato.jsp").forward(request, response);	
		
		
		} catch (Exception e) {
     	request.setAttribute("error", e);
         e.printStackTrace();
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
		
	}

}
