package com.pms.controller.doctor;

import com.pms.dao.DiagnosisDAO;
import com.pms.dao.PatientDAO;
import com.pms.model.Diagnosis;
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

@WebServlet({"/doctor/diagnose"})
public class DiagnosePatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DiagnosisDAO diagnosisDAO;
    private PatientDAO patientDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        diagnosisDAO = new DiagnosisDAO();
        patientDAO = new PatientDAO();
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
            response.sendRedirect(request.getContextPath() + "/access-denied");
            return;
        }
        
        // Get the patient ID from the request
        String patientId = request.getParameter("id");
        if (patientId == null || patientId.isEmpty()) {
            request.setAttribute("errorMessage", "No patient ID provided");
            request.getRequestDispatcher("/doctor/dashboard").forward(request, response);
            return;
        }
        
        try {
            int patientID = Integer.parseInt(patientId);
            
            // Get the patient information
            Patient patient = patientDAO.getPatientByID(patientID);
            
            if (patient == null) {
                request.setAttribute("errorMessage", "Patient not found");
                request.getRequestDispatcher("/doctor/dashboard").forward(request, response);
                return;
            }
            
            // Get diagnosis or create a new one if it doesn't exist
            Diagnosis diagnosis = diagnosisDAO.getDiagnosisByPatientID(patientID);
            
            if (diagnosis == null) {
                // Create a new diagnosis for this patient
                diagnosis = new Diagnosis();
                diagnosis.setPatientID(patientID);
                
                // Get the doctor ID from the session
                int doctorId = 0;
                if (session.getAttribute("doctor") != null) {
                    doctorId = ((com.pms.model.Doctor) session.getAttribute("doctor")).getId();
                } else {
                    doctorId = user.getUserID();
                }
                
                diagnosis.setDoctorID(doctorId);
                
                // Use the User ID as nurse ID temporarily (or fetch from patient record if possible)
                // For a real system, you should store or retrieve the actual nurse ID
                int nurseId = 0;
                try {
                    // Try to get the nurse ID associated with the patient
                    nurseId = patient.getCreatedBy();
                } catch (Exception e) {
                    // If not available, use the first available nurse or a default value
                    nurseId = 1; // Default to first nurse ID
                }
                
                diagnosis.setNurseID(nurseId);
                diagnosis.setDiagnoStatus("Referrable"); // Default to referrable
                diagnosis.setResult("Pending"); // Default to pending
                
                // Set timestamps
                Timestamp now = new Timestamp(System.currentTimeMillis());
                diagnosis.setCreatedDate(now);
                diagnosis.setUpdatedDate(now);
                
                // Add the diagnosis to the database
                boolean added = diagnosisDAO.addDiagnosis(diagnosis);
                
                if (!added) {
                    request.setAttribute("errorMessage", "Failed to create diagnosis record");
                    request.getRequestDispatcher("/doctor/dashboard").forward(request, response);
                    return;
                }
                
                // Get the newly created diagnosis with its ID
                diagnosis = diagnosisDAO.getDiagnosisByPatientID(patientID);
                
                if (diagnosis == null) {
                    request.setAttribute("errorMessage", "Failed to retrieve newly created diagnosis");
                    request.getRequestDispatcher("/doctor/dashboard").forward(request, response);
                    return;
                }
            }
            
            // Set attributes for the JSP
            request.setAttribute("patient", patient);
            request.setAttribute("diagnosis", diagnosis);
            
            // Forward to the diagnosis form JSP
            request.getRequestDispatcher("/WEB-INF/views/doctor/diagnose_form.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid patient ID");
            request.getRequestDispatcher("/doctor/dashboard").forward(request, response);
        }
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
            response.sendRedirect(request.getContextPath() + "/access-denied");
            return;
        }
        
        // Get form data
        String diagnosisIdParam = request.getParameter("diagnosisId");
        String patientIdParam = request.getParameter("patientId");
        String diagnosisResult = request.getParameter("diagnosisResult");
        
        if (diagnosisIdParam == null || patientIdParam == null || diagnosisResult == null) {
            request.setAttribute("errorMessage", "Missing required parameters");
            response.sendRedirect(request.getContextPath() + "/doctor/dashboard");
            return;
        }
        
        try {
            int diagnosisId = Integer.parseInt(diagnosisIdParam);
            int patientId = Integer.parseInt(patientIdParam);
            
            // Get the diagnosis from the database
            Diagnosis diagnosis = diagnosisDAO.getDiagnosisByID(diagnosisId);
            
            if (diagnosis == null) {
                session.setAttribute("errorMessage", "Diagnosis not found");
                response.sendRedirect(request.getContextPath() + "/doctor/dashboard");
                return;
            }
            
            // Get the doctor ID from the session (User ID or Doctor ID based on your implementation)
            int doctorId = 0;
            if (session.getAttribute("doctor") != null) {
                // If doctor object is in session, use its ID
                doctorId = ((com.pms.model.Doctor) session.getAttribute("doctor")).getId();
            } else {
                // Otherwise, use the user ID as doctor ID
                doctorId = user.getUserID();
            }
            
            // Update the diagnosis
            diagnosis.setDoctorID(doctorId);
            diagnosis.setResult(diagnosisResult);
            diagnosis.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
            
            boolean updated = diagnosisDAO.updateDiagnosis(diagnosis);
            
            if (updated) {
                session.setAttribute("successMessage", "Diagnosis updated successfully");
            } else {
                session.setAttribute("errorMessage", "Failed to update diagnosis");
            }
            
            // Redirect back to the dashboard
            response.sendRedirect(request.getContextPath() + "/doctor/dashboard");
            
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid diagnosis or patient ID");
            response.sendRedirect(request.getContextPath() + "/doctor/dashboard");
        }
    }
} 