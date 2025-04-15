package com.pms.dao;

import com.pms.model.Patient;
import com.pms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {
    
    public Patient getPatientByID(int userID) {
        String sql = "SELECT u.*, ud.DateOfBirth, ud.Gender, ud.BloodGroup, ud.EmergencyContact " +
                     "FROM Users u " +
                     "LEFT JOIN UserDetails ud ON u.UserID = ud.UserID " +
                     "WHERE u.UserID = ? AND u.Role = 'Patient'";
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
                patient.setPatientID(rs.getInt("UserID"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setContactNumber(rs.getString("ContactNumber"));
                patient.setEmail(rs.getString("Email"));
                patient.setAddress(rs.getString("Address"));
                patient.setProfileImage(rs.getString("ProfileImage"));
                patient.setDateOfBirth(rs.getDate("DateOfBirth"));
                patient.setGender(rs.getString("Gender"));
                patient.setBloodGroup(rs.getString("BloodGroup"));
                
                // Calculate age if date of birth is available
                if (rs.getDate("DateOfBirth") != null) {
                    patient.setAge(calculateAge(rs.getDate("DateOfBirth")));
                }
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
        // In the new schema, this is the same as getPatientByID since UserID is the primary key
        return getPatientByID(userID);
    }
    
    public List<Patient> getAllPatients() {
        String sql = "SELECT u.*, ud.DateOfBirth, ud.Gender, ud.BloodGroup, ud.EmergencyContact " +
                     "FROM Users u " +
                     "LEFT JOIN UserDetails ud ON u.UserID = ud.UserID " +
                     "WHERE u.Role = 'Patient'";
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
                patient.setPatientID(rs.getInt("UserID"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setContactNumber(rs.getString("ContactNumber"));
                patient.setEmail(rs.getString("Email"));
                patient.setAddress(rs.getString("Address"));
                patient.setProfileImage(rs.getString("ProfileImage"));
                patient.setDateOfBirth(rs.getDate("DateOfBirth"));
                patient.setGender(rs.getString("Gender"));
                patient.setBloodGroup(rs.getString("BloodGroup"));
                
                // Calculate age if date of birth is available
                if (rs.getDate("DateOfBirth") != null) {
                    patient.setAge(calculateAge(rs.getDate("DateOfBirth")));
                }
                
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
        // Get all patients who have a diagnosis record with this nurse
        String sql = "SELECT DISTINCT u.*, ud.DateOfBirth, ud.Gender, ud.BloodGroup, ud.EmergencyContact " +
                     "FROM Users u " +
                     "LEFT JOIN UserDetails ud ON u.UserID = ud.UserID " +
                     "INNER JOIN Diagnosis d ON u.UserID = d.PatientID " +
                     "WHERE d.NurseID = ? AND u.Role = 'Patient'";
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
                patient.setPatientID(rs.getInt("UserID"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setContactNumber(rs.getString("ContactNumber"));
                patient.setEmail(rs.getString("Email"));
                patient.setAddress(rs.getString("Address"));
                patient.setProfileImage(rs.getString("ProfileImage"));
                patient.setDateOfBirth(rs.getDate("DateOfBirth"));
                patient.setGender(rs.getString("Gender"));
                patient.setBloodGroup(rs.getString("BloodGroup"));
                
                // Calculate age if date of birth is available
                if (rs.getDate("DateOfBirth") != null) {
                    patient.setAge(calculateAge(rs.getDate("DateOfBirth")));
                }
                
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
        String sql = "SELECT DISTINCT u.*, ud.DateOfBirth, ud.Gender, ud.BloodGroup, ud.EmergencyContact " +
                     "FROM Users u " +
                     "LEFT JOIN UserDetails ud ON u.UserID = ud.UserID " +
                     "INNER JOIN Diagnosis d ON u.UserID = d.PatientID " +
                     "WHERE d.DoctorID = ? AND u.Role = 'Patient'";
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
                patient.setPatientID(rs.getInt("UserID"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setContactNumber(rs.getString("ContactNumber"));
                patient.setEmail(rs.getString("Email"));
                patient.setAddress(rs.getString("Address"));
                patient.setProfileImage(rs.getString("ProfileImage"));
                patient.setDateOfBirth(rs.getDate("DateOfBirth"));
                patient.setGender(rs.getString("Gender"));
                patient.setBloodGroup(rs.getString("BloodGroup"));
                
                // Calculate age if date of birth is available
                if (rs.getDate("DateOfBirth") != null) {
                    patient.setAge(calculateAge(rs.getDate("DateOfBirth")));
                }
                
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
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO patients (UserID, FirstName, LastName, Gender, DateOfBirth, ContactNumber, " +
                          "Email, Address, BloodGroup, EmergencyContact) " +
                          "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, patient.getUserID());
            stmt.setString(2, patient.getFirstName());
            stmt.setString(3, patient.getLastName());
            stmt.setString(4, patient.getGender());
            stmt.setDate(5, patient.getDateOfBirth());
            stmt.setString(6, patient.getContactNumber());
            stmt.setString(7, patient.getEmail());
            stmt.setString(8, patient.getAddress());
            stmt.setString(9, patient.getBloodGroup());
            stmt.setString(10, patient.getEmergencyContact());
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
            
            // Log the patient creation for debugging
            if (success) {
                System.out.println("Successfully added patient with ID: " + patient.getUserID());
            } else {
                System.out.println("Failed to add patient with ID: " + patient.getUserID());
            }
            
        } catch (SQLException e) {
            System.err.println("SQL Error when adding patient: " + e.getMessage());
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
    
    public boolean updatePatient(Patient patient) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE patients SET FirstName=?, LastName=?, Gender=?, DateOfBirth=?, " +
                         "ContactNumber=?, Email=?, Address=?, BloodGroup=?, EmergencyContact=? " +
                         "WHERE PatientID=?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, patient.getFirstName());
            stmt.setString(2, patient.getLastName());
            stmt.setString(3, patient.getGender());
            stmt.setDate(4, patient.getDateOfBirth());
            stmt.setString(5, patient.getContactNumber());
            stmt.setString(6, patient.getEmail());
            stmt.setString(7, patient.getAddress());
            stmt.setString(8, patient.getBloodGroup());
            stmt.setString(9, patient.getEmergencyContact());
            stmt.setInt(10, patient.getPatientID());
            
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
    
    public boolean deletePatient(int patientID) {
        // With foreign key constraints using ON DELETE CASCADE, deleting from Users will also delete from UserDetails
        String sql = "DELETE FROM Users WHERE UserID = ? AND Role = 'Patient'";
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
        String sql = "SELECT u.*, ud.DateOfBirth, ud.Gender, ud.BloodGroup " +
                     "FROM Users u " +
                     "LEFT JOIN UserDetails ud ON u.UserID = ud.UserID " +
                     "LEFT JOIN Diagnosis d ON u.UserID = d.PatientID " +
                     "WHERE u.Role = 'Patient' AND d.DiagnosisID IS NULL";
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
                patient.setPatientID(rs.getInt("UserID"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setContactNumber(rs.getString("ContactNumber"));
                patient.setEmail(rs.getString("Email"));
                patient.setAddress(rs.getString("Address"));
                patient.setProfileImage(rs.getString("ProfileImage"));
                patient.setDateOfBirth(rs.getDate("DateOfBirth"));
                patient.setGender(rs.getString("Gender"));
                patient.setBloodGroup(rs.getString("BloodGroup"));
                
                // Calculate age if date of birth is available
                if (rs.getDate("DateOfBirth") != null) {
                    patient.setAge(calculateAge(rs.getDate("DateOfBirth")));
                }
                
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
        String sql = "SELECT n.FirstName, n.LastName " +
                     "FROM Diagnosis d " +
                     "JOIN Users n ON d.NurseID = n.UserID " +
                     "WHERE d.PatientID = ? " +
                     "ORDER BY d.CreatedDate ASC LIMIT 1";
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
        // Same as getPatientsByNurse(int nurseUserID) in the new schema
        return getPatientsByNurse(nurseID);
    }
    
    /**
     * Get nurse name by nurse ID
     * 
     * @param nurseID the ID of the nurse
     * @return the full name of the nurse
     */
    public String getNurseNameByID(int nurseID) {
        String sql = "SELECT FirstName, LastName FROM Users WHERE UserID = ? AND Role = 'Nurse'";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String nurseName = "Unknown";
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, nurseID);
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
     * Get doctor name by doctor ID
     * 
     * @param doctorID the ID of the doctor
     * @return the full name of the doctor
     */
    public String getDoctorNameByID(int doctorID) {
        String sql = "SELECT FirstName, LastName FROM Users WHERE UserID = ? AND Role = 'Doctor'";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String doctorName = "Unknown";
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, doctorID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                doctorName = rs.getString("FirstName") + " " + rs.getString("LastName");
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
        
        return doctorName;
    }
} 