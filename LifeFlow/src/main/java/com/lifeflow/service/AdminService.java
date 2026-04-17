package com.lifeflow.service;

import com.lifeflow.config.DBConfig;
import com.lifeflow.model.Appointment;
import com.lifeflow.model.BloodRequest;
import com.lifeflow.model.ContactMessage;
import com.lifeflow.model.Donor;
import com.lifeflow.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminService {

    public int getTotalUsers() {
        return getCount("SELECT COUNT(*) FROM users");
    }

    public int getTotalDonors() {
        return getCount("SELECT COUNT(*) FROM donors");
    }

    public int getTotalAppointments() {
        return getCount("SELECT COUNT(*) FROM appointments");
    }

    public int getTotalBloodRequests() {
        return getCount("SELECT COUNT(*) FROM blood_requests");
    }

    public int getTotalContactMessages() {
        return getCount("SELECT COUNT(*) FROM contact_messages");
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users ORDER BY user_id DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
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
                users.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    public boolean deleteUserById(int userId) {
        String query = "DELETE FROM users WHERE user_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Donor> getAllDonors() {
        List<Donor> donors = new ArrayList<>();
        String query = "SELECT * FROM donors ORDER BY donor_id DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Donor donor = new Donor();
                donor.setDonorId(rs.getInt("donor_id"));
                donor.setUserId(rs.getInt("user_id"));
                donor.setBloodGroup(rs.getString("blood_group"));
                donor.setGender(rs.getString("gender"));
                donor.setDateOfBirth(rs.getDate("date_of_birth"));
                donor.setAddress(rs.getString("address"));
                donor.setCity(rs.getString("city"));
                donor.setEligibilityStatus(rs.getString("eligibility_status"));
                donors.add(donor);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return donors;
    }

    public Donor getDonorById(int donorId) {
        String query = "SELECT * FROM donors WHERE donor_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, donorId);
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

    public boolean updateDonor(Donor donor) {
        String query = "UPDATE donors SET blood_group = ?, gender = ?, date_of_birth = ?, address = ?, city = ?, eligibility_status = ? WHERE donor_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, donor.getBloodGroup());
            ps.setString(2, donor.getGender());
            ps.setDate(3, donor.getDateOfBirth());
            ps.setString(4, donor.getAddress());
            ps.setString(5, donor.getCity());
            ps.setString(6, donor.getEligibilityStatus());
            ps.setInt(7, donor.getDonorId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<BloodRequest> getAllBloodRequests() {
        List<BloodRequest> requests = new ArrayList<>();
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
                requests.add(request);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return requests;
    }

    public BloodRequest getBloodRequestById(int requestId) {
        String query = "SELECT * FROM blood_requests WHERE request_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, requestId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
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
                return request;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean addBloodRequest(BloodRequest request) {
        String query = "INSERT INTO blood_requests (patient_name, blood_group, hospital_name, city, urgency_level, units_required, request_status) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, request.getPatientName());
            ps.setString(2, request.getBloodGroup());
            ps.setString(3, request.getHospitalName());
            ps.setString(4, request.getCity());
            ps.setString(5, request.getUrgencyLevel());
            ps.setInt(6, request.getUnitsRequired());
            ps.setString(7, request.getRequestStatus());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateBloodRequest(BloodRequest request) {
        String query = "UPDATE blood_requests SET patient_name = ?, blood_group = ?, hospital_name = ?, city = ?, urgency_level = ?, units_required = ?, request_status = ? WHERE request_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, request.getPatientName());
            ps.setString(2, request.getBloodGroup());
            ps.setString(3, request.getHospitalName());
            ps.setString(4, request.getCity());
            ps.setString(5, request.getUrgencyLevel());
            ps.setInt(6, request.getUnitsRequired());
            ps.setString(7, request.getRequestStatus());
            ps.setInt(8, request.getRequestId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteBloodRequestById(int requestId) {
        String query = "DELETE FROM blood_requests WHERE request_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, requestId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Appointment> getAllAppointments() {
        List<Appointment> appointments = new ArrayList<>();
        String query = "SELECT * FROM appointments ORDER BY appointment_id DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setAppointmentId(rs.getInt("appointment_id"));
                appointment.setDonorId(rs.getInt("donor_id"));
                appointment.setAppointmentDate(rs.getDate("appointment_date"));
                appointment.setAppointmentTime(rs.getTime("appointment_time"));
                appointment.setLocation(rs.getString("location"));
                appointment.setStatus(rs.getString("status"));
                appointments.add(appointment);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return appointments;
    }

    public Appointment getAppointmentById(int appointmentId) {
        String query = "SELECT * FROM appointments WHERE appointment_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, appointmentId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setAppointmentId(rs.getInt("appointment_id"));
                appointment.setDonorId(rs.getInt("donor_id"));
                appointment.setAppointmentDate(rs.getDate("appointment_date"));
                appointment.setAppointmentTime(rs.getTime("appointment_time"));
                appointment.setLocation(rs.getString("location"));
                appointment.setStatus(rs.getString("status"));
                return appointment;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean addAppointment(Appointment appointment) {
        String query = "INSERT INTO appointments (donor_id, appointment_date, appointment_time, location, status) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, appointment.getDonorId());
            ps.setDate(2, appointment.getAppointmentDate());
            ps.setTime(3, appointment.getAppointmentTime());
            ps.setString(4, appointment.getLocation());
            ps.setString(5, appointment.getStatus());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateAppointment(Appointment appointment) {
        String query = "UPDATE appointments SET donor_id = ?, appointment_date = ?, appointment_time = ?, location = ?, status = ? WHERE appointment_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, appointment.getDonorId());
            ps.setDate(2, appointment.getAppointmentDate());
            ps.setTime(3, appointment.getAppointmentTime());
            ps.setString(4, appointment.getLocation());
            ps.setString(5, appointment.getStatus());
            ps.setInt(6, appointment.getAppointmentId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteAppointmentById(int appointmentId) {
        String query = "DELETE FROM appointments WHERE appointment_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, appointmentId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<ContactMessage> getAllContactMessages() {
        List<ContactMessage> messages = new ArrayList<>();
        String query = "SELECT * FROM contact_messages ORDER BY message_id DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ContactMessage message = new ContactMessage();
                message.setMessageId(rs.getInt("message_id"));
                message.setName(rs.getString("name"));
                message.setEmail(rs.getString("email"));
                message.setSubject(rs.getString("subject"));
                message.setMessage(rs.getString("message"));
                message.setSubmittedAt(rs.getTimestamp("submitted_at"));
                messages.add(message);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return messages;
    }

    public boolean deleteContactMessageById(int messageId) {
        String query = "DELETE FROM contact_messages WHERE message_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, messageId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private int getCount(String query) {
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
    public List<User> searchUsers(String keyword, String role) {
        List<User> users = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM users WHERE 1=1");
        List<String> parameters = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            query.append(" AND (full_name LIKE ? OR email LIKE ? OR phone LIKE ?)");
            String value = "%" + keyword.trim() + "%";
            parameters.add(value);
            parameters.add(value);
            parameters.add(value);
        }

        if (role != null && !role.trim().isEmpty()) {
            query.append(" AND role = ?");
            parameters.add(role.trim());
        }

        query.append(" ORDER BY user_id DESC");

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query.toString())) {

            for (int i = 0; i < parameters.size(); i++) {
                ps.setString(i + 1, parameters.get(i));
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
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
                users.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }
    public List<Donor> searchDonors(String bloodGroup, String city, String eligibilityStatus) {
        List<Donor> donors = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM donors WHERE 1=1");
        List<String> parameters = new ArrayList<>();

        if (bloodGroup != null && !bloodGroup.trim().isEmpty()) {
            query.append(" AND blood_group = ?");
            parameters.add(bloodGroup.trim());
        }

        if (city != null && !city.trim().isEmpty()) {
            query.append(" AND city LIKE ?");
            parameters.add("%" + city.trim() + "%");
        }

        if (eligibilityStatus != null && !eligibilityStatus.trim().isEmpty()) {
            query.append(" AND eligibility_status = ?");
            parameters.add(eligibilityStatus.trim());
        }

        query.append(" ORDER BY donor_id DESC");

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query.toString())) {

            for (int i = 0; i < parameters.size(); i++) {
                ps.setString(i + 1, parameters.get(i));
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Donor donor = new Donor();
                donor.setDonorId(rs.getInt("donor_id"));
                donor.setUserId(rs.getInt("user_id"));
                donor.setBloodGroup(rs.getString("blood_group"));
                donor.setGender(rs.getString("gender"));
                donor.setDateOfBirth(rs.getDate("date_of_birth"));
                donor.setAddress(rs.getString("address"));
                donor.setCity(rs.getString("city"));
                donor.setEligibilityStatus(rs.getString("eligibility_status"));
                donors.add(donor);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return donors;
    }
    public List<BloodRequest> searchBloodRequests(String keyword, String bloodGroup, String city, String urgencyLevel, String requestStatus) {
        List<BloodRequest> requests = new ArrayList<>();
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

        if (urgencyLevel != null && !urgencyLevel.trim().isEmpty()) {
            query.append(" AND urgency_level = ?");
            parameters.add(urgencyLevel.trim());
        }

        if (requestStatus != null && !requestStatus.trim().isEmpty()) {
            query.append(" AND request_status = ?");
            parameters.add(requestStatus.trim());
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
                requests.add(request);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return requests;
    }
}