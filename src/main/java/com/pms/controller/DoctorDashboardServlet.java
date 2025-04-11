package com.pms.controller;

import com.pms.dao.DoctorDAO;
import com.pms.dao.PatientDAO;
import com.pms.dao.DiagnosisDAO;
import com.pms.model.Doctor;
import com.pms.model.Patient;
import com.pms.model.Diagnosis;
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

@WebServlet("/doctor/dashboard")
public class DoctorDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DoctorDAO doctorDAO;
    private PatientDAO patientDAO;
    private DiagnosisDAO diagnosisDAO;

    public void init() {
        doctorDAO = new DoctorDAO();
        patientDAO = new PatientDAO();
        diagnosisDAO = new DiagnosisDAO();
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
            session.setAttribute("doctor", doctor);
        }
        
        // Retrieve pending cases (patients without diagnosis)
        List<Map<String, Object>> pendingCases = new ArrayList<>();
        List<Patient> patientsWithoutDiagnosis = patientDAO.getPatientsWithoutDiagnosis();
        
        for (Patient patient : patientsWithoutDiagnosis) {
            Map<String, Object> caseDetails = new HashMap<>();
            caseDetails.put("patientID", patient.getPatientID());
            caseDetails.put("patientName", patient.getFirstName() + " " + patient.getLastName());
            caseDetails.put("patientAge", patient.getAge());
            caseDetails.put("patientGender", patient.getGender());
            caseDetails.put("symptoms", patient.getSymptoms());
            
            // Get nurse name who registered the patient
            String nurseName = patientDAO.getRegisteringNurseName(patient.getPatientID());
            caseDetails.put("registeredByNurse", nurseName);
            
            pendingCases.add(caseDetails);
        }
        
        // Retrieve confirmed cases (patients with diagnosis)
        List<Map<String, Object>> confirmedCases = new ArrayList<>();
        List<Diagnosis> diagnoses = diagnosisDAO.getDiagnosesByDoctorID(doctor.getDoctorID());
        
        for (Diagnosis diagnosis : diagnoses) {
            Map<String, Object> caseDetails = new HashMap<>();
            Patient patient = patientDAO.getPatientByID(diagnosis.getPatientID());
            
            caseDetails.put("patientID", patient.getPatientID());
            caseDetails.put("patientName", patient.getFirstName() + " " + patient.getLastName());
            caseDetails.put("patientAge", patient.getAge());
            caseDetails.put("diagnosis", diagnosis.getDiagnosis());
            caseDetails.put("treatment", diagnosis.getTreatment());
            caseDetails.put("diagnosisDate", diagnosis.getDiagnosisDate());
            
            confirmedCases.add(caseDetails);
        }
        
        // Set attributes for the JSP
        request.setAttribute("doctor", doctor);
        request.setAttribute("pendingCases", pendingCases);
        request.setAttribute("confirmedCases", confirmedCases);
        request.setAttribute("pendingCasesCount", pendingCases.size());
        request.setAttribute("confirmedCasesCount", confirmedCases.size());
        
        // Forward to the dashboard JSP
        request.getRequestDispatcher("/WEB-INF/views/doctor/doctor_dashboard.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 