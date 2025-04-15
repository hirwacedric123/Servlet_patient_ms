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
        
        // Validate required fields
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All required fields must be filled out");
            request.setAttribute("userType", userType.toLowerCase());
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        // Validate password strength
        if (!password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$")) {
            request.setAttribute("errorMessage", "Password must be at least 8 characters and include uppercase, lowercase, and numbers");
            request.setAttribute("userType", userType.toLowerCase());
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        // Only allow Doctor and Patient registration
        if (!"Doctor".equals(userType) && !"Patient".equals(userType)) {
            request.setAttribute("errorMessage", "Invalid user type for registration");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        // Check if username already exists
        if (userExists(username)) {
            request.setAttribute("errorMessage", "Username already exists");
            request.setAttribute("userType", userType.toLowerCase());
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        try {
            // Create the user account with firstName and lastName
            User user = new User(username, password, userType, firstName, lastName);
            boolean userCreated = userDAO.addUser(user);
            
            if (!userCreated) {
                request.setAttribute("errorMessage", "Failed to create user account");
                request.setAttribute("userType", userType.toLowerCase());
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }
            
            // Handle Doctor specific registration
            if ("Doctor".equals(userType)) {
                String specialization = request.getParameter("specialization");
                String contactNumber = request.getParameter("contactNumber");
                String email = request.getParameter("email");
                String address = request.getParameter("address");
                
                // Validate doctor-specific fields
                if (specialization == null || specialization.trim().isEmpty() ||
                    contactNumber == null || contactNumber.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    address == null || address.trim().isEmpty()) {
                    userDAO.deleteUser(user.getUserID());
                    request.setAttribute("errorMessage", "All doctor fields are required");
                    request.setAttribute("userType", userType.toLowerCase());
                    request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                    return;
                }
                
                // Validate email format
                if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
                    userDAO.deleteUser(user.getUserID());
                    request.setAttribute("errorMessage", "Invalid email format");
                    request.setAttribute("userType", userType.toLowerCase());
                    request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                    return;
                }
                
                Doctor doctor = new Doctor();
                doctor.setFirstName(firstName);
                doctor.setLastName(lastName);
                doctor.setSpecialization(specialization);
                doctor.setContactNumber(contactNumber);
                doctor.setEmail(email);
                doctor.setAddress(address);
                doctor.setHospitalName("General Hospital"); // Default hospital name
                doctor.setUserID(user.getUserID());
                
                boolean doctorCreated = doctorDAO.addDoctor(doctor);
                if (!doctorCreated) {
                    userDAO.deleteUser(user.getUserID());
                    request.setAttribute("errorMessage", "Failed to create doctor profile. Please try again.");
                    request.setAttribute("userType", userType.toLowerCase());
                    request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                    return;
                }
                
                // Set user and doctor in session for automatic login
                request.getSession().setAttribute("user", user);
                request.getSession().setAttribute("doctor", doctor);
                
                // Redirect to doctor dashboard
                response.sendRedirect(request.getContextPath() + "/doctor/dashboard");
                return;
            }
            
            // Handle Patient specific registration
            if ("Patient".equals(userType)) {
                String gender = request.getParameter("gender");
                String dateOfBirth = request.getParameter("dateOfBirth");
                String address = request.getParameter("address");
                String contactNumber = request.getParameter("contactNumber");
                String email = request.getParameter("email");
                
                // Validate patient-specific fields
                if (gender == null || gender.trim().isEmpty() ||
                    dateOfBirth == null || dateOfBirth.trim().isEmpty() ||
                    address == null || address.trim().isEmpty() ||
                    contactNumber == null || contactNumber.trim().isEmpty() ||
                    email == null || email.trim().isEmpty()) {
                    userDAO.deleteUser(user.getUserID());
                    request.setAttribute("errorMessage", "All patient fields are required");
                    request.setAttribute("userType", userType.toLowerCase());
                    request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                    return;
                }
                
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
                    request.setAttribute("userType", userType.toLowerCase());
                    request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                    return;
                }
                
                // Set user and patient in session for automatic login
                request.getSession().setAttribute("user", user);
                request.getSession().setAttribute("patient", patient);
                
                // Redirect to patient dashboard
                response.sendRedirect(request.getContextPath() + "/patient/dashboard");
                return;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred during registration. Please try again.");
            request.setAttribute("userType", userType.toLowerCase());
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
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