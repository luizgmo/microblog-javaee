// CadastroForm.java
package edu.ifsp.microblog.controllers.usuario;

public record CadastroForm(
        String username,
        String email,
        String senha,
        String nomeExibicao,
        String bio,
        String fotoPerfil) { }