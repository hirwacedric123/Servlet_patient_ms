package com.pms;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Entry point servlet to check if the application is loaded and running
 */
@WebServlet("/status")
public class AppEntryPoint extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>PMS Status</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Patient Management System Status</h1>");
            out.println("<p>Application is loaded and running correctly!</p>");
            out.println("<p>Context Path: " + request.getContextPath() + "</p>");
            out.println("<p>Servlet Path: " + request.getServletPath() + "</p>");
            out.println("<p><a href='" + request.getContextPath() + "/login'>Go to Login</a></p>");
            out.println("</body>");
            out.println("</html>");
        }
    }
} 