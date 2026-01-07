package com.laca.utils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonSyntaxException;
import java.lang.reflect.Type;

/**
 * JSON Utility class - Wrapper for Gson library
 * Centralizes all JSON serialization/deserialization logic
 */
public class JsonUtils {
    
    private static final Gson gson = new GsonBuilder()
            .setPrettyPrinting()
            .serializeNulls()
            .create();
    
    /**
     * Convert Java object to JSON string
     * @param obj Object to serialize
     * @return JSON string
     */
    public static String toJson(Object obj) {
        if (obj == null) {
            return "null";
        }
        return gson.toJson(obj);
    }
    
    /**
     * Parse JSON string to Java object
     * @param json JSON string
     * @param classOfT Target class type
     * @return Deserialized object
     */
    public static <T> T fromJson(String json, Class<T> classOfT) {
        if (json == null || json.trim().isEmpty()) {
            return null;
        }
        try {
            return gson.fromJson(json, classOfT);
        } catch (JsonSyntaxException e) {
            System.err.println("JSON parsing error: " + e.getMessage());
            return null;
        }
    }
    
    /**
     * Parse JSON string to Java object with Type
     * Useful for generic collections
     * @param json JSON string
     * @param typeOfT Target type
     * @return Deserialized object
     */
    public static <T> T fromJson(String json, Type typeOfT) {
        if (json == null || json.trim().isEmpty()) {
            return null;
        }
        try {
            return gson.fromJson(json, typeOfT);
        } catch (JsonSyntaxException e) {
            System.err.println("JSON parsing error: " + e.getMessage());
            return null;
        }
    }
}
