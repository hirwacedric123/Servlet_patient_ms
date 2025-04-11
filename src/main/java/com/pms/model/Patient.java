package com.pms.model;

public class Patient {
    private int patientID;
    private String firstName;
    private String lastName;
    private String telephone;
    private String email;
    private String address;
    private String pImageLink;
    private int createdBy;
    
    public Patient() {
    }
    
    public Patient(String firstName, String lastName, String telephone, String email, String address, String pImageLink, int createdBy) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.telephone = telephone;
        this.email = email;
        this.address = address;
        this.pImageLink = pImageLink;
        this.createdBy = createdBy;
    }
    
    public Patient(int patientID, String firstName, String lastName, String telephone, String email, String address, String pImageLink, int createdBy) {
        this.patientID = patientID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.telephone = telephone;
        this.email = email;
        this.address = address;
        this.pImageLink = pImageLink;
        this.createdBy = createdBy;
    }
    
    public int getPatientID() {
        return patientID;
    }
    
    public void setPatientID(int patientID) {
        this.patientID = patientID;
    }
    
    public String getFirstName() {
        return firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    
    public String getLastName() {
        return lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    public String getTelephone() {
        return telephone;
    }
    
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getPImageLink() {
        return pImageLink;
    }
    
    public void setPImageLink(String pImageLink) {
        this.pImageLink = pImageLink;
    }
    
    public int getCreatedBy() {
        return createdBy;
    }
    
    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }
} 