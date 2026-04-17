package com.lifeflow.model;

import java.sql.Timestamp;

public class User {
    private int userId;
    private String fullName;
    private String email;
    private String phone;
    private String password;
    private String role;
    private int failedAttempts;
    private boolean accountLocked;
    private Timestamp createdAt;

    public User() {
    }

    public User(int userId, String fullName, String email, String phone, String password,
                String role, int failedAttempts, boolean accountLocked, Timestamp createdAt) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.role = role;
        this.failedAttempts = failedAttempts;
        this.accountLocked = accountLocked;
        this.createdAt = createdAt;
    }

    public User(String fullName, String email, String phone, String password, String role) {
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.role = role;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
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
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getFailedAttempts() {
        return failedAttempts;
    }

    public void setFailedAttempts(int failedAttempts) {
        this.failedAttempts = failedAttempts;
    }

    public boolean isAccountLocked() {
        return accountLocked;
    }

    public void setAccountLocked(boolean accountLocked) {
        this.accountLocked = accountLocked;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}