package com.pms.model;

public class Doctor {
    private int doctorID;
    private String firstName;
    private String lastName;
    private String contactNumber;
    private String email;
    private String address;
    private String hospitalName;
    private String specialization;
    private int userID;
    
    public Doctor() {
    }
    
    public Doctor(String firstName, String lastName, String contactNumber, String email, String address, String hospitalName, String specialization, int userID) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.contactNumber = contactNumber;
        this.email = email;
        this.address = address;
        this.hospitalName = hospitalName;
        this.specialization = specialization;
        this.userID = userID;
    }
    
    public Doctor(int doctorID, String firstName, String lastName, String contactNumber, String email, String address, String hospitalName, String specialization, int userID) {
        this.doctorID = doctorID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.contactNumber = contactNumber;
        this.email = email;
        this.address = address;
        this.hospitalName = hospitalName;
        this.specialization = specialization;
        this.userID = userID;
    }
    
    public int getDoctorID() {
        return doctorID;
    }
    
    public void setDoctorID(int doctorID) {
        this.doctorID = doctorID;
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
    
    public String getHospitalName() {
        return hospitalName;
    }
    
    public void setHospitalName(String hospitalName) {
        this.hospitalName = hospitalName;
    }
    
    public String getSpecialization() {
        return specialization;
    }
    
    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }
    
    public int getUserID() {
        return userID;
    }
    
    public void setUserID(int userID) {
        this.userID = userID;
    }
} 