package com.pms.model;

import java.sql.Timestamp;

public class Diagnosis {
    private int diagnosisID;
    private int patientID;
    private int nurseID;
    private Integer doctorID;
    private String diagnoStatus;
    private String result;
    private Timestamp createdDate;
    private Timestamp updatedDate;
    
    public Diagnosis() {
    }
    
    public Diagnosis(int patientID, int nurseID, Integer doctorID, String diagnoStatus, String result) {
        this.patientID = patientID;
        this.nurseID = nurseID;
        this.doctorID = doctorID;
        this.diagnoStatus = diagnoStatus;
        this.result = result;
    }
    
    public Diagnosis(int diagnosisID, int patientID, int nurseID, Integer doctorID, String diagnoStatus, String result, Timestamp createdDate, Timestamp updatedDate) {
        this.diagnosisID = diagnosisID;
        this.patientID = patientID;
        this.nurseID = nurseID;
        this.doctorID = doctorID;
        this.diagnoStatus = diagnoStatus;
        this.result = result;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
    }
    
    public int getDiagnosisID() {
        return diagnosisID;
    }
    
    public void setDiagnosisID(int diagnosisID) {
        this.diagnosisID = diagnosisID;
    }
    
    public int getPatientID() {
        return patientID;
    }
    
    public void setPatientID(int patientID) {
        this.patientID = patientID;
    }
    
    public int getNurseID() {
        return nurseID;
    }
    
    public void setNurseID(int nurseID) {
        this.nurseID = nurseID;
    }
    
    public Integer getDoctorID() {
        return doctorID;
    }
    
    public void setDoctorID(Integer doctorID) {
        this.doctorID = doctorID;
    }
    
    public String getDiagnoStatus() {
        return diagnoStatus;
    }
    
    public void setDiagnoStatus(String diagnoStatus) {
        this.diagnoStatus = diagnoStatus;
    }
    
    public String getResult() {
        return result;
    }
    
    public void setResult(String result) {
        this.result = result;
    }
    
    public Timestamp getCreatedDate() {
        return createdDate;
    }
    
    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }
    
    public Timestamp getUpdatedDate() {
        return updatedDate;
    }
    
    public void setUpdatedDate(Timestamp updatedDate) {
        this.updatedDate = updatedDate;
    }
} 