package com.pms.dao;

import com.pms.model.Diagnosis;
import com.pms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DiagnosisDAO {
    
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
                diagnosis.setDoctorID(rs.getInt("DoctorID") != 0 ? rs.getInt("DoctorID") : null);
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
                diagnosis.setDoctorID(rs.getInt("DoctorID") != 0 ? rs.getInt("DoctorID") : null);
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
                diagnosis.setDoctorID(rs.getInt("DoctorID") != 0 ? rs.getInt("DoctorID") : null);
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
    
    public List<Diagnosis> getDiagnosesByNurse(int nurseID) {
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
                diagnosis.setDoctorID(rs.getInt("DoctorID") != 0 ? rs.getInt("DoctorID") : null);
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
    
    public List<Diagnosis> getDiagnosesByDoctor(int doctorID) {
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
                diagnosis.setDoctorID(rs.getInt("DoctorID") != 0 ? rs.getInt("DoctorID") : null);
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
                diagnosis.setDoctorID(rs.getInt("DoctorID") != 0 ? rs.getInt("DoctorID") : null);
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
                diagnosis.setDoctorID(rs.getInt("DoctorID") != 0 ? rs.getInt("DoctorID") : null);
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
    
    public boolean addDiagnosis(Diagnosis diagnosis) {
        String sql = "INSERT INTO Diagnosis (PatientID, NurseID, DoctorID, DiagnoStatus, Result) VALUES (?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, diagnosis.getPatientID());
            stmt.setInt(2, diagnosis.getNurseID());
            if (diagnosis.getDoctorID() != null) {
                stmt.setInt(3, diagnosis.getDoctorID());
            } else {
                stmt.setNull(3, Types.INTEGER);
            }
            stmt.setString(4, diagnosis.getDiagnoStatus());
            stmt.setString(5, diagnosis.getResult());
            
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
    
    public boolean updateDiagnosis(Diagnosis diagnosis) {
        String sql = "UPDATE Diagnosis SET DoctorID = ?, DiagnoStatus = ?, Result = ? WHERE DiagnosisID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            if (diagnosis.getDoctorID() != null) {
                stmt.setInt(1, diagnosis.getDoctorID());
            } else {
                stmt.setNull(1, Types.INTEGER);
            }
            stmt.setString(2, diagnosis.getDiagnoStatus());
            stmt.setString(3, diagnosis.getResult());
            stmt.setInt(4, diagnosis.getDiagnosisID());
            
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