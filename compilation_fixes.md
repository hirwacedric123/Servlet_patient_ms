# Patient Management System - Compilation Fixes

This document outlines how to fix the compilation issues in the Patient Management System.

## 1. Model Classes

### Patient.java

Update the Patient class to match the database schema:

```java
package com.pms.model;

import java.sql.Date;

public class Patient {
    private int patientID;
    private int userID;
    private String firstName;
    private String lastName;
    private String gender;
    private Date dateOfBirth;
    private int age;
    private String contactNumber;
    private String email;
    private String address;
    private String bloodGroup;
    private int nurseID;
    private String symptoms;
    private boolean referrable;
    private String pImageLink;
    private int createdBy;
    
    // Add getters and setters for all fields
    // Note: Change dateOfBirth from String to Date
    // Add isReferrable() and getAge() methods
}
```

### Diagnosis.java

Update the Diagnosis class to match the diagnosis table schema:

```java
package com.pms.model;

import java.sql.Timestamp;

public class Diagnosis {
    private int diagnosisID;
    private int patientID;
    private int doctorID;
    private String diagnosis;
    private String treatment;
    private Timestamp diagnosisDate;
    private String notes;
    
    // Add getters and setters for all fields
    // Remove old fields: nurseID, diagnoStatus, result, createdDate, updatedDate
}
```

## 2. DAO Classes

### DiagnosisDAO.java

Fix issues in DiagnosisDAO:

1. Remove duplicate methods (addDiagnosis, updateDiagnosis, deleteDiagnosis)
2. Update all SQL queries to use the new table schema
3. Update field references to match the Diagnosis model

```java
// Example method update
public List<Diagnosis> getDiagnosesByDoctorID(int doctorID) {
    String sql = "SELECT * FROM diagnosis WHERE DoctorID = ?";
    // ...processing...
    
    // Update the property assignments
    diagnosis.setDiagnosisID(rs.getInt("DiagnosisID"));
    diagnosis.setPatientID(rs.getInt("PatientID"));
    diagnosis.setDoctorID(rs.getInt("DoctorID"));
    diagnosis.setDiagnosis(rs.getString("Diagnosis"));
    diagnosis.setTreatment(rs.getString("Treatment"));
    diagnosis.setDiagnosisDate(rs.getTimestamp("DiagnosisDate"));
    diagnosis.setNotes(rs.getString("Notes"));
    
    // ...
}
```

### PatientDAO.java

Add the missing getPatientsByNurseID method:

```java
/**
 * Get patients registered by a specific nurse
 * 
 * @param nurseID the ID of the nurse
 * @return a list of patients registered by the nurse
 */
public List<Patient> getPatientsByNurseID(int nurseID) {
    String sql = "SELECT * FROM patients WHERE NurseID = ?";
    // ... implementation ...
}
```

## 3. Database Schema Updates

The database schema has been updated to better match the model classes. The key changes are:

1. In the `patients` table:
   - Added `IsReferrable` boolean field
   - Added `Symptoms` text field
   - Changed date handling for `DateOfBirth`

2. In the `diagnosis` table:
   - Renamed fields to match the model
   - Removed NurseID field
   - Added Treatment and Notes fields

Execute the schema update script in `src/main/resources/database_schema.sql` to ensure your database is properly set up.

## 4. Additional Steps

After fixing these issues:

1. Rebuild the project: `mvn clean package`
2. Redeploy to your application server
3. Verify the dashboards load correctly for the different user roles

If you encounter any specific compilation errors, check the error message against the fixes listed above to identify what still needs to be corrected. 