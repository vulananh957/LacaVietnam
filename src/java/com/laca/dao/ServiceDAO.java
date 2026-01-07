package com.laca.dao;

import com.laca.conf.DBContext;
import com.laca.entity.Service;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

/**
 * ServiceDAO - Data Access Object for Services table
 * Pure JDBC implementation with Mock Real-Time Pricing Engine
 */
public class ServiceDAO {
    
    /**
     * Search services by destination slug
     * CRITICAL: Implements Mock Pricing Engine (base * 0.95-1.15)
     * CRITICAL: Handles null image paths with default fallback
     * @param destSlug Destination slug
     * @return List of services with dynamic pricing
     */
    public List<Map<String, Object>> searchServices(String destSlug) {
        List<Map<String, Object>> services = new ArrayList<>();
        
        String sql = "SELECT s.service_id, s.type, s.name, s.base_price, s.currency, " +
                    "s.rating, s.description, s.attributes_json, " +
                    "si.image_url, sp.name as supplier_name, sp.logo_url, " +
                    "d.name as dest_name, d.slug " +
                    "FROM Services s " +
                    "INNER JOIN Destinations d ON s.dest_id = d.dest_id " +
                    "LEFT JOIN Suppliers sp ON s.supplier_id = sp.supplier_id " +
                    "LEFT JOIN ServiceImages si ON s.service_id = si.service_id AND si.is_main = 1 " +
                    "WHERE d.slug = ? " +
                    "ORDER BY s.rating DESC, s.type";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, destSlug);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> service = new HashMap<>();
                
                // Basic info
                service.put("id", rs.getInt("service_id"));
                service.put("type", rs.getString("type"));
                service.put("name", rs.getString("name"));
                service.put("rating", rs.getDouble("rating"));
                service.put("description", rs.getString("description"));
                service.put("supplierName", rs.getString("supplier_name"));
                service.put("supplierLogo", rs.getString("logo_url"));
                service.put("destName", rs.getString("dest_name"));
                
                // CRITICAL: Mock Real-Time Pricing Engine
                BigDecimal basePrice = rs.getBigDecimal("base_price");
                double randomFactor = 0.95 + (Math.random() * 0.2); // 0.95 to 1.15
                BigDecimal displayPrice = basePrice.multiply(BigDecimal.valueOf(randomFactor));
                
                service.put("basePrice", basePrice);
                service.put("displayPrice", displayPrice.setScale(0, BigDecimal.ROUND_HALF_UP));
                service.put("currency", rs.getString("currency"));
                
                // CRITICAL: Handle null image paths with defaults
                String imageUrl = rs.getString("image_url");
                if (imageUrl == null || imageUrl.isEmpty()) {
                    String type = rs.getString("type");
                    imageUrl = getDefaultImagePath(type);
                }
                service.put("imageUrl", imageUrl);
                
                // Parse JSON attributes
                String attributesJson = rs.getString("attributes_json");
                service.put("attributes", attributesJson);
                
                services.add(service);
            }
        } catch (SQLException e) {
            System.err.println("Search services error: " + e.getMessage());
            e.printStackTrace();
        }
        
        return services;
    }
    
    /**
     * Get default image path based on service type
     * Handles missing images in database
     */
    private String getDefaultImagePath(String type) {
        return switch (type) {
            case "FLIGHT" -> "assets/images/defaults/flight_main.jpg";
            case "HOTEL" -> "assets/images/defaults/hotel_main.jpg";
            case "ACTIVITY" -> "assets/images/defaults/activity_main.jpg";
            default -> "assets/images/defaults/placeholder.jpg";
        };
    }
    
    /**
     * Get all services for a destination
     * @param destId Destination ID
     * @return List of Service objects
     */
    public List<Service> getServicesByDestination(int destId) {
        List<Service> services = new ArrayList<>();
        
        String sql = "SELECT s.service_id, s.dest_id, s.supplier_id, s.type, s.name, " +
                    "s.base_price, s.currency, s.rating, s.description, s.attributes_json, " +
                    "si.image_url " +
                    "FROM Services s " +
                    "LEFT JOIN ServiceImages si ON s.service_id = si.service_id AND si.is_main = 1 " +
                    "WHERE s.dest_id = ? " +
                    "ORDER BY s.type, s.rating DESC";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, destId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                services.add(mapResultSetToService(rs));
            }
        } catch (SQLException e) {
            System.err.println("Get services by destination error: " + e.getMessage());
        }
        
        return services;
    }
    
    /**
     * Get services by type (FLIGHT, HOTEL, ACTIVITY)
     * @param type Service type
     * @param destSlug Destination slug
     * @return List of services
     */
    public List<Map<String, Object>> getServicesByType(String type, String destSlug) {
        List<Map<String, Object>> services = searchServices(destSlug);
        services.removeIf(s -> !type.equals(s.get("type")));
        return services;
    }
    
    /**
     * Map ResultSet to Service object
     */
    private Service mapResultSetToService(ResultSet rs) throws SQLException {
        return new Service(
            rs.getInt("service_id"),
            rs.getInt("dest_id"),
            rs.getInt("supplier_id"),
            rs.getString("type"),
            rs.getString("name"),
            rs.getBigDecimal("base_price"),
            rs.getString("currency"),
            rs.getDouble("rating"),
            rs.getString("description"),
            rs.getString("attributes_json"),
            rs.getString("image_url")
        );
    }
}
