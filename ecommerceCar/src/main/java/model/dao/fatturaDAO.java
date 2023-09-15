package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import model.object.ordine;
import model.object.prodotto;
import model.object.utente;


public class fatturaDAO {

	/*PRENDI INFORMAZIONI DI UN ORDINE PER FATTURA */
	 public  ordine getInfoOrdine(String email,String id_ordine) {
		 PreparedStatement ps =null;
		 ResultSet rs=null;
		 try (Connection con = ConPool.getConnection()) {
			 try(ps = con.prepareStatement){
					("SELECT\r\n"
					+ "    ordini.data_ordine,\r\n"
					+ "    UTENTI.email,\r\n"
					+ "    UTENTI.nome,\r\n"
					+ "    ACQUISTI.tipo,\r\n"
					+ "    UTENTI.cognome,\r\n"
					+ "    ACQUISTI.nome AS nome_prodotto,\r\n"
					+ "    ACQUISTI.prezzo,\r\n"
					+ "    ACQUISTI.brand AS nome_brand,\r\n"
					+ "    COLORI.nome AS nome_colore,\r\n"
					+ "    RUOTE.tipo AS tipo_ruote,\r\n"
					+ "    INTERNI.tipo AS tipo_interni\r\n"
					+ "FROM\r\n"
					+ "    ACQUISTI\r\n"
					+ "    JOIN ORDINI ON ACQUISTI.id_ordine = ORDINI.id\r\n"
					+ "    JOIN UTENTI ON ACQUISTI.email_utente = UTENTI.email\r\n"
					+ "    LEFT JOIN COLORI ON ACQUISTI.id_colore = COLORI.id\r\n"
					+ "    LEFT JOIN RUOTE ON ACQUISTI.id_ruote = RUOTE.id\r\n"
					+ "    LEFT JOIN INTERNI ON ACQUISTI.id_interni = INTERNI.id\r\n"
					+ "WHERE\r\n"
					+ "    ACQUISTI.email_utente = ?\r\n"
					+ "    AND ACQUISTI.id_ordine = ?;");
			   ps.setString(1, email);
			   ps.setString(2, id_ordine);
			    rs = ps.executeQuery();
	           
			   utente utente=new utente();
			   String data_ordine="";
			   ArrayList<prodotto> prodotti = new ArrayList<>();

	           while (rs.next()) {
	        	  
	            	/*PRENDI PRODOTTI DELL'ORDINE*/
	        	   
	        	    prodotto p=new prodotto();

	            	p.setTipo(rs.getString(4));
	            	p.setNome(rs.getString(6));
	            	p.setPrezzo(rs.getString(7));
	            	p.setBrand(rs.getString(8));
	            	
	            	if(rs.getString(4).equals("macchina"))
	            	{
	            	
	            		p.setColore(rs.getString(9)); 
		        	    p.setRuote(rs.getString(10)); 
		        	    p.setInterni(rs.getString(11)); 
	            	}
	                prodotti.add(p);
	                
	                /*PRENDI INFORMAZIONI UTENTE*/
	                utente.setNome(rs.getString(3));
	                utente.setCognome(rs.getString(5));
	                utente.setEmail(rs.getString(2));
	                
	                /*PRENDI DATA ORDINE*/
	                data_ordine=rs.getString(1);
	            }
	           ordine ordine=new ordine(data_ordine,prodotti,utente);
	           ordine=getPrezziOrdine(utente.getEmail(),id_ordine,ordine);

	           return ordine;
		 } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		   finally {
			    try {
			        if (rs != null) {
			            rs.close();
			        }
			        if (ps != null) {
			            ps.close();
			        }
			    } catch (SQLException e) {
			        e.printStackTrace();
			    }
		  }
		  }
	 
		/*PRENDI INFORMAZIONI DEI PREZZI DI UN ORDINE PER FATTURA */
	 public  ordine getPrezziOrdine(String email,String id_ordine,ordine ordine) {
		 PreparedStatement ps =null;
		 ResultSet rs=null;
		 try (Connection con = ConPool.getConnection()) {
			 try(ps = con.prepareStatement){
					("SELECT\r\n"
            		+ "	ordini.prezzo_noiva,\r\n"
            		+ "    ordini.prezzo_tot\r\n"
            		+ "FROM\r\n"
            		+ "   ordini\r\n"
            		+ "WHERE\r\n"
            		+ "    ordini.email_utente = ?\r\n"
            		+ "    AND ordini.id = ?");
			   ps.setString(1, email);
			   ps.setString(2, id_ordine);
			    rs = ps.executeQuery();
	           
			  
			   while (rs.next()) {
				   ordine.setPrezzo_novia(rs.getString(1));
				   ordine.setPrezzo_tot(rs.getString(2));
	           }
	           return ordine;
		 } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		   finally {
			    try {
			        if (rs != null) {
			            rs.close();
			        }
			        if (ps != null) {
			            ps.close();
			        }
			    } catch (SQLException e) {
			        e.printStackTrace();
			    }
		  }
		  }
	 
	 
	
	
}
