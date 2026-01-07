package com.laca.dao;

import com.laca.conf.DBContext;
import com.laca.entity.Destination;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DestinationDAO - Data Access Object for Destinations table
 * Pure JDBC implementation
 */
public class DestinationDAO {
    
    /**
     * Get destination by slug
     * Used to fetch background wallpaper for UI
     * @param slug Destination slug (e.g., "ha-noi", "da-nang")
     * @return Destination object or null
     */
    public Destination getBySlug(String slug) {
        String sql = "SELECT dest_id, name, slug, region, thumbnail_url, overview " +
                    "FROM Destinations WHERE slug = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, slug);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToDestination(rs);
            }
        } catch (SQLException e) {
            System.err.println("Get destination by slug error: " + e.getMessage());
        }
        return null;
    }
    
    /**
     * Get all destinations
     * @return List of destinations
     */
    public List<Destination> getAllDestinations() {
        List<Destination> destinations = new ArrayList<>();
        String sql = "SELECT dest_id, name, slug, region, thumbnail_url, overview " +
                    "FROM Destinations ORDER BY name";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                destinations.add(mapResultSetToDestination(rs));
            }
        } catch (SQLException e) {
            System.err.println("Get all destinations error: " + e.getMessage());
        }
        return destinations;
    }
    
    /**
     * Get destinations by region
     * @param region Region name (Miền Bắc, Miền Trung, Miền Nam)
     * @return List of destinations
     */
    public List<Destination> getByRegion(String region) {
        List<Destination> destinations = new ArrayList<>();
        String sql = "SELECT dest_id, name, slug, region, thumbnail_url, overview " +
                    "FROM Destinations WHERE region = ? ORDER BY name";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, region);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                destinations.add(mapResultSetToDestination(rs));
            }
        } catch (SQLException e) {
            System.err.println("Get destinations by region error: " + e.getMessage());
        }
        return destinations;
    }
    
    /**
     * Map ResultSet to Destination object
     */
    private Destination mapResultSetToDestination(ResultSet rs) throws SQLException {
        return new Destination(
            rs.getInt("dest_id"),
            rs.getString("name"),
            rs.getString("slug"),
            rs.getString("region"),
            rs.getString("thumbnail_url"),
            rs.getString("overview")
        );
    }
}
