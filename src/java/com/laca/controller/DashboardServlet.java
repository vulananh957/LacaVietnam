package com.laca.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * DashboardServlet - Main entry point for client dashboard
 * Routes: /dashboard
 */
public class DashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Forward to dashboard JSP
        request.getRequestDispatcher("/WEB-INF/views/client/dashboard.jsp")
               .forward(request, response);
    }
}
