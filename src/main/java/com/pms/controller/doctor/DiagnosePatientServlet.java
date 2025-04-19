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
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet({"/doctor/diagnose"})
public class DiagnosePatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(DiagnosePatientServlet.class.getName());
    
    private DiagnosisDAO diagnosisDAO;
    private PatientDAO patientDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        diagnosisDAO = new DiagnosisDAO();
        patientDAO = new PatientDAO();
    }

    @Override
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
        
        // Get diagnosis ID from request parameter
        String diagnosisId = request.getParameter("id");
        if (diagnosisId == null || diagnosisId.isEmpty()) {
            request.setAttribute("errorMessage", "Missing diagnosis ID");
            request.getRequestDispatcher("/doctor/dashboard").forward(request, response);
            return;
        }
        
        try {
            int diagnosisID = Integer.parseInt(diagnosisId);
            
            // Get the diagnosis information
            Diagnosis diagnosis = diagnosisDAO.getDiagnosisById(diagnosisID);
            
            if (diagnosis == null) {
                request.setAttribute("errorMessage", "Diagnosis not found");
                request.getRequestDispatcher("/doctor/dashboard").forward(request, response);
                return;
            }
            
            // Check if diagnosis is referrable and pending
            if (!"Referrable".equals(diagnosis.getDiagnoStatus()) || !"Pending".equals(diagnosis.getResult())) {
                if (!"Referrable".equals(diagnosis.getDiagnoStatus())) {
                    request.setAttribute("errorMessage", "Cannot update non-referrable diagnosis");
                } else {
                    request.setAttribute("errorMessage", "This diagnosis has already been updated");
                }
                request.getRequestDispatcher("/doctor/dashboard").forward(request, response);
                return;
            }
            
            // Get the patient information
            Patient patient = patientDAO.getPatientByID(diagnosis.getPatientID());
            
            if (patient == null) {
                request.setAttribute("errorMessage", "Patient not found");
                request.getRequestDispatcher("/doctor/dashboard").forward(request, response);
                return;
            }
            
            // Set attributes for the JSP
            request.setAttribute("patient", patient);
            request.setAttribute("diagnosis", diagnosis);
            
            // Get nurse name who created this diagnosis
            String nurseName = patientDAO.getNurseNameByID(diagnosis.getNurseID());
            request.setAttribute("nurseName", nurseName);
            
            // Forward to the diagnosis form JSP
            request.getRequestDispatcher("/WEB-INF/views/doctor/diagnose_form.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid diagnosis ID format: " + diagnosisId);
            request.setAttribute("errorMessage", "Invalid diagnosis ID format");
            request.getRequestDispatcher("/doctor/dashboard").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error accessing diagnosis", e);
            request.setAttribute("errorMessage", "Error accessing diagnosis: " + e.getMessage());
            request.getRequestDispatcher("/doctor/dashboard").forward(request, response);
        }
    }

    @Override
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
        String diagnosisResult = request.getParameter("diagnosisResult");
        
        if (diagnosisIdParam == null || diagnosisIdParam.isEmpty() || diagnosisResult == null || diagnosisResult.isEmpty()) {
            request.setAttribute("errorMessage", "Diagnosis ID and result are required");
            response.sendRedirect(request.getContextPath() + "/doctor/dashboard");
            return;
        }
        
        try {
            int diagnosisID = Integer.parseInt(diagnosisIdParam);
            
            // Get current diagnosis
            Diagnosis diagnosis = diagnosisDAO.getDiagnosisById(diagnosisID);
            
            if (diagnosis == null) {
                request.setAttribute("errorMessage", "Diagnosis not found");
                request.getRequestDispatcher("/doctor/dashboard").forward(request, response);
                return;
            }
            
            // Check if this diagnosis is referrable and pending
            if (!"Referrable".equals(diagnosis.getDiagnoStatus()) || !"Pending".equals(diagnosis.getResult())) {
                if (!"Referrable".equals(diagnosis.getDiagnoStatus())) {
                    request.setAttribute("errorMessage", "Cannot update non-referrable diagnosis");
                } else {
                    request.setAttribute("errorMessage", "This diagnosis has already been updated");
                }
                request.getRequestDispatcher("/doctor/dashboard").forward(request, response);
                return;
            }
            
            // Update the diagnosis
            diagnosis.setResult(diagnosisResult);
            diagnosis.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
            
            boolean updated = diagnosisDAO.updateDiagnosis(diagnosis);
            
            if (updated) {
                // Set success message and redirect to dashboard
                session.setAttribute("successMessage", "Diagnosis result updated successfully");
                response.sendRedirect(request.getContextPath() + "/doctor/dashboard");
            } else {
                // Handle update failure
                request.setAttribute("errorMessage", "Failed to update diagnosis");
                
                // Get patient for form
                Patient patient = patientDAO.getPatientByID(diagnosis.getPatientID());
                request.setAttribute("patient", patient);
                request.setAttribute("diagnosis", diagnosis);
                
                // Get nurse name who created this diagnosis
                String nurseName = patientDAO.getNurseNameByID(diagnosis.getNurseID());
                request.setAttribute("nurseName", nurseName);
                
                request.getRequestDispatcher("/WEB-INF/views/doctor/diagnose_form.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid diagnosis ID format", e);
            request.setAttribute("errorMessage", "Invalid diagnosis ID format");
            request.getRequestDispatcher("/doctor/dashboard").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error updating diagnosis", e);
            request.setAttribute("errorMessage", "Error updating diagnosis: " + e.getMessage());
            request.getRequestDispatcher("/doctor/dashboard").forward(request, response);
        }
    }
} 