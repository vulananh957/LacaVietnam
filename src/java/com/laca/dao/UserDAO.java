package com.laca.dao;

import com.laca.conf.DBContext;
import com.laca.entity.User;
import java.sql.*;
import java.time.LocalDateTime;

/**
 * UserDAO - Data Access Object for Users table
 * Pure JDBC implementation
 */
public class UserDAO {
    
    /**
     * Authenticate user login
     * @param username Username
     * @param password Plain text password (will be hashed in production)
     * @return User object if successful, null otherwise
     */
    public User login(String username, String password) {
        String sql = "SELECT user_id, username, email, password_hash, full_name, role, " +
                    "phone_number, avatar_url, created_at, updated_at " +
                    "FROM Users WHERE username = ? AND password_hash = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, password); // In production, hash this first
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        } catch (SQLException e) {
            System.err.println("Login error: " + e.getMessage());
        }
        return null;
    }
    
    /**
     * Register a new user
     * @param user User object
     * @return true if successful
     */
    public boolean register(User user) {
        String sql = "INSERT INTO Users (username, email, password_hash, full_name, role) " +
                    "VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.username());
            ps.setString(2, user.email());
            ps.setString(3, user.passwordHash());
            ps.setString(4, user.fullName());
            ps.setString(5, user.role());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Registration error: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Get user by ID
     * @param userId User ID
     * @return User object or null
     */
    public User getUserById(int userId) {
        String sql = "SELECT user_id, username, email, password_hash, full_name, role, " +
                    "phone_number, avatar_url, created_at, updated_at " +
                    "FROM Users WHERE user_id = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        } catch (SQLException e) {
            System.err.println("Get user error: " + e.getMessage());
        }
        return null;
    }
    
    /**
     * Map ResultSet to User object
     */
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        return new User(
            rs.getInt("user_id"),
            rs.getString("username"),
            rs.getString("email"),
            rs.getString("password_hash"),
            rs.getString("full_name"),
            rs.getString("role"),
            rs.getString("phone_number"),
            rs.getString("avatar_url"),
            rs.getTimestamp("created_at") != null ? 
                rs.getTimestamp("created_at").toLocalDateTime() : null,
            rs.getTimestamp("updated_at") != null ? 
                rs.getTimestamp("updated_at").toLocalDateTime() : null
        );
    }
}
