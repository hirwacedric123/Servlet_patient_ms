package com.pms.dao;

import com.pms.model.User;
import com.pms.util.DBConnection;
import java.sql.*;

public class AdminDAO {
    
    public User authenticateAdmin(String username, String password) {
        String sql = "SELECT * FROM Admins WHERE Username = ? AND Password = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        User admin = null;
        
        try {
            System.out.println("Attempting to authenticate admin: " + username);
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                admin = new User();
                admin.setUserID(rs.getInt("AdminID"));
                admin.setUsername(rs.getString("Username"));
                admin.setPassword(rs.getString("Password"));
                admin.setUserType("Admin");
                admin.setFirstName(rs.getString("FirstName"));
                admin.setLastName(rs.getString("LastName"));
                System.out.println("Admin authentication successful for: " + username);
            } else {
                System.out.println("Admin authentication failed: Invalid credentials");
            }
        } catch (SQLException e) {
            System.out.println("SQL Error during admin authentication: " + e.getMessage());
            e.printStackTrace();
        } finally {
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
        
        return admin;
    }
    
    public boolean changeAdminPassword(String username, String newPassword) {
        String sql = "UPDATE Admins SET Password = ? WHERE Username = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPassword);
            stmt.setString(2, username);
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
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
        }
        
        return success;
    }
} 