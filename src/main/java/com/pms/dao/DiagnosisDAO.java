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
        String sql = "SELECT * FROM Diagnosis WHERE DiagnosisID = ?";
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
                diagnosis.setNurseID(rs.getInt("NurseID"));
                diagnosis.setDoctorID(rs.getInt("DoctorID"));
                diagnosis.setDiagnoStatus(rs.getString("DiagnoStatus"));
                diagnosis.setResult(rs.getString("Result"));
                diagnosis.setCreatedDate(rs.getTimestamp("CreatedDate"));
                diagnosis.setUpdatedDate(rs.getTimestamp("UpdatedDate"));
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
        String sql = "SELECT * FROM Diagnosis";
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
                diagnosis.setNurseID(rs.getInt("NurseID"));
                diagnosis.setDoctorID(rs.getInt("DoctorID"));
                diagnosis.setDiagnoStatus(rs.getString("DiagnoStatus"));
                diagnosis.setResult(rs.getString("Result"));
                diagnosis.setCreatedDate(rs.getTimestamp("CreatedDate"));
                diagnosis.setUpdatedDate(rs.getTimestamp("UpdatedDate"));
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
        String sql = "SELECT * FROM Diagnosis WHERE PatientID = ?";
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
                diagnosis.setNurseID(rs.getInt("NurseID"));
                diagnosis.setDoctorID(rs.getInt("DoctorID"));
                diagnosis.setDiagnoStatus(rs.getString("DiagnoStatus"));
                diagnosis.setResult(rs.getString("Result"));
                diagnosis.setCreatedDate(rs.getTimestamp("CreatedDate"));
                diagnosis.setUpdatedDate(rs.getTimestamp("UpdatedDate"));
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
        String sql = "SELECT * FROM Diagnosis WHERE DoctorID = ?";
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
                diagnosis.setNurseID(rs.getInt("NurseID"));
                diagnosis.setDoctorID(rs.getInt("DoctorID"));
                diagnosis.setDiagnoStatus(rs.getString("DiagnoStatus"));
                diagnosis.setResult(rs.getString("Result"));
                diagnosis.setCreatedDate(rs.getTimestamp("CreatedDate"));
                diagnosis.setUpdatedDate(rs.getTimestamp("UpdatedDate"));
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
     * Get all diagnoses created by a specific nurse
     * 
     * @param nurseID the ID of the nurse
     * @return a list of diagnoses
     */
    public List<Diagnosis> getDiagnosesByNurseID(int nurseID) {
        String sql = "SELECT * FROM Diagnosis WHERE NurseID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Diagnosis> diagnoses = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, nurseID);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Diagnosis diagnosis = new Diagnosis();
                diagnosis.setDiagnosisID(rs.getInt("DiagnosisID"));
                diagnosis.setPatientID(rs.getInt("PatientID"));
                diagnosis.setNurseID(rs.getInt("NurseID"));
                diagnosis.setDoctorID(rs.getInt("DoctorID"));
                diagnosis.setDiagnoStatus(rs.getString("DiagnoStatus"));
                diagnosis.setResult(rs.getString("Result"));
                diagnosis.setCreatedDate(rs.getTimestamp("CreatedDate"));
                diagnosis.setUpdatedDate(rs.getTimestamp("UpdatedDate"));
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
     * Get all referrable diagnoses
     * 
     * @return a list of referrable diagnoses
     */
    public List<Diagnosis> getReferrableDiagnoses() {
        String sql = "SELECT * FROM Diagnosis WHERE DiagnoStatus = 'Referrable'";
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
                diagnosis.setNurseID(rs.getInt("NurseID"));
                diagnosis.setDoctorID(rs.getInt("DoctorID"));
                diagnosis.setDiagnoStatus(rs.getString("DiagnoStatus"));
                diagnosis.setResult(rs.getString("Result"));
                diagnosis.setCreatedDate(rs.getTimestamp("CreatedDate"));
                diagnosis.setUpdatedDate(rs.getTimestamp("UpdatedDate"));
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
     * Get all non-referrable diagnoses
     * 
     * @return a list of non-referrable diagnoses
     */
    public List<Diagnosis> getNonReferrableDiagnoses() {
        String sql = "SELECT * FROM Diagnosis WHERE DiagnoStatus = 'Not Referrable'";
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
                diagnosis.setNurseID(rs.getInt("NurseID"));
                diagnosis.setDoctorID(rs.getInt("DoctorID"));
                diagnosis.setDiagnoStatus(rs.getString("DiagnoStatus"));
                diagnosis.setResult(rs.getString("Result"));
                diagnosis.setCreatedDate(rs.getTimestamp("CreatedDate"));
                diagnosis.setUpdatedDate(rs.getTimestamp("UpdatedDate"));
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
        String sql = "SELECT * FROM Diagnosis WHERE PatientID = ?";
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
                diagnosis.setNurseID(rs.getInt("NurseID"));
                diagnosis.setDoctorID(rs.getInt("DoctorID"));
                diagnosis.setDiagnoStatus(rs.getString("DiagnoStatus"));
                diagnosis.setResult(rs.getString("Result"));
                diagnosis.setCreatedDate(rs.getTimestamp("CreatedDate"));
                diagnosis.setUpdatedDate(rs.getTimestamp("UpdatedDate"));
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
        String sql = "INSERT INTO Diagnosis (PatientID, NurseID, DoctorID, DiagnoStatus, Result, CreatedDate, UpdatedDate) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, diagnosis.getPatientID());
            stmt.setInt(2, diagnosis.getNurseID());
            
            // Doctor ID might be null initially for new diagnoses
            if (diagnosis.getDoctorID() > 0) {
                stmt.setInt(3, diagnosis.getDoctorID());
            } else {
                stmt.setNull(3, Types.INTEGER);
            }
            
            stmt.setString(4, diagnosis.getDiagnoStatus());
            stmt.setString(5, diagnosis.getResult());
            
            // Use current timestamp if not provided
            Timestamp now = new Timestamp(System.currentTimeMillis());
            if (diagnosis.getCreatedDate() == null) {
                stmt.setTimestamp(6, now);
            } else {
                stmt.setTimestamp(6, diagnosis.getCreatedDate());
            }
            
            if (diagnosis.getUpdatedDate() == null) {
                stmt.setTimestamp(7, now);
            } else {
                stmt.setTimestamp(7, diagnosis.getUpdatedDate());
            }
            
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                result = true;
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    diagnosis.setDiagnosisID(generatedKeys.getInt(1));
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
    
    /**
     * Update an existing diagnosis
     * 
     * @param diagnosis the diagnosis to update
     * @return true if successful, false otherwise
     */
    public boolean updateDiagnosis(Diagnosis diagnosis) {
        String sql = "UPDATE Diagnosis SET DoctorID = ?, Result = ?, UpdatedDate = ? WHERE DiagnosisID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            
            if (diagnosis.getDoctorID() > 0) {
                stmt.setInt(1, diagnosis.getDoctorID());
            } else {
                stmt.setNull(1, Types.INTEGER);
            }
            
            stmt.setString(2, diagnosis.getResult());
            stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
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
        String sql = "DELETE FROM Diagnosis WHERE DiagnosisID = ?";
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
    
    /**
     * Count referrable diagnoses by nurse
     * 
     * @param nurseID the ID of the nurse
     * @return the count of referrable diagnoses by this nurse
     */
    public int countReferrableByNurse(int nurseID) {
        String sql = "SELECT COUNT(*) FROM Diagnosis WHERE NurseID = ? AND DiagnoStatus = 'Referrable'";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, nurseID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
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
        
        return count;
    }
    
    /**
     * Count non-referrable diagnoses by nurse
     * 
     * @param nurseID the ID of the nurse
     * @return the count of non-referrable diagnoses by this nurse
     */
    public int countNonReferrableByNurse(int nurseID) {
        String sql = "SELECT COUNT(*) FROM Diagnosis WHERE NurseID = ? AND DiagnoStatus = 'Not Referrable'";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, nurseID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
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
        
        return count;
    }
    
    /**
     * Count pending cases for a doctor
     * 
     * @param doctorID the ID of the doctor
     * @return the count of pending cases for this doctor
     */
    public int countPendingCasesForDoctor(int doctorID) {
        String sql = "SELECT COUNT(*) FROM Diagnosis WHERE DoctorID = ? AND Result = 'Pending'";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, doctorID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
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
        
        return count;
    }
    
    /**
     * Count confirmed cases for a doctor
     * 
     * @param doctorID the ID of the doctor
     * @return the count of confirmed cases for this doctor
     */
    public int countConfirmedCasesForDoctor(int doctorID) {
        String sql = "SELECT COUNT(*) FROM Diagnosis WHERE DoctorID = ? AND Result != 'Pending'";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, doctorID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
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
        
        return count;
    }
} 