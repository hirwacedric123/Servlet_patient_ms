package com.pms.dao;

import com.pms.model.Doctor;
import com.pms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DoctorDAO {
    
    public Doctor getDoctorByID(int doctorID) {
        String sql = "SELECT * FROM Doctors WHERE DoctorID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Doctor doctor = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, doctorID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                doctor = new Doctor();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setFirstName(rs.getString("FirstName"));
                doctor.setLastName(rs.getString("LastName"));
                doctor.setTelephone(rs.getString("Telephone"));
                doctor.setEmail(rs.getString("Email"));
                doctor.setAddress(rs.getString("Address"));
                doctor.setHospitalName(rs.getString("HospitalName"));
                doctor.setUserID(rs.getInt("UserID"));
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
        
        return doctor;
    }
    
    public Doctor getDoctorByUserID(int userID) {
        String sql = "SELECT * FROM Doctors WHERE UserID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Doctor doctor = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                doctor = new Doctor();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setFirstName(rs.getString("FirstName"));
                doctor.setLastName(rs.getString("LastName"));
                doctor.setTelephone(rs.getString("Telephone"));
                doctor.setEmail(rs.getString("Email"));
                doctor.setAddress(rs.getString("Address"));
                doctor.setHospitalName(rs.getString("HospitalName"));
                doctor.setUserID(rs.getInt("UserID"));
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
        
        return doctor;
    }
    
    public List<Doctor> getAllDoctors() {
        String sql = "SELECT * FROM Doctors";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Doctor> doctors = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Doctor doctor = new Doctor();
                doctor.setDoctorID(rs.getInt("DoctorID"));
                doctor.setFirstName(rs.getString("FirstName"));
                doctor.setLastName(rs.getString("LastName"));
                doctor.setTelephone(rs.getString("Telephone"));
                doctor.setEmail(rs.getString("Email"));
                doctor.setAddress(rs.getString("Address"));
                doctor.setHospitalName(rs.getString("HospitalName"));
                doctor.setUserID(rs.getInt("UserID"));
                doctors.add(doctor);
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
        
        return doctors;
    }
    
    public boolean addDoctor(Doctor doctor) {
        String sql = "INSERT INTO Doctors (FirstName, LastName, Telephone, Email, Address, HospitalName, UserID) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, doctor.getFirstName());
            stmt.setString(2, doctor.getLastName());
            stmt.setString(3, doctor.getTelephone());
            stmt.setString(4, doctor.getEmail());
            stmt.setString(5, doctor.getAddress());
            stmt.setString(6, doctor.getHospitalName());
            stmt.setInt(7, doctor.getUserID());
            
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                result = true;
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    doctor.setDoctorID(generatedKeys.getInt(1));
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
    
    public boolean updateDoctor(Doctor doctor) {
        String sql = "UPDATE Doctors SET FirstName = ?, LastName = ?, Telephone = ?, Email = ?, Address = ?, HospitalName = ? WHERE DoctorID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, doctor.getFirstName());
            stmt.setString(2, doctor.getLastName());
            stmt.setString(3, doctor.getTelephone());
            stmt.setString(4, doctor.getEmail());
            stmt.setString(5, doctor.getAddress());
            stmt.setString(6, doctor.getHospitalName());
            stmt.setInt(7, doctor.getDoctorID());
            
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
    
    public boolean deleteDoctor(int doctorID) {
        String sql = "DELETE FROM Doctors WHERE DoctorID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, doctorID);
            
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
} 