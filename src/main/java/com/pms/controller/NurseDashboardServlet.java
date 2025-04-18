package com.pms.controller;

import com.pms.dao.NurseDAO;
import com.pms.dao.PatientDAO;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/nurse/dashboard")
public class NurseDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PatientDAO patientDAO;
    private NurseDAO nurseDAO;

    @Override
    public void init() {
        patientDAO = new PatientDAO();
        nurseDAO = new NurseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in and is a nurse
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"Nurse".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get nurse information
        Nurse nurse = (Nurse) session.getAttribute("nurse");
        
        if (nurse == null) {
            // If nurse not in session, retrieve from database
            nurse = nurseDAO.getNurseByUserID(user.getUserID());
            
            // If nurse still null, handle the error case
            if (nurse == null) {
                request.setAttribute("errorMessage", "Nurse profile is incomplete. Please contact an administrator.");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }
            
            session.setAttribute("nurse", nurse);
        }
        
        // Get the success message from session if it exists and then remove it
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }
        
        // Initialize dashboard data
        List<Patient> registeredPatients = new ArrayList<>();
        int referrableCount = 0;
        int nonReferrableCount = 0;
        
        try {
            // Get patients registered by this nurse
            registeredPatients = patientDAO.getRegisteredPatientsByNurseID(nurse.getNurseID());
            
            // Count referrable and non-referrable cases
            for (Patient patient : registeredPatients) {
                if (patient.isReferrable()) {
                    referrableCount++;
                } else {
                    nonReferrableCount++;
                }
            }
            
            // Debug information to console
            System.out.println("Nurse ID: " + nurse.getNurseID());
            System.out.println("Registered Patients Count: " + registeredPatients.size());
            System.out.println("Referrable: " + referrableCount + ", Non-Referrable: " + nonReferrableCount);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving patient data: " + e.getMessage());
        }
        
        // Set attributes for the JSP
        request.setAttribute("nurse", nurse);
        request.setAttribute("registeredPatients", registeredPatients);
        request.setAttribute("patientCount", registeredPatients.size());
        request.setAttribute("referrableCount", referrableCount);
        request.setAttribute("nonReferrableCount", nonReferrableCount);
        
        // Forward to the dashboard JSP
        request.getRequestDispatcher("/WEB-INF/views/nurse/dashboard.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 