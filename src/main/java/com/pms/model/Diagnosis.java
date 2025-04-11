package com.pms.model;

import java.sql.Timestamp;

/**
 * Model class representing a diagnosis entry in the system
 */
public class Diagnosis {
    private int diagnosisID;
    private int patientID;
    private int doctorID;
    private String diagnosis;
    private String treatment;
    private Timestamp diagnosisDate;
    private String notes;
    
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
     * @param doctorID the doctor ID
     * @param diagnosis the diagnosis text
     * @param treatment the treatment plan
     * @param diagnosisDate the date of diagnosis
     * @param notes additional notes
     */
    public Diagnosis(int diagnosisID, int patientID, int doctorID, String diagnosis, String treatment, 
                     Timestamp diagnosisDate, String notes) {
        this.diagnosisID = diagnosisID;
        this.patientID = patientID;
        this.doctorID = doctorID;
        this.diagnosis = diagnosis;
        this.treatment = treatment;
        this.diagnosisDate = diagnosisDate;
        this.notes = notes;
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
     * @return the diagnosis
     */
    public String getDiagnosis() {
        return diagnosis;
    }
    
    /**
     * @param diagnosis the diagnosis to set
     */
    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }
    
    /**
     * @return the treatment
     */
    public String getTreatment() {
        return treatment;
    }
    
    /**
     * @param treatment the treatment to set
     */
    public void setTreatment(String treatment) {
        this.treatment = treatment;
    }
    
    /**
     * @return the diagnosisDate
     */
    public Timestamp getDiagnosisDate() {
        return diagnosisDate;
    }
    
    /**
     * @param diagnosisDate the diagnosisDate to set
     */
    public void setDiagnosisDate(Timestamp diagnosisDate) {
        this.diagnosisDate = diagnosisDate;
    }
    
    /**
     * @return the notes
     */
    public String getNotes() {
        return notes;
    }
    
    /**
     * @param notes the notes to set
     */
    public void setNotes(String notes) {
        this.notes = notes;
    }
} 