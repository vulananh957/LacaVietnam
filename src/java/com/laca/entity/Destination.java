package com.laca.entity;

/**
 * Destination Entity - Represents a tourist destination in Vietnam
 * Maps to Destinations table in database
 */
public record Destination(
    int id,
    String name,
    String slug,
    String region,
    String thumbnailUrl,
    String overview
) {
    // Constructor for creating without ID
    public Destination(String name, String slug, String region, String thumbnailUrl, String overview) {
        this(0, name, slug, region, thumbnailUrl, overview);
    }
}
