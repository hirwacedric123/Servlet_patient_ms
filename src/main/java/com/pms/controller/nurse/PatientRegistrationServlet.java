package com.pms.controller.nurse;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.pms.dao.DiagnosisDAO;
import com.pms.dao.PatientDAO;
import com.pms.model.Diagnosis;
import com.pms.model.Patient;
import com.pms.model.User;
import com.pms.util.FormValidator;

@WebServlet("/nurse/register-patient")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 5 * 1024 * 1024,   // 5 MB
    maxRequestSize = 10 * 1024 * 1024 // 10 MB
)
public class PatientRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(PatientRegistrationServlet.class.getName());
    private static final String UPLOAD_DIRECTORY = "patient_images";
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"nurse".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/access-denied");
            return;
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/nurse/patient-register.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"nurse".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/access-denied");
            return;
        }
        
        try {
            // Validation for required fields
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String gender = request.getParameter("gender");
            String contactNumber = request.getParameter("contactNumber");
            String diagnoStatus = request.getParameter("diagnoStatus");
            
            if (FormValidator.isNullOrEmpty(firstName) || 
                FormValidator.isNullOrEmpty(lastName) || 
                FormValidator.isNullOrEmpty(gender) || 
                FormValidator.isNullOrEmpty(contactNumber) ||
                FormValidator.isNullOrEmpty(diagnoStatus)) {
                
                request.setAttribute("errorMessage", "Required fields cannot be empty");
                request.getRequestDispatcher("/WEB-INF/views/nurse/patient-register.jsp").forward(request, response);
                return;
            }
            
            // Optional fields
            String dateOfBirthStr = request.getParameter("dateOfBirth");
            Date dateOfBirth = null;
            if (!FormValidator.isNullOrEmpty(dateOfBirthStr)) {
                try {
                    dateOfBirth = Date.valueOf(dateOfBirthStr);
                } catch (IllegalArgumentException e) {
                    LOGGER.log(Level.WARNING, "Invalid date format: " + dateOfBirthStr, e);
                }
            }
            
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String emergencyContact = request.getParameter("emergencyContact");
            String bloodGroup = request.getParameter("bloodGroup");
            String symptoms = request.getParameter("symptoms");
            
            // Process file upload
            String imagePath = null;
            Part filePart = request.getPart("patientImage");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getSubmittedFileName(filePart);
                if (fileName != null && !fileName.isEmpty()) {
                    // Generate unique file name to avoid collisions
                    String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                    
                    // Get upload directory path
                    String applicationPath = request.getServletContext().getRealPath("");
                    String uploadPath = applicationPath + UPLOAD_DIRECTORY;
                    
                    // Create directory if it doesn't exist
                    Path uploadDir = Paths.get(uploadPath);
                    if (!Files.exists(uploadDir)) {
                        Files.createDirectories(uploadDir);
                    }
                    
                    // Save file
                    Path filePath = uploadDir.resolve(uniqueFileName);
                    Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                    
                    // Set relative path for database
                    imagePath = UPLOAD_DIRECTORY + "/" + uniqueFileName;
                    LOGGER.log(Level.INFO, "File uploaded successfully: {0}", filePath);
                }
            }
            
            // Create patient object
            Patient patient = new Patient();
            patient.setFirstName(firstName);
            patient.setLastName(lastName);
            patient.setGender(gender);
            patient.setContactNumber(contactNumber);
            patient.setEmail(email);
            patient.setAddress(address);
            patient.setDateOfBirth(dateOfBirth);
            patient.setEmergencyContact(emergencyContact);
            patient.setBloodGroup(bloodGroup);
            patient.setImagePath(imagePath);
            patient.setRegisterDate(new java.sql.Date(System.currentTimeMillis()));
            patient.setRegisteredByNurseId(user.getId()); // Set the nurse ID who registered this patient
            
            // Save patient to database
            PatientDAO patientDAO = new PatientDAO();
            int patientId = patientDAO.addPatient(patient);
            
            if (patientId > 0) {
                LOGGER.log(Level.INFO, "Patient registered successfully with ID: {0}", patientId);
                
                // Create diagnosis entry for the patient
                Diagnosis diagnosis = new Diagnosis();
                diagnosis.setPatientId(patientId);
                diagnosis.setDiagnosisStatus(diagnoStatus);
                diagnosis.setSymptoms(symptoms);
                diagnosis.setDiagnosisDate(new java.sql.Date(System.currentTimeMillis()));
                diagnosis.setNurseId(user.getId());
                
                DiagnosisDAO diagnosisDAO = new DiagnosisDAO();
                int diagnosisId = diagnosisDAO.addDiagnosis(diagnosis);
                
                if (diagnosisId > 0) {
                    LOGGER.log(Level.INFO, "Diagnosis record created with ID: {0}", diagnosisId);
                    response.sendRedirect(request.getContextPath() + "/nurse/patients?success=Patient registered successfully");
                } else {
                    LOGGER.log(Level.WARNING, "Failed to create diagnosis record for patient ID: {0}", patientId);
                    response.sendRedirect(request.getContextPath() + "/nurse/patients?warning=Patient registered but diagnosis record creation failed");
                }
            } else {
                LOGGER.log(Level.SEVERE, "Failed to register patient");
                request.setAttribute("errorMessage", "Failed to register patient. Please try again.");
                request.getRequestDispatcher("/WEB-INF/views/nurse/patient-register.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error registering patient", e);
            request.setAttribute("errorMessage", "An error occurred while registering the patient: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/nurse/patient-register.jsp").forward(request, response);
        }
    }
    
    private String getSubmittedFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
} 