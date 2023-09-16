package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.object.ordine;
import model.object.prodotto;

public class ordiniDAO {

	/*INSERISCI NUOVO ORDINE */
	public int insertNewOrder(String email_utente, String nome, String cognome, String metodopagamento, String prezzo_tot, String prezzo_noiva, String data_ordine) {
	    int generatedOrderId = -1; // Valore di default nel caso in cui non venga generato alcun ID valido
		 ResultSet generatedKeys=null;
	    try (Connection con = ConPool.getConnection();
		     PreparedStatement ps = con.prepareStatement(
	                "INSERT INTO ordini(email_utente, nome, cognome, metodo_di_pagamento, prezzo_tot, prezzo_noiva, data_ordine) VALUES(?, ?, ?, ?, ?, ?, ?);",
	                Statement.RETURN_GENERATED_KEYS)) {
	        ps.setString(1, email_utente);
	        ps.setString(2, nome);
	        ps.setString(3, cognome);
	        ps.setString(4, metodopagamento);
	        ps.setString(5, prezzo_tot); 
	        ps.setString(6, prezzo_noiva);
	        ps.setString(7, data_ordine);

	        int rowsAffected = ps.executeUpdate();
	        if (rowsAffected == 1) {
	             generatedKeys = ps.getGeneratedKeys();
	            if (generatedKeys.next()) {
	                generatedOrderId = generatedKeys.getInt(1); // Assumendo che l'ID sia di tipo INT.
	            } else {
	                throw new RuntimeException("Failed to get the generated order ID.");
	            }
	        } else {
	            throw new RuntimeException("INSERT error.");
	        }

	        return generatedOrderId;
	} catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
	}

	 /*INSERISCI NUOVO ACQUISTO MACCHINA (CON PERSONALIZZAZIONE DEI PRODOTTI DELL'ORDINE) */
	 public void InsertNewAcquisto(String email_utente, String tipo, String brand, String percorso, String prezzo, String nome, String id_ruote, String id_interni, String id_colore, int id_ordine) {		  
		
		 try (Connection con = ConPool.getConnection();
		     PreparedStatement ps = con.prepareStatement(
					  "insert into ACQUISTI(email_utente,tipo,brand,percorso,prezzo,nome,id_ruote,id_interni,id_colore,id_ordine)  VALUES(?,?,?,?,?,?,?,?,?,?);",
	                    Statement.RETURN_GENERATED_KEYS)) {
	            ps.setString(1, email_utente);
	            ps.setString(2, tipo);
	            ps.setString(3, brand);
	            ps.setString(4, percorso); 
	            ps.setString(5, prezzo);
	            ps.setString(6, nome);
	            ps.setString(7, id_ruote);
	            ps.setString(8, id_interni);
	            ps.setString(9, id_colore);
	            ps.setInt(10, id_ordine);
	            
	            
	            if (ps.executeUpdate() != 1) {
	                throw new RuntimeException("INSERT error.");
	               
	            }
	           return;
		} catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		  }
	 
	 /*INSERISCI NUOVO ACQUISTO ACCESSORIO */
	 public void InsertNewAcquisto(String email_utente, String tipo, String brand, String percorso, String prezzo, String nome, int id_ordine) {		  
	
		 try (Connection con = ConPool.getConnection();
		     PreparedStatement ps = con.prepareStatement(
					  "insert into ACQUISTI(email_utente,tipo,brand, percorso,prezzo,nome,id_ordine)  VALUES(?,?,?,?,?,?,?);",
	                    Statement.RETURN_GENERATED_KEYS)) {
	            ps.setString(1, email_utente);
	            ps.setString(2, tipo);
	            ps.setString(3, brand);
	            ps.setString(4, percorso); 
	            ps.setString(5, prezzo);
	            ps.setString(6, nome);
	            ps.setInt(7, id_ordine);
	            
	            
	            if (ps.executeUpdate() != 1) {
	                throw new RuntimeException("INSERT error.");
	               
	            }
	           return;
		} catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		  }
	 
