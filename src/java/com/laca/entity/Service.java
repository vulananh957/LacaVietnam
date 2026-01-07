package com.laca.entity;

import java.math.BigDecimal;

/**
 * Service Entity - Represents a travel service (FLIGHT, HOTEL, ACTIVITY)
 * Maps to Services table in database
 */
public record Service(
    int id,
    int destId,
    int supplierId,
    String type,
    String name,
    BigDecimal basePrice,
    String currency,
    double rating,
    String description,
    String attributesJson,
    String imageUrl
) {
    // Constructor for creating without ID
    public Service(int destId, int supplierId, String type, String name, 
                   BigDecimal basePrice, String attributesJson) {
        this(0, destId, supplierId, type, name, basePrice, "VND", 5.0, null, attributesJson, null);
    }
}
