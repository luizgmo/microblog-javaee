package edu.ifsp.microblog.service;

import edu.ifsp.microblog.controllers.usuario.CadastroForm;
import edu.ifsp.microblog.modelo.Usuario;
import edu.ifsp.microblog.persistencia.SeguidorDAO;
import edu.ifsp.microblog.persistencia.UsuarioDAO;

public class UsuarioService {
    private UsuarioDAO usuarioDAO = new UsuarioDAO();
    private SeguidorDAO seguidorDAO = new SeguidorDAO();

    /* Autentica usuario por email e senha; retorna null se invalido */
    public Usuario login(String email, String senha) {
        Usuario usuario = usuarioDAO.findByEmail(email);
        if (usuario != null && usuario.getSenha().equals(senha)) {
            return usuario;
        }
        return null;
    }

    /* Cadastra novo usuario; lanca excecao se username ou email ja existirem */
    public Usuario cadastrar(CadastroForm form) {
        if (usuarioDAO.findByUsername(form.username()) != null) {
            throw new IllegalArgumentException("Username já está em uso.");
        }
        if (usuarioDAO.findByEmail(form.email()) != null) {
            throw new IllegalArgumentException("E-mail já está em uso.");
        }

        Usuario usuario = new Usuario();
        usuario.setUsername(form.username());
        usuario.setEmail(form.email());
        usuario.setSenha(form.senha());
        usuario.setNomeExibicao(form.nomeExibicao());
        usuario.setBio(form.bio());
        usuario.setFotoPerfil(form.fotoPerfil());

        return usuarioDAO.save(usuario);
    }

    /* Retorna perfil completo de um usuario pelo username */
    public PerfilDTO getPerfil(String username, int usuarioLogadoId) {
        Usuario usuario = usuarioDAO.findByUsername(username);
        if (usuario == null) {
            return null;
        }

        int seguidores = usuarioDAO.countSeguidores(usuario.getId());
        int seguindo   = usuarioDAO.countSeguindo(usuario.getId());
        boolean jaSeguindo = seguidorDAO.isFollowing(usuarioLogadoId, usuario.getId());

        return new PerfilDTO(usuario, seguidores, seguindo, jaSeguindo);
    }

    /* Segue ou deixa de seguir um usuario */
    public void toggleFollow(int seguidorId, int seguidoId) {
        if (seguidorDAO.isFollowing(seguidorId, seguidoId)) {
            seguidorDAO.unfollow(seguidorId, seguidoId);
        } else {
            seguidorDAO.follow(seguidorId, seguidoId);
        }
    }
}