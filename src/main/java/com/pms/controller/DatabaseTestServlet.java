package com.pms.controller;

import com.pms.dao.NurseDAO;
import com.pms.dao.PatientDAO;
import com.pms.dao.DiagnosisDAO;
import com.pms.dao.UserDAO;
import com.pms.model.Diagnosis;
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
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/debug/database-test")
public class DatabaseTestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private PatientDAO patientDAO;
    private NurseDAO nurseDAO;
    private UserDAO userDAO;
    private DiagnosisDAO diagnosisDAO;
    
    @Override
    public void init() {
        patientDAO = new PatientDAO();
        nurseDAO = new NurseDAO();
        userDAO = new UserDAO();
        diagnosisDAO = new DiagnosisDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User currentUser = (User) session.getAttribute("user");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html><head><title>Database Diagnostic</title>");
        out.println("<style>body { font-family: Arial, sans-serif; margin: 20px; }");
        out.println("h1, h2 { color: #3498db; }");
        out.println("table { border-collapse: collapse; width: 100%; margin-bottom: 20px; }");
        out.println("th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }");
        out.println("th { background-color: #f2f2f2; }");
        out.println("tr:nth-child(even) { background-color: #f9f9f9; }");
        out.println("</style></head><body>");
        
        out.println("<h1>Database Diagnostic Tool</h1>");
        out.println("<p>Current user: " + currentUser.getFirstName() + " " + currentUser.getLastName() + " (UserID: " + currentUser.getUserID() + ", Role: " + currentUser.getUserType() + ")</p>");
        
        // Show a form to create a test patient if requested
        out.println("<h2>Create Test Patient</h2>");
        out.println("<form method='post' action='" + request.getContextPath() + "/debug/database-test'>");
        out.println("<button type='submit' name='action' value='create_test_patient'>Create Test Patient</button>");
        out.println("</form>");
        
        // User Data
        out.println("<h2>Users Table</h2>");
        List<User> users = userDAO.getAllUsers();
        out.println("<p>Total users: " + users.size() + "</p>");
        out.println("<table>");
        out.println("<tr><th>UserID</th><th>Username</th><th>FirstName</th><th>LastName</th><th>Role</th></tr>");
        
        for (User user : users) {
            out.println("<tr>");
            out.println("<td>" + user.getUserID() + "</td>");
            out.println("<td>" + user.getUsername() + "</td>");
            out.println("<td>" + user.getFirstName() + "</td>");
            out.println("<td>" + user.getLastName() + "</td>");
            out.println("<td>" + user.getUserType() + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
        
        // Nurse Data
        Nurse nurse = null;
        if ("Nurse".equals(currentUser.getUserType())) {
            nurse = nurseDAO.getNurseByUserID(currentUser.getUserID());
            
            out.println("<h2>Current Nurse Information</h2>");
            out.println("<p>NurseID: " + (nurse != null ? nurse.getNurseID() : "Not found") + "</p>");
            out.println("<p>UserID: " + (nurse != null ? nurse.getUserID() : "Not found") + "</p>");
            out.println("<p>Name: " + (nurse != null ? nurse.getFirstName() + " " + nurse.getLastName() : "Not found") + "</p>");
        }
        
        // Patient Data
        out.println("<h2>Patients</h2>");
        List<Patient> allPatients = patientDAO.getAllPatients();
        out.println("<p>Total patients: " + allPatients.size() + "</p>");
        
        if (nurse != null) {
            List<Patient> nursePatients = patientDAO.getPatientsByNurseID(nurse.getNurseID());
            out.println("<p>Patients by NurseID method: " + nursePatients.size() + "</p>");
            
            List<Patient> registeredPatients = patientDAO.getRegisteredPatientsByNurseID(nurse.getNurseID());
            out.println("<p>Patients by RegisteredByNurseID method: " + registeredPatients.size() + "</p>");
        }
        
        out.println("<table>");
        out.println("<tr><th>PatientID</th><th>Name</th><th>Gender</th><th>Contact</th><th>Email</th></tr>");
        
        for (Patient patient : allPatients) {
            out.println("<tr>");
            out.println("<td>" + patient.getPatientID() + "</td>");
            out.println("<td>" + patient.getFirstName() + " " + patient.getLastName() + "</td>");
            out.println("<td>" + patient.getGender() + "</td>");
            out.println("<td>" + patient.getContactNumber() + "</td>");
            out.println("<td>" + patient.getEmail() + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
        
        // Diagnosis Data
        out.println("<h2>Diagnosis Records</h2>");
        List<Diagnosis> allDiagnoses = diagnosisDAO.getAllDiagnoses();
        out.println("<p>Total diagnosis records: " + allDiagnoses.size() + "</p>");
        
        out.println("<table>");
        out.println("<tr><th>DiagnosisID</th><th>PatientID</th><th>NurseID</th><th>DoctorID</th><th>Status</th><th>Date</th></tr>");
        
        for (Diagnosis diag : allDiagnoses) {
            out.println("<tr>");
            out.println("<td>" + diag.getDiagnosisID() + "</td>");
            out.println("<td>" + diag.getPatientID() + "</td>");
            out.println("<td>" + diag.getNurseID() + "</td>");
            out.println("<td>" + diag.getDoctorID() + "</td>");
            out.println("<td>" + diag.getDiagnoStatus() + "</td>");
            out.println("<td>" + diag.getCreatedDate() + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
        
        out.println("</body></html>");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("create_test_patient".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            
            User currentUser = (User) session.getAttribute("user");
            
            // Create a test user
            User testUser = new User();
            testUser.setUsername("testpatient" + System.currentTimeMillis());
            testUser.setPassword("Test123");
            testUser.setUserType("Patient");
            testUser.setFirstName("Test");
            testUser.setLastName("Patient");
            
            boolean userCreated = userDAO.addUser(testUser);
            
            if (userCreated) {
                // Create patient record
                Patient patient = new Patient();
                patient.setUserID(testUser.getUserID());
                patient.setFirstName(testUser.getFirstName());
                patient.setLastName(testUser.getLastName());
                patient.setGender("Male");
                patient.setContactNumber("1234567890");
                patient.setEmail("test@example.com");
                patient.setAddress("Test Address");
                
                boolean patientAdded = patientDAO.addPatient(patient);
                
                if (patientAdded) {
                    // Create diagnosis record
                    Diagnosis diagnosis = new Diagnosis();
                    diagnosis.setPatientID(patient.getPatientID());
                    diagnosis.setNurseID(currentUser.getUserID());
                    diagnosis.setDiagnoStatus("Not Referrable");
                    diagnosis.setResult("Test patient for debugging");
                    diagnosis.setCreatedDate(new Timestamp(System.currentTimeMillis()));
                    diagnosis.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
                    
                    boolean diagnosisAdded = diagnosisDAO.addDiagnosis(diagnosis);
                    
                    if (diagnosisAdded) {
                        session.setAttribute("successMessage", "Test patient created successfully!");
                    } else {
                        session.setAttribute("errorMessage", "Failed to create diagnosis record");
                    }
                } else {
                    session.setAttribute("errorMessage", "Failed to create patient record");
                }
            } else {
                session.setAttribute("errorMessage", "Failed to create user record");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/debug/database-test");
    }
} 