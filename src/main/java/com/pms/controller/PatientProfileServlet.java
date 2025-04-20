package com.pms.controller;

import com.pms.dao.PatientDAO;
import com.pms.model.Patient;
import com.pms.model.User;
import com.pms.util.FileUploadUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet("/patient/profile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class PatientProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PatientDAO patientDAO;

    public void init() {
        patientDAO = new PatientDAO();
        // Initialize FileUploadUtil with the ServletContext
        FileUploadUtil.setServletContext(getServletContext());
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in and is a patient
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"Patient".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get patient information
        Patient patient = (Patient) session.getAttribute("patient");
        
        if (patient == null) {
            // If patient not in session, retrieve from database
            patient = patientDAO.getPatientByUserID(user.getUserID());
            
            // If patient still null, create a minimal patient object
            if (patient == null) {
                patient = new Patient();
                patient.setPatientID(user.getUserID());
                patient.setUserID(user.getUserID());
                patient.setFirstName(user.getFirstName());
                patient.setLastName(user.getLastName());
                
                request.setAttribute("errorMessage", "Patient profile is incomplete. Please update your profile.");
            }
            
            session.setAttribute("patient", patient);
        }
        
        // Forward to the profile JSP
        request.getRequestDispatcher("/WEB-INF/views/patient/patient_profile.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in and is a patient
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"Patient".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get the current patient from session
        Patient patient = (Patient) session.getAttribute("patient");
        
        if (patient == null) {
            patient = patientDAO.getPatientByUserID(user.getUserID());
            
            if (patient == null) {
                // Create a new patient object if it doesn't exist
                patient = new Patient();
                patient.setPatientID(user.getUserID());
                patient.setUserID(user.getUserID());
            }
        }
        
        // Get form parameters
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        String contactNumber = request.getParameter("contactNumber");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String bloodGroup = request.getParameter("bloodGroup");
        String emergencyContact = request.getParameter("emergencyContact");
        
        // Validate required fields
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            contactNumber == null || contactNumber.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "First name, last name, contact number, and email are required.");
            request.setAttribute("patient", patient);
            request.getRequestDispatcher("/WEB-INF/views/patient/patient_profile.jsp").forward(request, response);
            return;
        }
        
        // Update patient data
        patient.setFirstName(firstName);
        patient.setLastName(lastName);
        patient.setGender(gender);
        patient.setContactNumber(contactNumber);
        patient.setEmail(email);
        patient.setAddress(address);
        patient.setBloodGroup(bloodGroup);
        patient.setEmergencyContact(emergencyContact);
        
        // Handle date of birth
        if (dateOfBirthStr != null && !dateOfBirthStr.trim().isEmpty()) {
            try {
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date parsed = format.parse(dateOfBirthStr);
                patient.setDateOfBirth(new Date(parsed.getTime()));
            } catch (ParseException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Invalid date format. Please use yyyy-MM-dd.");
                request.setAttribute("patient", patient);
                request.getRequestDispatcher("/WEB-INF/views/patient/patient_profile.jsp").forward(request, response);
                return;
            }
        }
        
        // Process profile image upload if present
        Part filePart = request.getPart("profileImage");
        if (filePart != null && filePart.getSize() > 0) {
            try {
                System.out.println("Processing image upload for user: " + patient.getPatientID());
                String imageLink = FileUploadUtil.saveFile(filePart);
                System.out.println("Image saved successfully at: " + imageLink);
                
                // Set the image path - this is already prefixed with context path by FileUploadUtil
                patient.setProfileImage(imageLink);
            } catch (IOException e) {
                e.printStackTrace();
                System.err.println("Error uploading image: " + e.getMessage());
                request.setAttribute("errorMessage", "Error uploading image: " + e.getMessage());
                request.setAttribute("patient", patient);
                request.getRequestDispatcher("/WEB-INF/views/patient/patient_profile.jsp").forward(request, response);
                return;
            }
        }
        
        // Save patient to database
        boolean updated = patientDAO.updatePatient(patient);
        
        if (updated) {
            // Update session data
            session.setAttribute("patient", patient);
            session.setAttribute("successMessage", "Profile updated successfully.");
            System.out.println("Profile updated successfully for patient: " + patient.getPatientID() + 
                              ", Profile image: " + patient.getProfileImage());
            response.sendRedirect(request.getContextPath() + "/patient/profile");
        } else {
            request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
            request.setAttribute("patient", patient);
            request.getRequestDispatcher("/WEB-INF/views/patient/patient_profile.jsp").forward(request, response);
        }
    }
} 