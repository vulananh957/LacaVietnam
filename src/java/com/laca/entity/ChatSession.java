package com.laca.entity;

import java.time.LocalDateTime;

/**
 * ChatSession Entity - Represents an AI chat conversation context
 * Maps to ChatSessions table in database
 */
public record ChatSession(
    int id,
    Integer userId,
    String contextState,
    LocalDateTime createdAt,
    LocalDateTime lastInteraction
) {
    // Constructor for creating new session
    public ChatSession(Integer userId, String contextState) {
        this(0, userId, contextState, null, null);
    }
}
