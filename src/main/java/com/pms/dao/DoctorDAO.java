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
                "INSERT INTO doctors (name, specialization, email, phone, address, active) VALUES (?, ?, ?, ?, ?, ?)"
            );
            ps.setString(1, doctor.getName());
            ps.setString(2, doctor.getSpecialization());
            ps.setString(3, doctor.getEmail());
            ps.setString(4, doctor.getPhone());
            ps.setString(5, doctor.getAddress());
            ps.setBoolean(6, doctor.isActive());
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
            ResultSet rs = statement.executeQuery("SELECT * FROM doctors ORDER BY name");
            while (rs.next()) {
                Doctor doctor = new Doctor();
                doctor.setId(rs.getInt("id"));
                doctor.setName(rs.getString("name"));
                doctor.setSpecialization(rs.getString("specialization"));
                doctor.setEmail(rs.getString("email"));
                doctor.setPhone(rs.getString("phone"));
                doctor.setAddress(rs.getString("address"));
                doctor.setActive(rs.getBoolean("active"));
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
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM doctors WHERE id=?");
            ps.setInt(1, id);
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doctor;
    }
} 