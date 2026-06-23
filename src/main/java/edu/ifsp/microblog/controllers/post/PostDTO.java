package edu.ifsp.microblog.controllers.post;

import java.util.Date;

public record PostDTO(
        int id,
        String conteudo,
        String fotoUrl,
        Date dataHora,
        String autorUsername,
        String autorNomeExibicao,
        String autorFotoPerfil) { }