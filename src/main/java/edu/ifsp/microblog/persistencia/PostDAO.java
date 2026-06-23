package edu.ifsp.microblog.persistencia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import edu.ifsp.microblog.modelo.Post;
import edu.ifsp.microblog.modelo.Usuario;

public class PostDAO {

    /* Salva novo post e retorna com id gerado */
    public Post save(Post post) {
        try {
            Connection conn = DatabaseConnector.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO post (conteudo, foto_url, autor_id) VALUES (?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, post.getConteudo());
            ps.setString(2, post.getFotoUrl());
            ps.setInt(3, post.getAutor().getId());
            ps.executeUpdate();

            ResultSet keys = ps.getGeneratedKeys();
            keys.next();
            post.setId(keys.getInt(1));

            keys.close(); ps.close(); conn.close();
            return post;

        } catch (SQLException e) {
            throw new DataAccessException(e);
        }
    }

    /* Retorna posts de um usuario especifico com paginacao */
    public List<Post> findByAutorPaged(int autorId, int page, int pageSize) {
        List<Post> posts = new ArrayList<>();

        try {
            Connection conn = DatabaseConnector.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT p.id, p.conteudo, p.foto_url, p.data_hora, "
                    + "       u.id AS u_id, u.username, u.nome_exibicao, u.foto_perfil "
                    + "FROM post p "
                    + "JOIN usuario u ON u.id = p.autor_id "
                    + "WHERE p.autor_id = ? "
                    + "ORDER BY p.data_hora DESC "
                    + "LIMIT ?, ?");

            ps.setInt(1, autorId);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                posts.add(mapRow(rs));
            }

            rs.close(); ps.close(); conn.close();

        } catch (SQLException e) {
            throw new DataAccessException(e);
        }

        return posts;
    }

    /* Retorna o feed global: TODOS os posts cadastrados no banco, com paginação */
    public List<Post> findFeedPaged(int usuarioId, int page, int pageSize) {
        List<Post> posts = new ArrayList<>();

        try {
            Connection conn = DatabaseConnector.getConnection();
            
            // Query limpa: traz tudo associando com o autor correspondente
            String sql = "SELECT p.id, p.conteudo, p.foto_url, p.data_hora, "
                       + "       u.id AS u_id, u.username, u.nome_exibicao, u.foto_perfil "
                       + "FROM post p "
                       + "JOIN usuario u ON u.id = p.autor_id "
                       + "ORDER BY p.data_hora DESC "
                       + "LIMIT ?, ?";

            PreparedStatement ps = conn.prepareStatement(sql);

            // Como tiramos os filtros por ID, passamos direto os parâmetros de paginação
            ps.setInt(1, (page - 1) * pageSize); // OFFSET
            ps.setInt(2, pageSize);              // LIMIT

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                posts.add(mapRow(rs));
            }

            rs.close(); ps.close(); conn.close();

        } catch (SQLException e) {
            throw new DataAccessException(e);
        }

        return posts;
    }

    /* Conta total de posts de um autor (para calcular paginas) */
    public int countByAutor(int autorId) {
        try {
            Connection conn = DatabaseConnector.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM post WHERE autor_id = ?");
            ps.setInt(1, autorId);
            ResultSet rs = ps.executeQuery();
            rs.next();
            int count = rs.getInt(1);
            rs.close(); ps.close(); conn.close();
            return count;
        } catch (SQLException e) {
            throw new DataAccessException(e);
        }
    }

    private Post mapRow(ResultSet rs) throws SQLException {
        Post p = new Post();
        p.setId(rs.getInt("id"));
        p.setConteudo(rs.getString("conteudo"));
        p.setFotoUrl(rs.getString("foto_url"));
        p.setDataHora(rs.getTimestamp("data_hora"));

        Usuario autor = new Usuario();
        autor.setId(rs.getInt("u_id"));
        autor.setUsername(rs.getString("username"));
        autor.setNomeExibicao(rs.getString("nome_exibicao"));
        autor.setFotoPerfil(rs.getString("foto_perfil"));
        p.setAutor(autor);

        return p;
    }
}