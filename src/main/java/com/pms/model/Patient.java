package com.pms.model;

public class Patient {
    private int patientID;
    private String firstName;
    private String lastName;
    private String contactNumber;
    private String email;
    private String address;
    private String pImageLink;
    private String gender;
    private String dateOfBirth;
    private int createdBy;
    private int userID;
    
    public Patient() {
    }
    
    public Patient(String firstName, String lastName, String contactNumber, String email, String address, String pImageLink, String gender, String dateOfBirth, int createdBy) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.contactNumber = contactNumber;
        this.email = email;
        this.address = address;
        this.pImageLink = pImageLink;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.createdBy = createdBy;
    }
    
    public Patient(int patientID, String firstName, String lastName, String contactNumber, String email, String address, String pImageLink, String gender, String dateOfBirth, int createdBy, int userID) {
        this.patientID = patientID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.contactNumber = contactNumber;
        this.email = email;
        this.address = address;
        this.pImageLink = pImageLink;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.createdBy = createdBy;
        this.userID = userID;
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
    
    public String getContactNumber() {
        return contactNumber;
    }
    
    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
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
    
    public String getGender() {
        return gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public String getDateOfBirth() {
        return dateOfBirth;
    }
    
    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }
    
    public int getCreatedBy() {
        return createdBy;
    }
    
    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }
    
    public int getUserID() {
        return userID;
    }
    
    public void setUserID(int userID) {
        this.userID = userID;
    }
} 