package com.pms.controller;

import com.pms.dao.UserDAO;
import com.pms.dao.AdminDAO;
import com.pms.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private AdminDAO adminDAO;
    
    public void init() {
        userDAO = new UserDAO();
        adminDAO = new AdminDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            redirectToUserDashboard(user, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // First try admin authentication
        User admin = adminDAO.authenticateAdmin(username, password);
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", admin);
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }
        
        // If not admin, try regular user authentication
        User user = userDAO.authenticate(username, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            redirectToUserDashboard(user, response);
        } else {
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
    
    private void redirectToUserDashboard(User user, HttpServletResponse response) throws IOException {
        String userType = user.getUserType();
        String contextPath = request.getContextPath();
        
        switch (userType.toLowerCase()) {
            case "admin":
                response.sendRedirect(contextPath + "/admin/dashboard");
                break;
            case "doctor":
                response.sendRedirect(contextPath + "/doctor/dashboard");
                break;
            case "nurse":
                response.sendRedirect(contextPath + "/nurse/dashboard");
                break;
            case "patient":
                response.sendRedirect(contextPath + "/patient/dashboard");
                break;
            default:
                response.sendRedirect(contextPath + "/login");
                break;
        }
    }
} 