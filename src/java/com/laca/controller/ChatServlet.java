package com.laca.controller;

import com.laca.dao.DestinationDAO;
import com.laca.dao.ServiceDAO;
import com.laca.entity.Destination;
import com.laca.service.OpenAIService;
import com.laca.utils.JsonUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ChatServlet - The Core Controller
 * Orchestrates the conversation flow between User, AI, and Database
 * 
 * Workflow:
 * 1. Parse User JSON input
 * 2. Call OpenAIService to get AI response
 * 3. Based on AI intent, fetch data from ServiceDAO
 * 4. Construct final JSON response with ui_action
 */
@WebServlet(name = "ChatServlet", urlPatterns = {"/chat"})
public class ChatServlet extends HttpServlet {
    
    private OpenAIService openAIService;
    private ServiceDAO serviceDAO;
    private DestinationDAO destinationDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        openAIService = new OpenAIService();
        serviceDAO = new ServiceDAO();
        destinationDAO = new DestinationDAO();
    }
    
    /**
     * Handle POST requests - Main chat endpoint
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set response headers for JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            // Step 1: Parse User JSON input
            String userMessage = parseUserInput(request);
            
            if (userMessage == null || userMessage.trim().isEmpty()) {
                sendErrorResponse(response, "Empty message");
                return;
            }
            
            // Step 2: Call OpenAI Service
            Map<String, Object> aiResponse = openAIService.chat(userMessage, null);
            
            String botReply = (String) aiResponse.get("reply");
            String intent = (String) aiResponse.get("intent");
            String visualSlug = (String) aiResponse.get("visual_slug");
            Map<String, Object> slots = (Map<String, Object>) aiResponse.get("slots");
            
            // Step 3: Build final response based on intent
            Map<String, Object> finalResponse = buildFinalResponse(
                botReply, intent, visualSlug, slots
            );
            
            // Step 4: Send JSON response
            sendJsonResponse(response, finalResponse);
            
        } catch (Exception e) {
            System.err.println("ChatServlet error: " + e.getMessage());
            e.printStackTrace();
            sendErrorResponse(response, "Internal server error");
        }
    }
    
    /**
     * Parse incoming JSON from request body
     */
    private String parseUserInput(HttpServletRequest request) throws IOException {
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }
        
        // Parse JSON
        Map<String, Object> json = JsonUtils.fromJson(sb.toString(), Map.class);
        return json != null ? (String) json.get("message") : null;
    }
    
    /**
     * Build final response with UI actions and data
     * CRITICAL: This determines what happens on the frontend
     */
    private Map<String, Object> buildFinalResponse(
            String botReply, String intent, String visualSlug, Map<String, Object> slots) {
        
        Map<String, Object> response = new HashMap<>();
        response.put("bot_message", botReply);
        response.put("intent", intent);
        
        // Determine UI action based on intent and available data
        if (visualSlug != null && !visualSlug.isEmpty()) {
            // User mentioned a destination
            Destination dest = destinationDAO.getBySlug(visualSlug);
            
            if (dest != null) {
                // Change background to destination image
                response.put("ui_action", "CHANGE_BG");
                response.put("background_url", dest.thumbnailUrl());
                response.put("destination", Map.of(
                    "name", dest.name(),
                    "slug", dest.slug(),
                    "region", dest.region()
                ));
                
                // Check if we have enough info to show services
                if (shouldFetchServices(slots)) {
                    // Fetch services from database
                    List<Map<String, Object>> services = serviceDAO.searchServices(visualSlug);
                    
                    if (!services.isEmpty()) {
                        response.put("ui_action", "RENDER_RESULTS");
                        response.put("services", services);
                        response.put("background_url", dest.thumbnailUrl());
                    }
                }
            }
        } else if ("PLAN_TRIP".equals(intent)) {
            // User wants to plan but hasn't specified destination yet
            response.put("ui_action", "WAIT_INPUT");
        } else {
            // General chat or other intents
            response.put("ui_action", "NONE");
        }
        
        return response;
    }
    
    /**
     * Determine if we should fetch and display services
     * Based on extracted slots (date, people count, etc.)
     */
    private boolean shouldFetchServices(Map<String, Object> slots) {
        if (slots == null || slots.isEmpty()) {
            return false;
        }
        
        // Check if we have enough information
        // For now, just having a destination is enough
        // In production, you might want dates and people count
        return slots.containsKey("destination") && slots.get("destination") != null;
    }
    
    /**
     * Send JSON response to client
     */
    private void sendJsonResponse(HttpServletResponse response, Map<String, Object> data) 
            throws IOException {
        String json = JsonUtils.toJson(data);
        try (PrintWriter out = response.getWriter()) {
            out.print(json);
            out.flush();
        }
    }
    
    /**
     * Send error response
     */
    private void sendErrorResponse(HttpServletResponse response, String message) 
            throws IOException {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        Map<String, Object> error = new HashMap<>();
        error.put("error", message);
        error.put("bot_message", "Xin lỗi, có lỗi xảy ra. Vui lòng thử lại.");
        sendJsonResponse(response, error);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.getWriter().write("{\"message\": \"Chat endpoint. Use POST to send messages.\"}");
    }
}
