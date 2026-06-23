package edu.ifsp.microblog.service;

import java.util.List;

import edu.ifsp.microblog.controllers.post.NovoPostForm;
import edu.ifsp.microblog.controllers.post.PostDTO;
import edu.ifsp.microblog.modelo.Post;
import edu.ifsp.microblog.modelo.Usuario;
import edu.ifsp.microblog.persistencia.PostDAO;

public class PostService {
    private PostDAO postDAO = new PostDAO();

    /* Publica novo post */
    public void publicar(NovoPostForm form, int autorId) {
        if (form.conteudo() == null || form.conteudo().isBlank()) {
            throw new IllegalArgumentException("O conteúdo do post não pode ser vazio.");
        }
        if (form.conteudo().length() > 280) {
            throw new IllegalArgumentException("Post excede 280 caracteres.");
        }

        Usuario autor = new Usuario();
        autor.setId(autorId);

        Post post = new Post();
        post.setConteudo(form.conteudo());
        post.setFotoUrl(form.fotoUrl());
        post.setAutor(autor);

        postDAO.save(post);
    }

    /* Retorna feed paginado do usuario */
    public List<PostDTO> getFeed(int usuarioId, int page, int pageSize) {
        return postDAO.findFeedPaged(usuarioId, page, pageSize)
                .stream()
                .map(this::toDTO)
                .toList();
    }

    /* Retorna posts paginados de um perfil */
    public List<PostDTO> getPostsDoPerfil(int autorId, int page, int pageSize) {
        return postDAO.findByAutorPaged(autorId, page, pageSize)
                .stream()
                .map(this::toDTO)
                .toList();
    }

    /* Calcula total de paginas para os posts de um autor */
    public int totalPaginas(int autorId, int pageSize) {
        int total = postDAO.countByAutor(autorId);
        return (int) Math.ceil((double) total / pageSize);
    }

    private PostDTO toDTO(Post p) {
        return new PostDTO(
                p.getId(),
                p.getConteudo(),
                p.getFotoUrl(),
                p.getDataHora(),
                p.getAutor().getUsername(),
                p.getAutor().getNomeExibicao(),
                p.getAutor().getFotoPerfil());
    }
}