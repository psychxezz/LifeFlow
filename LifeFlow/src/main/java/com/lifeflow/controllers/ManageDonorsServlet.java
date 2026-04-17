package com.lifeflow.controllers;

import com.lifeflow.model.Donor;
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
import java.util.List;

@WebServlet("/manage-donors")
public class ManageDonorsServlet extends HttpServlet {
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

        String bloodGroup = request.getParameter("bloodGroup");
        String city = request.getParameter("city");
        String eligibilityStatus = request.getParameter("eligibilityStatus");

        List<Donor> donors = adminService.searchDonors(bloodGroup, city, eligibilityStatus);
        request.setAttribute("donors", donors);

        request.setAttribute("bloodGroup", bloodGroup);
        request.setAttribute("city", city);
        request.setAttribute("eligibilityStatus", eligibilityStatus);

        String donorIdValue = request.getParameter("editId");
        if (donorIdValue != null && !donorIdValue.trim().isEmpty()) {
            int donorId = Integer.parseInt(donorIdValue);
            Donor donor = adminService.getDonorById(donorId);
            request.setAttribute("editDonor", donor);
        }

        String message = request.getParameter("message");
        if (message != null) {
            request.setAttribute("successMessage", message);
        }

        request.getRequestDispatcher("/WEB-INF/pages/manage-donors.jsp").forward(request, response);
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

        int donorId = Integer.parseInt(request.getParameter("donorId"));
        String bloodGroup = request.getParameter("bloodGroup");
        String gender = request.getParameter("gender");
        String dateOfBirthValue = request.getParameter("dateOfBirth");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String eligibilityStatus = request.getParameter("eligibilityStatus");

        Date dateOfBirth = Date.valueOf(dateOfBirthValue);

        Donor donor = new Donor();
        donor.setDonorId(donorId);
        donor.setBloodGroup(bloodGroup);
        donor.setGender(gender);
        donor.setDateOfBirth(dateOfBirth);
        donor.setAddress(address);
        donor.setCity(city);
        donor.setEligibilityStatus(eligibilityStatus);

        boolean updated = adminService.updateDonor(donor);

        if (updated) {
            response.sendRedirect(request.getContextPath() + "/manage-donors?message=Donor updated successfully.");
        } else {
            response.sendRedirect(request.getContextPath() + "/manage-donors?message=Failed to update donor.");
        }
    }
}