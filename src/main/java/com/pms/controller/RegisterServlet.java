package com.pms.controller;

import com.pms.dao.DoctorDAO;
import com.pms.dao.PatientDAO;
import com.pms.dao.UserDAO;
import com.pms.model.Doctor;
import com.pms.model.Patient;
import com.pms.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private DoctorDAO doctorDAO;
    private PatientDAO patientDAO;
    
    public void init() {
        userDAO = new UserDAO();
        doctorDAO = new DoctorDAO();
        patientDAO = new PatientDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userType = request.getParameter("type");
        
        if ("doctor".equalsIgnoreCase(userType) || "patient".equalsIgnoreCase(userType)) {
            request.setAttribute("userType", userType);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        
        // Only allow Doctor and Patient registration
        if (!"Doctor".equals(userType) && !"Patient".equals(userType)) {
            request.setAttribute("errorMessage", "Invalid user type for registration");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        // Check if username already exists
        if (userExists(username)) {
            request.setAttribute("errorMessage", "Username already exists");
            request.setAttribute("userType", userType);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        // Create the user account with firstName and lastName
        User user = new User(username, password, userType, firstName, lastName);
        boolean userCreated = userDAO.addUser(user);
        
        if (!userCreated) {
            request.setAttribute("errorMessage", "Failed to create user account");
            request.setAttribute("userType", userType);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        // Handle Doctor specific registration
        if ("Doctor".equals(userType)) {
            String specialization = request.getParameter("specialization");
            String contactNumber = request.getParameter("contactNumber");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            
            // Debug information
            System.out.println("Doctor Registration Data:");
            System.out.println("- FirstName: " + firstName);
            System.out.println("- LastName: " + lastName);
            System.out.println("- Specialization: " + specialization);
            System.out.println("- ContactNumber: " + contactNumber);
            System.out.println("- Email: " + email);
            System.out.println("- Address: " + address);
            System.out.println("- UserID: " + user.getUserID());
            
            Doctor doctor = new Doctor();
            doctor.setFirstName(firstName);
            doctor.setLastName(lastName);
            doctor.setSpecialization(specialization);
            doctor.setContactNumber(contactNumber);
            doctor.setEmail(email);
            // Set default address if not provided
            doctor.setAddress(address != null && !address.trim().isEmpty() ? address : "Not specified");
            // Set default hospital name
            doctor.setHospitalName("General Hospital"); // Default hospital name
            doctor.setUserID(user.getUserID());
            
            boolean doctorCreated = doctorDAO.addDoctor(doctor);
            if (!doctorCreated) {
                // Log the error to help with debugging
                System.out.println("Failed to create doctor profile for user ID: " + user.getUserID());
                userDAO.deleteUser(user.getUserID());
                request.setAttribute("errorMessage", "Failed to create doctor profile");
                request.setAttribute("userType", userType);
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }
        }
        
        // Handle Patient specific registration
        if ("Patient".equals(userType)) {
            String gender = request.getParameter("gender");
            String dateOfBirth = request.getParameter("dateOfBirth");
            String address = request.getParameter("address");
            String contactNumber = request.getParameter("contactNumber");
            String email = request.getParameter("email");
            
            Patient patient = new Patient();
            patient.setFirstName(firstName);
            patient.setLastName(lastName);
            patient.setGender(gender);
            patient.setDateOfBirth(dateOfBirth);
            patient.setAddress(address);
            patient.setContactNumber(contactNumber);
            patient.setEmail(email);
            patient.setUserID(user.getUserID());
            
            boolean patientCreated = patientDAO.addPatient(patient);
            if (!patientCreated) {
                userDAO.deleteUser(user.getUserID());
                request.setAttribute("errorMessage", "Failed to create patient profile");
                request.setAttribute("userType", userType);
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }
        }
        
        // Registration successful, redirect to login page
        request.getSession().setAttribute("message", "Registration successful! Please login.");
        response.sendRedirect(request.getContextPath() + "/login");
    }
    
    private boolean userExists(String username) {
        // Loop through all users to check if username exists
        for (User user : userDAO.getAllUsers()) {
            if (user.getUsername().equals(username)) {
                return true;
            }
        }
        return false;
    }
} 