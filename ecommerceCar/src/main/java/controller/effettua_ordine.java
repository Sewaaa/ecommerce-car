package controller;
import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.carrelloDAO;
import model.dao.ordiniDAO;
import model.dao.personalizzazioneDAO;
import model.object.prodotto;

import java.util.ArrayList;
import java.util.Date;


@WebServlet("/effettua_ordine")
public class effettua_ordine extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

    public effettua_ordine() {
        super();
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		HttpSession sessione = request.getSession();
		String email= (String)sessione.getAttribute("email");
		String metodo= request.getParameter("metodo_di_pagamento");
		String prezzo_totale= request.getParameter("prezzo_totale");
		String prezzo_noiva= request.getParameter("prezzo_noiva");
		String nome= (String)sessione.getAttribute("nome");
		String cognome= (String)sessione.getAttribute("cognome");
		/*Prende e formatta ora e data attuale dell'ordine*/
		SimpleDateFormat sdfDate = new SimpleDateFormat("dd/MM/yyyy");
	    SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
	    Date currentDate = new Date();
	    String formattedDate = sdfDate.format(currentDate);
	    String formattedTime = sdfTime.format(currentDate);
	   
	   ArrayList<prodotto>  carrello = new ArrayList<prodotto>();
        
       ordiniDAO ordiniDAO=new ordiniDAO();
       carrelloDAO carrelloDAO=new carrelloDAO();
       personalizzazioneDAO persDAO=new personalizzazioneDAO();
       
       /*Creazione nuovo ordine*/
       int generatedOrderId=(int)ordiniDAO.insertNewOrder(email,nome,cognome,metodo,prezzo_totale,prezzo_noiva, formattedDate+" "+formattedTime);
       /*Prelievo dei prodotti del carrello*/
       carrello = (ArrayList<prodotto>) carrelloDAO.getMyCart(email);
       /*Inserisci prodotti da carrello a acquisti, correllati all'ordine creato*/
       for(prodotto p: carrello){
    	   if(p.getTipo().equals("macchina"))
    	   {
    		   ArrayList<String> id_personalizzazioni= (ArrayList<String>) persDAO.NameToId(p.getColore(),p.getRuote(),p.getInterni());
        	   ordiniDAO.InsertNewAcquisto(email,p.getTipo(), p.getBrand(),p.getPercorso(),p.getPrezzo(),p.getNome(),id_personalizzazioni.get(1),id_personalizzazioni.get(2),id_personalizzazioni.get(0),generatedOrderId);       
    	   }
    	   else
    	   {
    		   ordiniDAO.InsertNewAcquisto(email,p.getTipo(),p.getBrand(), p.getPercorso(),p.getPrezzo(),p.getNome(),generatedOrderId);       
    	   }
       }
       /*Svuota carrello*/
        carrelloDAO.DeleteMyCart(email);
		
        
        sessione.setAttribute("generatedOrderId", generatedOrderId);
		request.getServletContext().getRequestDispatcher("/ordine_completato.jsp").forward(request, response);	
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
		
	}

}
