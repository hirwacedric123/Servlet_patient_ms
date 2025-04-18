package com.pms.controller.nurse;

import com.pms.dao.DiagnosisDAO;
import com.pms.dao.DoctorDAO;
import com.pms.dao.NurseDAO;
import com.pms.dao.PatientDAO;
import com.pms.model.Diagnosis;
import com.pms.model.Doctor;
import com.pms.model.Nurse;
import com.pms.model.Patient;
import com.pms.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet for nurses to create diagnoses for existing patients
 */
@WebServlet("/nurse/create-diagnosis")
public class CreateDiagnosisServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(CreateDiagnosisServlet.class.getName());
    
    private PatientDAO patientDAO;
    private DiagnosisDAO diagnosisDAO;
    private DoctorDAO doctorDAO;
    private NurseDAO nurseDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        patientDAO = new PatientDAO();
        diagnosisDAO = new DiagnosisDAO();
        doctorDAO = new DoctorDAO();
        nurseDAO = new NurseDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"Nurse".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/access-denied");
            return;
        }
        
        // Get the patient ID from the request
        String patientIdParam = request.getParameter("patientId");
        if (patientIdParam == null || patientIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/nurse/patients");
            return;
        }
        
        try {
            int patientId = Integer.parseInt(patientIdParam);
            
            // Get the patient details
            Patient patient = patientDAO.getPatientByID(patientId);
            if (patient == null) {
                request.setAttribute("errorMessage", "Patient not found");
                request.getRequestDispatcher("/nurse/dashboard").forward(request, response);
                return;
            }
            
            // Get available doctors for referral
            List<Doctor> doctors = doctorDAO.getAllDoctors();
            
            // Set attributes for the JSP
            request.setAttribute("patient", patient);
            request.setAttribute("doctors", doctors);
            
            // Forward to the diagnosis form
            request.getRequestDispatcher("/WEB-INF/views/nurse/create_diagnosis.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid patient ID format: " + patientIdParam);
            response.sendRedirect(request.getContextPath() + "/nurse/dashboard");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"Nurse".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/access-denied");
            return;
        }
        
        // Get the nurse from session or database
        Nurse nurse = (Nurse) session.getAttribute("nurse");
        if (nurse == null) {
            nurse = nurseDAO.getNurseByUserID(user.getUserID());
            if (nurse == null) {
                request.setAttribute("errorMessage", "Nurse record not found. Please contact admin.");
                request.getRequestDispatcher("/nurse/dashboard").forward(request, response);
                return;
            }
            // Store in session for future use
            session.setAttribute("nurse", nurse);
        }
        
        // Get form data
        String patientIdParam = request.getParameter("patientId");
        String diagnosisStatus = request.getParameter("diagnosisStatus");
        String doctorIdParam = request.getParameter("doctorId");
        String symptoms = request.getParameter("symptoms");
        
        // Validate required fields
        if (patientIdParam == null || patientIdParam.isEmpty() || 
            diagnosisStatus == null || diagnosisStatus.isEmpty()) {
            
            request.setAttribute("errorMessage", "Patient ID and diagnosis status are required");
            response.sendRedirect(request.getContextPath() + "/nurse/dashboard");
            return;
        }
        
        try {
            int patientId = Integer.parseInt(patientIdParam);
            
            // Create a new diagnosis
            Diagnosis diagnosis = new Diagnosis();
            diagnosis.setPatientID(patientId);
            diagnosis.setNurseID(nurse.getNurseID()); // Use NurseID from the nurses table
            
            // Set doctor ID if this is a referrable case
            int doctorId = 0;
            if ("Referrable".equals(diagnosisStatus) && doctorIdParam != null && !doctorIdParam.isEmpty()) {
                doctorId = Integer.parseInt(doctorIdParam);
                diagnosis.setDoctorID(doctorId);
            }
            
            diagnosis.setDiagnoStatus(diagnosisStatus);
            
            // Set result based on status
            if ("Referrable".equals(diagnosisStatus)) {
                diagnosis.setResult("Pending");
            } else {
                diagnosis.setResult("Negative");
            }
            
            // Add symptoms to the result if provided
            if (symptoms != null && !symptoms.isEmpty()) {
                String result = diagnosis.getResult();
                diagnosis.setResult("Symptoms: " + symptoms + "\n" + result);
            }
            
            // Set timestamps
            Timestamp now = new Timestamp(System.currentTimeMillis());
            diagnosis.setCreatedDate(now);
            diagnosis.setUpdatedDate(now);
            
            // Log debug info
            LOGGER.log(Level.INFO, "Creating diagnosis: PatientID={0}, NurseID={1}, Status={2}",
                  new Object[]{patientId, nurse.getNurseID(), diagnosisStatus});
            
            // Save the diagnosis
            boolean success = diagnosisDAO.addDiagnosis(diagnosis);
            
            if (success) {
                // Log the success
                LOGGER.log(Level.INFO, "Diagnosis created for patient ID " + patientId);
                
                // Set success message in session
                session.setAttribute("successMessage", "Diagnosis created successfully" + 
                    ("Referrable".equals(diagnosisStatus) ? " and referred to doctor" : ""));
                
                // Redirect to dashboard
                response.sendRedirect(request.getContextPath() + "/nurse/dashboard");
            } else {
                LOGGER.log(Level.WARNING, "Failed to create diagnosis for patient ID " + patientId);
                request.setAttribute("errorMessage", "Failed to create diagnosis. Please try again.");
                
                // Get patient and doctors again for the form
                Patient patient = patientDAO.getPatientByID(patientId);
                List<Doctor> doctors = doctorDAO.getAllDoctors();
                request.setAttribute("patient", patient);
                request.setAttribute("doctors", doctors);
                
                request.getRequestDispatcher("/WEB-INF/views/nurse/create_diagnosis.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid ID format", e);
            request.setAttribute("errorMessage", "Invalid ID format");
            request.getRequestDispatcher("/nurse/dashboard").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error creating diagnosis", e);
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/nurse/dashboard").forward(request, response);
        }
    }
} 