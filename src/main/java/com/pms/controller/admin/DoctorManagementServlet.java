package com.pms.controller.admin;

import com.pms.dao.DoctorDAO;
import com.pms.model.Doctor;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/doctors/*")
public class DoctorManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DoctorDAO doctorDAO;

    public void init() {
        doctorDAO = new DoctorDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Display all doctors
            List<Doctor> doctors = doctorDAO.getAllDoctors();
            request.setAttribute("doctors", doctors);
            request.getRequestDispatcher("/WEB-INF/views/admin/doctors/list.jsp").forward(request, response);
        } else if (pathInfo.equals("/add")) {
            // Show add doctor form
            request.getRequestDispatcher("/WEB-INF/views/admin/doctors/add.jsp").forward(request, response);
        } else if (pathInfo.equals("/edit")) {
            // Show edit doctor form
            String doctorId = request.getParameter("id");
            Doctor doctor = doctorDAO.getDoctorById(Integer.parseInt(doctorId));
            request.setAttribute("doctor", doctor);
            request.getRequestDispatcher("/WEB-INF/views/admin/doctors/edit.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo.equals("/add")) {
            // Handle add doctor
            Doctor doctor = new Doctor();
            doctor.setName(request.getParameter("name"));
            doctor.setSpecialization(request.getParameter("specialization"));
            doctor.setEmail(request.getParameter("email"));
            doctor.setPhone(request.getParameter("phone"));
            doctor.setAddress(request.getParameter("address"));
            
            doctorDAO.addDoctor(doctor);
            response.sendRedirect(request.getContextPath() + "/admin/doctors");
            
        } else if (pathInfo.equals("/edit")) {
            // Handle edit doctor
            Doctor doctor = new Doctor();
            doctor.setId(Integer.parseInt(request.getParameter("id")));
            doctor.setName(request.getParameter("name"));
            doctor.setSpecialization(request.getParameter("specialization"));
            doctor.setEmail(request.getParameter("email"));
            doctor.setPhone(request.getParameter("phone"));
            doctor.setAddress(request.getParameter("address"));
            
            doctorDAO.updateDoctor(doctor);
            response.sendRedirect(request.getContextPath() + "/admin/doctors");
            
        } else if (pathInfo.equals("/delete")) {
            // Handle delete doctor
            int doctorId = Integer.parseInt(request.getParameter("id"));
            doctorDAO.deleteDoctor(doctorId);
            response.sendRedirect(request.getContextPath() + "/admin/doctors");
        }
    }
} 