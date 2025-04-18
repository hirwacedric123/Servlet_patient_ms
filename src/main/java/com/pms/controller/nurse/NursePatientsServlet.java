package com.pms.controller.nurse;

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
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/nurse/patients")
public class NursePatientsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(NursePatientsServlet.class.getName());
    
    private PatientDAO patientDAO;
    private NurseDAO nurseDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        patientDAO = new PatientDAO();
        nurseDAO = new NurseDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in and is a nurse
        if (session == null || session.getAttribute("user") == null) {
            LOGGER.log(Level.INFO, "No valid session found, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"Nurse".equals(user.getUserType())) {
            LOGGER.log(Level.WARNING, "Unauthorized access attempt to nurse section by user type: {0}", user.getUserType());
            response.sendRedirect(request.getContextPath() + "/access-denied");
            return;
        }
        
        // Get nurse information
        Nurse nurse = (Nurse) session.getAttribute("nurse");
        
        if (nurse == null) {
            // If nurse not in session, retrieve from database
            LOGGER.log(Level.INFO, "Retrieving nurse data for user ID: {0}", user.getUserID());
            nurse = nurseDAO.getNurseByUserID(user.getUserID());
            
            // If nurse still null, handle the error case
            if (nurse == null) {
                LOGGER.log(Level.WARNING, "Nurse profile not found for user ID: {0}", user.getUserID());
                request.setAttribute("errorMessage", "Nurse profile is incomplete. Please contact an administrator.");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }
            
            session.setAttribute("nurse", nurse);
        }
        
        // Get the success/warning messages from session if they exist and then remove them
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }
        
        String warningMessage = (String) session.getAttribute("warningMessage");
        if (warningMessage != null) {
            request.setAttribute("warningMessage", warningMessage);
            session.removeAttribute("warningMessage");
        }
        
        // Initialize patient list
        List<Patient> patients = new ArrayList<>();
        int referrableCount = 0;
        int nonReferrableCount = 0;
        
        try {
            // Get patients registered by this nurse
            LOGGER.log(Level.INFO, "Retrieving patients for nurse ID: {0}", nurse.getNurseID());
            
            // Use the new method to get all patients in the system
            patients = patientDAO.getAllPatientsForNurse(nurse.getNurseID());
            
            // Count referrable and non-referrable cases
            for (Patient patient : patients) {
                if (patient.isReferrable()) {
                    referrableCount++;
                } else {
                    nonReferrableCount++;
                }
            }
            
            LOGGER.log(Level.INFO, "Found {0} patients, {1} referrable, {2} non-referrable", 
                       new Object[]{patients.size(), referrableCount, nonReferrableCount});
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error retrieving patient data", e);
            request.setAttribute("errorMessage", "Error retrieving patient data: " + e.getMessage());
        }
        
        // Set attributes for the JSP
        request.setAttribute("nurse", nurse);
        request.setAttribute("patients", patients);
        request.setAttribute("patientCount", patients.size());
        request.setAttribute("referrableCount", referrableCount);
        request.setAttribute("nonReferrableCount", nonReferrableCount);
        
        // Forward to the patients JSP
        LOGGER.log(Level.INFO, "Forwarding to patients view for nurse ID: {0}", nurse.getNurseID());
        request.getRequestDispatcher("/WEB-INF/views/nurse/nurse_dashboard.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 