package com.pms.controller.nurse;

import com.pms.dao.DiagnosisDAO;
import com.pms.dao.NurseDAO;
import com.pms.dao.PatientDAO;
import com.pms.model.Diagnosis;
import com.pms.model.Nurse;
import com.pms.model.Patient;
import com.pms.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.util.UUID;

@WebServlet("/nurse/register-patient")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,     // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 50    // 50 MB
)
public class PatientRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PatientDAO patientDAO;
    private NurseDAO nurseDAO;
    private DiagnosisDAO diagnosisDAO;
    private String imagesPath;
    
    @Override
    public void init() throws ServletException {
        super.init();
        patientDAO = new PatientDAO();
        nurseDAO = new NurseDAO();
        diagnosisDAO = new DiagnosisDAO();
        
        // Set up the images directory path
        String contextPath = getServletContext().getRealPath("/");
        imagesPath = contextPath + "images";
        
        // Create the directory if it doesn't exist
        File imagesDir = new File(imagesPath);
        if (!imagesDir.exists()) {
            imagesDir.mkdirs();
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if the user is logged in and is a nurse
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null || !"Nurse".equals(currentUser.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Nurse nurse = nurseDAO.getNurseByUserID(currentUser.getUserID());
        request.setAttribute("nurse", nurse);
        
        // Forward to the registration form
        request.getRequestDispatcher("/WEB-INF/views/nurse/patient-register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if the user is logged in and is a nurse
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null || !"Nurse".equals(currentUser.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get the nurse information
        Nurse nurse = nurseDAO.getNurseByUserID(currentUser.getUserID());
        
        // Get form parameters
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String contactNumber = request.getParameter("contactNumber");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String diagnoStatus = request.getParameter("diagnoStatus");
        String symptoms = request.getParameter("symptoms");
        
        // Validate required fields
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            contactNumber == null || contactNumber.trim().isEmpty() ||
            gender == null || gender.trim().isEmpty() ||
            diagnoStatus == null || diagnoStatus.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Please fill in all required fields");
            request.setAttribute("nurse", nurse);
            request.getRequestDispatcher("/WEB-INF/views/nurse/patient-register.jsp").forward(request, response);
            return;
        }
        
        // Handle file upload
        Part filePart = request.getPart("patientImage");
        String fileName = "";
        String pImageLink = "";
        
        if (filePart != null && filePart.getSize() > 0) {
            // Generate a unique file name to prevent collisions
            String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String fileExtension = "";
            int i = originalFileName.lastIndexOf('.');
            if (i > 0) {
                fileExtension = originalFileName.substring(i);
            }
            fileName = UUID.randomUUID().toString() + fileExtension;
            
            // Save the file to the images directory
            try (InputStream fileContent = filePart.getInputStream()) {
                Path filePath = Paths.get(imagesPath, fileName);
                Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
                pImageLink = "images/" + fileName;
            } catch (IOException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Error uploading image: " + e.getMessage());
                request.setAttribute("nurse", nurse);
                request.getRequestDispatcher("/WEB-INF/views/nurse/patient-register.jsp").forward(request, response);
                return;
            }
        }
        
        // Create a new patient
        Patient patient = new Patient();
        patient.setFirstName(firstName);
        patient.setLastName(lastName);
        patient.setContactNumber(contactNumber);
        patient.setEmail(email);
        patient.setAddress(address);
        patient.setGender(gender);
        patient.setDateOfBirth(dateOfBirth);
        patient.setPImageLink(pImageLink);
        patient.setCreatedBy(nurse.getNurseID());
        
        // Save the patient to the database
        boolean patientAdded = patientDAO.addPatient(patient);
        
        if (!patientAdded) {
            request.setAttribute("errorMessage", "Failed to register patient");
            request.setAttribute("nurse", nurse);
            request.getRequestDispatcher("/WEB-INF/views/nurse/patient-register.jsp").forward(request, response);
            return;
        }
        
        // Create a diagnosis entry
        Diagnosis diagnosis = new Diagnosis();
        diagnosis.setPatientID(patient.getPatientID());
        diagnosis.setNurseID(nurse.getNurseID());
        diagnosis.setDiagnoStatus(diagnoStatus);
        // Result will be automatically set based on DiagnoStatus
        diagnosis.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        diagnosis.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
        
        // Save the diagnosis
        boolean diagnosisAdded = diagnosisDAO.addDiagnosis(diagnosis);
        
        if (!diagnosisAdded) {
            request.setAttribute("errorMessage", "Patient registered but failed to create diagnosis entry");
            request.setAttribute("nurse", nurse);
            request.getRequestDispatcher("/WEB-INF/views/nurse/patient-register.jsp").forward(request, response);
            return;
        }
        
        // Success - redirect to the patients list
        session.setAttribute("successMessage", "Patient successfully registered");
        response.sendRedirect(request.getContextPath() + "/nurse/patients");
    }
} 