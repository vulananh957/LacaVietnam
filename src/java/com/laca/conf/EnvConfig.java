package com.laca.conf;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Environment Configuration - Load sensitive data from .env file
 * SECURITY: API keys and credentials should NEVER be hardcoded in source code
 */
public class EnvConfig {
    
    private static Properties properties = new Properties();
    private static boolean loaded = false;
    
    static {
        loadConfig();
    }
    
    /**
     * Load configuration from .env file or environment variables
     */
    private static void loadConfig() {
        try {
            // Try to load from .env file first
            String envPath = System.getProperty("user.dir") + "/.env";
            try (InputStream input = new FileInputStream(envPath)) {
                properties.load(input);
                loaded = true;
                System.out.println("✅ Loaded configuration from .env file");
            } catch (IOException e) {
                System.out.println("⚠️ .env file not found, using environment variables or defaults");
            }
            
            // Fallback to system environment variables
            if (!loaded || properties.isEmpty()) {
                loadFromEnvironment();
            }
            
        } catch (Exception e) {
            System.err.println("❌ Error loading configuration: " + e.getMessage());
        }
    }
    
    /**
     * Load from system environment variables
     */
    private static void loadFromEnvironment() {
        // Database
        properties.setProperty("DB_URL", 
            System.getenv().getOrDefault("DB_URL", 
            "jdbc:sqlserver://localhost:1433;databaseName=LacaVietnamDB;encrypt=true;trustServerCertificate=true;"));
        properties.setProperty("DB_USER", 
            System.getenv().getOrDefault("DB_USER", "sa"));
        properties.setProperty("DB_PASSWORD", 
            System.getenv().getOrDefault("DB_PASSWORD", "sa"));
        
        // OpenAI
        properties.setProperty("OPENAI_API_KEY", 
            System.getenv().getOrDefault("OPENAI_API_KEY", ""));
        properties.setProperty("OPENAI_MODEL", 
            System.getenv().getOrDefault("OPENAI_MODEL", "gpt-5-mini"));
    }
    
    /**
     * Get configuration value
     */
    public static String get(String key) {
        return properties.getProperty(key);
    }
    
    /**
     * Get configuration value with default
     */
    public static String get(String key, String defaultValue) {
        return properties.getProperty(key, defaultValue);
    }
    
    /**
     * Check if API key is configured
     */
    public static boolean hasApiKey() {
        String key = get("OPENAI_API_KEY");
        return key != null && !key.isEmpty() && !key.equals("YOUR_OPENAI_API_KEY");
    }
}
