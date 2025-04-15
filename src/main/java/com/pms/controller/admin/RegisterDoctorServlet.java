package com.pms.controller.admin;

import com.pms.dao.DoctorDAO;
import com.pms.dao.UserDAO;
import com.pms.model.Doctor;
import com.pms.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/register-doctor")
public class RegisterDoctorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DoctorDAO doctorDAO;
    private UserDAO userDAO;
    
    public void init() {
        doctorDAO = new DoctorDAO();
        userDAO = new UserDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in and is admin
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"Admin".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Forward to the doctor registration form
        request.getRequestDispatcher("/WEB-INF/views/admin/register-doctor.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in and is admin
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"Admin".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Get doctor information from form
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String telephone = request.getParameter("telephone");
            String address = request.getParameter("address");
            String hospitalName = request.getParameter("hospitalName");
            String specialization = request.getParameter("specialization");
            String licenseNumber = request.getParameter("licenseNumber");
            
            // Get user account information
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            // Check if username already exists by retrieving all users and checking
            List<User> allUsers = userDAO.getAllUsers();
            boolean usernameExists = false;
            for (User existingUser : allUsers) {
                if (existingUser.getUsername().equals(username)) {
                    usernameExists = true;
                    break;
                }
            }
            
            if (usernameExists) {
                request.setAttribute("errorMessage", "Username already exists. Please choose a different username.");
                request.getRequestDispatcher("/WEB-INF/views/admin/register-doctor.jsp").forward(request, response);
                return;
            }
            
            // Create user record
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(password);
            newUser.setUserType("Doctor");
            newUser.setFirstName(firstName);
            newUser.setLastName(lastName);
            
            boolean userCreated = userDAO.addUser(newUser);
            
            if (userCreated) {
                // Create doctor record
                Doctor doctor = new Doctor();
                doctor.setName(firstName + " " + lastName);
                doctor.setEmail(email);
                doctor.setPhone(telephone);
                doctor.setAddress(address);
                doctor.setHospitalName(hospitalName);
                doctor.setSpecialization(specialization);
                doctor.setUserId(newUser.getUserID());
                doctor.setActive(true);
                
                doctorDAO.addDoctor(doctor);
                request.setAttribute("successMessage", "Doctor registered successfully!");
            } else {
                request.setAttribute("errorMessage", "Error creating user account. Please try again.");
            }
            
            request.getRequestDispatcher("/WEB-INF/views/admin/register-doctor.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/register-doctor.jsp").forward(request, response);
        }
    }
} 