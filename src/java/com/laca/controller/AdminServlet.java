package com.laca.controller;

import com.laca.dao.DestinationDAO;
import com.laca.dao.ServiceDAO;
import com.laca.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * AdminServlet - Admin dashboard controller
 * Must be protected by AdminFilter
 * Routes: /admin?page=dashboard|services|users
 */
@WebServlet(name = "AdminServlet", urlPatterns = {"/admin"})
public class AdminServlet extends HttpServlet {
    
    private UserDAO userDAO;
    private DestinationDAO destinationDAO;
    private ServiceDAO serviceDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO();
        destinationDAO = new DestinationDAO();
        serviceDAO = new ServiceDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is admin (should be done by filter)
        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/auth");
            return;
        }
        
        String page = request.getParameter("page");
        if (page == null) {
            page = "dashboard";
        }
        
        switch (page) {
            case "services":
                showServicesPage(request, response);
                break;
            case "users":
                showUsersPage(request, response);
                break;
            case "dashboard":
            default:
                showDashboard(request, response);
                break;
        }
    }
    
    /**
     * Show admin dashboard
     */
    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Load statistics
        // In production, create specific DAO methods for stats
        
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp")
               .forward(request, response);
    }
    
    /**
     * Show services management page
     */
    private void showServicesPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Load all destinations for dropdown
        request.setAttribute("destinations", destinationDAO.getAllDestinations());
        
        request.getRequestDispatcher("/WEB-INF/views/admin/services.jsp")
               .forward(request, response);
    }
    
    /**
     * Show users management page
     */
    private void showUsersPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp")
               .forward(request, response);
    }
}
