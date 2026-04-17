package com.lifeflow.controllers;

import com.lifeflow.model.Appointment;
import com.lifeflow.model.Donor;
import com.lifeflow.model.User;
import com.lifeflow.service.AppointmentService;
import com.lifeflow.service.UserService;

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

@WebServlet("/appointments")
public class AppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final AppointmentService appointmentService = new AppointmentService();
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Donor donor = userService.getDonorByUserId(loggedInUser.getUserId());

        if (donor == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        List<Appointment> appointments = appointmentService.getAppointmentsByDonorId(donor.getDonorId());
        request.setAttribute("appointments", appointments);

        String message = request.getParameter("message");
        if (message != null) {
            request.setAttribute("successMessage", message);
        }

        request.getRequestDispatcher("/WEB-INF/pages/appointments.jsp").forward(request, response);
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

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Donor donor = userService.getDonorByUserId(loggedInUser.getUserId());

        if (donor == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String action = request.getParameter("action");

        if ("cancel".equalsIgnoreCase(action)) {
            String appointmentIdValue = request.getParameter("appointmentId");

            if (appointmentIdValue != null && !appointmentIdValue.trim().isEmpty()) {
                int appointmentId = Integer.parseInt(appointmentIdValue);
                boolean cancelled = appointmentService.cancelAppointmentByDonor(appointmentId, donor.getDonorId());

                if (cancelled) {
                    response.sendRedirect(request.getContextPath() + "/appointments?message=Appointment cancelled successfully.");
                } else {
                    response.sendRedirect(request.getContextPath() + "/appointments?message=Unable to cancel appointment.");
                }
                return;
            }
        }

        String appointmentDateValue = request.getParameter("appointmentDate");
        String appointmentTimeValue = request.getParameter("appointmentTime");
        String location = request.getParameter("location");

        if (appointmentDateValue == null || appointmentDateValue.trim().isEmpty()
                || appointmentTimeValue == null || appointmentTimeValue.trim().isEmpty()
                || location == null || location.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/appointments?message=All fields are required.");
            return;
        }

        Appointment appointment = new Appointment();
        appointment.setDonorId(donor.getDonorId());
        appointment.setAppointmentDate(Date.valueOf(appointmentDateValue));
        appointment.setAppointmentTime(Time.valueOf(appointmentTimeValue + ":00"));
        appointment.setLocation(location);
        appointment.setStatus("Pending");

        boolean success = appointmentService.addAppointment(appointment);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/appointments?message=Appointment booked successfully.");
        } else {
            response.sendRedirect(request.getContextPath() + "/appointments?message=Failed to book appointment.");
        }
    }
}