	 /*PRENDI TUTTI ORDINI */
	 public ArrayList<ordine>  getAllOrdini(String emailFiltrata) {
		 ResultSet rs=null;
		 PreparedStatement ps=null;
		 try (Connection con = ConPool.getConnection()) {
			 String query = "SELECT o.id AS id_ordine, a.tipo AS tipo, a.nome AS nome_prodotto, a.brand AS nome_brand, a.percorso AS percorso_media, a.prezzo AS prezzo_prodotto, c.nome AS nome_colore, r.tipo AS tipo_ruote, i.tipo AS tipo_interni, o.email_utente as email_utente"
                     + " FROM ACQUISTI a"
                     + " JOIN ORDINI o ON a.id_ordine = o.id"
                     + " JOIN UTENTI u ON a.email_utente = u.email"
                     + " LEFT JOIN COLORI c ON a.id_colore = c.id"
                     + " LEFT JOIN RUOTE r ON a.id_ruote = r.id"
                     + " LEFT JOIN INTERNI i ON a.id_interni = i.id";
			 
			    if (emailFiltrata != null && !emailFiltrata.isEmpty()) {
			    	
			    	query += " WHERE o.email_utente = ? ORDER BY o.id";
                    try(PreparedStatement psLocal = con.prepareStatement(query)){
                    	  ps=psLocal;
                          ps.setString(1, emailFiltrata);
                    } catch (SQLException e) {
        	            throw new RuntimeException(e);
        	        }
                } else {
                	
                    query += " ORDER BY o.id";
                    try(PreparedStatement psLocal = con.prepareStatement(query)){
                    	ps=psLocal;
                    }catch (SQLException e) {
                    throw new RuntimeException(e);
                    }
                }
			   ArrayList<ordine> ordini = new ArrayList<ordine>();
	            rs = ps.executeQuery();          
	           String currentOrderId = "";
	           ordine o = null;
	           while (rs.next()) {
	        	  
	        	   
	        	   String orderId = rs.getString(1);
	        	   
                   if (!currentOrderId.equals(orderId)) {
                      
                	   try(PreparedStatement ps2 = con.prepareStatement
   					 ( "SELECT * FROM ordini WHERE id=? AND email_utente=?;")){
                       ps2.setString(1, orderId);
                       ps2.setString(2, rs.getString(10));
                       
                       
                       ResultSet rs2 = ps2.executeQuery();
                       rs2.next();

                       
                       String dataOrdine = rs2.getString(6);
                       String prezzoTot = rs2.getString(4);
                       String emailUtente= rs2.getString(2);
                       String metodo = rs2.getString(3);
                       String nome= rs2.getString(7);
                       String cognome= rs2.getString(8);
                       
                       o=new ordine(orderId,dataOrdine,nome,cognome,emailUtente,prezzoTot,metodo);
                       ordini.add(o);
			} catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
                   }
                   
                    prodotto p=new prodotto();
	            	
                    
	            	p.setTipo(rs.getString(2));//tipo
	            	p.setNome(rs.getString(3));//nome prodotto
	            	p.setBrand(rs.getString(4));//nome brand
	            	p.setPercorso(rs.getString(5));//percorso
	            	p.setPrezzo(rs.getString(6));//prezzo_prod
	            	p.setColore(rs.getString(7));//nome_colore
	            	p.setRuote(rs.getString(8));//ruote
	            	p.setInterni(rs.getString(9));//interni

	            	o.addProdotto(p);
	            }
	           return ordini;
		
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		  }
	 
	 /*PRENDI TUTTI ORDINI CON FILTRO PIU RECENTI/VECCHI */
	 public ArrayList<ordine>  getAllOrdini(String emailFiltrata, String Orderby) {
		 boolean email=false; 
		 ResultSet rs=null;
		 PreparedStatement ps=null;
		 try (Connection con = ConPool.getConnection()) {
	
			 String query = "SELECT o.id AS id_ordine, a.tipo AS tipo, a.nome AS nome_prodotto, a.brand AS nome_brand, a.percorso AS percorso_media, a.prezzo AS prezzo_prodotto, c.nome AS nome_colore, r.tipo AS tipo_ruote, i.tipo AS tipo_interni, o.email_utente as email_utente"
                     + " FROM ACQUISTI a"
                     + " JOIN ORDINI o ON a.id_ordine = o.id"
                     + " JOIN UTENTI u ON a.email_utente = u.email"
                     + " LEFT JOIN COLORI c ON a.id_colore = c.id"
                     + " LEFT JOIN RUOTE r ON a.id_ruote = r.id"
                     + " LEFT JOIN INTERNI i ON a.id_interni = i.id";
			 
			 
			 
			    if (emailFiltrata != null && !emailFiltrata.isEmpty()) {
			    	query += " WHERE o.email_utente = ? ";
                    email=true;   
                } 
			    if ("recenti".equals(Orderby)) {
                    query += " ORDER BY o.id DESC";
                    try(PreparedStatement psLocal = con.prepareStatement(query))
                    {
                    	ps=psLocal;
                    	} catch (SQLException e) {
                         	throw new RuntimeException(e);
                    	}
                } else if ("vecchi".equals(Orderby)) {
                    query += " ORDER BY o.id ASC";
                    try(PreparedStatement psLocal = con.prepareStatement(query))
                    		{
                    			ps=psLocal;
                    		} catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
                }
			    if(email)
			    {
			    	ps.setString(1, emailFiltrata);    
			    }
			   
			   
			   ArrayList<ordine> ordini = new ArrayList<ordine>();
	            rs = ps.executeQuery();          
	           String currentOrderId = "";
	           ordine o = null;
	           while (rs.next()) {
	        	  
	        	   
	        	   String orderId = rs.getString(1);
	        	   
                   if (!currentOrderId.equals(orderId)) {
                      
                	   try(PreparedStatement ps2 = con.prepareStatement
   					 ( "SELECT * FROM ordini WHERE id=? AND email_utente=?;")){
                       ps2.setString(1, orderId);
                       ps2.setString(2, rs.getString(10));
                       
                       
                       ResultSet rs2 = ps2.executeQuery();
                       rs2.next();

                       
                       String dataOrdine = rs2.getString(6);
                       String prezzoTot = rs2.getString(4);
                       String emailUtente= rs2.getString(2);
                       String metodo= rs2.getString(3);
                       String nome= rs2.getString(7);
                       String cognome= rs2.getString(8);
                       
                       o=new ordine(orderId,dataOrdine,nome, cognome,emailUtente,prezzoTot,metodo);
                       ordini.add(o);
			} catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
                   }
                   
                    prodotto p=new prodotto();
	            	
                    //System.out.print("\nnew prod");
	            	p.setTipo(rs.getString(2));//tipo
	            	p.setNome(rs.getString(3));//nome prodotto
	            	p.setBrand(rs.getString(4));//nome brand
	            	p.setPercorso(rs.getString(5));//percorso
	            	p.setPrezzo(rs.getString(6));//prezzo_prod
	            	p.setColore(rs.getString(7));//nome_colore
	            	p.setRuote(rs.getString(8));//ruote
	            	p.setInterni(rs.getString(9));//interni

	            	o.addProdotto(p);
	            }
	           return ordini;
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		  }
	
}
