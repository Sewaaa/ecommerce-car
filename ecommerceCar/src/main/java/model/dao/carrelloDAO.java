package model.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.object.*;


public class carrelloDAO {

	/*PRENDI CARRELLO DI UTENTE X */
	 public List<prodotto>  getMyCart(String email) {
		 PreparedStatement ps =null;
		 ResultSet rs=null;
		 try (Connection con = ConPool.getConnection()) {
			ps = con.prepareStatement
			("SELECT p.id as id_prodotto,p.tipo,c.id as id_carrello, p.nome as nome_prodotto, p.prezzo, b.nome as nome_brand, colori.nome as colore, ruote.tipo as ruote , interni.tipo as interni, m.percorso, count(*)"+
			" FROM prodotti p"+
			" INNER JOIN carrello c ON p.id = c.id_prodotto"+
			" INNER JOIN media m ON p.id = m.id_prodotto"+
			" INNER JOIN brand b ON p.id_brand = b.id"+
			" left JOIN  colori ON colori.id = c.id_colore"+
			" left JOIN  ruote ON ruote.id = c.id_ruote"+
			" left JOIN  interni ON interni.id = c.id_interni"+
			" WHERE c.email_utente = ?"+
			" group by id_prodotto, colore, ruote, interni");
			ps.setString(1, email);
			   rs = ps.executeQuery();
	           List<prodotto> carrello = new ArrayList<>();
	           
	           while (rs.next()) {
	        	  
	            	prodotto p=new prodotto();
	            	p.setId(rs.getString(1)); //id_prodotto
	            	p.setTipo(rs.getString(2));//tipo	
	            	p.setIdcarrello(rs.getString(3));//id_carrello
	            	p.setNome(rs.getString(4));//nome_prodotto
	            	p.setPrezzo(rs.getString(5));//prezzo
	            	p.setBrand(rs.getString(6));//nome_brand
	            	if(rs.getString(2).equals("macchina"))
	            	{
	            		//System.out.print(rs.getString(7)+"\n");
	            		p.setColore(rs.getString(7)); 
		        	    p.setRuote(rs.getString(8)); 
		        	    p.setInterni(rs.getString(9)); 
	            	}
	            	p.setPercorso(rs.getString(10));//percorso
	            	p.setQuantita(rs.getInt(11));//quantità del prodotto nel carrello
	                carrello.add(p);
	            }
	           return carrello;
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
	 
	 /*PRENDI CARRELLO CON SESSIONE */
	 public List<prodotto>  getGuestCart(ArrayList<prodotto> lista_idprodotti) {
		 int i=0;
		 PreparedStatement ps =null;
		 ResultSet rs=null;
		 List<prodotto> carrello = new ArrayList<>();
		 try (Connection con = ConPool.getConnection()) {
			 
			 for (prodotto p : lista_idprodotti) {
				
				 ps = con.prepareStatement
				("select p.id as id_prodotto ,p.prezzo,p.tipo, b.nome as nome_brand, p.nome as nome_prodotto, m.percorso from prodotti as p ,brand as b, media as m where p.id_brand=b.id and m.id_prodotto=p.id and p.id=?");
				ps.setString(1, lista_idprodotti.get(i).getId());
				    rs = ps.executeQuery();
				   
		           while (rs.next()) {
		        	    p.setId(rs.getString(1)); //id_prodotto
		        	    p.setPrezzo(rs.getString(2));//prezzo
		        	    p.setTipo(rs.getString(3));//tipo	
		            	p.setBrand(rs.getString(4));//nome_brand
		            	p.setNome(rs.getString(5));//nome_prodotto
		            	p.setPercorso(rs.getString(6));//percorso
		            	p.setIdcarrello(String.valueOf(i));//id carrello=i
		            	
		            	
		            	if(rs.getString(3).equals("macchina"))
		            	{
						    p.setColore(lista_idprodotti.get(i).getColore()); 
			        	    p.setRuote(lista_idprodotti.get(i).getRuote()); 
			        	    p.setInterni(lista_idprodotti.get(i).getInterni()); 
		            	}
		                carrello.add(p);
		           	}
		           i++;
			 }
	           return carrello;
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
	 
	 
	 
	 
	 /*INSERISCI ACCESSORIO IN CARRELLO DI UTENTE X */
	 public void InsertIntoCart(String email_utente, String id_prodotto) {
		 PreparedStatement ps =null;
		 try (Connection con = ConPool.getConnection()) {
			   ps = con.prepareStatement(
	                    "insert into carrello (email_utente, id_prodotto) VALUES(?,?);",
	                    Statement.RETURN_GENERATED_KEYS);
	            ps.setString(1, email_utente);
	            ps.setString(2, id_prodotto);
	           
	            if (ps.executeUpdate() != 1) {
	                throw new RuntimeException("INSERT error.");
	            }
	           return;
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		   finally {
			    try {
			        if (ps != null) {
			            ps.close();
			        }
			    } catch (SQLException e) {
			        e.printStackTrace();
			    }
		  }
		  }
	 
	 /*INSERISCI MACCHINA IN CARRELLO DI UTENTE X */
	 public void InsertIntoCart(String email_utente, String id_prodotto, String colore, String ruote, String interni) {		  
		 PreparedStatement ps =null;
		
		 try (Connection con = ConPool.getConnection()) {
			   ps = con.prepareStatement(
					  "insert into carrello (email_utente, id_prodotto,id_colore,id_ruote,id_interni) VALUES(?,?,?,?,?);",
	                    Statement.RETURN_GENERATED_KEYS);
	            ps.setString(1, email_utente);
	            ps.setString(2, id_prodotto); 
	            ps.setString(3, colore);
	            ps.setString(4, ruote);
	            ps.setString(5, interni);
	            
	            if (ps.executeUpdate() != 1) {
	                throw new RuntimeException("INSERT error.");  
	            }
	           return;
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		   finally {
			    try {
			        if (ps != null) {
			            ps.close();
			        }
			    } catch (SQLException e) {
			        e.printStackTrace();
			    }
		  }
		  }
	 
	 /*ELIMINA PRODOTTO DA CARRELLO DA ID */
	 public void DeleteFromCart(String id_prodotto) {
		 PreparedStatement ps =null;

		 try (Connection con = ConPool.getConnection()) {
			ps = con.prepareStatement(
	                    "delete from carrello where id= ?");
	         
	            ps.setString(1, id_prodotto);
	            ps.executeUpdate();
	           return;
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		   finally {
			    try {
			        if (ps != null) {
			            ps.close();
			        }
			    } catch (SQLException e) {
			        e.printStackTrace();
			    }
		  }
	}
	 
	 /*ELIMINA TUTTO CARRELLO DI UTENTE X */
	 public void DeleteMyCart(String email) {
		 PreparedStatement ps =null;
		 try (Connection con = ConPool.getConnection()) {
			   ps = con.prepareStatement(
	                    "delete from carrello where email_utente= ?");
	         
	            ps.setString(1, email);
	            ps.executeUpdate();
	           return;
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		   finally {
			    try {
			        if (ps != null) {
			            ps.close();
			        }
			    } catch (SQLException e) {
			        e.printStackTrace();
			    }
		  }
	}
	 
	 /*ELIMINA PRODOTTO DA CARRELLO DA ID */
	 public String SearchFromCart(String id_prodotto, String interni, String ruote, String colore, String email) {
		 PreparedStatement ps =null;
		 try (Connection con = ConPool.getConnection()) {
			   ps = con.prepareStatement(
	          "Select id from carrello where id_prodotto= ? and id_colore=? and id_ruote=? and id_interni=? and email_utente=?");
	         
	            ps.setString(1, id_prodotto);
	            ps.setString(2, colore);
	            ps.setString(3, ruote);
	            ps.setString(4, interni);
	            ps.setString(5, email);
	            ResultSet rs = ps.executeQuery();
	            String result = "";
				while(rs.next()) {
					result = rs.getString(1);
				}
	           return result;
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		   finally {
			    try {
			        if (ps != null) {
			            ps.close();
			        }
			    } catch (SQLException e) {
			        e.printStackTrace();
			    }
		  }
	}
}
