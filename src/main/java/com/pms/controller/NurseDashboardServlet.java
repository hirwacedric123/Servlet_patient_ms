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
import java.util.List;

@WebServlet("/nurse/dashboard")
public class NurseDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NurseDAO nurseDAO;
    private PatientDAO patientDAO;

    public void init() {
        nurseDAO = new NurseDAO();
        patientDAO = new PatientDAO();
    }

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
            session.setAttribute("nurse", nurse);
        }
        
        // Get patients registered by this nurse
        List<Patient> patients = patientDAO.getPatientsByNurseID(nurse.getNurseID());
        
        // Count referrable and non-referrable patients
        int referrableCount = 0;
        int notReferrableCount = 0;
        
        for (Patient patient : patients) {
            if (patient.isReferrable()) {
                referrableCount++;
            } else {
                notReferrableCount++;
            }
        }
        
        // Set attributes for the JSP
        request.setAttribute("nurse", nurse);
        request.setAttribute("registeredPatients", patients);
        request.setAttribute("referrableCount", referrableCount);
        request.setAttribute("notReferrableCount", notReferrableCount);
        
        // Forward to the dashboard JSP
        request.getRequestDispatcher("/WEB-INF/views/nurse/nurse_dashboard.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 