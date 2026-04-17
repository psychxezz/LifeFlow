package com.lifeflow.service;

import com.lifeflow.config.DBConfig;
import com.lifeflow.model.BloodRequest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BloodRequestService {

    public List<BloodRequest> getAllOpenBloodRequests() {
        List<BloodRequest> bloodRequests = new ArrayList<>();
        String query = "SELECT * FROM blood_requests ORDER BY request_id DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BloodRequest request = new BloodRequest();
                request.setRequestId(rs.getInt("request_id"));
                request.setPatientName(rs.getString("patient_name"));
                request.setBloodGroup(rs.getString("blood_group"));
                request.setHospitalName(rs.getString("hospital_name"));
                request.setCity(rs.getString("city"));
                request.setUrgencyLevel(rs.getString("urgency_level"));
                request.setUnitsRequired(rs.getInt("units_required"));
                request.setRequestStatus(rs.getString("request_status"));
                request.setCreatedAt(rs.getTimestamp("created_at"));
                bloodRequests.add(request);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bloodRequests;
    }

    public List<BloodRequest> searchBloodRequests(String keyword, String bloodGroup, String city) {
        List<BloodRequest> bloodRequests = new ArrayList<>();

        StringBuilder query = new StringBuilder("SELECT * FROM blood_requests WHERE 1=1");
        List<String> parameters = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            query.append(" AND (patient_name LIKE ? OR hospital_name LIKE ?)");
            String value = "%" + keyword.trim() + "%";
            parameters.add(value);
            parameters.add(value);
        }

        if (bloodGroup != null && !bloodGroup.trim().isEmpty()) {
            query.append(" AND blood_group = ?");
            parameters.add(bloodGroup.trim());
        }

        if (city != null && !city.trim().isEmpty()) {
            query.append(" AND city LIKE ?");
            parameters.add("%" + city.trim() + "%");
        }

        query.append(" ORDER BY request_id DESC");

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query.toString())) {

            for (int i = 0; i < parameters.size(); i++) {
                ps.setString(i + 1, parameters.get(i));
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BloodRequest request = new BloodRequest();
                request.setRequestId(rs.getInt("request_id"));
                request.setPatientName(rs.getString("patient_name"));
                request.setBloodGroup(rs.getString("blood_group"));
                request.setHospitalName(rs.getString("hospital_name"));
                request.setCity(rs.getString("city"));
                request.setUrgencyLevel(rs.getString("urgency_level"));
                request.setUnitsRequired(rs.getInt("units_required"));
                request.setRequestStatus(rs.getString("request_status"));
                request.setCreatedAt(rs.getTimestamp("created_at"));
                bloodRequests.add(request);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bloodRequests;
    }
}