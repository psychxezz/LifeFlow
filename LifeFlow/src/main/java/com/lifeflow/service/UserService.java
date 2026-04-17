package com.lifeflow.service;

import com.lifeflow.config.DBConfig;
import com.lifeflow.model.Donor;
import com.lifeflow.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class UserService {

    public boolean isEmailExists(String email) {
        String query = "SELECT email FROM users WHERE email = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean isPhoneExists(String phone) {
        String query = "SELECT phone FROM users WHERE phone = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean registerUser(User user) {
        String query = "INSERT INTO users (full_name, email, phone, password, role) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole());

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean registerUserWithDonor(User user, Donor donor) {
        String userQuery = "INSERT INTO users (full_name, email, phone, password, role) VALUES (?, ?, ?, ?, ?)";
        String donorQuery = "INSERT INTO donors (user_id, blood_group, gender, date_of_birth, address, city, eligibility_status) VALUES (?, ?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement userPs = null;
        PreparedStatement donorPs = null;
        ResultSet generatedKeys = null;

        try {
            conn = DBConfig.getConnection();
            conn.setAutoCommit(false);

            userPs = conn.prepareStatement(userQuery, Statement.RETURN_GENERATED_KEYS);
            userPs.setString(1, user.getFullName());
            userPs.setString(2, user.getEmail());
            userPs.setString(3, user.getPhone());
            userPs.setString(4, user.getPassword());
            userPs.setString(5, user.getRole());

            int userRows = userPs.executeUpdate();

            if (userRows == 0) {
                conn.rollback();
                return false;
            }

            generatedKeys = userPs.getGeneratedKeys();
            if (!generatedKeys.next()) {
                conn.rollback();
                return false;
            }

            int userId = generatedKeys.getInt(1);

            donorPs = conn.prepareStatement(donorQuery);
            donorPs.setInt(1, userId);
            donorPs.setString(2, donor.getBloodGroup());
            donorPs.setString(3, donor.getGender());
            donorPs.setDate(4, donor.getDateOfBirth());
            donorPs.setString(5, donor.getAddress());
            donorPs.setString(6, donor.getCity());
            donorPs.setString(7, donor.getEligibilityStatus());

            int donorRows = donorPs.executeUpdate();

            if (donorRows == 0) {
                conn.rollback();
                return false;
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (generatedKeys != null) generatedKeys.close();
                if (userPs != null) userPs.close();
                if (donorPs != null) donorPs.close();
                if (conn != null) conn.setAutoCommit(true);
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return false;
    }

    public User getUserByEmail(String email) {
        String query = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setFailedAttempts(rs.getInt("failed_attempts"));
                user.setAccountLocked(rs.getBoolean("account_locked"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                return user;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public int getUserIdByEmail(String email) {
        String query = "SELECT user_id FROM users WHERE email = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("user_id");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }

    public Donor getDonorByUserId(int userId) {
        String query = "SELECT * FROM donors WHERE user_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Donor donor = new Donor();
                donor.setDonorId(rs.getInt("donor_id"));
                donor.setUserId(rs.getInt("user_id"));
                donor.setBloodGroup(rs.getString("blood_group"));
                donor.setGender(rs.getString("gender"));
                donor.setDateOfBirth(rs.getDate("date_of_birth"));
                donor.setAddress(rs.getString("address"));
                donor.setCity(rs.getString("city"));
                donor.setEligibilityStatus(rs.getString("eligibility_status"));
                return donor;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
    public boolean updatePasswordByEmail(String email, String newPassword) {
        String query = "UPDATE users SET password = ?, failed_attempts = 0, account_locked = FALSE WHERE email = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, newPassword);
            ps.setString(2, email);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
    public boolean updateUserProfile(User user) {
        String query = "UPDATE users SET full_name = ?, phone = ? WHERE user_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPhone());
            ps.setInt(3, user.getUserId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateDonorProfile(Donor donor) {
        String query = "UPDATE donors SET blood_group = ?, gender = ?, date_of_birth = ?, address = ?, city = ? WHERE user_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, donor.getBloodGroup());
            ps.setString(2, donor.getGender());
            ps.setDate(3, donor.getDateOfBirth());
            ps.setString(4, donor.getAddress());
            ps.setString(5, donor.getCity());
            ps.setInt(6, donor.getUserId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}