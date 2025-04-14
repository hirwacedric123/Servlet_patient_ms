package com.pms.controller;

import com.pms.dao.UserDAO;
import com.pms.model.User;
import com.pms.util.PasswordUtil;
import com.pms.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet for direct user signup with immediate dashboard redirection
 */
@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    
    public void init() {
        userDAO = new UserDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to signup form
        request.getRequestDispatcher("/WEB-INF/views/signup.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("SignupServlet: Processing POST request");
        
        // Get parameters from form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");
        
        System.out.println("SignupServlet: Received data - Username: " + username + ", UserType: " + userType);
        
        // Validate input
        if (username == null || password == null || userType == null || 
            username.trim().isEmpty() || password.trim().isEmpty() || userType.trim().isEmpty()) {
            System.out.println("SignupServlet: Validation failed - empty fields");
            request.setAttribute("errorMessage", "All fields are required");
            request.getRequestDispatcher("/WEB-INF/views/signup.jsp").forward(request, response);
            return;
        }
        
        try {
            // Check if username already exists
            boolean exists = userExists(username);
            System.out.println("SignupServlet: User exists check result: " + exists);
            
            if (exists) {
                request.setAttribute("errorMessage", "Username already exists");
                request.getRequestDispatcher("/WEB-INF/views/signup.jsp").forward(request, response);
                return;
            }
            
            // Hash the password
            String hashedPassword = PasswordUtil.hashPassword(password);
            System.out.println("SignupServlet: Password hashed successfully");
            
            // Create and insert the user
            User user = new User(username, hashedPassword, userType);
            System.out.println("SignupServlet: Attempting to add user to database");
            boolean userCreated = userDAO.addUser(user);
            System.out.println("SignupServlet: User creation result: " + userCreated);
            
            if (!userCreated) {
                request.setAttribute("errorMessage", "Failed to create user account");
                request.getRequestDispatcher("/WEB-INF/views/signup.jsp").forward(request, response);
                return;
            }
            
            // Get the created user with ID
            System.out.println("SignupServlet: Authenticating newly created user");
            User createdUser = userDAO.authenticate(username, password);
            if (createdUser == null) {
                System.out.println("SignupServlet: Failed to authenticate newly created user");
                request.setAttribute("errorMessage", "User created but unable to authenticate");
                request.getRequestDispatcher("/WEB-INF/views/signup.jsp").forward(request, response);
                return;
            }
            
            System.out.println("SignupServlet: User successfully created and authenticated with ID: " + createdUser.getUserID());
            
            // Store user data in session
            HttpSession session = request.getSession();
            session.setAttribute("user", createdUser);
            
            // Redirect to appropriate dashboard based on userType
            redirectToDashboard(createdUser, response, request);
        } catch (Exception e) {
            System.err.println("SignupServlet: Exception occurred during signup process");
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error during registration: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/signup.jsp").forward(request, response);
        }
    }
    
    private boolean userExists(String username) {
        System.out.println("SignupServlet: Checking if username '" + username + "' exists");
        try {
            for (User user : userDAO.getAllUsers()) {
                if (user.getUsername().equals(username)) {
                    return true;
                }
            }
            return false;
        } catch (Exception e) {
            System.err.println("SignupServlet: Error checking if user exists: " + e.getMessage());
            e.printStackTrace();
            // In case of error, assume username doesn't exist to allow registration attempt
            return false;
        }
    }
    
    private void redirectToDashboard(User user, HttpServletResponse response, HttpServletRequest request) throws IOException {
        String userType = user.getUserType();
        String contextPath = request.getContextPath();
        
        System.out.println("SignupServlet: Redirecting " + userType + " to dashboard");
        
        switch (userType) {
            case "Admin":
                response.sendRedirect(contextPath + "/admin/dashboard");
                break;
            case "Doctor":
                response.sendRedirect(contextPath + "/doctor/dashboard");
                break;
            case "Nurse":
                response.sendRedirect(contextPath + "/nurse/dashboard");
                break;
            case "Patient":
                response.sendRedirect(contextPath + "/patient/dashboard");
                break;
            default:
                response.sendRedirect(contextPath + "/login");
                break;
        }
    }
} 