package com.laca.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * AdminFilter - Security filter for admin routes
 * Ensures only users with ADMIN role can access /admin/*
 * NON-NEGOTIABLE: All admin routes MUST be protected
 */
@WebFilter(filterName = "AdminFilter", urlPatterns = {"/admin/*"})
public class AdminFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Get session
        HttpSession session = httpRequest.getSession(false);
        
        // Check if user is logged in and is admin
        boolean isAdmin = false;
        if (session != null) {
            String role = (String) session.getAttribute("userRole");
            isAdmin = "ADMIN".equals(role);
        }
        
        if (isAdmin) {
            // User is admin, allow access
            chain.doFilter(request, response);
        } else {
            // Not admin, redirect to login
            String contextPath = httpRequest.getContextPath();
            httpResponse.sendRedirect(contextPath + "/auth?error=unauthorized");
        }
    }
    
    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
