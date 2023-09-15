package model.object;

public class brand {
	private String id;
	private String nome;
	private String percorso;
	
	public brand() {
		this.id = "";
		this.nome = "";
		this.percorso = "";
	}

	public brand(String id, String nome, String percorso) {
		super();
		this.id = id;
		this.nome = nome;
		this.percorso = percorso;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getPercorso() {
		return percorso;
	}

	public void setPercorso(String percorso) {
		this.percorso = percorso;
	}
	
	
}
