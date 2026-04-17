package com.lifeflow.model;

import java.sql.Date;

public class Donor {
    private int donorId;
    private int userId;
    private String bloodGroup;
    private String gender;
    private Date dateOfBirth;
    private String address;
    private String city;
    private String eligibilityStatus;

    public Donor() {
    }

    public Donor(int donorId, int userId, String bloodGroup, String gender, Date dateOfBirth,
                 String address, String city, String eligibilityStatus) {
        this.donorId = donorId;
        this.userId = userId;
        this.bloodGroup = bloodGroup;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.address = address;
        this.city = city;
        this.eligibilityStatus = eligibilityStatus;
    }

    public Donor(int userId, String bloodGroup, String gender, Date dateOfBirth,
                 String address, String city, String eligibilityStatus) {
        this.userId = userId;
        this.bloodGroup = bloodGroup;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.address = address;
        this.city = city;
        this.eligibilityStatus = eligibilityStatus;
    }

    public int getDonorId() {
        return donorId;
    }

    public void setDonorId(int donorId) {
        this.donorId = donorId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getBloodGroup() {
        return bloodGroup;
    }

    public void setBloodGroup(String bloodGroup) {
        this.bloodGroup = bloodGroup;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getEligibilityStatus() {
        return eligibilityStatus;
    }

    public void setEligibilityStatus(String eligibilityStatus) {
        this.eligibilityStatus = eligibilityStatus;
    }
}