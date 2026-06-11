package edu.ifsp.microblog.persistencia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import edu.ifsp.microblog.modelo.Usuario;

public class UsuarioDAO {

    /* Busca usuario por id */
    public Usuario findById(int id) {
        try {
            Connection conn = DatabaseConnector.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT id, username, email, senha, nome_exibicao, bio, foto_perfil, data_cadastro "
                    + "FROM usuario WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            Usuario usuario = null;
            if (rs.next()) {
                usuario = mapRow(rs);
            }

            rs.close(); ps.close(); conn.close();
            return usuario;

        } catch (SQLException e) {
            throw new DataAccessException(e);
        }
    }

    /* Busca usuario por username */
    public Usuario findByUsername(String username) {
        try {
            Connection conn = DatabaseConnector.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT id, username, email, senha, nome_exibicao, bio, foto_perfil, data_cadastro "
                    + "FROM usuario WHERE username = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            Usuario usuario = null;
            if (rs.next()) {
                usuario = mapRow(rs);
            }

            rs.close(); ps.close(); conn.close();
            return usuario;

        } catch (SQLException e) {
            throw new DataAccessException(e);
        }
    }

    /* Busca usuario por email */
    public Usuario findByEmail(String email) {
        try {
            Connection conn = DatabaseConnector.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT id, username, email, senha, nome_exibicao, bio, foto_perfil, data_cadastro "
                    + "FROM usuario WHERE email = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            Usuario usuario = null;
            if (rs.next()) {
                usuario = mapRow(rs);
            }

            rs.close(); ps.close(); conn.close();
            return usuario;

        } catch (SQLException e) {
            throw new DataAccessException(e);
        }
    }

    /* Salva novo usuario e retorna com id gerado */
    public Usuario save(Usuario usuario) {
        try {
            Connection conn = DatabaseConnector.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO usuario (username, email, senha, nome_exibicao, bio, foto_perfil) "
                    + "VALUES (?, ?, ?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, usuario.getUsername());
            ps.setString(2, usuario.getEmail());
            ps.setString(3, usuario.getSenha());
            ps.setString(4, usuario.getNomeExibicao());
            ps.setString(5, usuario.getBio());
            ps.setString(6, usuario.getFotoPerfil());
            ps.executeUpdate();

            ResultSet keys = ps.getGeneratedKeys();
            keys.next();
            usuario.setId(keys.getInt(1));

            keys.close(); ps.close(); conn.close();
            return usuario;

        } catch (SQLException e) {
            throw new DataAccessException(e);
        }
    }

    /* Conta quantos seguidores um usuario tem */
    public int countSeguidores(int usuarioId) {
        try {
            Connection conn = DatabaseConnector.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM seguidor WHERE seguido_id = ?");
            ps.setInt(1, usuarioId);
            ResultSet rs = ps.executeQuery();
            rs.next();
            int count = rs.getInt(1);
            rs.close(); ps.close(); conn.close();
            return count;
        } catch (SQLException e) {
            throw new DataAccessException(e);
        }
    }

    /* Conta quantos usuarios um usuario segue */
    public int countSeguindo(int usuarioId) {
        try {
            Connection conn = DatabaseConnector.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM seguidor WHERE seguidor_id = ?");
            ps.setInt(1, usuarioId);
            ResultSet rs = ps.executeQuery();
            rs.next();
            int count = rs.getInt(1);
            rs.close(); ps.close(); conn.close();
            return count;
        } catch (SQLException e) {
            throw new DataAccessException(e);
        }
    }

    private Usuario mapRow(ResultSet rs) throws SQLException {
        Usuario u = new Usuario();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        u.setEmail(rs.getString("email"));
        u.setSenha(rs.getString("senha"));
        u.setNomeExibicao(rs.getString("nome_exibicao"));
        u.setBio(rs.getString("bio"));
        u.setFotoPerfil(rs.getString("foto_perfil"));
        u.setDataCadastro(rs.getTimestamp("data_cadastro"));
        return u;
    }
}