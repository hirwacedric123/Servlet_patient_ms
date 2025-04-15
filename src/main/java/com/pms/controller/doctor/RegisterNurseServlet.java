package com.pms.controller.doctor;

import com.pms.dao.DoctorDAO;
import com.pms.dao.NurseDAO;
import com.pms.dao.UserDAO;
import com.pms.model.Doctor;
import com.pms.model.Nurse;
import com.pms.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/doctor/register-nurse")
public class RegisterNurseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NurseDAO nurseDAO;
    private UserDAO userDAO;
    private DoctorDAO doctorDAO;
    
    public void init() {
        nurseDAO = new NurseDAO();
        userDAO = new UserDAO();
        doctorDAO = new DoctorDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in and is a doctor
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"Doctor".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get the doctor information
        Doctor doctor = doctorDAO.getDoctorByUserID(user.getUserID());
        request.setAttribute("doctor", doctor);
        
        // Forward to the nurse registration form
        request.getRequestDispatcher("/WEB-INF/views/doctor/register-nurse.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in and is a doctor
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"Doctor".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Get nurse information from form
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String telephone = request.getParameter("telephone");
            String address = request.getParameter("address");
            String healthCenter = request.getParameter("healthCenter");
            String department = request.getParameter("department");
            
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
                request.getRequestDispatcher("/WEB-INF/views/doctor/register-nurse.jsp").forward(request, response);
                return;
            }
            
            // Create user record
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(password);
            newUser.setUserType("Nurse");
            newUser.setFirstName(firstName);
            newUser.setLastName(lastName);
            
            boolean userCreated = userDAO.addUser(newUser);
            
            if (userCreated) {
                // Create nurse record
                Nurse nurse = new Nurse();
                nurse.setFirstName(firstName);
                nurse.setLastName(lastName);
                nurse.setEmail(email);
                nurse.setTelephone(telephone);
                nurse.setAddress(address);
                nurse.setHealthCenter(healthCenter);
                nurse.setUserID(newUser.getUserID());
                
                // Save the doctor ID who registered this nurse
                Doctor registeringDoctor = doctorDAO.getDoctorByUserID(user.getUserID());
                if (registeringDoctor != null) {
                    // We'll need to add a field to the Nurse model and database to track this
                    nurse.setRegisteredByDoctorID(registeringDoctor.getId());
                }
                
                nurseDAO.addNurse(nurse);
                request.setAttribute("successMessage", "Nurse registered successfully!");
            } else {
                request.setAttribute("errorMessage", "Error creating user account. Please try again.");
            }
            
            request.getRequestDispatcher("/WEB-INF/views/doctor/register-nurse.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/doctor/register-nurse.jsp").forward(request, response);
        }
    }
} 