package model.object;

public class utente {
	
	private String nome;
	private String cognome;
	private String telefono;
	private String email;
	private String psw;
	private String provincia;
	private String citta;
	private String cap;
	private String via;
	private String nciv;
	
	public utente() {
		super();
		this.nome = "";
		this.cognome = "";
		this.email = "";
		this.psw = "";
	}
	
	
	
	public utente(String nome, String cognome, String email, String psw) {
		super();
		this.nome = nome;
		this.cognome = cognome;
		this.email = email;
		this.psw = psw;
	}
	
	public utente(String nome, String cognome, String email, String telefono, String psw, String provincia, String citta, String cap, String via, String nciv) {
		super();
		this.nome = nome;
		this.cognome = cognome;
		this.email = email;
		this.psw = psw;
		this.telefono = telefono;
		this.provincia = provincia;
		this.citta = citta;
		this.cap = cap;
		this.via = via;
		this.nciv = nciv;
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



	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPsw() {
		return psw;
	}
	public void setPsw(String psw) {
		this.psw = psw;
	}



	public String getTelefono() {
		return telefono;
	}



	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}



	public String getProvincia() {
		return provincia;
	}



	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}



	public String getCitta() {
		return citta;
	}



	public void setCitta(String citta) {
		this.citta = citta;
	}



	public String getCap() {
		return cap;
	}



	public void setCap(String cap) {
		this.cap = cap;
	}



	public String getNciv() {
		return nciv;
	}



	public void setNciv(String nciv) {
		this.nciv = nciv;
	}



	public String getVia() {
		return via;
	}



	public void setVia(String via) {
		this.via = via;
	}
	
	
	
}
