package edu.ifsp.microblog.modelo;

import java.util.Date;

public class Post {

    private int id;
    private String conteudo;
    private String fotoUrl;
    private Date dataHora;
    private Usuario autor;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getConteudo() { return conteudo; }
    public void setConteudo(String conteudo) { this.conteudo = conteudo; }

    public String getFotoUrl() { return fotoUrl; }
    public void setFotoUrl(String fotoUrl) { this.fotoUrl = fotoUrl; }

    public Date getDataHora() { return dataHora; }
    public void setDataHora(Date dataHora) { this.dataHora = dataHora; }

    public Usuario getAutor() { return autor; }
    public void setAutor(Usuario autor) { this.autor = autor; }
}