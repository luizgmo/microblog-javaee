package edu.ifsp.microblog.persistencia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SeguidorDAO {

    /* Verifica se seguidorId ja segue seguidoId */
    public boolean isFollowing(int seguidorId, int seguidoId) {
        try {
            Connection conn = DatabaseConnector.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM seguidor WHERE seguidor_id = ? AND seguido_id = ?");
            ps.setInt(1, seguidorId);
            ps.setInt(2, seguidoId);
            ResultSet rs = ps.executeQuery();
            rs.next();
            boolean result = rs.getInt(1) > 0;
            rs.close(); ps.close(); conn.close();
            return result;
        } catch (SQLException e) {
            throw new DataAccessException(e);
        }
    }

    /* Segue um usuario — usa transacao explicita igual ao PedidoDAO */
    public void follow(int seguidorId, int seguidoId) {
        try {
            Connection conn = DatabaseConnector.getConnection();
            conn.setAutoCommit(false);
            try {
                PreparedStatement ps = conn.prepareStatement(
                        "INSERT INTO seguidor (seguidor_id, seguido_id) VALUES (?, ?)");
                ps.setInt(1, seguidorId);
                ps.setInt(2, seguidoId);
                ps.executeUpdate();
                conn.commit();
                ps.close();
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.close();
            }
        } catch (SQLException e) {
            throw new DataAccessException(e);
        }
    }

    /* Deixa de seguir um usuario — usa transacao explicita */
    public void unfollow(int seguidorId, int seguidoId) {
        try {
            Connection conn = DatabaseConnector.getConnection();
            conn.setAutoCommit(false);
            try {
                PreparedStatement ps = conn.prepareStatement(
                        "DELETE FROM seguidor WHERE seguidor_id = ? AND seguido_id = ?");
                ps.setInt(1, seguidorId);
                ps.setInt(2, seguidoId);
                ps.executeUpdate();
                conn.commit();
                ps.close();
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.close();
            }
        } catch (SQLException e) {
            throw new DataAccessException(e);
        }
    }
}