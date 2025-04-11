package com.pms.dao;

import com.pms.model.Patient;
import com.pms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {
    
    public Patient getPatientByID(int patientID) {
        String sql = "SELECT * FROM Patients WHERE PatientID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Patient patient = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, patientID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                patient = new Patient();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setContactNumber(rs.getString("ContactNumber"));
                patient.setEmail(rs.getString("Email"));
                patient.setAddress(rs.getString("Address"));
                patient.setPImageLink(rs.getString("PImageLink"));
                patient.setCreatedBy(rs.getInt("CreatedBy"));
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
        
        return patient;
    }
    
    public Patient getPatientByUserID(int userID) {
        String sql = "SELECT * FROM Patients WHERE CreatedBy = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Patient patient = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                patient = new Patient();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setContactNumber(rs.getString("ContactNumber"));
                patient.setEmail(rs.getString("Email"));
                patient.setAddress(rs.getString("Address"));
                patient.setPImageLink(rs.getString("PImageLink"));
                patient.setCreatedBy(rs.getInt("CreatedBy"));
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
        
        return patient;
    }
    
    public List<Patient> getAllPatients() {
        String sql = "SELECT * FROM Patients";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Patient> patients = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Patient patient = new Patient();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setContactNumber(rs.getString("ContactNumber"));
                patient.setEmail(rs.getString("Email"));
                patient.setAddress(rs.getString("Address"));
                patient.setPImageLink(rs.getString("PImageLink"));
                patient.setCreatedBy(rs.getInt("CreatedBy"));
                patients.add(patient);
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
        
        return patients;
    }
    
    public List<Patient> getPatientsByNurse(int nurseUserID) {
        String sql = "SELECT p.* FROM Patients p WHERE p.CreatedBy = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Patient> patients = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, nurseUserID);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Patient patient = new Patient();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setContactNumber(rs.getString("ContactNumber"));
                patient.setEmail(rs.getString("Email"));
                patient.setAddress(rs.getString("Address"));
                patient.setPImageLink(rs.getString("PImageLink"));
                patient.setCreatedBy(rs.getInt("CreatedBy"));
                patients.add(patient);
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
        
        return patients;
    }
    
    public List<Patient> getPatientsByDoctor(int doctorID) {
        String sql = "SELECT p.* FROM Patients p " +
                    "JOIN Diagnosis d ON p.PatientID = d.PatientID " +
                    "WHERE d.DoctorID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Patient> patients = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, doctorID);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Patient patient = new Patient();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setContactNumber(rs.getString("ContactNumber"));
                patient.setEmail(rs.getString("Email"));
                patient.setAddress(rs.getString("Address"));
                patient.setPImageLink(rs.getString("PImageLink"));
                patient.setCreatedBy(rs.getInt("CreatedBy"));
                patients.add(patient);
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
        
        return patients;
    }
    
    public boolean addPatient(Patient patient) {
        String sql = "INSERT INTO Patients (FirstName, LastName, ContactNumber, Email, Address, PImageLink, CreatedBy) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, patient.getFirstName());
            stmt.setString(2, patient.getLastName());
            stmt.setString(3, patient.getContactNumber());
            stmt.setString(4, patient.getEmail());
            stmt.setString(5, patient.getAddress());
            stmt.setString(6, patient.getPImageLink());
            stmt.setInt(7, patient.getCreatedBy());
            
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                result = true;
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    patient.setPatientID(generatedKeys.getInt(1));
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
    
    public boolean updatePatient(Patient patient) {
        String sql = "UPDATE Patients SET FirstName = ?, LastName = ?, ContactNumber = ?, Email = ?, Address = ?, PImageLink = ? WHERE PatientID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, patient.getFirstName());
            stmt.setString(2, patient.getLastName());
            stmt.setString(3, patient.getContactNumber());
            stmt.setString(4, patient.getEmail());
            stmt.setString(5, patient.getAddress());
            stmt.setString(6, patient.getPImageLink());
            stmt.setInt(7, patient.getPatientID());
            
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
    
    public boolean deletePatient(int patientID) {
        String sql = "DELETE FROM Patients WHERE PatientID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, patientID);
            
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
     * Get all patients who don't have a diagnosis yet
     * 
     * @return list of patients without diagnosis
     */
    public List<Patient> getPatientsWithoutDiagnosis() {
        // Query to get patients that don't have an entry in the diagnosis table
        String sql = "SELECT p.* FROM patients p LEFT JOIN diagnosis d ON p.PatientID = d.PatientID WHERE d.DiagnosisID IS NULL";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Patient> patients = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Patient patient = new Patient();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setUserID(rs.getInt("UserID"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setGender(rs.getString("Gender"));
                patient.setDateOfBirth(rs.getDate("DateOfBirth"));
                patient.setAge(calculateAge(rs.getDate("DateOfBirth")));
                patient.setContactNumber(rs.getString("ContactNumber"));
                patient.setAddress(rs.getString("Address"));
                patient.setBloodGroup(rs.getString("BloodGroup"));
                patient.setNurseID(rs.getInt("NurseID"));
                patient.setSymptoms(rs.getString("Symptoms"));
                patient.setReferrable(rs.getBoolean("IsReferrable"));
                
                patients.add(patient);
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
        
        return patients;
    }
    
    /**
     * Calculate age from date of birth
     * 
     * @param dob date of birth
     * @return calculated age
     */
    private int calculateAge(Date dob) {
        if (dob == null) {
            return 0;
        }
        
        long dobTime = dob.getTime();
        long currentTime = System.currentTimeMillis();
        
        // Calculate difference in milliseconds
        long diff = currentTime - dobTime;
        
        // Convert to years
        return (int) (diff / (1000L * 60 * 60 * 24 * 365));
    }
    
    /**
     * Get the name of the nurse who registered a patient
     * 
     * @param patientID the patient's ID
     * @return nurse's name (first + last)
     */
    public String getRegisteringNurseName(int patientID) {
        String sql = "SELECT n.FirstName, n.LastName FROM patients p JOIN nurses n ON p.NurseID = n.NurseID WHERE p.PatientID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String nurseName = "Unknown";
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, patientID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                nurseName = rs.getString("FirstName") + " " + rs.getString("LastName");
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
        
        return nurseName;
    }
    
    /**
     * Get patients registered by a specific nurse
     * 
     * @param nurseID the ID of the nurse
     * @return a list of patients registered by the nurse
     */
    public List<Patient> getPatientsByNurseID(int nurseID) {
        String sql = "SELECT * FROM patients WHERE NurseID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Patient> patients = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, nurseID);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Patient patient = new Patient();
                patient.setPatientID(rs.getInt("PatientID"));
                patient.setUserID(rs.getInt("UserID"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setGender(rs.getString("Gender"));
                patient.setDateOfBirth(rs.getDate("DateOfBirth"));
                patient.setAge(calculateAge(rs.getDate("DateOfBirth")));
                patient.setContactNumber(rs.getString("ContactNumber"));
                patient.setAddress(rs.getString("Address"));
                patient.setBloodGroup(rs.getString("BloodGroup"));
                patient.setNurseID(rs.getInt("NurseID"));
                patient.setSymptoms(rs.getString("Symptoms"));
                patient.setReferrable(rs.getBoolean("IsReferrable"));
                
                patients.add(patient);
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
        
        return patients;
    }
} 