package com.pms.controller.admin;

import com.pms.dao.NurseDAO;
import com.pms.dao.UserDAO;
import com.pms.model.Nurse;
import com.pms.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet to synchronize nurse users with the nurses table
 * This creates nurse records for users with role "Nurse" who don't have corresponding entries in the nurses table
 */
@WebServlet("/admin/sync-nurses")
public class SyncNursesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private NurseDAO nurseDAO;
    
    @Override
    public void init() {
        userDAO = new UserDAO();
        nurseDAO = new NurseDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in and is an admin
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"Admin".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get all users with role "Nurse"
        List<User> allUsers = userDAO.getAllUsers();
        List<User> nurseUsers = new ArrayList<>();
        for (User u : allUsers) {
            if ("Nurse".equals(u.getUserType())) {
                nurseUsers.add(u);
            }
        }
        
        // Keep track of users processed
        List<String> results = new ArrayList<>();
        int created = 0;
        int skipped = 0;
        
        // Process each nurse user
        for (User nurseUser : nurseUsers) {
            // Check if nurse record already exists
            Nurse existingNurse = nurseDAO.getNurseByUserID(nurseUser.getUserID());
            
            if (existingNurse == null) {
                // Create a new nurse record
                Nurse newNurse = new Nurse();
                newNurse.setUserID(nurseUser.getUserID());
                newNurse.setFirstName(nurseUser.getFirstName());
                newNurse.setLastName(nurseUser.getLastName());
                
                // Set default values for required fields
                newNurse.setTelephone("Default telephone");
                String email = nurseUser.getFirstName().toLowerCase() + "." + nurseUser.getLastName().toLowerCase() + "@example.com";
                newNurse.setEmail(email);
                newNurse.setAddress("Default address");
                newNurse.setHealthCenter("Default health center");
                
                // Add the nurse to the database
                boolean success = nurseDAO.addNurse(newNurse);
                
                if (success) {
                    created++;
                    results.add("Created nurse record for user " + nurseUser.getUsername() + " (ID: " + nurseUser.getUserID() + ")");
                } else {
                    results.add("Failed to create nurse record for user " + nurseUser.getUsername() + " (ID: " + nurseUser.getUserID() + ")");
                }
            } else {
                skipped++;
                results.add("Skipped user " + nurseUser.getUsername() + " (ID: " + nurseUser.getUserID() + "), nurse record already exists");
            }
        }
        
        // Store results in request for display
        request.setAttribute("results", results);
        request.setAttribute("created", created);
        request.setAttribute("skipped", skipped);
        request.setAttribute("total", nurseUsers.size());
        
        // Forward to the results page
        request.getRequestDispatcher("/WEB-INF/views/admin/sync-nurses-result.jsp").forward(request, response);
    }
} 