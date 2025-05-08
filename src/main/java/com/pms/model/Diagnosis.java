package com.pms.model;

import java.sql.Timestamp;

/**
 * Model class representing a diagnosis entry in the system
 */
public class Diagnosis {
    private int diagnosisID;
    private int patientID;
    private int nurseID;
    private int doctorID;
    private String diagnoStatus; // 'Referrable' or 'Not Referrable'
    private String result; // 'Pending' or text result provided by doctor
    private Timestamp createdDate;
    private Timestamp updatedDate;
    
    /**
     * Default constructor
     */
    public Diagnosis() {
    }
    
    /**
     * Constructor with parameters
     * 
     * @param diagnosisID the diagnosis ID
     * @param patientID the patient ID
     * @param nurseID the nurse ID who registered the patient
     * @param doctorID the doctor ID who provided diagnosis
     * @param diagnoStatus the diagnosis status (Referrable or Not Referrable)
     * @param result the diagnosis result
     * @param createdDate the date diagnosis was created
     * @param updatedDate the date diagnosis was updated
     */
    public Diagnosis(int diagnosisID, int patientID, int nurseID, int doctorID, String diagnoStatus,
                     String result, Timestamp createdDate, Timestamp updatedDate) {
        this.diagnosisID = diagnosisID;
        this.patientID = patientID;
        this.nurseID = nurseID;
        this.doctorID = doctorID;
        this.diagnoStatus = diagnoStatus;
        this.result = result;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
    }
    
    /**
     * @return the diagnosisID
     */
    public int getDiagnosisID() {
        return diagnosisID;
    }
    
    /**
     * @param diagnosisID the diagnosisID to set
     */
    public void setDiagnosisID(int diagnosisID) {
        this.diagnosisID = diagnosisID;
    }
    
    /**
     * @return the patientID
     */
    public int getPatientID() {
        return patientID;
    }
    
    /**
     * @param patientID the patientID to set
     */
    public void setPatientID(int patientID) {
        this.patientID = patientID;
    }
    
    /**
     * @return the nurseID
     */
    public int getNurseID() {
        return nurseID;
    }
    
    /**
     * @param nurseID the nurseID to set
     */
    public void setNurseID(int nurseID) {
        this.nurseID = nurseID;
    }
    
    /**
     * @return the doctorID
     */
    public int getDoctorID() {
        return doctorID;
    }
    
    /**
     * @param doctorID the doctorID to set
     */
    public void setDoctorID(int doctorID) {
        this.doctorID = doctorID;
    }
    
    /**
     * @return the diagnoStatus
     */
    public String getDiagnoStatus() {
        return diagnoStatus;
    }
    
    /**
     * @param diagnoStatus the diagnoStatus to set (Referrable or Not Referrable)
     */
    public void setDiagnoStatus(String diagnoStatus) {
        this.diagnoStatus = diagnoStatus;
        // Set default result based on diagnoStatus
        if (this.result == null || this.result.isEmpty()) {
            if ("Referrable".equalsIgnoreCase(diagnoStatus)) {
                this.result = "Pending";
            } else if ("Not Referrable".equalsIgnoreCase(diagnoStatus)) {
                this.result = "Negative";
            }
        }
    }
    
    /**
     * @return the result
     */
    public String getResult() {
        return result;
    }
    
    /**
     * @param result the result to set
     */
    public void setResult(String result) {
        this.result = result;
    }
    
    /**
     * @return whether the diagnosis is referrable
     */
    public boolean isReferrable() {
        return "Referrable".equalsIgnoreCase(diagnoStatus);
    }
    
    /**
     * @return whether the diagnosis result is pending
     */
    public boolean isPending() {
        return result != null && result.contains("Pending");
    }
    
    /**
     * @return the createdDate
     */
    public Timestamp getCreatedDate() {
        return createdDate;
    }
    
    /**
     * @param createdDate the createdDate to set
     */
    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }
    
    /**
     * @return the updatedDate
     */
    public Timestamp getUpdatedDate() {
        return updatedDate;
    }
    
    /**
     * @param updatedDate the updatedDate to set
     */
    public void setUpdatedDate(Timestamp updatedDate) {
        this.updatedDate = updatedDate;
    }
} 