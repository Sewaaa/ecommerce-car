package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class personalizzazioneDAO {
	
	/*DATI NOMI PERSONALIZZAZIONE, RESTITUISCI RISPETTIVI ID */
	 public List<String>  NameToId(String colore, String ruote, String interni) {
		 List<String> id_personalizzazioni = new ArrayList<>();
		 ResultSet rs=null,rs1=null,rs2=null;
		
		 try (Connection con = ConPool.getConnection();
		    PreparedStatement ps = con.prepareStatement
			  ("SELECT id  FROM colori WHERE nome=?;");
		     PreparedStatement ps1 = con.prepareStatement
				("SELECT id  FROM ruote WHERE tipo=?;");
		     PreparedStatement ps2 = con.prepareStatement
				("SELECT id  FROM interni WHERE tipo=?;")) {
			
			   ps.setString(1, colore);
			   rs = ps.executeQuery();
			   while(rs.next())
			   {
				   id_personalizzazioni.add(rs.getString(1));
				  
			   }
			   
			   
			   
				   ps1.setString(1, ruote);
				   rs1 = ps1.executeQuery();
				   while(rs1.next())
				   {	   
				   id_personalizzazioni.add(rs1.getString(1));
				   
				   }
						   
			   
				   ps2.setString(1, interni);
				   rs2 = ps2.executeQuery();
				   while(rs2.next())
				   {	   
				   id_personalizzazioni.add(rs2.getString(1));
				  
				   }

				   //System.out.print("ps:"+ps+"\nps1:"+ps1+"\nps2:"+ps2+"\n");   
				   
	           return id_personalizzazioni;
		
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		  
		  }
	 
	 /*DATI ID PERSONALIZZAZIONE, RESTITUISCI RISPETTIVI NOMI/TIPO */
	 public List<String>  IdToName(String colore, String ruote, String interni) {
		 
		 ResultSet rs=null;
		 try (Connection con = ConPool.getConnection();
		    PreparedStatement ps = con.prepareStatement
					("SELECT nome  FROM colori WHERE id=?\r\n"
							+ "UNION\r\n"
							+ "SELECT tipo FROM ruote WHERE id=?\r\n"
							+ "UNION\r\n"
							+ "SELECT tipo FROM interni WHERE id=?;")) {
			
			   ps.setString(1, colore);
			   ps.setString(2, ruote);
			   ps.setString(3, interni);
			    rs = ps.executeQuery();
	          
			   List<String> id_personalizzazioni = new ArrayList<>();
	           
	           while (rs.next()) {
	        	   id_personalizzazioni.add(rs.getString(1));
	        	   id_personalizzazioni.add(rs.getString(2));
	        	   id_personalizzazioni.add(rs.getString(3));
	            }
	           return id_personalizzazioni;
		
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		  
	
}
