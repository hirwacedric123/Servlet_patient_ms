package com.pms.dao;

import com.pms.model.Nurse;
import com.pms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NurseDAO {
    private Connection connection;
    
    public NurseDAO() {
        try {
            connection = DBConnection.getConnection();
            // Ensure the Nurses table exists
            ensureNursesTableExists();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to establish database connection", e);
        }
    }
    
    /**
     * Creates the Nurses table if it doesn't exist
     */
    private void ensureNursesTableExists() {
        try {
            DatabaseMetaData meta = connection.getMetaData();
            ResultSet tables = meta.getTables(null, null, "Nurses", null);
            
            if (!tables.next()) {
                // Table doesn't exist, create it
                Statement stmt = connection.createStatement();
                String createTableSQL = 
                    "CREATE TABLE Nurses (" +
                    "NurseID INT AUTO_INCREMENT PRIMARY KEY, " +
                    "UserID INT NOT NULL, " +
                    "FirstName VARCHAR(50) NOT NULL, " +
                    "LastName VARCHAR(50) NOT NULL, " +
                    "telephone VARCHAR(20), " +
                    "Email VARCHAR(100) NOT NULL, " +
                    "Department VARCHAR(100), " +
                    "RegisteredByDoctorID INT, " +
                    "address VARCHAR(255), " +
                    "healthcenter VARCHAR(100), " +
                    "FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE" +
                    ")";
                
                stmt.executeUpdate(createTableSQL);
                System.out.println("Created Nurses table");
                stmt.close();
            } else {
                // Table exists, make sure all columns match
                System.out.println("Nurses table exists, checking columns");
                
                // Check if Department column exists
                ResultSet deptColumns = meta.getColumns(null, null, "Nurses", "Department");
                if (!deptColumns.next()) {
                    Statement stmt = connection.createStatement();
                    String addColumnSQL = "ALTER TABLE Nurses ADD COLUMN Department VARCHAR(100)";
                    stmt.executeUpdate(addColumnSQL);
                    System.out.println("Added Department column to Nurses table");
                    stmt.close();
                }
                
                // Make sure telephone column exists
                ResultSet telephoneColumns = meta.getColumns(null, null, "Nurses", "telephone");
                if (!telephoneColumns.next()) {
                    Statement stmt = connection.createStatement();
                    String addColumnSQL = "ALTER TABLE Nurses ADD COLUMN telephone VARCHAR(20)";
                    stmt.executeUpdate(addColumnSQL);
                    System.out.println("Added telephone column to Nurses table");
                    stmt.close();
                }
                
                // Make sure address column exists
                ResultSet addressColumns = meta.getColumns(null, null, "Nurses", "address");
                if (!addressColumns.next()) {
                    Statement stmt = connection.createStatement();
                    String addColumnSQL = "ALTER TABLE Nurses ADD COLUMN address VARCHAR(255)";
                    stmt.executeUpdate(addColumnSQL);
                    System.out.println("Added address column to Nurses table");
                    stmt.close();
                }
                
                // Make sure healthcenter column exists
                ResultSet healthColumns = meta.getColumns(null, null, "Nurses", "healthcenter");
                if (!healthColumns.next()) {
                    Statement stmt = connection.createStatement();
                    String addColumnSQL = "ALTER TABLE Nurses ADD COLUMN healthcenter VARCHAR(100)";
                    stmt.executeUpdate(addColumnSQL);
                    System.out.println("Added healthcenter column to Nurses table");
                    stmt.close();
                }
                
                // Drop ContactNumber column if it exists (to prevent conflicts)
                try {
                    ResultSet contactColumns = meta.getColumns(null, null, "Nurses", "ContactNumber");
                    if (contactColumns.next()) {
                        Statement stmt = connection.createStatement();
                        String dropColumnSQL = "ALTER TABLE Nurses DROP COLUMN ContactNumber";
                        stmt.executeUpdate(dropColumnSQL);
                        System.out.println("Dropped ContactNumber column from Nurses table (using telephone instead)");
                        stmt.close();
                    }
                } catch (SQLException e) {
                    // Ignore if the column doesn't exist or can't be dropped
                    System.out.println("No ContactNumber column found or error dropping it: " + e.getMessage());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error ensuring Nurses table: " + e.getMessage());
        }
    }
    
    public Nurse getNurseByID(int nurseID) {
        String sql = "SELECT * FROM Nurses WHERE NurseID = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Nurse nurse = null;
        
        try {
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, nurseID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                nurse = new Nurse();
                nurse.setNurseID(rs.getInt("NurseID"));
                nurse.setFirstName(rs.getString("FirstName"));
                nurse.setLastName(rs.getString("LastName"));
                nurse.setTelephone(rs.getString("telephone"));
                nurse.setEmail(rs.getString("Email"));
                nurse.setAddress(rs.getString("address"));
                nurse.setHealthCenter(rs.getString("healthcenter"));
                nurse.setUserID(rs.getInt("UserID"));
                
                try {
                    nurse.setRegisteredByDoctorID(rs.getInt("RegisteredByDoctorID"));
                } catch (SQLException e) {
                    // RegisteredByDoctorID might not exist in older records
                    nurse.setRegisteredByDoctorID(0);
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
        }
        
        return nurse;
    }
    
    public Nurse getNurseByUserID(int userID) {
        String sql = "SELECT * FROM Nurses WHERE UserID = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Nurse nurse = null;
        
        try {
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, userID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                nurse = new Nurse();
                nurse.setNurseID(rs.getInt("NurseID"));
                nurse.setFirstName(rs.getString("FirstName"));
                nurse.setLastName(rs.getString("LastName"));
                nurse.setTelephone(rs.getString("telephone"));
                nurse.setEmail(rs.getString("Email"));
                nurse.setAddress(rs.getString("address"));
                nurse.setHealthCenter(rs.getString("healthcenter"));
                nurse.setUserID(rs.getInt("UserID"));
                
                try {
                    nurse.setRegisteredByDoctorID(rs.getInt("RegisteredByDoctorID"));
                } catch (SQLException e) {
                    // RegisteredByDoctorID might not exist in older records
                    nurse.setRegisteredByDoctorID(0);
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
        }
        
        return nurse;
    }
    
    public List<Nurse> getAllNurses() {
        String sql = "SELECT * FROM Nurses";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Nurse> nurses = new ArrayList<>();
        
        try {
            stmt = connection.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Nurse nurse = new Nurse();
                nurse.setNurseID(rs.getInt("NurseID"));
                nurse.setFirstName(rs.getString("FirstName"));
                nurse.setLastName(rs.getString("LastName"));
                nurse.setTelephone(rs.getString("telephone"));
                nurse.setEmail(rs.getString("Email"));
                nurse.setAddress(rs.getString("address"));
                nurse.setHealthCenter(rs.getString("healthcenter"));
                nurse.setUserID(rs.getInt("UserID"));
                
                try {
                    nurse.setRegisteredByDoctorID(rs.getInt("RegisteredByDoctorID"));
                } catch (SQLException e) {
                    // RegisteredByDoctorID might not exist in older records
                    nurse.setRegisteredByDoctorID(0);
                }
                
                nurses.add(nurse);
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
        }
        
        return nurses;
    }
    
    public boolean addNurse(Nurse nurse) {
        String sql = "INSERT INTO Nurses (UserID, FirstName, LastName, telephone, Email, Department, RegisteredByDoctorID, address, healthcenter) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, nurse.getUserID());
            stmt.setString(2, nurse.getFirstName());
            stmt.setString(3, nurse.getLastName());
            
            // telephone is the actual column name we should use
            String phoneNumber = nurse.getTelephone();
            if (phoneNumber == null || phoneNumber.isEmpty()) {
                phoneNumber = "Unknown";
            }
            stmt.setString(4, phoneNumber);
            
            // Email is required, use a default if not provided
            String email = nurse.getEmail();
            if (email == null || email.isEmpty()) {
                email = nurse.getFirstName().toLowerCase() + "." + nurse.getLastName().toLowerCase() + "@example.com";
            }
            stmt.setString(5, email);
            
            // Department might be null
            String department = nurse.getHealthCenter(); // Use HealthCenter as Department since our model doesn't have department
            stmt.setString(6, department);
            
            // Handle RegisteredByDoctorID
            if (nurse.getRegisteredByDoctorID() > 0) {
                stmt.setInt(7, nurse.getRegisteredByDoctorID());
            } else {
                stmt.setNull(7, java.sql.Types.INTEGER);
            }
            
            // Optional fields
            stmt.setString(8, nurse.getAddress());
            stmt.setString(9, nurse.getHealthCenter());
            
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                result = true;
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    nurse.setNurseID(generatedKeys.getInt(1));
                    System.out.println("Successfully added nurse with ID: " + nurse.getNurseID());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error adding nurse: " + e.getMessage());
            // Check if the Nurses table exists and try to create it if needed
            ensureNursesTableExists();
            // Try one more time if the table was created
            if (stmt == null) {
                try {
                    stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                    stmt.setInt(1, nurse.getUserID());
                    stmt.setString(2, nurse.getFirstName());
                    stmt.setString(3, nurse.getLastName());
                    
                    // telephone is the actual column name we should use
                    String phoneNumber = nurse.getTelephone();
                    if (phoneNumber == null || phoneNumber.isEmpty()) {
                        phoneNumber = "Unknown";
                    }
                    stmt.setString(4, phoneNumber);
                    
                    // Email is required, use a default if not provided
                    String email = nurse.getEmail();
                    if (email == null || email.isEmpty()) {
                        email = nurse.getFirstName().toLowerCase() + "." + nurse.getLastName().toLowerCase() + "@example.com";
                    }
                    stmt.setString(5, email);
                    
                    // Department might be null
                    String department = nurse.getHealthCenter(); // Use HealthCenter as Department
                    stmt.setString(6, department);
                    
                    // Handle RegisteredByDoctorID
                    if (nurse.getRegisteredByDoctorID() > 0) {
                        stmt.setInt(7, nurse.getRegisteredByDoctorID());
                    } else {
                        stmt.setNull(7, java.sql.Types.INTEGER);
                    }
                    
                    // Optional fields
                    stmt.setString(8, nurse.getAddress());
                    stmt.setString(9, nurse.getHealthCenter());
                    
                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        result = true;
                        ResultSet generatedKeys = stmt.getGeneratedKeys();
                        if (generatedKeys.next()) {
                            nurse.setNurseID(generatedKeys.getInt(1));
                            System.out.println("Successfully added nurse on retry with ID: " + nurse.getNurseID());
                        }
                    }
                } catch (SQLException e2) {
                    e2.printStackTrace();
                    System.err.println("Failed to add nurse on retry: " + e2.getMessage());
                }
            }
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
    
    public boolean updateNurse(Nurse nurse) {
        String sql = "UPDATE Nurses SET FirstName = ?, LastName = ?, telephone = ?, Email = ?, Department = ?, address = ?, healthcenter = ? WHERE NurseID = ?";
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, nurse.getFirstName());
            stmt.setString(2, nurse.getLastName());
            
            // telephone is the actual column name we should use
            String phoneNumber = nurse.getTelephone();
            if (phoneNumber == null || phoneNumber.isEmpty()) {
                phoneNumber = "Unknown";
            }
            stmt.setString(3, phoneNumber);
            
            // Email is required, use a default if not provided
            String email = nurse.getEmail();
            if (email == null || email.isEmpty()) {
                email = nurse.getFirstName().toLowerCase() + "." + nurse.getLastName().toLowerCase() + "@example.com";
            }
            stmt.setString(4, email);
            
            // Department might be null
            String department = nurse.getHealthCenter(); // Use HealthCenter as Department
            stmt.setString(5, department);
            
            // Optional fields
            stmt.setString(6, nurse.getAddress());
            stmt.setString(7, nurse.getHealthCenter());
            stmt.setInt(8, nurse.getNurseID());
            
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
    
    public boolean deleteNurse(int nurseID) {
        String sql = "DELETE FROM Nurses WHERE NurseID = ?";
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, nurseID);
            
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
     * Get all nurses registered by a specific doctor
     * 
     * @param doctorID the ID of the doctor who registered the nurses
     * @return a list of nurses registered by the doctor
     */
    public List<Nurse> getNursesByDoctor(int doctorID) {
        String sql = "SELECT * FROM Nurses WHERE RegisteredByDoctorID = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Nurse> nurses = new ArrayList<>();
        
        try {
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, doctorID);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Nurse nurse = new Nurse();
                nurse.setNurseID(rs.getInt("NurseID"));
                nurse.setFirstName(rs.getString("FirstName"));
                nurse.setLastName(rs.getString("LastName"));
                nurse.setTelephone(rs.getString("telephone"));
                nurse.setEmail(rs.getString("Email"));
                nurse.setAddress(rs.getString("address"));
                nurse.setHealthCenter(rs.getString("healthcenter"));
                nurse.setUserID(rs.getInt("UserID"));
                nurse.setRegisteredByDoctorID(rs.getInt("RegisteredByDoctorID"));
                nurses.add(nurse);
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
        }
        
        return nurses;
    }
    
    /**
     * Get nurse name by nurse ID
     * 
     * @param nurseID the ID of the nurse
     * @return the full name of the nurse
     */
    public String getNurseNameByID(int nurseID) {
        String sql = "SELECT FirstName, LastName FROM Nurses WHERE NurseID = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String nurseName = "Unknown";
        
        try {
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, nurseID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                nurseName = rs.getString("FirstName") + " " + rs.getString("LastName");
            } else {
                // Try looking up by UserID if NurseID doesn't match
                String userSql = "SELECT FirstName, LastName FROM Users WHERE UserID = ? AND Role = 'Nurse'";
                PreparedStatement userStmt = null;
                ResultSet userRs = null;
                
                try {
                    userStmt = connection.prepareStatement(userSql);
                    userStmt.setInt(1, nurseID);
                    userRs = userStmt.executeQuery();
                    
                    if (userRs.next()) {
                        nurseName = userRs.getString("FirstName") + " " + userRs.getString("LastName");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (userRs != null) {
                        try { userRs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                    if (userStmt != null) {
                        try { userStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
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
        }
        
        return nurseName;
    }
} 