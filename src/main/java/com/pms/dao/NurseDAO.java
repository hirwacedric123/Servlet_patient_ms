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
                    "FirstName VARCHAR(50) NOT NULL, " +
                    "LastName VARCHAR(50) NOT NULL, " +
                    "telephone VARCHAR(20), " +
                    "Email VARCHAR(100), " +
                    "address VARCHAR(255), " +
                    "healthcenter VARCHAR(100), " +
                    "UserID INT NOT NULL, " +
                    "RegisteredByDoctorID INT, " +
                    "FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE" +
                    ")";
                
                stmt.executeUpdate(createTableSQL);
                System.out.println("Created Nurses table");
                stmt.close();
            } else {
                // Table exists, check if all required columns exist
                boolean hasTelephoneColumn = false;
                ResultSet columns = meta.getColumns(null, null, "Nurses", "telephone");
                if (columns.next()) {
                    hasTelephoneColumn = true;
                }

                // Check capitalized version too
                columns = meta.getColumns(null, null, "Nurses", "Telephone");
                if (columns.next()) {
                    hasTelephoneColumn = true;
                }
                
                if (!hasTelephoneColumn) {
                    // Add the missing column
                    Statement stmt = connection.createStatement();
                    String addColumnSQL = "ALTER TABLE Nurses ADD COLUMN telephone VARCHAR(20)";
                    stmt.executeUpdate(addColumnSQL);
                    System.out.println("Added telephone column to Nurses table");
                    stmt.close();
                }
                
                // Check for address column (both cases)
                boolean hasAddressColumn = false;
                ResultSet addressColumns = meta.getColumns(null, null, "Nurses", "address");
                if (addressColumns.next()) {
                    hasAddressColumn = true;
                }

                // Check capitalized version too
                addressColumns = meta.getColumns(null, null, "Nurses", "Address");
                if (addressColumns.next()) {
                    hasAddressColumn = true;
                }
                
                if (!hasAddressColumn) {
                    // Add the missing column
                    Statement stmt = connection.createStatement();
                    String addColumnSQL = "ALTER TABLE Nurses ADD COLUMN address VARCHAR(255)";
                    stmt.executeUpdate(addColumnSQL);
                    System.out.println("Added address column to Nurses table");
                    stmt.close();
                }
                
                // Check for healthcenter column (both cases)
                boolean hasHealthCenterColumn = false;
                ResultSet healthCenterColumns = meta.getColumns(null, null, "Nurses", "healthcenter");
                if (healthCenterColumns.next()) {
                    hasHealthCenterColumn = true;
                }

                // Check capitalized version too
                healthCenterColumns = meta.getColumns(null, null, "Nurses", "HealthCenter");
                if (healthCenterColumns.next()) {
                    hasHealthCenterColumn = true;
                }
                
                if (!hasHealthCenterColumn) {
                    // Add the missing column
                    Statement stmt = connection.createStatement();
                    String addColumnSQL = "ALTER TABLE Nurses ADD COLUMN healthcenter VARCHAR(100)";
                    stmt.executeUpdate(addColumnSQL);
                    System.out.println("Added healthcenter column to Nurses table");
                    stmt.close();
                }
                
                // Check for RegisteredByDoctorID column
                ResultSet doctorIdColumn = meta.getColumns(null, null, "Nurses", "RegisteredByDoctorID");
                if (!doctorIdColumn.next()) {
                    // Add the missing column
                    Statement stmt = connection.createStatement();
                    String addColumnSQL = "ALTER TABLE Nurses ADD COLUMN RegisteredByDoctorID INT DEFAULT NULL";
                    stmt.executeUpdate(addColumnSQL);
                    System.out.println("Added RegisteredByDoctorID column to Nurses table");
                    stmt.close();
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
        String sql = "INSERT INTO Nurses (FirstName, LastName, telephone, Email, address, healthcenter, UserID, RegisteredByDoctorID) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, nurse.getFirstName());
            stmt.setString(2, nurse.getLastName());
            stmt.setString(3, nurse.getTelephone());
            stmt.setString(4, nurse.getEmail());
            stmt.setString(5, nurse.getAddress());
            stmt.setString(6, nurse.getHealthCenter());
            stmt.setInt(7, nurse.getUserID());
            
            // Handle RegisteredByDoctorID, which could be 0 if not set
            if (nurse.getRegisteredByDoctorID() > 0) {
                stmt.setInt(8, nurse.getRegisteredByDoctorID());
            } else {
                stmt.setNull(8, java.sql.Types.INTEGER);
            }
            
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
                    stmt.setString(1, nurse.getFirstName());
                    stmt.setString(2, nurse.getLastName());
                    stmt.setString(3, nurse.getTelephone());
                    stmt.setString(4, nurse.getEmail());
                    stmt.setString(5, nurse.getAddress());
                    stmt.setString(6, nurse.getHealthCenter());
                    stmt.setInt(7, nurse.getUserID());
                    
                    if (nurse.getRegisteredByDoctorID() > 0) {
                        stmt.setInt(8, nurse.getRegisteredByDoctorID());
                    } else {
                        stmt.setNull(8, java.sql.Types.INTEGER);
                    }
                    
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
        String sql = "UPDATE Nurses SET FirstName = ?, LastName = ?, telephone = ?, Email = ?, address = ?, healthcenter = ? WHERE NurseID = ?";
        PreparedStatement stmt = null;
        boolean result = false;
        
        try {
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, nurse.getFirstName());
            stmt.setString(2, nurse.getLastName());
            stmt.setString(3, nurse.getTelephone());
            stmt.setString(4, nurse.getEmail());
            stmt.setString(5, nurse.getAddress());
            stmt.setString(6, nurse.getHealthCenter());
            stmt.setInt(7, nurse.getNurseID());
            
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
} 