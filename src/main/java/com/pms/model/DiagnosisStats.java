package com.pms.model;

/**
 * Model class to represent statistics about diagnosis cases 
 * handled by doctors and nurses
 */
public class DiagnosisStats {
    private int staffID;
    private String staffName;
    private String facilityName; // Hospital or Health Center
    private int totalCases;
    private int referrableCases;
    private int nonReferrableCases;
    private int pendingCases;
    private int confirmedCases;
    
    // Default constructor
    public DiagnosisStats() {
    }
    
    // Constructor for doctor stats
    public DiagnosisStats(int doctorID, String doctorName, String hospitalName, int totalCases) {
        this.staffID = doctorID;
        this.staffName = doctorName;
        this.facilityName = hospitalName;
        this.totalCases = totalCases;
    }
    
    // Constructor for nurse stats
    public DiagnosisStats(int nurseID, String nurseName, String healthCenter, int totalCases, 
                          int referrableCases, int nonReferrableCases) {
        this.staffID = nurseID;
        this.staffName = nurseName;
        this.facilityName = healthCenter;
        this.totalCases = totalCases;
        this.referrableCases = referrableCases;
        this.nonReferrableCases = nonReferrableCases;
    }

    // Getters and setters
    public int getStaffID() {
        return staffID;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getFacilityName() {
        return facilityName;
    }

    public void setFacilityName(String facilityName) {
        this.facilityName = facilityName;
    }

    public int getTotalCases() {
        return totalCases;
    }

    public void setTotalCases(int totalCases) {
        this.totalCases = totalCases;
    }

    public int getReferrableCases() {
        return referrableCases;
    }

    public void setReferrableCases(int referrableCases) {
        this.referrableCases = referrableCases;
    }

    public int getNonReferrableCases() {
        return nonReferrableCases;
    }

    public void setNonReferrableCases(int nonReferrableCases) {
        this.nonReferrableCases = nonReferrableCases;
    }

    public int getPendingCases() {
        return pendingCases;
    }

    public void setPendingCases(int pendingCases) {
        this.pendingCases = pendingCases;
    }

    public int getConfirmedCases() {
        return confirmedCases;
    }

    public void setConfirmedCases(int confirmedCases) {
        this.confirmedCases = confirmedCases;
    }
    
    // For Doctor-specific stats
    public String getDoctorName() {
        return this.staffName;
    }
    
    public String getHospitalName() {
        return this.facilityName;
    }
    
    // For Nurse-specific stats
    public String getNurseName() {
        return this.staffName;
    }
    
    public String getHealthCenter() {
        return this.facilityName;
    }
} 