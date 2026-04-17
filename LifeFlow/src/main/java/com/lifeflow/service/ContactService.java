package com.lifeflow.service;

import com.lifeflow.config.DBConfig;
import com.lifeflow.model.ContactMessage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ContactService {

    public boolean saveContactMessage(ContactMessage contactMessage) {
        String query = "INSERT INTO contact_messages (name, email, subject, message) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, contactMessage.getName());
            ps.setString(2, contactMessage.getEmail());
            ps.setString(3, contactMessage.getSubject());
            ps.setString(4, contactMessage.getMessage());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}