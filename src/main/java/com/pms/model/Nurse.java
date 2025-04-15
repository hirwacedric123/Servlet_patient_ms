package com.pms.model;

public class Nurse {
    private int nurseID;
    private String firstName;
    private String lastName;
    private String telephone;
    private String email;
    private String address;
    private String healthCenter;
    private int userID;
    private int registeredByDoctorID;
    
    public Nurse() {
    }
    
    public Nurse(String firstName, String lastName, String telephone, String email, String address, String healthCenter, int userID) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.telephone = telephone;
        this.email = email;
        this.address = address;
        this.healthCenter = healthCenter;
        this.userID = userID;
    }
    
    public Nurse(int nurseID, String firstName, String lastName, String telephone, String email, String address, String healthCenter, int userID) {
        this.nurseID = nurseID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.telephone = telephone;
        this.email = email;
        this.address = address;
        this.healthCenter = healthCenter;
        this.userID = userID;
    }
    
    public int getNurseID() {
        return nurseID;
    }
    
    public void setNurseID(int nurseID) {
        this.nurseID = nurseID;
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
    
    public String getHealthCenter() {
        return healthCenter;
    }
    
    public void setHealthCenter(String healthCenter) {
        this.healthCenter = healthCenter;
    }
    
    public int getUserID() {
        return userID;
    }
    
    public void setUserID(int userID) {
        this.userID = userID;
    }
    
    public int getRegisteredByDoctorID() {
        return registeredByDoctorID;
    }
    
    public void setRegisteredByDoctorID(int registeredByDoctorID) {
        this.registeredByDoctorID = registeredByDoctorID;
    }
} 