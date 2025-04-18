package com.pms.dao;

import com.pms.model.Diagnosis;
import com.pms.model.DiagnosisStats;
import com.pms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DiagnosisDAO {
    
    private Connection connection;
    
    // Constructor for the DiagnosisDAO
    public DiagnosisDAO() {
        try {
            connection = DBConnection.getConnection();
            // Ensure the diagnosis table exists
            ensureDiagnosisTableExists();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to establish database connection", e);
        }
    }
    
    /**
     * Creates the diagnosis table if it doesn't exist
     */
    private void ensureDiagnosisTableExists() {
        try {
            DatabaseMetaData meta = connection.getMetaData();
            
            // Check if Diagnosis table exists
            ResultSet tables = meta.getTables(null, null, "Diagnosis", null);
            
            if (!tables.next()) {
                System.out.println("Diagnosis table does not exist, creating it now");
                
                // Create Diagnosis table if it doesn't exist
                Statement stmt = connection.createStatement();
                String createDiagnosisSQL = 
                    "CREATE TABLE IF NOT EXISTS Diagnosis (" +
                    "DiagnosisID INT PRIMARY KEY AUTO_INCREMENT, " +
                    "PatientID INT NOT NULL, " +
                    "NurseID INT NOT NULL, " +
                    "DoctorID INT, " +
                    "DiagnoStatus VARCHAR(20) NOT NULL, " +
                    "Result TEXT, " +
                    "CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, " +
                    "FOREIGN KEY (PatientID) REFERENCES Users(UserID) ON DELETE CASCADE, " +
                    "FOREIGN KEY (NurseID) REFERENCES Users(UserID), " +
                    "FOREIGN KEY (DoctorID) REFERENCES Users(UserID)" +
                    ")";
                
                stmt.executeUpdate(createDiagnosisSQL);
                System.out.println("Created Diagnosis table");
                stmt.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error ensuring Diagnosis table: " + e.getMessage());
        }
    }
    
    /**
     * Get diagnosis by ID
     * 
     * @param diagnosisID the ID of the diagnosis
     * @return the diagnosis or null if not found
     */
    public Diagnosis getDiagnosisByID(int diagnosisID) {
        return getDiagnosisById(diagnosisID);
    }
    
    /**
     * Get all diagnoses
     * 
     * @return a list of all diagnoses
     */
    public List<Diagnosis> getAllDiagnoses() {
        String sql = "SELECT * FROM Diagnosis";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Diagnosis> diagnoses = new ArrayList<>();
        
        try {
            stmt = connection.prepareStatement(sql);
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
            closeResources(rs, stmt);
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
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Diagnosis> diagnoses = new ArrayList<>();
        
        try {
            stmt = connection.prepareStatement(sql);
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
            closeResources(rs, stmt);
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
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Diagnosis> diagnoses = new ArrayList<>();
        
        try {
            stmt = connection.prepareStatement(sql);
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
            closeResources(rs, stmt);
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
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Diagnosis> diagnoses = new ArrayList<>();
        
        try {
            stmt = connection.prepareStatement(sql);
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
            closeResources(rs, stmt);
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
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Diagnosis> diagnoses = new ArrayList<>();
        
        try {
            stmt = connection.prepareStatement(sql);
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
            closeResources(rs, stmt);
        }
        
        return diagnoses;
    }
    
    /**
     * Get all non-referrable diagnoses
     * 
     * @return a list of non-referrable diagnoses
     */
    public List<Diagnosis> getNonReferrableDiagnoses() {
        String sql = "SELECT * FROM Diagnosis WHERE DiagnoStatus = 'Not Referrable' ORDER BY CreatedDate DESC LIMIT 100";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Diagnosis> diagnoses = new ArrayList<>();
        
        try {
            stmt = connection.prepareStatement(sql);
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
            closeResources(rs, stmt);
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
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Diagnosis diagnosis = null;
        
        try {
            stmt = connection.prepareStatement(sql);
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
            closeResources(rs, stmt);
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
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
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
                generatedKeys.close();
            }
        } catch (SQLException e) {
            System.err.println("Error adding diagnosis: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, stmt);
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
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            stmt = connection.prepareStatement(sql);
            
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
            closeResources(null, stmt);
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
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, diagnosisID);
            
            int rowsAffected = stmt.executeUpdate();
            result = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(null, stmt);
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
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, nurseID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt);
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
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, nurseID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt);
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
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, doctorID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt);
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
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, doctorID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt);
        }
        
        return count;
    }
    
    /**
     * Get diagnosis cases statistics grouped by doctor
     * @return List of diagnosis statistics by doctor
     */
    public List<DiagnosisStats> getDiagnosisStatsByDoctor() {
        List<DiagnosisStats> doctorStats = new ArrayList<>();
        
        String sql = "SELECT d.DoctorID, CONCAT(d.FirstName, ' ', d.LastName) AS DoctorName, " +
                     "d.HospitalName, COUNT(diag.DiagnosisID) AS TotalCases " +
                     "FROM Doctors d " +
                     "LEFT JOIN Diagnosis diag ON d.DoctorID = diag.DoctorID " +
                     "GROUP BY d.DoctorID, DoctorName, d.HospitalName " +
                     "ORDER BY TotalCases DESC";
        
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            stmt = connection.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                int doctorId = rs.getInt("DoctorID");
                String doctorName = rs.getString("DoctorName");
                String hospitalName = rs.getString("HospitalName");
                int totalCases = rs.getInt("TotalCases");
                
                DiagnosisStats stats = new DiagnosisStats(doctorId, doctorName, hospitalName, totalCases);
                doctorStats.add(stats);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt);
        }
        
        return doctorStats;
    }
    
    /**
     * Get diagnosis cases statistics grouped by nurse
     * @return List of diagnosis statistics by nurse
     */
    public List<DiagnosisStats> getDiagnosisStatsByNurse() {
        List<DiagnosisStats> nurseStats = new ArrayList<>();
        
        String sql = "SELECT n.NurseID, CONCAT(n.FirstName, ' ', n.LastName) AS NurseName, " +
                     "n.HealthCenter, COUNT(diag.DiagnosisID) AS TotalCases, " +
                     "SUM(CASE WHEN diag.DiagnoStatus = 'Referrable' THEN 1 ELSE 0 END) AS ReferrableCases, " +
                     "SUM(CASE WHEN diag.DiagnoStatus = 'Not Referrable' THEN 1 ELSE 0 END) AS NonReferrableCases " +
                     "FROM Nurses n " +
                     "LEFT JOIN Diagnosis diag ON n.NurseID = diag.NurseID " +
                     "GROUP BY n.NurseID, NurseName, n.HealthCenter " +
                     "ORDER BY TotalCases DESC";
        
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            stmt = connection.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                int nurseId = rs.getInt("NurseID");
                String nurseName = rs.getString("NurseName");
                String healthCenter = rs.getString("HealthCenter");
                int totalCases = rs.getInt("TotalCases");
                int referrableCases = rs.getInt("ReferrableCases");
                int nonReferrableCases = rs.getInt("NonReferrableCases");
                
                DiagnosisStats stats = new DiagnosisStats(nurseId, nurseName, healthCenter, 
                                                         totalCases, referrableCases, nonReferrableCases);
                nurseStats.add(stats);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt);
        }
        
        return nurseStats;
    }
    
    /**
     * Close database resources
     */
    private void closeResources(ResultSet rs, Statement stmt) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * Close the database connection when the DAO is no longer needed
     */
    public void close() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("DiagnosisDAO connection closed");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    /**
     * Get a diagnosis by ID
     * 
     * @param diagnosisID the diagnosis ID
     * @return the diagnosis or null if not found
     */
    public Diagnosis getDiagnosisById(int diagnosisID) {
        String sql = "SELECT * FROM Diagnosis WHERE DiagnosisID = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Diagnosis diagnosis = null;
        
        try {
            stmt = connection.prepareStatement(sql);
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
            closeResources(rs, stmt);
        }
        
        return diagnosis;
    }
    
    /**
     * Get all referrable diagnoses assigned to a doctor
     * 
     * @param doctorID the ID of the doctor
     * @return a list of referrable diagnoses for the doctor
     */
    public List<Diagnosis> getReferrableDiagnosesByDoctorID(int doctorID) {
        String sql = "SELECT * FROM Diagnosis WHERE DoctorID = ? AND DiagnoStatus = 'Referrable'";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Diagnosis> diagnoses = new ArrayList<>();
        
        try {
            stmt = connection.prepareStatement(sql);
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
            closeResources(rs, stmt);
        }
        
        return diagnoses;
    }
} 