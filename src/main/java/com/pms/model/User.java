package com.pms.model;

public class User {
    private int userID;
    private String username;
    private String password;
    private String userType;
    
    public User() {
    }
    
    public User(String username, String password, String userType) {
        this.username = username;
        this.password = password;
        this.userType = userType;
    }
    
    public User(int userID, String username, String password, String userType) {
        this.userID = userID;
        this.username = username;
        this.password = password;
        this.userType = userType;
    }
    
    public int getUserID() {
        return userID;
    }
    
    public void setUserID(int userID) {
        this.userID = userID;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getUserType() {
        return userType;
    }
    
    public void setUserType(String userType) {
        this.userType = userType;
    }
} 