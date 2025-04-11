package com.pms.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pms.util.DBConnection;
import com.pms.util.PasswordUtil;

/**
 * Utility servlet to update admin password to use BCrypt
 * This should be removed after initial use for security reasons
 */
@WebServlet("/admin/update-password")
public class AdminPasswordUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><head><title>Admin Password Update</title></head><body>");
        
        // Only accessible from localhost for security
        String remoteAddr = request.getRemoteAddr();
        if (!remoteAddr.equals("127.0.0.1") && !remoteAddr.equals("0:0:0:0:0:0:0:1")) {
            out.println("<h2>Access Denied</h2>");
            out.println("<p>This utility can only be accessed from the local machine.</p>");
            out.println("</body></html>");
            return;
        }
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            // Get the admin's current password
            String plainPassword = "admin123"; // The current plain text password
            
            // Hash it using BCrypt
            String hashedPassword = PasswordUtil.hashPassword(plainPassword);
            
            // Update the admin password
            conn = DBConnection.getConnection();
            String sql = "UPDATE users SET Password = ? WHERE Username = 'admin'";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, hashedPassword);
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                out.println("<h2>Success!</h2>");
                out.println("<p>Admin password has been updated to use BCrypt.</p>");
                out.println("<p>New hashed password: " + hashedPassword + "</p>");
                out.println("<p>You can now log in with username 'admin' and password 'admin123'.</p>");
            } else {
                out.println("<h2>Error</h2>");
                out.println("<p>Failed to update admin password. Admin user may not exist.</p>");
            }
            
        } catch (SQLException e) {
            out.println("<h2>Error</h2>");
            out.println("<p>Database error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            DBConnection.closeConnection(conn);
            
            out.println("<p><a href=\"" + request.getContextPath() + "/login\">Go to Login Page</a></p>");
            out.println("</body></html>");
        }
    }
} 