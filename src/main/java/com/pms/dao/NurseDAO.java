package com.pms.dao;

import com.pms.model.Nurse;
import com.pms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NurseDAO {
    
    public Nurse getNurseByID(int nurseID) {
        String sql = "SELECT * FROM Nurses WHERE NurseID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Nurse nurse = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, nurseID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                nurse = new Nurse();
                nurse.setNurseID(rs.getInt("NurseID"));
                nurse.setFirstName(rs.getString("FirstName"));
                nurse.setLastName(rs.getString("LastName"));
                nurse.setTelephone(rs.getString("Telephone"));
                nurse.setEmail(rs.getString("Email"));
                nurse.setAddress(rs.getString("Address"));
                nurse.setHealthCenter(rs.getString("HealthCenter"));
                nurse.setUserID(rs.getInt("UserID"));
            }
        } catch (SQLException e) {
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
        
        return nurse;
    }
    
    public Nurse getNurseByUserID(int userID) {
        String sql = "SELECT * FROM Nurses WHERE UserID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Nurse nurse = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                nurse = new Nurse();
                nurse.setNurseID(rs.getInt("NurseID"));
                nurse.setFirstName(rs.getString("FirstName"));
                nurse.setLastName(rs.getString("LastName"));
                nurse.setTelephone(rs.getString("Telephone"));
                nurse.setEmail(rs.getString("Email"));
                nurse.setAddress(rs.getString("Address"));
                nurse.setHealthCenter(rs.getString("HealthCenter"));
                nurse.setUserID(rs.getInt("UserID"));
            }
        } catch (SQLException e) {
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
        
        return nurse;
    }
    
    public List<Nurse> getAllNurses() {
        String sql = "SELECT * FROM Nurses";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Nurse> nurses = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Nurse nurse = new Nurse();
                nurse.setNurseID(rs.getInt("NurseID"));
                nurse.setFirstName(rs.getString("FirstName"));
                nurse.setLastName(rs.getString("LastName"));
                nurse.setTelephone(rs.getString("Telephone"));
                nurse.setEmail(rs.getString("Email"));
                nurse.setAddress(rs.getString("Address"));
                nurse.setHealthCenter(rs.getString("HealthCenter"));
                nurse.setUserID(rs.getInt("UserID"));
                nurses.add(nurse);
            }
        } catch (SQLException e) {
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
        
        return nurses;
    }
    
    public boolean addNurse(Nurse nurse) {
        String sql = "INSERT INTO Nurses (FirstName, LastName, Telephone, Email, Address, HealthCenter, UserID) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, nurse.getFirstName());
            stmt.setString(2, nurse.getLastName());
            stmt.setString(3, nurse.getTelephone());
            stmt.setString(4, nurse.getEmail());
            stmt.setString(5, nurse.getAddress());
            stmt.setString(6, nurse.getHealthCenter());
            stmt.setInt(7, nurse.getUserID());
            
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                result = true;
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    nurse.setNurseID(generatedKeys.getInt(1));
                }
            }
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
        
        return result;
    }
    
    public boolean updateNurse(Nurse nurse) {
        String sql = "UPDATE Nurses SET FirstName = ?, LastName = ?, Telephone = ?, Email = ?, Address = ?, HealthCenter = ? WHERE NurseID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, nurse.getFirstName());
            stmt.setString(2, nurse.getLastName());
            stmt.setString(3, nurse.getTelephone());
            stmt.setString(4, nurse.getEmail());
            stmt.setString(5, nurse.getAddress());
            stmt.setString(6, nurse.getHealthCenter());
            stmt.setInt(7, nurse.getNurseID());
            
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                result = true;
            }
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
        
        return result;
    }
    
    public boolean deleteNurse(int nurseID) {
        String sql = "DELETE FROM Nurses WHERE NurseID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, nurseID);
            
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                result = true;
            }
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
        
        return result;
    }
    
    /**
     * Get all nurses registered by a specific doctor
     * 
     * @param doctorID the ID of the doctor who registered the nurses
     * @return a list of nurses registered by the doctor
     */
    public List<Nurse> getNursesByDoctor(int doctorID) {
        String sql = "SELECT n.* FROM Nurses n WHERE n.RegisteredByDoctorID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Nurse> nurses = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, doctorID);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Nurse nurse = new Nurse();
                nurse.setNurseID(rs.getInt("NurseID"));
                nurse.setFirstName(rs.getString("FirstName"));
                nurse.setLastName(rs.getString("LastName"));
                nurse.setTelephone(rs.getString("Telephone"));
                nurse.setEmail(rs.getString("Email"));
                nurse.setAddress(rs.getString("Address"));
                nurse.setHealthCenter(rs.getString("HealthCenter"));
                nurse.setUserID(rs.getInt("UserID"));
                nurses.add(nurse);
            }
        } catch (SQLException e) {
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
        
        return nurses;
    }
} 