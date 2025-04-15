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

@WebServlet("/doctor/dashboard")
public class DoctorDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
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
                // Either create a temporary doctor object with minimal info
                doctor = new Doctor();
                doctor.setId(0); // Use setId with a default ID
                doctor.setName(user.getUsername()); // Use setName
                doctor.setSpecialization("General");
                doctor.setUserId(user.getUserID()); // Use setUserId
                
                // Add a message to the request about the missing doctor record
                request.setAttribute("errorMessage", "Doctor profile is incomplete. Please contact an administrator.");
                
                // Or you could instead redirect to a profile setup page
                // response.sendRedirect(request.getContextPath() + "/doctor/setup-profile");
                // return;
            }
            
            session.setAttribute("doctor", doctor);
        }
        
        // Initialize empty lists
        List<Map<String, Object>> pendingCases = new ArrayList<>();
        List<Map<String, Object>> confirmedCases = new ArrayList<>();
        
        try {
            // Get pending patient cases (patients without diagnosis by this doctor)
            List<Patient> patients = patientDAO.getPatientsWithoutDiagnosis();
            
            for (Patient patient : patients) {
                Map<String, Object> patientData = new HashMap<>();
                patientData.put("patientID", patient.getPatientID());
                patientData.put("patientName", patient.getFirstName() + " " + patient.getLastName());
                patientData.put("patientAge", patient.getAge());
                patientData.put("patientGender", patient.getGender());
                patientData.put("symptoms", patient.getSymptoms());
                
                // Get the name of the nurse who registered this patient
                String nurseName = patientDAO.getRegisteringNurseName(patient.getPatientID());
                patientData.put("registeredByNurse", nurseName);
                
                pendingCases.add(patientData);
            }
            
            if (doctor.getId() > 0) {
                // Retrieve confirmed cases (patients with diagnosis)
                List<Diagnosis> diagnoses = diagnosisDAO.getDiagnosesByDoctorID(doctor.getId());
                
                for (Diagnosis diagnosis : diagnoses) {
                    Map<String, Object> caseDetails = new HashMap<>();
                    Patient patient = patientDAO.getPatientByID(diagnosis.getPatientID());
                    
                    if (patient != null) {
                        caseDetails.put("patientID", patient.getPatientID());
                        caseDetails.put("patientName", patient.getFirstName() + " " + patient.getLastName());
                        caseDetails.put("patientAge", patient.getAge());
                        caseDetails.put("diagnosis", diagnosis.getDiagnoStatus());
                        caseDetails.put("treatment", diagnosis.getResult());
                        caseDetails.put("diagnosisDate", diagnosis.getCreatedDate());
                        
                        confirmedCases.add(caseDetails);
                    }
                }
                
                // Get nurses registered by this doctor
                List<Nurse> nursesRegistered = nurseDAO.getNursesByDoctor(doctor.getId());
                request.setAttribute("nursesRegistered", nursesRegistered);
                request.setAttribute("nursesCount", nursesRegistered.size());
            }
        } catch (Exception e) {
            // Log the error and add an error message to the request
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving patient data: " + e.getMessage());
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