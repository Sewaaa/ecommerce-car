package ecommerceCar;

public class prodotto {
		private String id;
		private String categoria;
	    private String colore;
	    private String interni;
	    private String ruote;

	    public prodotto(String id, String categoria) {
	    	this.id = id;
	    	this.categoria = categoria;
	        this.colore = "";
	        this.interni = "";
	        this.ruote = "";
	    }
	    
	    public prodotto(String id, String colore, String interni, String ruote, String categoria) {
	    	this.id = id;
	    	this.categoria = categoria;
	        this.colore = colore;
	        this.interni = interni;
	        this.ruote = ruote;
	    }

	    public String getId() {
	        return id;
	    }

	    public void setId(String id) {
	        this.id = id;
	    }
	    
	    public String getCategoria() {
	        return categoria;
	    }

	    public void setCategoria(String categoria) {
	        this.categoria = categoria;
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
}

