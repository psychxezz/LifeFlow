package com.lifeflow.controllers;

import com.lifeflow.model.User;
import com.lifeflow.service.AdminService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {
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

        User user = (User) session.getAttribute("loggedInUser");

        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        request.setAttribute("totalUsers", adminService.getTotalUsers());
        request.setAttribute("totalDonors", adminService.getTotalDonors());
        request.setAttribute("totalAppointments", adminService.getTotalAppointments());
        request.setAttribute("totalBloodRequests", adminService.getTotalBloodRequests());
        request.setAttribute("totalContactMessages", adminService.getTotalContactMessages());

        request.getRequestDispatcher("/WEB-INF/pages/admin-dashboard.jsp").forward(request, response);
    }
}