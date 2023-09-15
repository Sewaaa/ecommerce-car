package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


import model.object.*;

public class utenteDAO {

	/*Prelievo informazioni per login */
	 public ArrayList<utente> getAllUtenti(String searchEmail) {
		 PreparedStatement ps =null;
		 ResultSet rs=null;
		 try (Connection con = ConPool.getConnection()) {
		    String query = "SELECT email, nome, cognome, telefono FROM utenti WHERE email != 'admin@fgms.it'";
		    if (searchEmail != null && !searchEmail.isEmpty()) {
		        query += " AND email=?";
		        ps = con.prepareStatement(query);
		        ps.setString(1, searchEmail);
		    }
		    else
		    {
		    	searchEmail = "";
		    	ps = con.prepareStatement(query);
		    }

			 rs = ps.executeQuery();
			ArrayList<utente> utenti=new ArrayList<utente>();
	           while (rs.next()) {
	        	    utente u=new utente();
	        	    u.setEmail(rs.getString(1));
	        	    u.setNome(rs.getString(2));
					u.setCognome(rs.getString(3));
					u.setTelefono(rs.getString(4));
					
					utenti.add(u);
	           }
	           return utenti;
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
	
	
	
	/*Prelievo informazioni per login */
	 public utente login(String email, String psw) {
		 PreparedStatement ps =null;
		 ResultSet rs=null;
		 try (Connection con = ConPool.getConnection()) {
			
			 ps = con.prepareStatement
			("SELECT nome, cognome FROM UTENTI WHERE email =? AND psw =?");
			ps.setString(1, email);
			ps.setString(2, psw);
			 rs = ps.executeQuery();
			utente u=null;
	           while (rs.next()) {
	        	    u=new utente();
	        	    u.setNome(rs.getString(1));
					u.setCognome(rs.getString(2));
					u.setEmail(email);
					u.setPsw(psw);
	           }
	           return u;
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
	 
	 /*Prelievo informazioni per utente loggato */
	 public utente getUtenteLoggato(String email) {
		 PreparedStatement ps =null;
		 ResultSet rs=null;
		 try (Connection con = ConPool.getConnection()) {
			
			 ps = con.prepareStatement
			("SELECT * FROM UTENTI WHERE email =?");
			ps.setString(1, email);
			 rs = ps.executeQuery();
			utente u=null;
	           while (rs.next()) {
	        	    u=new utente();
	        	    if(rs.getString(1) == null){ u.setEmail(""); }
	        	    else{u.setEmail(rs.getString(1));}
	        	    if(rs.getString(2) == null){ u.setPsw(""); }
	        	    else{u.setPsw(rs.getString(2));}
	        	    if(rs.getString(3) == null){ u.setNome(""); }
	        	    else{u.setNome(rs.getString(3));}
	        	    if(rs.getString(4) == null){ u.setCognome(""); }
	        	    else{u.setCognome(rs.getString(4));}
	        	    if(rs.getString(5) == null){ u.setTelefono(""); }
	        	    else{u.setTelefono(rs.getString(5));}
	        	    if(rs.getString(6) == null){ u.setProvincia(""); }
	        	    else{u.setProvincia(rs.getString(6));}
	        	    if(rs.getString(7) == null){ u.setCitta(""); }
	        	    else{u.setCitta(rs.getString(7));}
	        	    if(rs.getString(8) == null){ u.setCap(""); }
	        	    else{u.setCap(rs.getString(8));}
	        	    if(rs.getString(9) == null){ u.setVia(""); }
	        	    else{u.setVia(rs.getString(9));}
	        	    if(rs.getString(10) == null){ u.setNciv(""); }
	        	    else{u.setNciv(rs.getString(10));}
	           }
	           return u;
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
	 
		/*prelievo utente (per controllo esistenza utente) */
	 public boolean checkUser(String email) {
		 PreparedStatement ps =null;
		 ResultSet rs=null;
		 try (Connection con = ConPool.getConnection()) {
			
			 ps = con.prepareStatement
			("SELECT nome, cognome FROM UTENTI WHERE email =?");
			ps.setString(1, email);
			 rs = ps.executeQuery();
			boolean trovato=false;
	           while (rs.next()) {
	        	    trovato=true;
	           }
	           return trovato;
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
	 
	 /*INSERISCI NUOVO UTENTE */
	 public void InsertNewUtente(String email, String psw, String nome, String cognome, String telefono, String provincia, String citta, String cap, String via, String n_civ) {
		 PreparedStatement ps =null;
	
		 try (Connection con = ConPool.getConnection()) {
			   ps = con.prepareStatement(
	                    "INSERT INTO UTENTI (email, psw, nome, cognome, telefono, provincia, citta, cap, via, n_civ) VALUES (?,?,?,?,?,?,?,?,?,?);",
	                    Statement.RETURN_GENERATED_KEYS);
	            ps.setString(1, email);
	            ps.setString(2, psw);
	            ps.setString(3, nome);
	            ps.setString(4, cognome);
	            ps.setString(5, telefono);
	            ps.setString(6, provincia);
	            ps.setString(7, citta);
	            ps.setString(8, cap);
	            ps.setString(9, via);
	            ps.setString(10, n_civ);
	           
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
	 
	 /*MODIFICA UN utente */
	 public void modificaUtente(String id, String email,String password,String nome,String cognome,String telefono,String provincia,String citta,String cap,String via,String nciv) {
		 PreparedStatement Ps =null;
		 try (Connection con = ConPool.getConnection()) {
		    	String query1 = "UPDATE utenti AS u SET u.email = ?, u.psw = ?, "
			 		 		+ "u.nome = ?, u.cognome = ?, u.telefono=?,"
			 		 		+ "u.provincia=?, u.citta = ?, u.cap=?, u.via=?, u.n_civ=?"
			                + "WHERE u.email = ?;";
		         Ps = con.prepareStatement(query1, Statement.RETURN_GENERATED_KEYS);
		        Ps.setString(1, email);
		        Ps.setString(2, password);
		        Ps.setString(3, nome);
		        Ps.setString(4, cognome);
		        Ps.setString(5, telefono);
		        Ps.setString(6, provincia);
		        Ps.setString(7, citta);
		        Ps.setString(8, cap);
		        Ps.setString(9, via);
		        Ps.setString(10, nciv);
		        Ps.setString(11, id);
		        
		        Ps.executeUpdate();
		        
		       
		    } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		   finally {
			    try {
			        if (Ps != null) {
			            Ps.close();
			        }
			    } catch (SQLException e) {
			        e.printStackTrace();
			    }
		  }
		}
	 
}
