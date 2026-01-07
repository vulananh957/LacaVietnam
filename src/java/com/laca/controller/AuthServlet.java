package com.laca.controller;

import com.laca.dao.UserDAO;
import com.laca.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * AuthServlet - Handle user authentication
 * Routes: /auth?action=login|logout|register
 */
@WebServlet(name = "AuthServlet", urlPatterns = {"/auth"})
public class AuthServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("logout".equals(action)) {
            handleLogout(request, response);
        } else {
            // Show login page
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
                   .forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("register".equals(action)) {
            handleRegister(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/auth");
        }
    }
    
    /**
     * Handle login
     */
    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        User user = userDAO.login(username, password);
        
        if (user != null) {
            // Login successful
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.id());
            session.setAttribute("userRole", user.role());
            
            // Redirect based on role
            if ("ADMIN".equals(user.role())) {
                response.sendRedirect(request.getContextPath() + "/admin");
            } else {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            }
        } else {
            // Login failed
            request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
                   .forward(request, response);
        }
    }
    
    /**
     * Handle registration
     */
    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        
        User newUser = new User(username, email, password, fullName, "USER");
        boolean success = userDAO.register(newUser);
        
        if (success) {
            request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
        } else {
            request.setAttribute("error", "Đăng ký thất bại. Tên đăng nhập hoặc email đã tồn tại.");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
               .forward(request, response);
    }
    
    /**
     * Handle logout
     */
    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        response.sendRedirect(request.getContextPath() + "/auth");
    }
}
