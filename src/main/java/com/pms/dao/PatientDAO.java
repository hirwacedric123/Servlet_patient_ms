package com.pms.dao;

import com.pms.model.Patient;
import com.pms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {
    
    private Connection connection;
    
    // Constructor for the PatientDAO
    public PatientDAO() {
        try {
            connection = DBConnection.getConnection();
            // Ensure the necessary tables exist
            ensurePatientsTableExists();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to establish database connection", e);
        }
    }
    
    /**
     * Creates the patients table if it doesn't exist
     */
    private void ensurePatientsTableExists() {
        try {
            DatabaseMetaData meta = connection.getMetaData();
            
            // Check if patients table exists
            ResultSet tables = meta.getTables(null, null, "patients", null);
            
            if (!tables.next()) {
                System.out.println("Patients table does not exist, using UserDetails instead");
                
                // Check if UserDetails table exists
                ResultSet userDetailsTables = meta.getTables(null, null, "UserDetails", null);
                
                if (!userDetailsTables.next()) {
                    // Create UserDetails table if it doesn't exist
                    Statement stmt = connection.createStatement();
                    String createUserDetailsSQL = 
                        "CREATE TABLE IF NOT EXISTS UserDetails (" +
                        "UserID INT PRIMARY KEY, " +
                        "DateOfBirth DATE, " +
                        "Gender VARCHAR(10), " +
                        "BloodGroup VARCHAR(5), " +
                        "EmergencyContact VARCHAR(50), " +
                        "FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE" +
                        ")";
                    
                    stmt.executeUpdate(createUserDetailsSQL);
                    System.out.println("Created UserDetails table");
                    stmt.close();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error ensuring patients table: " + e.getMessage());
        }
    }
    
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
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            // Instead of using patients table directly, we'll store the data in Users and UserDetails tables
            
            // Insert into UserDetails for patient-specific data
            String sql = "INSERT INTO UserDetails (UserID, DateOfBirth, Gender, BloodGroup, EmergencyContact) " +
                          "VALUES (?, ?, ?, ?, ?)";
            
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, patient.getUserID());
            stmt.setDate(2, patient.getDateOfBirth());
            stmt.setString(3, patient.getGender());
            stmt.setString(4, patient.getBloodGroup());
            stmt.setString(5, patient.getEmergencyContact());
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
            
            // Log the patient creation for debugging
            if (success) {
                System.out.println("Successfully added patient details with ID: " + patient.getUserID());
            } else {
                System.out.println("Failed to add patient details with ID: " + patient.getUserID());
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
        }
        
        return success;
    }
    
    public boolean updatePatient(Patient patient) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean success = false;
        
        try {
            // First check if user details exist
            String checkSql = "SELECT * FROM UserDetails WHERE UserID = ?";
            stmt = connection.prepareStatement(checkSql);
            stmt.setInt(1, patient.getUserID());
            rs = stmt.executeQuery();
            
            boolean userDetailsExist = rs.next();
            
            if (userDetailsExist) {
                // Update the UserDetails table
                String sql = "UPDATE UserDetails SET DateOfBirth=?, Gender=?, BloodGroup=?, EmergencyContact=? " +
                             "WHERE UserID=?";
                
                stmt = connection.prepareStatement(sql);
                stmt.setDate(1, patient.getDateOfBirth());
                stmt.setString(2, patient.getGender());
                stmt.setString(3, patient.getBloodGroup());
                stmt.setString(4, patient.getEmergencyContact());
                stmt.setInt(5, patient.getUserID());
                
                stmt.executeUpdate();
            } else {
                // Insert into UserDetails table
                String sql = "INSERT INTO UserDetails (UserID, DateOfBirth, Gender, BloodGroup, EmergencyContact) " +
                             "VALUES (?, ?, ?, ?, ?)";
                
                stmt = connection.prepareStatement(sql);
                stmt.setInt(1, patient.getUserID());
                stmt.setDate(2, patient.getDateOfBirth());
                stmt.setString(3, patient.getGender());
                stmt.setString(4, patient.getBloodGroup());
                stmt.setString(5, patient.getEmergencyContact());
                
                stmt.executeUpdate();
            }
            
            // Update the Users table
            String userSql = "UPDATE Users SET FirstName=?, LastName=?, ContactNumber=?, Email=?, Address=? ";
            
            // Add profile image update if it's not null or empty
            if (patient.getProfileImage() != null && !patient.getProfileImage().isEmpty()) {
                userSql += ", ProfileImage=? ";
            }
            
            userSql += "WHERE UserID=?";
            
            stmt = connection.prepareStatement(userSql);
            stmt.setString(1, patient.getFirstName());
            stmt.setString(2, patient.getLastName());
            stmt.setString(3, patient.getContactNumber());
            stmt.setString(4, patient.getEmail());
            stmt.setString(5, patient.getAddress());
            
            int paramIndex = 6;
            if (patient.getProfileImage() != null && !patient.getProfileImage().isEmpty()) {
                stmt.setString(paramIndex++, patient.getProfileImage());
            }
            
            stmt.setInt(paramIndex, patient.getUserID());
            
            int userRowsAffected = stmt.executeUpdate();
            
            success = userRowsAffected > 0;
            
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
        }
        
        return success;
    }
    
    public boolean deletePatient(int patientID) {
        // With foreign key constraints using ON DELETE CASCADE, deleting from Users will also delete from UserDetails
        String sql = "DELETE FROM Users WHERE UserID = ? AND Role = 'Patient'";
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            stmt = connection.prepareStatement(sql);
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
     * @return a list of patients registered by this nurse
     */
    public List<Patient> getRegisteredPatientsByNurseID(int nurseID) {
        // Modified query to check the CreatedBy field rather than diagnosis table
        String sql = "SELECT DISTINCT u.*, ud.DateOfBirth, ud.Gender, ud.BloodGroup, ud.EmergencyContact " +
                     "FROM Users u " +
                     "LEFT JOIN UserDetails ud ON u.UserID = ud.UserID " +
                     "WHERE u.CreatedBy = ? AND u.Role = 'Patient' " +
                     "ORDER BY u.FirstName, u.LastName";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Patient> patients = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            System.out.println("Attempting to connect to database at " + conn.getMetaData().getURL());
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, nurseID);
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
                
                // This patient was registered by this nurse
                patient.setCreatedBy(nurseID);
                
                // Now get the latest diagnosis for this patient to determine referrability
                String diagSql = "SELECT DiagnoStatus FROM Diagnosis " +
                                "WHERE PatientID = ? ORDER BY CreatedDate DESC LIMIT 1";
                
                PreparedStatement diagStmt = null;
                ResultSet diagRs = null;
                
                try {
                    diagStmt = conn.prepareStatement(diagSql);
                    diagStmt.setInt(1, patient.getPatientID());
                    diagRs = diagStmt.executeQuery();
                    
                    if (diagRs.next()) {
                        String latestDiagnosis = diagRs.getString("DiagnoStatus");
                        if (latestDiagnosis != null) {
                            // A patient is referrable if diagnosis status contains "refer" or "emergency"
                            boolean isReferrable = latestDiagnosis.toLowerCase().contains("refer") || 
                                                latestDiagnosis.toLowerCase().contains("emergency");
                            patient.setReferrable(isReferrable);
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (diagRs != null) {
                        try { diagRs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                    if (diagStmt != null) {
                        try { diagStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                }
                
                patients.add(patient);
            }
            
            // Debug log
            System.out.println("Found " + patients.size() + " patients registered by nurse " + nurseID);
            System.out.println("Database connection established successfully");
            
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
            System.out.println("Database connection closed successfully");
        }
        
        return patients;
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
    
    /**
     * Close the database connection when the DAO is no longer needed
     */
    public void close() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("PatientDAO connection closed");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    /**
     * Get all patients for a specific nurse, regardless of diagnosis status
     * This is needed for the nurse dashboard to show all patients
     * 
     * @param nurseID the ID of the nurse
     * @return a list of all patients 
     */
    public List<Patient> getAllPatientsForNurse(int nurseID) {
        // This will get all patients in the system with Role='Patient'
        String sql = "SELECT u.*, ud.DateOfBirth, ud.Gender, ud.BloodGroup, ud.EmergencyContact, " +
                     "(SELECT COUNT(*) > 0 FROM Diagnosis d WHERE d.PatientID = u.UserID AND d.NurseID = ?) AS RegisteredByNurse, " +
                     "(SELECT DiagnoStatus FROM Diagnosis WHERE PatientID = u.UserID ORDER BY CreatedDate DESC LIMIT 1) AS LatestDiagnosis " +
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
            stmt.setInt(1, nurseID);
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
                
                // Set if this patient was registered by the current nurse
                boolean registeredByNurse = rs.getBoolean("RegisteredByNurse");
                patient.setCreatedBy(registeredByNurse ? nurseID : 0);
                
                // Set if this patient is referrable based on latest diagnosis
                String latestDiagnosis = rs.getString("LatestDiagnosis");
                if (latestDiagnosis != null) {
                    // A patient is referrable if diagnosis status contains "refer" or "emergency"
                    boolean isReferrable = latestDiagnosis.toLowerCase().contains("refer") || 
                                         latestDiagnosis.toLowerCase().contains("emergency");
                    patient.setReferrable(isReferrable);
                } else {
                    patient.setReferrable(false);
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
     * Get patients by nurse ID
     * 
     * @param nurseID the ID of the nurse
     * @return a list of patients associated with this nurse
     */
    public List<Patient> getPatientsByNurseID(int nurseID) {
        // Same as getPatientsByNurse(int nurseUserID) in the new schema
        return getPatientsByNurse(nurseID);
    }
} 