package com.pms.controller;

import com.pms.dao.PatientDAO;
import com.pms.dao.UserDAO;
import com.pms.dao.NurseDAO;
import com.pms.model.Patient;
import com.pms.model.User;
import com.pms.model.Nurse;
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

@WebServlet("/legacy-register-patient")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class PatientRegistrationServlet extends HttpServlet {
    private PatientDAO patientDAO;
    private UserDAO userDAO;
    private NurseDAO nurseDAO;
    
    @Override
    public void init() {
        patientDAO = new PatientDAO();
        userDAO = new UserDAO();
        nurseDAO = new NurseDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Display the patient registration form
        request.getRequestDispatcher("/WEB-INF/views/nurse/register_patient.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in and is a nurse
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"Nurse".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get the nurse object who is registering this patient
        Nurse nurse = nurseDAO.getNurseByUserID(user.getUserID());
        if (nurse == null) {
            request.setAttribute("errorMessage", "Error retrieving nurse information.");
            request.getRequestDispatcher("/WEB-INF/views/nurse/register_patient.jsp").forward(request, response);
            return;
        }
        
        // Get form data
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String contactNumber = request.getParameter("contactNumber");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String bloodGroup = request.getParameter("bloodGroup");
        String symptoms = request.getParameter("symptoms");
        boolean isReferrable = "true".equals(request.getParameter("isReferrable"));
        
        // Validate required fields
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            gender == null || gender.trim().isEmpty() ||
            contactNumber == null || contactNumber.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "All required fields must be filled out");
            request.getRequestDispatcher("/WEB-INF/views/nurse/register_patient.jsp").forward(request, response);
            return;
        }
        
        // Process the patient image upload
        String imageLink = null;
        Part filePart = request.getPart("patientImage");
        if (filePart != null && filePart.getSize() > 0) {
            try {
                imageLink = FileUploadUtil.saveFile(filePart);
            } catch (IOException e) {
                request.setAttribute("errorMessage", "Error uploading image: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/views/nurse/register_patient.jsp").forward(request, response);
                return;
            }
        }
        
        // Create a new user for the patient
        String username = email.split("@")[0] + System.currentTimeMillis() % 10000; // Generate a username
        String defaultPassword = "Patient" + System.currentTimeMillis() % 10000; // Generate a default password
        
        User patientUser = new User();
        patientUser.setUsername(username);
        patientUser.setPassword(defaultPassword);
        patientUser.setUserType("Patient");
        
        // Add the user to the database
        boolean userCreated = userDAO.addUser(patientUser);
        if (!userCreated) {
            request.setAttribute("errorMessage", "Failed to create patient account");
            request.getRequestDispatcher("/WEB-INF/views/nurse/register_patient.jsp").forward(request, response);
            return;
        }
        
        // Create the patient record
        Patient patient = new Patient();
        patient.setUserID(patientUser.getUserID());
        patient.setFirstName(firstName);
        patient.setLastName(lastName);
        patient.setGender(gender);
        patient.setDateOfBirth(dateOfBirth);
        patient.setContactNumber(contactNumber);
        patient.setEmail(email);
        patient.setAddress(address);
        patient.setBloodGroup(bloodGroup);
        patient.setSymptoms(symptoms);
        patient.setReferrable(isReferrable);
        patient.setCreatedBy(nurse.getNurseID()); // Use getNurseID() instead of getId()
        patient.setPImageLink(imageLink); // Set the image link
        
        // Add the patient to the database
        boolean patientCreated = patientDAO.addPatient(patient);
        if (!patientCreated) {
            // Clean up by deleting the user if patient creation fails
            userDAO.deleteUser(patientUser.getUserID());
            
            // Delete the uploaded image if patient creation fails
            if (imageLink != null) {
                FileUploadUtil.deleteFile(imageLink);
            }
            
            request.setAttribute("errorMessage", "Failed to create patient record");
            request.getRequestDispatcher("/WEB-INF/views/nurse/register_patient.jsp").forward(request, response);
            return;
        }
        
        // Set a success message and redirect to the nurse dashboard
        request.getSession().setAttribute("successMessage", 
            "Patient registered successfully. Username: " + username + ", Password: " + defaultPassword);
        response.sendRedirect(request.getContextPath() + "/nurse/dashboard");
    }
} 