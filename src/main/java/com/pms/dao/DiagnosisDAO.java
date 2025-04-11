package com.pms.dao;

import com.pms.model.Diagnosis;
import com.pms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DiagnosisDAO {
    
    /**
     * Get diagnosis by ID
     * 
     * @param diagnosisID the ID of the diagnosis
     * @return the diagnosis or null if not found
     */
    public Diagnosis getDiagnosisByID(int diagnosisID) {
        String sql = "SELECT * FROM diagnosis WHERE DiagnosisID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Diagnosis diagnosis = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, diagnosisID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                diagnosis = new Diagnosis();
                diagnosis.setDiagnosisID(rs.getInt("DiagnosisID"));
                diagnosis.setPatientID(rs.getInt("PatientID"));
                diagnosis.setDoctorID(rs.getInt("DoctorID"));
                diagnosis.setDiagnosis(rs.getString("Diagnosis"));
                diagnosis.setTreatment(rs.getString("Treatment"));
                diagnosis.setDiagnosisDate(rs.getTimestamp("DiagnosisDate"));
                diagnosis.setNotes(rs.getString("Notes"));
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
        
        return diagnosis;
    }
    
    /**
     * Get all diagnoses
     * 
     * @return a list of all diagnoses
     */
    public List<Diagnosis> getAllDiagnoses() {
        String sql = "SELECT * FROM diagnosis";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Diagnosis> diagnoses = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Diagnosis diagnosis = new Diagnosis();
                diagnosis.setDiagnosisID(rs.getInt("DiagnosisID"));
                diagnosis.setPatientID(rs.getInt("PatientID"));
                diagnosis.setDoctorID(rs.getInt("DoctorID"));
                diagnosis.setDiagnosis(rs.getString("Diagnosis"));
                diagnosis.setTreatment(rs.getString("Treatment"));
                diagnosis.setDiagnosisDate(rs.getTimestamp("DiagnosisDate"));
                diagnosis.setNotes(rs.getString("Notes"));
                diagnoses.add(diagnosis);
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
        
        return diagnoses;
    }
    
    /**
     * Get all diagnoses by patient ID
     * 
     * @param patientID the ID of the patient
     * @return a list of diagnoses for the patient
     */
    public List<Diagnosis> getDiagnosesByPatient(int patientID) {
        String sql = "SELECT * FROM diagnosis WHERE PatientID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Diagnosis> diagnoses = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, patientID);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Diagnosis diagnosis = new Diagnosis();
                diagnosis.setDiagnosisID(rs.getInt("DiagnosisID"));
                diagnosis.setPatientID(rs.getInt("PatientID"));
                diagnosis.setDoctorID(rs.getInt("DoctorID"));
                diagnosis.setDiagnosis(rs.getString("Diagnosis"));
                diagnosis.setTreatment(rs.getString("Treatment"));
                diagnosis.setDiagnosisDate(rs.getTimestamp("DiagnosisDate"));
                diagnosis.setNotes(rs.getString("Notes"));
                diagnoses.add(diagnosis);
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
        
        return diagnoses;
    }
    
    /**
     * Get all diagnoses made by a specific doctor
     * 
     * @param doctorID the ID of the doctor
     * @return a list of diagnoses
     */
    public List<Diagnosis> getDiagnosesByDoctorID(int doctorID) {
        String sql = "SELECT * FROM diagnosis WHERE DoctorID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Diagnosis> diagnoses = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, doctorID);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Diagnosis diagnosis = new Diagnosis();
                diagnosis.setDiagnosisID(rs.getInt("DiagnosisID"));
                diagnosis.setPatientID(rs.getInt("PatientID"));
                diagnosis.setDoctorID(rs.getInt("DoctorID"));
                diagnosis.setDiagnosis(rs.getString("Diagnosis"));
                diagnosis.setTreatment(rs.getString("Treatment"));
                diagnosis.setDiagnosisDate(rs.getTimestamp("DiagnosisDate"));
                diagnosis.setNotes(rs.getString("Notes"));
                
                diagnoses.add(diagnosis);
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
        
        return diagnoses;
    }
    
    /**
     * Get diagnosis by patient ID
     * 
     * @param patientID the ID of the patient
     * @return the diagnosis or null if not found
     */
    public Diagnosis getDiagnosisByPatientID(int patientID) {
        String sql = "SELECT * FROM diagnosis WHERE PatientID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Diagnosis diagnosis = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, patientID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                diagnosis = new Diagnosis();
                diagnosis.setDiagnosisID(rs.getInt("DiagnosisID"));
                diagnosis.setPatientID(rs.getInt("PatientID"));
                diagnosis.setDoctorID(rs.getInt("DoctorID"));
                diagnosis.setDiagnosis(rs.getString("Diagnosis"));
                diagnosis.setTreatment(rs.getString("Treatment"));
                diagnosis.setDiagnosisDate(rs.getTimestamp("DiagnosisDate"));
                diagnosis.setNotes(rs.getString("Notes"));
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
        
        return diagnosis;
    }
    
    /**
     * Add a new diagnosis
     * 
     * @param diagnosis the diagnosis to add
     * @return true if successful, false otherwise
     */
    public boolean addDiagnosis(Diagnosis diagnosis) {
        String sql = "INSERT INTO diagnosis (PatientID, DoctorID, Diagnosis, Treatment, DiagnosisDate, Notes) VALUES (?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, diagnosis.getPatientID());
            stmt.setInt(2, diagnosis.getDoctorID());
            stmt.setString(3, diagnosis.getDiagnosis());
            stmt.setString(4, diagnosis.getTreatment());
            
            // Use current timestamp if not provided
            if (diagnosis.getDiagnosisDate() == null) {
                stmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            } else {
                stmt.setTimestamp(5, diagnosis.getDiagnosisDate());
            }
            
            stmt.setString(6, diagnosis.getNotes());
            
            int rowsAffected = stmt.executeUpdate();
            result = rowsAffected > 0;
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
     * Update an existing diagnosis
     * 
     * @param diagnosis the diagnosis to update
     * @return true if successful, false otherwise
     */
    public boolean updateDiagnosis(Diagnosis diagnosis) {
        String sql = "UPDATE diagnosis SET Diagnosis = ?, Treatment = ?, Notes = ? WHERE DiagnosisID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, diagnosis.getDiagnosis());
            stmt.setString(2, diagnosis.getTreatment());
            stmt.setString(3, diagnosis.getNotes());
            stmt.setInt(4, diagnosis.getDiagnosisID());
            
            int rowsAffected = stmt.executeUpdate();
            result = rowsAffected > 0;
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
     * Delete a diagnosis
     * 
     * @param diagnosisID the ID of the diagnosis to delete
     * @return true if successful, false otherwise
     */
    public boolean deleteDiagnosis(int diagnosisID) {
        String sql = "DELETE FROM diagnosis WHERE DiagnosisID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, diagnosisID);
            
            int rowsAffected = stmt.executeUpdate();
            result = rowsAffected > 0;
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