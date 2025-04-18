package com.pms.model;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class Patient {
    private int patientID; // This is now the UserID from the Users table
    private String firstName;
    private String lastName;
    private String gender;
    private Date dateOfBirth;
    private int age;
    private String contactNumber;
    private String email;
    private String address;
    private String bloodGroup;
    private String emergencyContact;
    private String pImageLink; // Profile image from Users table (was PImageLink)
    // New fields to match the schema
    private int userID; // Same as patientID, for compatibility 
    private String symptoms; // From Diagnosis table
    private boolean referrable; // Based on DiagnoStatus from Diagnosis
    private int createdBy; // NurseID who created the patient
    
    public Patient() {
        // Default constructor
    }
    
    public Patient(String firstName, String lastName, String contactNumber, String email, 
                  String address, String pImageLink, String gender, String dateOfBirth, 
                  String bloodGroup) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.contactNumber = contactNumber;
        this.email = email;
        this.address = address;
        this.pImageLink = pImageLink;
        this.gender = gender;
        this.dateOfBirth = convertStringToDate(dateOfBirth);
        this.bloodGroup = bloodGroup;
    }
    
    public Patient(int patientID, String firstName, String lastName, String contactNumber, 
                  String email, String address, String pImageLink, String gender, 
                  String dateOfBirth, String bloodGroup) {
        this.patientID = patientID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.contactNumber = contactNumber;
        this.email = email;
        this.address = address;
        this.pImageLink = pImageLink;
        this.gender = gender;
        this.dateOfBirth = convertStringToDate(dateOfBirth);
        this.bloodGroup = bloodGroup;
        this.userID = patientID;
    }
    
    // Helper method to convert String to java.sql.Date
    private Date convertStringToDate(String dateStr) {
        if (dateStr == null || dateStr.isEmpty()) {
            return null;
        }
        
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date parsedDate = format.parse(dateStr);
            return new Date(parsedDate.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public int getPatientID() {
        return patientID;
    }
    
    public void setPatientID(int patientID) {
        this.patientID = patientID;
        this.userID = patientID;
    }
    
    public int getUserID() {
        return userID;
    }
    
    public void setUserID(int userID) {
        this.userID = userID;
        this.patientID = userID;
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
    
    public String getGender() {
        return gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public Date getDateOfBirth() {
        return dateOfBirth;
    }
    
    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }
    
    // Additional setter for String dates
    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = convertStringToDate(dateOfBirth);
    }
    
    public int getAge() {
        return age;
    }
    
    public void setAge(int age) {
        this.age = age;
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
    
    public String getBloodGroup() {
        return bloodGroup;
    }
    
    public void setBloodGroup(String bloodGroup) {
        this.bloodGroup = bloodGroup;
    }
    
    public String getEmergencyContact() {
        return emergencyContact;
    }
    
    public void setEmergencyContact(String emergencyContact) {
        this.emergencyContact = emergencyContact;
    }

    public String getPImageLink() {
        return pImageLink;
    }

    public void setPImageLink(String pImageLink) {
        this.pImageLink = pImageLink;
    }
    
    // Added for compatibility with the new schema column name
    public String getProfileImage() {
        return pImageLink;
    }
    
    public void setProfileImage(String profileImage) {
        this.pImageLink = profileImage;
    }
    
    public String getSymptoms() {
        return symptoms;
    }
    
    public void setSymptoms(String symptoms) {
        this.symptoms = symptoms;
    }
    
    /**
     * Check if the patient is referrable
     * Default to false if not set (non-referrable)
     * 
     * @return true if the patient is referrable, false otherwise
     */
    public boolean isReferrable() {
        // Default to non-referrable if not explicitly set
        return referrable;
    }
    
    /**
     * Set whether the patient is referrable
     * 
     * @param referrable true if the patient is referrable, false otherwise
     */
    public void setReferrable(boolean referrable) {
        this.referrable = referrable;
    }
    
    public int getCreatedBy() {
        return createdBy;
    }
    
    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }
    
    public String getFullName() {
        return firstName + " " + lastName;
    }
} 