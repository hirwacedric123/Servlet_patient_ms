package com.pms.model;

public class Doctor {
    private int id;
    private int doctorID;
    private String name;
    private String firstName;
    private String lastName;
    private String specialization;
    private String email;
    private String phone;
    private String contactNumber;
    private String address;
    private boolean active;
    private int userId;
    private String hospitalName;

    public Doctor() {
    }

    public Doctor(int id, String name, String specialization, String email, String phone, String address) {
        this.id = id;
        this.doctorID = id;
        this.name = name;
        String[] parts = name.split(" ", 2);
        this.firstName = parts[0];
        this.lastName = parts.length > 1 ? parts[1] : "";
        this.specialization = specialization;
        this.email = email;
        this.phone = phone;
        this.contactNumber = phone;
        this.address = address;
        this.active = true;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
        this.doctorID = id;
    }

    public int getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(int doctorID) {
        this.doctorID = doctorID;
        this.id = doctorID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
        String[] parts = name.split(" ", 2);
        this.firstName = parts[0];
        this.lastName = parts.length > 1 ? parts[1] : "";
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
        this.name = firstName + (lastName != null ? " " + lastName : "");
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
        this.name = (firstName != null ? firstName + " " : "") + lastName;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
        this.contactNumber = phone;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
        this.phone = contactNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getHospitalName() {
        return hospitalName;
    }

    public void setHospitalName(String hospitalName) {
        this.hospitalName = hospitalName;
    }
} 