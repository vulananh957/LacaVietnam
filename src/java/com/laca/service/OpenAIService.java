package com.laca.service;

import com.laca.conf.EnvConfig;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

/**
 * OpenAI Service - AI Brain of the application
 * Handles conversation with GPT-5 mini model and returns structured JSON
 * SECURITY: API key loaded from .env file (never hardcoded!)
 */
public class OpenAIService {
    
    // Load from environment configuration
    private static final String API_KEY = EnvConfig.get("OPENAI_API_KEY");
    private static final String API_URL = "https://api.openai.com/v1/chat/completions";
    private static final String MODEL = EnvConfig.get("OPENAI_MODEL", "gpt-5-mini");
    
    /**
     * System prompt that enforces JSON output format
     * CRITICAL: Forces AI to return structured data for code to parse
     */
    private static final String SYSTEM_PROMPT = """
        You are Laca, an AI travel assistant specializing in Vietnam tourism.
        You help users plan trips to 24 famous destinations in Vietnam.
        
        IMPORTANT: You MUST respond ONLY with valid JSON in this exact format:
        {
            "reply": "Your friendly response here",
            "intent": "PLAN_TRIP|ASK_INFO|BOOK_SERVICE|GENERAL_CHAT",
            "visual_slug": "ha-noi|da-nang|hoi-an|etc (or null)",
            "slots": {
                "destination": "string or null",
                "startDate": "YYYY-MM-DD or null",
                "endDate": "YYYY-MM-DD or null",
                "numberOfPeople": "integer or null",
                "budget": "string or null",
                "serviceType": "FLIGHT|HOTEL|ACTIVITY or null"
            }
        }
        
        Rules:
        - Do NOT use markdown formatting or code blocks
        - Do NOT explain your response, just return the JSON
        - Be friendly and enthusiastic about Vietnam tourism
        - If user mentions a destination, set visual_slug to its slug (e.g., "Hà Nội" -> "ha-noi")
        - Extract information into slots for processing
        - If missing critical info (dates, people count), ask naturally in reply
        """;
    
    /**
     * Send message to OpenAI and get structured response
     * @param userMessage User's message
     * @param conversationHistory Previous messages (optional)
     * @return Map containing reply, intent, visual_slug, and slots
     */
    public Map<String, Object> chat(String userMessage, String conversationHistory) {
        // Validate API key
        if (!EnvConfig.hasApiKey()) {
            System.err.println("⚠️ OpenAI API key not configured!");
            Map<String, Object> error = new HashMap<>();
            error.put("reply", "Xin lỗi, hệ thống chưa được cấu hình API key. Vui lòng kiểm tra file .env");
            error.put("intent", "ERROR");
            error.put("visual_slug", null);
            error.put("slots", new HashMap<>());
            return error;
        }
        
        try {
            // Build request
            JsonObject requestBody = buildRequestBody(userMessage, conversationHistory);
            
            // Send HTTPS POST request
            String responseJson = sendPostRequest(requestBody.toString());
            
            // Parse OpenAI response
            JsonObject aiResponse = JsonParser.parseString(responseJson).getAsJsonObject();
            String content = aiResponse
                .getAsJsonArray("choices")
                .get(0).getAsJsonObject()
                .getAsJsonObject("message")
                .get("content").getAsString();
            
            // Parse the structured JSON from AI
            return parseAIResponse(content);
            
        } catch (Exception e) {
            System.err.println("OpenAI API error: " + e.getMessage());
            e.printStackTrace();
            return getFallbackResponse();
        }
    }
    
    /**
     * Build OpenAI API request body
     */
    private JsonObject buildRequestBody(String userMessage, String history) {
        JsonObject body = new JsonObject();
        body.addProperty("model", MODEL);
        body.addProperty("temperature", 0.7);
        
        JsonArray messages = new JsonArray();
        
        // System message
        JsonObject systemMsg = new JsonObject();
        systemMsg.addProperty("role", "system");
        systemMsg.addProperty("content", SYSTEM_PROMPT);
        messages.add(systemMsg);
        
        // Add conversation history if exists
        if (history != null && !history.isEmpty()) {
            // Parse and add history messages
            // Simplified version - in production, properly parse history
        }
        
        // User message
        JsonObject userMsg = new JsonObject();
        userMsg.addProperty("role", "user");
        userMsg.addProperty("content", userMessage);
        messages.add(userMsg);
        
        body.add("messages", messages);
        return body;
    }
    
    /**
     * Send HTTPS POST request to OpenAI API
     */
    private String sendPostRequest(String jsonBody) throws Exception {
        URL url = new URL(API_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        
        // Set headers
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Authorization", "Bearer " + API_KEY);
        conn.setDoOutput(true);
        
        // Send request
        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = jsonBody.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }
        
        // Read response
        int responseCode = conn.getResponseCode();
        if (responseCode != 200) {
            throw new RuntimeException("OpenAI API returned code: " + responseCode);
        }
        
        StringBuilder response = new StringBuilder();
        try (BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
        }
        
        return response.toString();
    }
    
    /**
     * Parse AI's JSON response into Map
     */
    private Map<String, Object> parseAIResponse(String content) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            JsonObject json = JsonParser.parseString(content).getAsJsonObject();
            
            result.put("reply", json.get("reply").getAsString());
            result.put("intent", json.get("intent").getAsString());
            result.put("visual_slug", 
                json.has("visual_slug") && !json.get("visual_slug").isJsonNull() 
                    ? json.get("visual_slug").getAsString() : null);
            
            // Parse slots
            if (json.has("slots")) {
                Map<String, Object> slots = new HashMap<>();
                JsonObject slotsObj = json.getAsJsonObject("slots");
                
                slotsObj.entrySet().forEach(entry -> {
                    if (!entry.getValue().isJsonNull()) {
                        slots.put(entry.getKey(), entry.getValue().getAsString());
                    }
                });
                
                result.put("slots", slots);
            }
            
        } catch (Exception e) {
            System.err.println("Failed to parse AI response: " + e.getMessage());
            return getFallbackResponse();
        }
        
        return result;
    }
    
    /**
     * Fallback response when API fails
     */
    private Map<String, Object> getFallbackResponse() {
        Map<String, Object> response = new HashMap<>();
        response.put("reply", "Xin lỗi, hệ thống đang gặp sự cố. Vui lòng thử lại sau.");
        response.put("intent", "GENERAL_CHAT");
        response.put("visual_slug", null);
        response.put("slots", new HashMap<>());
        return response;
    }
}
