package com.pms.controller;

import com.pms.dao.DoctorDAO;
import com.pms.dao.PatientDAO;
import com.pms.dao.DiagnosisDAO;
import com.pms.dao.NurseDAO;
import com.pms.model.Doctor;
import com.pms.model.Patient;
import com.pms.model.Diagnosis;
import com.pms.model.Nurse;
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
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/doctor/dashboard")
public class DoctorDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(DoctorDashboardServlet.class.getName());
    
    private DoctorDAO doctorDAO;
    private PatientDAO patientDAO;
    private DiagnosisDAO diagnosisDAO;
    private NurseDAO nurseDAO;

    public void init() {
        doctorDAO = new DoctorDAO();
        patientDAO = new PatientDAO();
        diagnosisDAO = new DiagnosisDAO();
        nurseDAO = new NurseDAO();
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
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get doctor information
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        
        if (doctor == null) {
            // If doctor not in session, retrieve from database
            doctor = doctorDAO.getDoctorByUserID(user.getUserID());
            
            // If doctor still null, handle the error case
            if (doctor == null) {
                request.setAttribute("errorMessage", "Doctor profile is incomplete. Please contact an administrator.");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }
            
            session.setAttribute("doctor", doctor);
        }
        
        // Get success message from session if exists and then remove it
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }
        
        // Initialize dashboard data
        List<Map<String, Object>> pendingReferrals = new ArrayList<>();
        List<Map<String, Object>> completedCases = new ArrayList<>();
        List<Map<String, Object>> nonReferrableCases = new ArrayList<>();
        int pendingCount = 0;
        int confirmedCount = 0;
        int referrableCount = 0;
        int nursesCount = 0;
        
        try {
            // Get pending referrals (referrable cases with pending results)
            List<Diagnosis> pendingDiagnoses = diagnosisDAO.getReferrableDiagnosesByDoctorID(doctor.getDoctorID());
            
            for (Diagnosis diagnosis : pendingDiagnoses) {
                Map<String, Object> caseData = new HashMap<>();
                
                // Get the patient details
                Patient patient = patientDAO.getPatientByID(diagnosis.getPatientID());
                
                if (patient != null) {
                    caseData.put("diagnosisID", diagnosis.getDiagnosisID());
                    caseData.put("patientID", patient.getPatientID());
                    caseData.put("patientName", patient.getFirstName() + " " + patient.getLastName());
                    caseData.put("patientAge", patient.getAge());
                    caseData.put("patientGender", patient.getGender());
                    caseData.put("diagnosisStatus", diagnosis.getDiagnoStatus());
                    caseData.put("diagnosisResult", diagnosis.getResult());
                    caseData.put("createdDate", diagnosis.getCreatedDate());
                    
                    // Get the nurse who submitted this diagnosis
                    String nurseName = patientDAO.getNurseNameByID(diagnosis.getNurseID());
                    caseData.put("submittedByNurse", nurseName);
                    
                    if ("Pending".equals(diagnosis.getResult())) {
                        pendingReferrals.add(caseData);
                        pendingCount++;
                    } else {
                        completedCases.add(caseData);
                        confirmedCount++;
                    }
                    
                    referrableCount++;
                }
            }
            
            // Get non-referrable cases (for read-only view)
            List<Diagnosis> nonReferrableDiagnoses = diagnosisDAO.getNonReferrableDiagnoses();
            
            for (Diagnosis diagnosis : nonReferrableDiagnoses) {
                Map<String, Object> caseData = new HashMap<>();
                
                // Get the patient details
                Patient patient = patientDAO.getPatientByID(diagnosis.getPatientID());
                
                if (patient != null) {
                    caseData.put("diagnosisID", diagnosis.getDiagnosisID());
                    caseData.put("patientID", patient.getPatientID());
                    caseData.put("patientName", patient.getFirstName() + " " + patient.getLastName());
                    caseData.put("patientAge", patient.getAge());
                    caseData.put("patientGender", patient.getGender());
                    caseData.put("diagnosisStatus", diagnosis.getDiagnoStatus());
                    caseData.put("diagnosisResult", diagnosis.getResult());
                    caseData.put("createdDate", diagnosis.getCreatedDate());
                    
                    // Get the nurse who submitted this diagnosis
                    String nurseName = patientDAO.getNurseNameByID(diagnosis.getNurseID());
                    caseData.put("submittedByNurse", nurseName);
                    
                    nonReferrableCases.add(caseData);
                }
            }
            
            // Get count of nurses registered in the hospital
            List<Nurse> nurses = nurseDAO.getAllNurses();
            nursesCount = nurses.size();
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error retrieving dashboard data", e);
            request.setAttribute("errorMessage", "Error retrieving dashboard data: " + e.getMessage());
        }
        
        // Set attributes for the JSP
        request.setAttribute("doctor", doctor);
        request.setAttribute("pendingReferrals", pendingReferrals);
        request.setAttribute("completedCases", completedCases);
        request.setAttribute("nonReferrableCases", nonReferrableCases);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("confirmedCount", confirmedCount);
        request.setAttribute("referrableCount", referrableCount);
        request.setAttribute("nursesCount", nursesCount);
        
        // Forward to the dashboard JSP
        request.getRequestDispatcher("/WEB-INF/views/doctor/dashboard.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 