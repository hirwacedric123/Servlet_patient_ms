package com.pms.controller;

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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/patient/dashboard")
public class PatientDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PatientDAO patientDAO;
    private DiagnosisDAO diagnosisDAO;

    public void init() {
        patientDAO = new PatientDAO();
        diagnosisDAO = new DiagnosisDAO();
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
            
            // If patient still null, handle the error case
            if (patient == null) {
                // Create a minimal patient object as a fallback
                patient = new Patient();
                patient.setPatientID(0);
                patient.setFirstName(user.getUsername());
                patient.setLastName("");
                patient.setUserID(user.getUserID());
                
                request.setAttribute("errorMessage", "Patient profile is incomplete. Please contact an administrator.");
            }
            
            session.setAttribute("patient", patient);
        }
        
        // Get diagnoses for this patient
        List<Map<String, Object>> diagnosisDetails = new ArrayList<>();
        
        try {
            // Get diagnoses for this patient
            if (patient.getPatientID() > 0) {
                List<Diagnosis> diagnoses = diagnosisDAO.getDiagnosesByPatient(patient.getPatientID());
                
                for (Diagnosis diagnosis : diagnoses) {
                    Map<String, Object> detail = new HashMap<>();
                    detail.put("diagnosisID", diagnosis.getDiagnosisID());
                    detail.put("diagnoStatus", diagnosis.getDiagnoStatus());
                    detail.put("result", diagnosis.getResult());
                    detail.put("createdDate", diagnosis.getCreatedDate());
                    detail.put("updatedDate", diagnosis.getUpdatedDate());
                    detail.put("isPending", diagnosis.isPending());
                    detail.put("isReferrable", diagnosis.isReferrable());
                    
                    // Get nurse and doctor information if available
                    String nurseName = patientDAO.getNurseNameByID(diagnosis.getNurseID());
                    String doctorName = "";
                    if (diagnosis.getDoctorID() > 0) {
                        doctorName = patientDAO.getDoctorNameByID(diagnosis.getDoctorID());
                    }
                    
                    detail.put("nurseName", nurseName);
                    detail.put("doctorName", doctorName);
                    
                    diagnosisDetails.add(detail);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving diagnosis data: " + e.getMessage());
        }
        
        // Set attributes for the JSP
        request.setAttribute("patient", patient);
        request.setAttribute("diagnoses", diagnosisDetails);
        request.setAttribute("diagnosesCount", diagnosisDetails.size());
        request.setAttribute("hasPendingDiagnosis", diagnosisDetails.stream().anyMatch(d -> (Boolean)d.get("isPending")));
        
        // Forward to the dashboard JSP
        request.getRequestDispatcher("/WEB-INF/views/patient/patient_dashboard.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 