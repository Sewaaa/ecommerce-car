import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import com.itextpdf.text.Image;


@WebServlet("/crea_pdf")
public class crea_pdf extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"Fattura_FGMS.pdf\"");
        HttpSession sessione = request.getSession();
		String email= (String)sessione.getAttribute("email");
		String nome= (String)sessione.getAttribute("nome");
		String cognome= (String)sessione.getAttribute("cognome");
		String id_ordine= request.getParameter("id_ordine");
		
		String dbUrl = "jdbc:mysql://localhost:3306/tsw_prog"; 
		String user = "root";
		String password = "root";
		try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection(dbUrl, user, password);
		Statement statement=connection.createStatement();
		ResultSet resultSet;
		String query="SELECT\r\n"
				+ "    ordini.data_ordine,\r\n"
				+ "    UTENTI.email,\r\n"
				+ "    UTENTI.nome,\r\n"
				+ "    PRODOTTI.tipo,\r\n"
				+ "    UTENTI.cognome,\r\n"
				+ "    PRODOTTI.nome AS nome_prodotto,\r\n"
				+ "    PRODOTTI.prezzo,\r\n"
				+ "    BRAND.nome AS nome_brand,\r\n"
				+ "    COLORI.nome AS nome_colore,\r\n"
				+ "    RUOTE.tipo AS tipo_ruote,\r\n"
				+ "    INTERNI.tipo AS tipo_interni\r\n"
				+ "FROM\r\n"
				+ "    ACQUISTI\r\n"
				+ "     JOIN ORDINI ON ACQUISTI.id_ordine = ORDINI.id\r\n"
				+ "    JOIN UTENTI ON ACQUISTI.email_utente = UTENTI.email\r\n"
				+ "    JOIN PRODOTTI ON ACQUISTI.id_prodotto = PRODOTTI.id\r\n"
				+ "    JOIN BRAND ON PRODOTTI.id_brand = BRAND.id\r\n"
				+ "    LEFT JOIN MEDIA ON PRODOTTI.id = MEDIA.id_prodotto\r\n"
				+ "    LEFT JOIN COLORI ON ACQUISTI.id_colore = COLORI.id\r\n"
				+ "    LEFT JOIN RUOTE ON ACQUISTI.id_ruote = RUOTE.id\r\n"
				+ "    LEFT JOIN INTERNI ON ACQUISTI.id_interni = INTERNI.id\r\n"
				+ "WHERE\r\n"
				+ "    ACQUISTI.email_utente = '"+email+"'\r\n"
				+ "    AND ACQUISTI.id_ordine = "+id_ordine+";";
		System.out.println(query);
		resultSet = statement.executeQuery(query);
		resultSet.next();
        Document document = new Document();
        try {
        	
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            
            // Creazione della fattura
            Paragraph titolo = new Paragraph("-FGMS-\n\nFattura");
            titolo.setAlignment(Element.ALIGN_CENTER);
            document.add(titolo);


            Paragraph datiCliente = new Paragraph("Cliente: " + nome+" "+cognome + "\nEmail: " + email+ "\nMetodo di pagamento: " + request.getParameter("metodo_di_pagamento"));
            Paragraph data = new Paragraph("Data: " + resultSet.getString("data_ordine"));
            Paragraph spazio = new Paragraph("\n\n");

            document.add(datiCliente);
            document.add(data);
            document.add(spazio);

            PdfPTable table = new PdfPTable(2); // Tabella con due colonne (Prodotto, Prezzo)
            table.setWidthPercentage(100);
            table.setSpacingBefore(10f);
            table.setSpacingAfter(10f);

            // Intestazioni della tabella
            PdfPCell cell1 = new PdfPCell(new Phrase("Prodotto"));
            PdfPCell cell2 = new PdfPCell(new Phrase("Prezzo"));
            table.addCell(cell1);
            table.addCell(cell2);
            	
            // Aggiunta dei prodotti acquistati alla tabella
            do{
            	 if(resultSet.getString("tipo").equals("macchina"))
            	 {
            		 table.addCell(resultSet.getString("nome_brand")+" "+resultSet.getString("nome_prodotto")+"\n(Colore:"+resultSet.getString("nome_colore")+" - Ruote: "+resultSet.getString("tipo_ruote")+" - Interni: "+resultSet.getString("tipo_interni")+")");
            	 }
            	 else
            	 {
            		 table.addCell(resultSet.getString("nome_brand")+" "+resultSet.getString("nome_prodotto"));
            	 }
            	 table.addCell("€"+resultSet.getString("prezzo"));
    		}while(resultSet.next());

            document.add(table);

            query="SELECT\r\n"
            		+ "	ordini.prezzo_noiva,\r\n"
            		+ "    ordini.prezzo_tot\r\n"
            		+ "FROM\r\n"
            		+ "   ordini\r\n"
            		+ "WHERE\r\n"
            		+ "    ordini.email_utente = '"+email+"'\r\n"
            		+ "    AND ordini.id = "+id_ordine+";";
    		System.out.println(query);
    		resultSet = statement.executeQuery(query);
    		resultSet.next();
            
            Paragraph prezzo_noivaFattura = new Paragraph("€"+resultSet.getString("prezzo_noiva")+" +IVA");
            Paragraph totaleFattura = new Paragraph("Totale: €"+resultSet.getString("prezzo_tot"));
            totaleFattura.setAlignment(Element.ALIGN_RIGHT);
            prezzo_noivaFattura.setAlignment(Element.ALIGN_RIGHT);
            document.add(prezzo_noivaFattura);
            document.add(totaleFattura);
            
            
        } catch (DocumentException e) {
            e.printStackTrace();
        } finally {
            document.close();
        }
		} catch (Exception e) {
	     	request.setAttribute("error", e);
	         e.printStackTrace();
	        }
    }
}
