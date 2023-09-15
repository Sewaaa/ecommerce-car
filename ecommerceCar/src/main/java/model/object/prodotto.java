package model.object;

public class prodotto {
		private String id;
		private String tipo;
		private String nome;
		private String descrizione;
		private String data_rilascio;
		private String prezzo;
		private String brand; 
		private String id_brand;
		private String colore; //memorizza nome colore   (per sapere il suo id si usa personalizzazioneDAO nameToId)
	    private String interni; //memorizza nome interni
	    private String ruote; 	//memorizza nome ruote  
	    private String percorso;
	    private String idcarrello;
	    private int quantita = 0;
	    
		public prodotto() {
			this.id = "";
			this.tipo = "";
			this.nome = "";
			this.descrizione = "";
			this.data_rilascio = "";
			this.prezzo = "";
			this.brand = "";
			this.colore = "";
			this.interni = "";
			this.ruote = "";
			this.percorso = "";
			this.idcarrello = "";
			this.id_brand= "";
		}
	    
	    public prodotto(String id, String tipo, String nome, String descrizione, String data_rilascio, String prezzo,
				String brand, String colore, String ruote, String interni, String percorso) {
			super();
			this.id = id;
			this.tipo = tipo;
			this.nome = nome;
			this.descrizione = descrizione;
			this.data_rilascio = data_rilascio;
			this.prezzo = prezzo;
			this.brand = brand;
			this.colore = colore;
			this.interni = interni;
			this.ruote = ruote;
			this.percorso = percorso;
		}
	  
	    public String getIdcarrello() {
			return idcarrello;
		}

		public void setIdcarrello(String idcarrello) {
			this.idcarrello = idcarrello;
		}

		public prodotto(String id, String colore, String ruote, String interni, String tipo) {
			super();
			this.id = id;
			this.tipo = tipo;
			this.colore = colore;
			this.interni = interni;
			this.ruote = ruote;
		}
	    
	    public prodotto(String id, String tipo) {
			super();
			this.id = id;
			this.tipo = tipo;
		}
	    
		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getTipo() {
			return tipo;
		}

		public void setTipo(String tipo) {
			this.tipo = tipo;
		}

		public String getNome() {
			return nome;
		}

		public void setNome(String nome) {
			this.nome = nome;
		}

		public String getDescrizione() {
			return descrizione;
		}

		public void setDescrizione(String descrizione) {
			this.descrizione = descrizione;
		}

		public String getData_rilascio() {
			return data_rilascio;
		}

		public void setData_rilascio(String data_rilascio) {
			this.data_rilascio = data_rilascio;
		}

		public String getPrezzo() {
			return prezzo;
		}

		public void setPrezzo(String prezzo) {
			this.prezzo = prezzo;
		}

		public String getBrand() {
			return brand;
		}

		public void setBrand(String brand) {
			this.brand = brand;
		}

		public String getColore() {
			return colore;
		}

		public void setColore(String colore) {
			this.colore = colore;
		}

		public String getInterni() {
			return interni;
		}

		public void setInterni(String interni) {
			this.interni = interni;
		}

		public String getRuote() {
			return ruote;
		}

		public void setRuote(String ruote) {
			this.ruote = ruote;
		}

		public String getPercorso() {
			return percorso;
		}

		public void setPercorso(String percorso) {
			this.percorso = percorso;
		}

		public String getId_brand() {
			return id_brand;
		}

		public void setId_brand(String id_brand) {
			this.id_brand = id_brand;
		}

		public int getQuantita() {
			return quantita;
		}

		public void setQuantita(int quantita) {
			this.quantita = quantita;
		}

		public void addQuantita() {
			this.quantita++;
		}
		
		public void sottQuantita() {
			this.quantita--;
		}




	    
}