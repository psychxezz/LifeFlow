package com.lifeflow.service;

import com.lifeflow.config.DBConfig;
import com.lifeflow.model.Appointment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AppointmentService {

    public List<Appointment> getAppointmentsByDonorId(int donorId) {
        List<Appointment> appointments = new ArrayList<>();
        String query = "SELECT * FROM appointments WHERE donor_id = ? ORDER BY appointment_id DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, donorId);
            ResultSet rs = ps.executeQuery();

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

    public boolean cancelAppointmentByDonor(int appointmentId, int donorId) {
        String query = "UPDATE appointments SET status = 'Cancelled' WHERE appointment_id = ? AND donor_id = ? AND status = 'Pending'";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, appointmentId);
            ps.setInt(2, donorId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}