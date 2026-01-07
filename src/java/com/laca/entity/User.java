package com.laca.entity;

import java.time.LocalDateTime;

/**
 * User Entity - Immutable record representing a user in the system
 * Maps to Users table in database
 */
public record User(
    int id,
    String username,
    String email,
    String passwordHash,
    String fullName,
    String role,
    String phoneNumber,
    String avatarUrl,
    LocalDateTime createdAt,
    LocalDateTime updatedAt
) {
    // Constructor for creating new users (without ID and timestamps)
    public User(String username, String email, String passwordHash, String fullName, String role) {
        this(0, username, email, passwordHash, fullName, role, null, null, null, null);
    }
}
