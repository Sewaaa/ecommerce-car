package model.object;

import java.util.ArrayList;


public class ordine {
	
	private String id;
	private String data_ordine;
	private String nome;
	private String cognome;
	private ArrayList<prodotto> prodotti;
	private utente utente;
	private String metodo_di_pagamento;
	private String prezzo_novia;
	private String prezzo_tot;
	

	/*per ordini dao (getAllOrdini)*/
	public ordine(String id, String data_ordine, String nome, String cognome, String email_utente, String prezzo_tot, String metodo_di_pagamento) {
		super();
		this.id = id;
		this.data_ordine = data_ordine;
		this.cognome = cognome;
		this.nome = nome;
		this.utente=new utente();
		this.utente.setEmail(email_utente); 
		this.metodo_di_pagamento = metodo_di_pagamento;
		this.prezzo_tot = prezzo_tot;
		this.prodotti =  new ArrayList<>();
	}



	public ordine(String data_ordine, ArrayList<prodotto> prodotti, model.object.utente utente, String prezzo_novia,
			String prezzo_tot) {
		super();
		this.data_ordine = data_ordine;
		this.prodotti = prodotti;
		this.utente = utente;
		this.prezzo_novia = prezzo_novia;
		this.prezzo_tot = prezzo_tot;
	}

	
	
	public ordine(String data_ordine, ArrayList<prodotto> prodotti, model.object.utente utente) {
		super();
		this.data_ordine = data_ordine;
		this.prodotti = prodotti;
		this.utente = utente;
	}



	public ordine() {
		super();
		this.data_ordine = "";
		this.prodotti =  new ArrayList<>();
		this.utente = new utente();
		this.prezzo_novia="";
		this.prezzo_tot="";
	}
	
	

	public String getPrezzo_novia() {
		return prezzo_novia;
	}

	public void setPrezzo_novia(String prezzo_novia) {
		this.prezzo_novia = prezzo_novia;
	}

	public String getPrezzo_tot() {
		return prezzo_tot;
	}

	public void setPrezzo_tot(String prezzo_tot) {
		this.prezzo_tot = prezzo_tot;
	}

	public String getData_ordine() {
		return data_ordine;
	}

	public void setData_ordine(String data_ordine) {
		this.data_ordine = data_ordine;
	}

	public ArrayList<prodotto> getProdotti() {
		return prodotti;
	}

	public void setProdotti(ArrayList<prodotto> prodotti) {
		this.prodotti = prodotti;
	}
	
	public void addProdotto(prodotto p) {
		this.prodotti.add(p);
	}

	public utente getUtente() {
		return utente;
	}

	public void setUtente(utente utente) {
		this.utente = utente;
	}
	
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}



	public String getMetodo_di_pagamento() {
		return metodo_di_pagamento;
	}



	public void setMetodo_di_pagamento(String metodo_di_pagamento) {
		this.metodo_di_pagamento = metodo_di_pagamento;
	}



	public String getNome() {
		return nome;
	}



	public void setNome(String nome) {
		this.nome = nome;
	}



	public String getCognome() {
		return cognome;
	}



	public void setCognome(String cognome) {
		this.cognome = cognome;
	}
	
	
	
}
