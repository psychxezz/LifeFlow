package com.lifeflow.service;

import com.lifeflow.config.DBConfig;
import com.lifeflow.model.User;
import com.lifeflow.util.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AuthService {

    public User loginUser(String email, String password) {
        // Fetch the user by email only (account must not be locked);
        // password verification is done in Java using the stored hash.
        String query = "SELECT * FROM users WHERE email = ? AND account_locked = FALSE";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");

                // Verify the plaintext password against the stored hash
                if (!PasswordUtil.verifyPassword(password, storedPassword)) {
                    return null;
                }

                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setPassword(storedPassword);
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

    public void increaseFailedAttempts(String email) {
        String query = "UPDATE users SET failed_attempts = failed_attempts + 1 WHERE email = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, email);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void resetFailedAttempts(String email) {
        String query = "UPDATE users SET failed_attempts = 0 WHERE email = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, email);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getFailedAttempts(String email) {
        String query = "SELECT failed_attempts FROM users WHERE email = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("failed_attempts");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public void lockAccount(String email) {
        String query = "UPDATE users SET account_locked = TRUE WHERE email = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, email);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean isAccountLocked(String email) {
        String query = "SELECT account_locked FROM users WHERE email = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getBoolean("account_locked");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}