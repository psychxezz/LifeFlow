package com.lifeflow.controllers;

import com.lifeflow.model.Appointment;
import com.lifeflow.model.User;
import com.lifeflow.service.AdminService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

@WebServlet("/manage-appointments")
public class ManageAppointmentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null || !"admin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String editIdValue = request.getParameter("editId");
        if (editIdValue != null && !editIdValue.trim().isEmpty()) {
            int appointmentId = Integer.parseInt(editIdValue);
            Appointment editAppointment = adminService.getAppointmentById(appointmentId);
            request.setAttribute("editAppointment", editAppointment);
        }

        String message = request.getParameter("message");
        if (message != null) {
            request.setAttribute("successMessage", message);
        }

        List<Appointment> appointments = adminService.getAllAppointments();
        request.setAttribute("appointments", appointments);

        request.getRequestDispatcher("/WEB-INF/pages/manage-appointments.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null || !"admin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String action = request.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
            boolean deleted = adminService.deleteAppointmentById(appointmentId);

            if (deleted) {
                response.sendRedirect(request.getContextPath() + "/manage-appointments?message=Appointment deleted successfully.");
            } else {
                response.sendRedirect(request.getContextPath() + "/manage-appointments?message=Failed to delete appointment.");
            }
            return;
        }

        String appointmentIdValue = request.getParameter("appointmentId");
        int donorId = Integer.parseInt(request.getParameter("donorId"));
        Date appointmentDate = Date.valueOf(request.getParameter("appointmentDate"));
        Time appointmentTime = Time.valueOf(request.getParameter("appointmentTime") + ":00");
        String location = request.getParameter("location");
        String status = request.getParameter("status");

        Appointment appointment = new Appointment();
        appointment.setDonorId(donorId);
        appointment.setAppointmentDate(appointmentDate);
        appointment.setAppointmentTime(appointmentTime);
        appointment.setLocation(location);
        appointment.setStatus(status);

        boolean success;

        if (appointmentIdValue != null && !appointmentIdValue.trim().isEmpty()) {
            appointment.setAppointmentId(Integer.parseInt(appointmentIdValue));
            success = adminService.updateAppointment(appointment);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/manage-appointments?message=Appointment updated successfully.");
            } else {
                response.sendRedirect(request.getContextPath() + "/manage-appointments?message=Failed to update appointment.");
            }
        } else {
            success = adminService.addAppointment(appointment);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/manage-appointments?message=Appointment added successfully.");
            } else {
                response.sendRedirect(request.getContextPath() + "/manage-appointments?message=Failed to add appointment.");
            }
        }
    }
}