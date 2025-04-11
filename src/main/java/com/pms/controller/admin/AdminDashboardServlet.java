package com.pms.controller.admin;

import com.pms.dao.*;
import com.pms.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAO userDAO;
    private DoctorDAO doctorDAO;
    private NurseDAO nurseDAO;
    private PatientDAO patientDAO;
    private DiagnosisDAO diagnosisDAO;
    
    public void init() {
        userDAO = new UserDAO();
        doctorDAO = new DoctorDAO();
        nurseDAO = new NurseDAO();
        patientDAO = new PatientDAO();
        diagnosisDAO = new DiagnosisDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"Admin".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get counts for dashboard
        List<Doctor> doctors = doctorDAO.getAllDoctors();
        List<Nurse> nurses = nurseDAO.getAllNurses();
        List<Patient> patients = patientDAO.getAllPatients();
        List<Diagnosis> diagnoses = diagnosisDAO.getAllDiagnoses();
        
        request.setAttribute("doctorCount", doctors.size());
        request.setAttribute("nurseCount", nurses.size());
        request.setAttribute("patientCount", patients.size());
        request.setAttribute("diagnosisCount", diagnoses.size());
        
        // Get recent doctors (limit to 5)
        List<Doctor> recentDoctors = doctors.size() > 5 ? doctors.subList(0, 5) : doctors;
        request.setAttribute("recentDoctors", recentDoctors);
        
        // Get recent nurses (limit to 5)
        List<Nurse> recentNurses = nurses.size() > 5 ? nurses.subList(0, 5) : nurses;
        request.setAttribute("recentNurses", recentNurses);
        
        // Get recent diagnoses with additional information (limit to 10)
        List<Map<String, Object>> recentDiagnosesWithInfo = new ArrayList<>();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        
        List<Diagnosis> recentDiagnoses = diagnoses.size() > 10 ? diagnoses.subList(0, 10) : diagnoses;
        
        for (Diagnosis diagnosis : recentDiagnoses) {
            Map<String, Object> diagnosisInfo = new HashMap<>();
            diagnosisInfo.put("diagnosisID", diagnosis.getDiagnosisID());
            diagnosisInfo.put("diagnoStatus", diagnosis.getDiagnoStatus());
            diagnosisInfo.put("formattedDate", dateFormat.format(diagnosis.getCreatedDate()));
            
            // Get patient name
            Patient patient = patientDAO.getPatientByID(diagnosis.getPatientID());
            if (patient != null) {
                diagnosisInfo.put("patientName", patient.getFirstName() + " " + patient.getLastName());
            } else {
                diagnosisInfo.put("patientName", "Unknown");
            }
            
            // Get nurse name
            Nurse nurse = nurseDAO.getNurseByID(diagnosis.getNurseID());
            if (nurse != null) {
                diagnosisInfo.put("nurseName", nurse.getFirstName() + " " + nurse.getLastName());
            } else {
                diagnosisInfo.put("nurseName", "Unknown");
            }
            
            // Get doctor name if assigned
            if (diagnosis.getDoctorID() != null) {
                Doctor doctor = doctorDAO.getDoctorByID(diagnosis.getDoctorID());
                if (doctor != null) {
                    diagnosisInfo.put("doctorName", doctor.getFirstName() + " " + doctor.getLastName());
                } else {
                    diagnosisInfo.put("doctorName", "Unknown");
                }
            } else {
                diagnosisInfo.put("doctorName", "Not Assigned");
            }
            
            recentDiagnosesWithInfo.add(diagnosisInfo);
        }
        
        request.setAttribute("recentDiagnoses", recentDiagnosesWithInfo);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 