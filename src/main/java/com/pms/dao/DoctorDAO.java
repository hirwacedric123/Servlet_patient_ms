package com.pms.dao;

import com.pms.model.Doctor;
import com.pms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DoctorDAO {
    private Connection connection;

    public DoctorDAO() {
        try {
            connection = DBConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to establish database connection", e);
        }
    }

    public void addDoctor(Doctor doctor) {
        try {
            PreparedStatement ps = connection.prepareStatement(
                "INSERT INTO doctors (UserID, FirstName, LastName, Specialization, ContactNumber, Email, Address, HospitalName) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
            );
            ps.setInt(1, doctor.getUserId());
            
            // Split name into first name and last name
            String[] nameParts = doctor.getName().split(" ", 2);
            String firstName = nameParts[0];
            String lastName = nameParts.length > 1 ? nameParts[1] : "";
            
            ps.setString(2, firstName);
            ps.setString(3, lastName);
            ps.setString(4, doctor.getSpecialization());
            ps.setString(5, doctor.getPhone());
            ps.setString(6, doctor.getEmail());
            ps.setString(7, doctor.getAddress());
            ps.setString(8, doctor.getHospitalName());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateDoctor(Doctor doctor) {
        try {
            PreparedStatement ps = connection.prepareStatement(
                "UPDATE doctors SET name=?, specialization=?, email=?, phone=?, address=?, active=? WHERE id=?"
            );
            ps.setString(1, doctor.getName());
            ps.setString(2, doctor.getSpecialization());
            ps.setString(3, doctor.getEmail());
            ps.setString(4, doctor.getPhone());
            ps.setString(5, doctor.getAddress());
            ps.setBoolean(6, doctor.isActive());
            ps.setInt(7, doctor.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteDoctor(int id) {
        try {
            PreparedStatement ps = connection.prepareStatement("DELETE FROM doctors WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Doctor> getAllDoctors() {
        List<Doctor> doctors = new ArrayList<>();
        try {
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM doctors ORDER BY FirstName, LastName");
            while (rs.next()) {
                Doctor doctor = new Doctor();
                doctor.setId(rs.getInt("DoctorID"));
                doctor.setUserId(rs.getInt("UserID"));
                
                // Combine first and last name
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");
                doctor.setName(firstName + " " + lastName);
                
                doctor.setSpecialization(rs.getString("Specialization"));
                doctor.setEmail(rs.getString("Email"));
                doctor.setPhone(rs.getString("ContactNumber"));
                doctor.setAddress(rs.getString("Address"));
                doctor.setHospitalName(rs.getString("HospitalName"));
                doctor.setActive(true); // Default to active
                doctors.add(doctor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doctors;
    }

    public Doctor getDoctorById(int id) {
        Doctor doctor = null;
        try {
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM doctors WHERE DoctorID=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                doctor = new Doctor();
                doctor.setId(rs.getInt("DoctorID"));
                doctor.setUserId(rs.getInt("UserID"));
                
                // Combine first and last name
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");
                doctor.setName(firstName + " " + lastName);
                
                doctor.setSpecialization(rs.getString("Specialization"));
                doctor.setEmail(rs.getString("Email"));
                doctor.setPhone(rs.getString("ContactNumber"));
                doctor.setAddress(rs.getString("Address"));
                doctor.setHospitalName(rs.getString("HospitalName"));
                doctor.setActive(true); // Default to active
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doctor;
    }

    public Doctor getDoctorByUserID(int userId) {
        Doctor doctor = null;
        try {
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM doctors WHERE user_id=?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                doctor = new Doctor();
                doctor.setId(rs.getInt("id"));
                doctor.setName(rs.getString("name"));
                doctor.setSpecialization(rs.getString("specialization"));
                doctor.setEmail(rs.getString("email"));
                doctor.setPhone(rs.getString("phone"));
                doctor.setAddress(rs.getString("address"));
                doctor.setActive(rs.getBoolean("active"));
                doctor.setUserId(rs.getInt("user_id"));
                doctor.setHospitalName(rs.getString("hospital_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doctor;
    }
} 