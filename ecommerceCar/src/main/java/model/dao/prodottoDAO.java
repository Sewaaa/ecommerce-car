package model.dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.object.*;

public class prodottoDAO {

	/*PRENDI TUTTI I PRODOTTI con annesso nome brand */
	 public List<prodotto>  getAllProdotti() {
		  
		 try (Connection con = ConPool.getConnection()) {
			PreparedStatement ps = con.prepareStatement
			("select * from prodotti as p ,brand as b, media as m where p.id_brand=b.id and m.id_prodotto=p.id ;"); 
	           ResultSet rs = ps.executeQuery();
	           List<prodotto> lista_prodotti = new ArrayList<>();
	           while (rs.next()) {
	            	prodotto p=new prodotto();
	            	p.setId(rs.getString(1));
	            	p.setNome(rs.getString(2));
	            	p.setTipo(rs.getString(3));
	            	p.setDescrizione(rs.getString(4));
	                p.setData_rilascio(rs.getString(5));
	                p.setPrezzo(rs.getString(6));
	                //idbrand
	                //id
	                p.setBrand(rs.getString(9));
	                //percorsologo
	                p.setPercorso(rs.getString(11));
	                lista_prodotti.add(p);
	            }
	           return lista_prodotti;
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		  }
	 
	 /*INSERISCI NUOVO PRODOTTO */
	 public void InsertNewProdotto(String nome, String tipo, String descrizione, String data_rilascio, String prezzo, String id_brand, String foto) throws Exception {
		    try (Connection con = ConPool.getConnection()) {
		        String insertProdottoQuery = "INSERT INTO prodotti (nome, tipo, descrizione, data_rilascio, prezzo, id_brand) VALUES (?, ?, ?, ?, ?, ?)";
		        PreparedStatement prodottoPs = con.prepareStatement(insertProdottoQuery, Statement.RETURN_GENERATED_KEYS);
		        prodottoPs.setString(1, nome);
		        prodottoPs.setString(2, tipo);
		        prodottoPs.setString(3, descrizione);
		        prodottoPs.setString(4, data_rilascio);
		        prodottoPs.setString(5, prezzo);
		        prodottoPs.setString(6, id_brand);

		        int rowsAffected = prodottoPs.executeUpdate();
		        if (rowsAffected != 1) {
		            throw new Exception("Failed to insert into prodotti table.");
		        }

		        ResultSet generatedKeys = prodottoPs.getGeneratedKeys();
		        if (generatedKeys.next()) {
		            int idProdotto = generatedKeys.getInt(1);

		            String insertMediaQuery = "INSERT INTO media (percorso, id_prodotto) VALUES (?, ?)";
		            PreparedStatement mediaPs = con.prepareStatement(insertMediaQuery);
		            mediaPs.setString(1, foto);
		            mediaPs.setInt(2, idProdotto);
		            
		            rowsAffected = mediaPs.executeUpdate();
		            if (rowsAffected != 1) {
		                throw new Exception("Failed to insert into media table.");
		            }
		        } else {
		            throw new Exception("Failed to get the generated product ID.");
		        }
		    } catch (SQLException e) {
		        throw new Exception("Database error during insertion.", e);
		    }
		}

	 /*RIMUOVI UN PRODOTTO */
	 public void removeProdotto(String id) {
		    try (Connection con = ConPool.getConnection()) {
		        String query = "delete from prodotti as p where id=?";
		        PreparedStatement prodottoPs = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
		        prodottoPs.setString(1, id);
		        prodottoPs.executeUpdate();
		    } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		}

	 /*MODIFICA UN PRODOTTO */
	 public void modificaProdotto(String tipo_p,String nome_p,String data_rilascio_p,String prezzo_p,String id_prodotto,String id_brand,String descrizione_p,String foto_p) {
		    try (Connection con = ConPool.getConnection()) {
		 		String query1 = "UPDATE prodotti AS p SET p.nome = ?, p.tipo = ?, "
			 		 		+ "p.data_rilascio = ?, p.prezzo = ?, p.id_brand=?,"
			 		 		+ "p.descrizione=?" +
			                "WHERE p.id = ?;";
		        PreparedStatement prodottoPs1 = con.prepareStatement(query1, Statement.RETURN_GENERATED_KEYS);
		        prodottoPs1.setString(1, nome_p);
		        prodottoPs1.setString(2, tipo_p);
		        prodottoPs1.setString(3, data_rilascio_p);
		        prodottoPs1.setString(4, prezzo_p);
		        prodottoPs1.setString(5, id_brand);
		        prodottoPs1.setString(6, descrizione_p);
		        prodottoPs1.setString(7, id_prodotto);
		        

		        String query2 = "UPDATE MEDIA as m "
			 		 		+ "SET m.percorso = ?"+
			 		 		"WHERE m.id_prodotto = ?;";
		        PreparedStatement prodottoPs2 = con.prepareStatement(query2, Statement.RETURN_GENERATED_KEYS);
		        prodottoPs2.setString(1, foto_p);
		        prodottoPs2.setString(2, id_prodotto);

		        
		        prodottoPs1.executeUpdate();
		        prodottoPs2.executeUpdate();
		        
		       
		    } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		}
	 
	 
	 /*PRENDI I PRODOTTI FILTRATI PER TIPO*/
	 public List<prodotto>  getFiltredProdotti(String tipo) {
		 
		 try (Connection con = ConPool.getConnection()) {
			  String query="select * from prodotti as p ,brand as b, media as m where p.id_brand=b.id and m.id_prodotto=p.id and p.tipo = ?;";
			  if(tipo.equals("tutti"))
			  {
				  query="select * from prodotti as p ,brand as b, media as m where p.id_brand=b.id and m.id_prodotto=p.id";	
			  }
				  PreparedStatement ps = con.prepareStatement(query); 
				  if (tipo != null && !tipo.isEmpty()) {
					  if(!tipo.equals("tutti"))
					  {
						  ps.setString(1, tipo);
					  }
				  }
				 
				   ResultSet rs = ps.executeQuery();
		           List<prodotto> lista_prodotti = new ArrayList<>();
		           while (rs.next()) {
		            	prodotto p=new prodotto();
		            	p.setId(rs.getString(1));
		            	p.setNome(rs.getString(2));
		            	p.setTipo(rs.getString(3));
		            	p.setDescrizione(rs.getString(4));
		                p.setData_rilascio(rs.getString(5));
		                p.setPrezzo(rs.getString(6));
		                //idbrand
		                //id
		                p.setBrand(rs.getString(9));
		                //percorsologo
		                p.setPercorso(rs.getString(11));
		                lista_prodotti.add(p);
		            }
			 
		           return lista_prodotti;
			  
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		  }

	 
	 /*PRENDI UN DETERMINATO PRODOTTO DALL' ID */
	 public prodotto getSelectedProdotto(String id) {
		  
		 try (Connection con = ConPool.getConnection()) {
			PreparedStatement ps = con.prepareStatement
			("select * from prodotti as p ,brand as b, media as m where p.id_brand=b.id and m.id_prodotto=p.id and p.id=?;"); 
			   ps.setString(1, id);
			   ResultSet rs = ps.executeQuery();
	           prodotto p = new prodotto();
	           while (rs.next()) {
	            	p.setId(rs.getString(1));
	            	p.setNome(rs.getString(2));
	            	p.setTipo(rs.getString(3));
	            	p.setDescrizione(rs.getString(4));
	                p.setData_rilascio(rs.getString(5));
	                p.setPrezzo(rs.getString(6));
	                p.setId_brand(rs.getString(7));
	                //id
	                p.setBrand(rs.getString(9));
	                //percorsologo
	                p.setPercorso(rs.getString(11));
	            }
	           return p;
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		  }

	 
	 /*RITORNA IL TIPO DI PRODOTTO DATO L'ID */
	 public String getTipoProdottoById(String id) {
		  
		 try (Connection con = ConPool.getConnection()) {
			PreparedStatement ps = con.prepareStatement
			("SELECT tipo FROM prodotti WHERE id=?"); 
			   ps.setString(1, id);
			   ResultSet rs = ps.executeQuery();
	           rs.next();
	           return rs.getString("tipo");
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		  }
	 
	/*PRENDI TUTTI I PRODOTTI DI UN BRAND */
	 public List<prodotto>  getBrandProdotti(String brand) {
		  
		 try (Connection con = ConPool.getConnection()) {
			PreparedStatement ps = con.prepareStatement
					("SELECT p.id AS id_prodotto, b.nome AS nome_brand, p.tipo, p.nome AS nome_prodotto, p.prezzo, m.percorso " +
                    "FROM prodotti AS p " +
                    "JOIN brand AS b ON p.id_brand = b.id " +
                    "JOIN media AS m ON m.id_prodotto = p.id " +
                    "WHERE b.id = ?"); 
			   ps.setString(1, brand);
	           ResultSet rs = ps.executeQuery();
	           List<prodotto> lista_prodotti = new ArrayList<>();
	           while (rs.next()) {
	            	prodotto p=new prodotto();
	            	p.setId(rs.getString(1));
	            	p.setBrand(rs.getString(2));
	            	p.setTipo(rs.getString(3));
	            	p.setNome(rs.getString(4));
	            	p.setPrezzo(rs.getString(5));
	            	p.setPercorso(rs.getString(6));

	                lista_prodotti.add(p);
	            }
	           return lista_prodotti;
	        } catch (SQLException e) {
	            throw new RuntimeException(e);
	        }
		  }
}



