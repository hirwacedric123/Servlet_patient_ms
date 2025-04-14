package com.pms.controller;

import com.pms.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet("/dbtest")
public class DatabaseTestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html><head><title>Database Test</title></head><body>");
        out.println("<h1>Database Connection Test</h1>");
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            // Test database connection
            out.println("<p>Attempting to connect to database...</p>");
            conn = DBConnection.getConnection();
            out.println("<p style='color:green'>Connection successful!</p>");
            
            // Test Users table
            out.println("<p>Attempting to query Users table...</p>");
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT COUNT(*) FROM Users");
            if (rs.next()) {
                int count = rs.getInt(1);
                out.println("<p style='color:green'>Users table query successful. Found " + count + " users.</p>");
            }
            
            // Test user creation
            out.println("<h2>Database Connection Parameters:</h2>");
            out.println("<pre>URL: jdbc:mysql://localhost:3306/pms?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC</pre>");
            out.println("<pre>Username: root</pre>");
            out.println("<pre>Password: [hidden]</pre>");
            
        } catch (SQLException e) {
            out.println("<p style='color:red'>Database Error: " + e.getMessage() + "</p>");
            out.println("<pre>" + e.toString() + "</pre>");
            e.printStackTrace();
        } finally {
            // Close resources
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            DBConnection.closeConnection(conn);
        }
        
        out.println("<p><a href=\"signup\">Go to Signup Page</a></p>");
        out.println("<p><a href=\"login\">Go to Login Page</a></p>");
        out.println("</body></html>");
    }
} 