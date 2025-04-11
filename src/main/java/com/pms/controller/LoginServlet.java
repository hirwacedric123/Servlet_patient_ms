package com.pms.controller;

import com.pms.dao.UserDAO;
import com.pms.dao.DoctorDAO;
import com.pms.dao.NurseDAO;
import com.pms.dao.PatientDAO;
import com.pms.model.User;
import com.pms.model.Doctor;
import com.pms.model.Nurse;
import com.pms.model.Patient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private DoctorDAO doctorDAO;
    private NurseDAO nurseDAO;
    private PatientDAO patientDAO;
    
    public void init() {
        userDAO = new UserDAO();
        doctorDAO = new DoctorDAO();
        nurseDAO = new NurseDAO();
        patientDAO = new PatientDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            redirectBasedOnUserType(user, response, request);
        } else {
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        User user = userDAO.authenticate(username, password);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            if ("Doctor".equals(user.getUserType())) {
                Doctor doctor = doctorDAO.getDoctorByUserID(user.getUserID());
                session.setAttribute("doctor", doctor);
            } else if ("Nurse".equals(user.getUserType())) {
                Nurse nurse = nurseDAO.getNurseByUserID(user.getUserID());
                session.setAttribute("nurse", nurse);
            } else if ("Patient".equals(user.getUserType())) {
                Patient patient = patientDAO.getPatientByUserID(user.getUserID());
                session.setAttribute("patient", patient);
            }
            
            redirectBasedOnUserType(user, response, request);
        } else {
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
    
    private void redirectBasedOnUserType(User user, HttpServletResponse response, HttpServletRequest request) throws IOException {
        String userType = user.getUserType();
        
        switch (userType) {
            case "Admin":
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                break;
            case "Doctor":
                response.sendRedirect(request.getContextPath() + "/doctor/dashboard");
                break;
            case "Nurse":
                response.sendRedirect(request.getContextPath() + "/nurse/dashboard");
                break;
            case "Patient":
                response.sendRedirect(request.getContextPath() + "/patient/dashboard");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/login");
                break;
        }
    }
} 