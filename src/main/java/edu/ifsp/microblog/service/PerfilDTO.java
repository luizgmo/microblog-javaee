package edu.ifsp.microblog.service;

import edu.ifsp.microblog.modelo.Usuario;

public record PerfilDTO(Usuario usuario, int seguidores, int seguindo, boolean jaSeguindo) { }