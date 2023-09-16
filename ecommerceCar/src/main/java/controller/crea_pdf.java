package controller;
import java.io.IOException;

import java.util.ArrayList;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import model.dao.fatturaDAO;
import model.object.ordine;
import model.object.prodotto;




@WebServlet("/crea_pdf")
public class crea_pdf extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"Fattura_FGMS.pdf\"");
		String email= request.getParameter("email");
		String nome= request.getParameter("nome");
		String cognome= request.getParameter("cognome");
		String id_ordine= request.getParameter("id_ordine");
		
		
		fatturaDAO fatturaDAO=new fatturaDAO();
		ordine ordine = new ordine();
		ordine=fatturaDAO.getInfoOrdine(email,id_ordine);
		
        Document document = new Document();
        try {
        	
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            
            // Creazione della fattura
            Paragraph titolo = new Paragraph("-FGMS-\n\nFattura");
            titolo.setAlignment(Element.ALIGN_CENTER);
            document.add(titolo);


            Paragraph datiCliente = new Paragraph("Cliente: " + nome+" "+cognome + "\nEmail: " + email+ "\nMetodo di pagamento: " + request.getParameter("metodo_di_pagamento"));
            Paragraph data = new Paragraph("Data: " + ordine.getData_ordine());
            Paragraph spazio = new Paragraph("\n\n");

            document.add(datiCliente);
            document.add(data);
            document.add(spazio);

            PdfPTable table = new PdfPTable(2); 
            table.setWidthPercentage(100);
            table.setSpacingBefore(10f);
            table.setSpacingAfter(10f);

         
            PdfPCell cell1 = new PdfPCell(new Phrase("Prodotto"));
            PdfPCell cell2 = new PdfPCell(new Phrase("Prezzo"));
            table.addCell(cell1);
            table.addCell(cell2);
            
            ArrayList<prodotto> prodotti = ordine.getProdotti();
            
            for(prodotto p: prodotti)
            {
            	
            	 if(p.getTipo().equals("macchina"))
            	 {
            		 table.addCell(p.getBrand()+" "+p.getNome()+"\n(Colore:"+p.getColore()+" - Ruote: "+p.getRuote()+" - Interni: "+p.getInterni()+")");
            	 }
            	 else
            	 {
            		 table.addCell(p.getBrand()+" "+p.getNome());
            	 }
            	 table.addCell("€"+p.getPrezzo());
    		}

            document.add(table);
            
            Paragraph prezzo_noivaFattura = new Paragraph("€"+ordine.getPrezzo_novia()+" +IVA");
            Paragraph totaleFattura = new Paragraph("Totale: €"+ordine.getPrezzo_tot());
            totaleFattura.setAlignment(Element.ALIGN_RIGHT);
            prezzo_noivaFattura.setAlignment(Element.ALIGN_RIGHT);
            document.add(prezzo_noivaFattura);
            document.add(totaleFattura);
            
            
        } catch (DocumentException e) {
            e.printStackTrace();
        } finally {
            document.close();
        }
		
    }
}
