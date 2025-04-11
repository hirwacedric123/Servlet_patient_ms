package com.pms.controller.admin;

import com.pms.dao.DoctorDAO;
import com.pms.dao.NurseDAO;
import com.pms.dao.PatientDAO;
import com.pms.dao.UserDAO;
import com.pms.model.Doctor;
import com.pms.model.Nurse;
import com.pms.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DoctorDAO doctorDAO;
    private NurseDAO nurseDAO;
    private PatientDAO patientDAO;
    private UserDAO userDAO;
    
    public void init() {
        doctorDAO = new DoctorDAO();
        nurseDAO = new NurseDAO();
        patientDAO = new PatientDAO();
        userDAO = new UserDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in and is admin
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"Admin".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get counts for dashboard stats
        int doctorCount = doctorDAO.getAllDoctors().size();
        int nurseCount = nurseDAO.getAllNurses().size();
        int patientCount = patientDAO.getAllPatients().size();
        int userCount = userDAO.getAllUsers().size();
        
        // Get lists of doctors and nurses
        List<Doctor> doctors = doctorDAO.getAllDoctors();
        List<Nurse> nurses = nurseDAO.getAllNurses();
        
        // Set attributes for the dashboard
        request.setAttribute("doctorCount", doctorCount);
        request.setAttribute("nurseCount", nurseCount);
        request.setAttribute("patientCount", patientCount);
        request.setAttribute("userCount", userCount);
        request.setAttribute("doctors", doctors);
        request.setAttribute("nurses", nurses);
        
        // Forward to the dashboard JSP
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 