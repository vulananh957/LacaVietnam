package com.laca.entity;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Trip Entity - Represents a travel plan/booking
 * Maps to Trips table in database
 */
public record Trip(
    int id,
    int userId,
    String tripName,
    LocalDate startDate,
    LocalDate endDate,
    int numberOfPeople,
    BigDecimal totalPrice,
    String status,
    LocalDateTime createdAt
) {
    // Constructor for creating new trip draft
    public Trip(int userId, String tripName, LocalDate startDate, LocalDate endDate, int numberOfPeople) {
        this(0, userId, tripName, startDate, endDate, numberOfPeople, BigDecimal.ZERO, "DRAFT", null);
    }
}
